`default_nettype none

module scrapcpu(
`ifdef USE_POWER_PINS
  inout vccd1,	// User area 1 1.8V supply
  inout vssd1,	// User area 1 digital ground
`endif
  input wb_clk_i, //Clock input (you can also use an input pin as a custom clock pin and ignore this)
  input rst_n, //Active low
  //Be careful with io_in/out/oeb[2:0] - these are assigned to the management controller on power-up
  //They may behave eratically until the firmware can assign them to your project
  //It is recommended to use them as outputs only
  input [35:0] io_in,
  output [35:0] io_out,
  output [35:0] io_oeb //Output Enable Bar ; 0 = Output, 1 = Input
);

reg carry;
reg zero;
reg [5:0] A;
reg [5:0] B;
reg [5:0] MAR;
reg [5:0] RAM [63:0];
wire [5:0] RAMval = MAR == 63 ? io_in[14:9] : (MAR == 60 ? io_in[20:15] : RAM[MAR]);
reg [5:0] P;
reg [11:0] PC;
reg [5:0] insin;
reg [5:0] imm_buff;
reg compat;

reg [11:0] last_PC;
reg [1:0] last_flags;
reg [5:0] last_A;
reg [5:0] last_B;
reg [5:0] last_MAR;
reg [5:0] last_P;

assign io_out[2:0] = {MAR[5], carry, zero};
assign io_oeb[2:0] = 3'h0;

wire [5:0] out_port1 = RAM[63];
wire [5:0] out_port2 = RAM[60];
wire [5:0] port_dirs = RAM[59];
assign io_out[14:9] = out_port1;
assign io_out[20:15] = out_port2;
assign io_oeb[20:9] = ~{port_dirs[5], port_dirs[5], port_dirs[4], port_dirs[4], port_dirs[3], port_dirs[3], port_dirs[2], port_dirs[2], port_dirs[1], port_dirs[1], port_dirs[0], port_dirs[0]};
assign io_oeb[22:21] = 2'h0;
assign io_out[21] = instr_cycle == 0;
assign io_out[22] = compat;
assign io_oeb[28:23] = 6'h00;
assign io_out[28:23] = RAM[58];

wire inter = io_in[29];
assign io_oeb[29] = 1'b1;
reg needs_irupt;
reg last_inter;
reg in_irupt;
assign io_out[30] = in_irupt;
assign io_oeb[30] = 1'b0;

assign io_out[29] = 0;
assign io_out[35:31] = 0;
assign io_oeb[35:31] = PC[11:7];

reg [2:0] instr_cycle;

/*
 * Instruction decode
 */
wire needs_address = !insin[5] && insin != 6'o17 && insin != 6'o20 && !is_jump;
wire needs_immediate = insin == 6'o17 || insin == 6'o20 || insin == 6'o77 || (is_jump && !insin[5]);
wire needs_argument = needs_address || needs_immediate;
wire to_MAR = needs_address || insin == 6'o17;
wire to_P = insin == 6'o20;
wire quick = insin[4];
wire is_ALU_op = insin[2] ? !insin[3] : insin[3];
wire is_jump = (insin[2] && insin[4:3] == 2'b01) || insin[4:0] == 5'o36;

wire [5:0] instr_arg = needs_immediate ? imm_buff : RAMval;

/*
 * Combinatorials
 */

reg [6:0] ALU_out;
always @(*) begin
	case(insin[2:0])
		default: ALU_out = {carry, A};
		0: ALU_out = {carry, instr_arg == A ? 6'h01 : 6'h00};
		1: ALU_out = {carry, A > instr_arg ? 6'h01 : 6'h00};
		2: ALU_out = {carry, A ^ instr_arg};
		3: ALU_out = {carry, A & instr_arg};
		4: ALU_out = {1'b0, A} + {1'b0, instr_arg};
		5: ALU_out = {1'b0, A} + {1'b0, instr_arg} + carry;
		6: ALU_out = {1'b0, A} + {1'b0, ~instr_arg} + 7'h01;
		7: ALU_out = {1'b0, A} + {1'b0, ~instr_arg} + carry;
	endcase
end

reg should_jump;
always @(*) begin
	case(insin[1:0])
		default: should_jump = 1'b1;
		1: should_jump = zero;
		2: should_jump = insin[4] ? carry : !zero;
	endcase
end

wire [5:0] rsh_result = {insin == 6'o23 ? carry : 1'b0, A[5:1]};

/*
 * Regs & IO for spiflash memory interface
 */
reg [4:0] ROM_spi_cycle;
reg [6:0] startup_cycle;
reg [4:0] mem_cycle;
reg CS_ROM;
reg SCLK_ROM;
reg [3:0] ROM_DO;
wire [3:0] ROM_DI = io_in[6:3];
assign io_out[6:3] = ROM_DO;
reg ROM_OEB;
reg ROM_spi_mode;
reg [7:0] ROM_spi_dat_out;
assign io_oeb[6:3] = ROM_spi_mode ? 4'b0010 : {ROM_OEB, ROM_OEB, ROM_OEB, ROM_OEB};
assign io_out[7] = CS_ROM;
assign io_out[8] = SCLK_ROM;
assign io_oeb[8:7] = 2'b00;
reg [11:0] ROM_addr_buff;
reg [11:0] last_addr;
reg spi_clkdiv;
reg [1:0] ROM_dest;
/*
 *
 */

always @(posedge wb_clk_i) begin
	if(rst_n) begin
		if(inter && !last_inter) begin
			needs_irupt <= 1;
		end
		last_inter <= inter;
	end
	if(!rst_n) begin
		A <= 0;
		B <= 0;
		MAR <= 0;
		P <= 0;
		PC <= 0;
		insin <= 0;
		instr_cycle <= 0;
		carry <= 0;
		zero <= 0;
		compat <= 1;
		needs_irupt <= 0;
		last_inter <= 0;
		in_irupt <= 0;
		RAM[63] <= 0;
		RAM[60] <= 0;
		RAM[59] <= 6'h3F;
		RAM[58] <= 0;
	end else if(mem_cycle == 0 && startup_cycle == 0 && ROM_spi_cycle == 0) begin
		if(instr_cycle == 0) begin
			if(needs_irupt && !in_irupt) begin
				last_PC <= PC;
				last_MAR <= MAR;
				last_A <= A;
				last_B <= B;
				last_P <= P;
				last_flags <= {zero, carry};
				PC <= 12'h004;
				ROM_addr_buff <= 12'h004;
				in_irupt <= 1;
				needs_irupt <= 0;
			end else begin
				ROM_addr_buff <= PC;
				PC <= PC + 1;
			end
			mem_cycle <= 1;
			instr_cycle <= 1;
			ROM_dest <= 0;
		end else if(instr_cycle == 1) begin
			if(insin == 6'o62) begin
				PC <= last_PC;
				MAR <= last_MAR;
				A <= last_A;
				B <= last_B;
				P <= last_P;
				zero <= last_flags[1];
				carry <= last_flags[0];
				instr_cycle <= 0;
				in_irupt <= 0;
			end else if(insin == 6'o61) begin
				compat <= !compat;
				instr_cycle <= 0;
			end else if(insin == 6'o40) begin
				carry <= 0;
				instr_cycle <= 0;
			end else if(insin == 6'o21) begin
				carry <= 1;
				instr_cycle <= 0;
			end else if(insin == 6'o22 || insin == 6'o23) begin
				B <= rsh_result;
				carry <= A[0];
				zero <= rsh_result == 0;
				instr_cycle <= 0;
			end else if(insin == 0) begin
				instr_cycle <= 0;
			end else if(needs_argument) begin
				instr_cycle <= insin == 6'o17 || to_P ? 0 : 2;
				ROM_addr_buff <= PC;
				mem_cycle <= 1;
				PC <= PC + 1;
				ROM_dest <= to_MAR ? 1 : (to_P ? 3 : 2);
			end else begin
				instr_cycle <= 2;
			end
		end else if(instr_cycle == 2) begin
			instr_cycle <= 0;
			if(insin[4:0] == 5'o01 || insin == 6'o77) begin
				A <= instr_arg;
				if(!compat && insin[4:0] == 5'o01) zero <= instr_arg == 0;
			end
			if(insin[4:0] == 5'o07) begin
				MAR <= instr_arg;
			end
			if(insin[4:0] == 5'o20) begin
				P <= instr_arg;
			end
			if(insin[4:0] == 5'o02) begin
				RAM[MAR] <= B;
			end
			if(insin[4:0] == 5'o03) begin
				RAM[MAR] <= A;
				if(compat) begin
					B <= A;
					carry <= 0;
					zero <= A == 0;
				end
			end
			if(is_ALU_op) begin
				B <= ALU_out[5:0];
				carry <= ALU_out[6];
				zero <= ALU_out[5:0] == 0;
				if(!quick) A <= ALU_out[5:0];
			end
			if(is_jump && should_jump) begin
				PC <= {P, instr_arg};
			end
		end
	end
	
	/*
	 * spiflash memory interface
	 */
	if(!rst_n) begin
		ROM_spi_cycle <= 5'h00;
		startup_cycle <= 7'h01;
		mem_cycle <= 5'h00;
		CS_ROM <= 1'b1;
		SCLK_ROM <= 1'b0;
		ROM_DO <= 4'b1100;
		ROM_OEB <= 1'b1;
		ROM_spi_mode <= 1'b1;
		ROM_spi_dat_out <= 8'h00;
		ROM_spi_cycle <= 5'h00;
		ROM_addr_buff <= 0;
		last_addr <= 0;
		spi_clkdiv <= 0;
		ROM_dest <= 0;
	end else if(ROM_spi_cycle != 0) begin
		spi_clkdiv <= !spi_clkdiv;
		if(spi_clkdiv) begin
			ROM_spi_cycle <= ROM_spi_cycle == 17 ? 0 : ROM_spi_cycle + 1;
			if(ROM_spi_cycle[0]) begin
				SCLK_ROM <= 1'b0;
				ROM_DO[0] <= ROM_spi_dat_out[7];
				ROM_spi_dat_out <= {ROM_spi_dat_out[6:0], 1'b0};
			end else begin
				SCLK_ROM <= 1'b1;
			end
		end
	end else if(startup_cycle != 0) begin
		startup_cycle <= startup_cycle + 1;
		case(startup_cycle)
			1: begin
				CS_ROM <= 0;
				ROM_spi_dat_out <= 8'hFF;
				ROM_spi_cycle <= 1;
			end
			2: begin
				CS_ROM <= 1;
			end
			4: begin
				CS_ROM <= 0;
				ROM_spi_dat_out <= 8'hAB;
				ROM_spi_cycle <= 1;
			end
			5: begin
				CS_ROM <= 1;
			end
			7: begin
				ROM_spi_dat_out <= 8'h06;
				CS_ROM <= 0;
				ROM_spi_cycle <= 1;
			end
			8: begin
				CS_ROM <= 1;
			end
			10: begin
				ROM_spi_dat_out <= 8'h01;
				CS_ROM <= 0;
				ROM_spi_cycle <= 1;
			end
			11: begin
				CS_ROM <= 0;
				ROM_spi_dat_out <= 8'b00000010;
				ROM_spi_cycle <= 1;
			end
			12: begin
				CS_ROM <= 0;
				ROM_spi_dat_out <= 8'b00000010;
				ROM_spi_cycle <= 1;
			end
			13: begin
				CS_ROM <= 1;
			end
			15: begin
				CS_ROM <= 0;
				ROM_spi_dat_out <= 8'hEB;
				ROM_spi_cycle <= 1;
			end
			16: begin
				ROM_OEB <= 0;
				ROM_spi_mode <= 0;
				ROM_DO <= 4'h0;
			end
			//20 - 23
			18: SCLK_ROM <= 1;
			20: SCLK_ROM <= 0;
			//16 - 19
			22: SCLK_ROM <= 1;
			24: SCLK_ROM <= 0;
			//12 - 15
			26: SCLK_ROM <= 1;
			28: SCLK_ROM <= 0;
			//8 - 11
			30: SCLK_ROM <= 1;
			32: SCLK_ROM <= 0;
			//4 - 7
			34: SCLK_ROM <= 1;
			36: SCLK_ROM <= 0;
			//0 - 3
			38: SCLK_ROM <= 1;
			40: begin
				SCLK_ROM <= 0;
				ROM_DO <= 4'b1010;
			end
			42: SCLK_ROM <= 1; //M4 - M7
			44: begin
				SCLK_ROM <= 0;
				ROM_DO <= 4'b0101;
			end
			46: SCLK_ROM <= 1; //M0 - M3
			48: begin
				SCLK_ROM <= 0;
				ROM_OEB <= 1;
			end
			50: SCLK_ROM <= 1;
			52: SCLK_ROM <= 0;
			54: SCLK_ROM <= 1;
			56: SCLK_ROM <= 0;
			58: SCLK_ROM <= 1;
			60: SCLK_ROM <= 0;
			62: SCLK_ROM <= 1;
			64: SCLK_ROM <= 0;
			66: SCLK_ROM <= 1;
			68: SCLK_ROM <= 0;
			70: SCLK_ROM <= 1;
			72: SCLK_ROM <= 0;
			74: SCLK_ROM <= 1;
			76: SCLK_ROM <= 0;
			78: CS_ROM <= 1;
			82: startup_cycle <= 0;
		endcase
	end else if(mem_cycle != 0) begin
		mem_cycle <= mem_cycle + 1;
		case(mem_cycle)
			1: begin
				last_addr <= ROM_addr_buff;
				if(last_addr + 1 == ROM_addr_buff) begin
					//Sequential read, just clock the flash a few times to get it
					mem_cycle <= 27;
				end else begin
					//Non-sequential read, need to restart spiflash read with a new address
					CS_ROM <= 1;
					SCLK_ROM <= 0;
				end
			end
			2: begin
				CS_ROM <= 0;
				ROM_DO <= 4'h0;
				ROM_OEB <= 0;
			end
			3: SCLK_ROM <= 1;
			4: SCLK_ROM <= 0;
			5: SCLK_ROM <= 1;
			6: begin
				SCLK_ROM <= 0;
				ROM_DO <= 4'h0;
			end
			7: SCLK_ROM <= 1;
			8: begin
				SCLK_ROM <= 0;
				ROM_DO <= ROM_addr_buff[11:8];
			end
			9: SCLK_ROM <= 1;
			10: begin
				SCLK_ROM <= 0;
				ROM_DO <= ROM_addr_buff[7:4];
			end
			11: SCLK_ROM <= 1;
			12: begin
				SCLK_ROM <= 0;
				ROM_DO <= ROM_addr_buff[3:0];
			end
			13: SCLK_ROM <= 1;
			14: begin
				SCLK_ROM <= 0;
				ROM_DO <= 4'b1010;
			end
			15: SCLK_ROM <= 1;
			16: begin
				SCLK_ROM <= 0;
				ROM_DO <= 4'b0101;
			end
			17: SCLK_ROM <= 1;
			18: begin
				SCLK_ROM <= 0;
				ROM_OEB <= 1;
			end
			19: SCLK_ROM <= 1;
			20: SCLK_ROM <= 0;
			21: SCLK_ROM <= 1;
			22: SCLK_ROM <= 0;
			23: SCLK_ROM <= 1;
			24: SCLK_ROM <= 0;
			25: SCLK_ROM <= 1;
			26: SCLK_ROM <= 0;

			27: begin
				SCLK_ROM <= 1;
				if(ROM_dest == 0) insin[5:4] <= ROM_DI[1:0];
				else if(ROM_dest == 1) MAR[5:4] <= ROM_DI[1:0];
				else if(ROM_dest == 2) imm_buff[5:4] <= ROM_DI[1:0];
				else P[5:4] <= ROM_DI[1:0];
			end
			28: SCLK_ROM <= 0;
			29: begin
				SCLK_ROM <= 1;
				if(ROM_dest == 0) insin[3:0] <= ROM_DI;
				else if(ROM_dest == 1) MAR[3:0] <= ROM_DI;
				else if(ROM_dest == 2) imm_buff[3:0] <= ROM_DI;
				else P[3:0] <= ROM_DI;
			end
			30: begin
				SCLK_ROM <= 0;
				mem_cycle <= 0;
			end
		endcase
	end
end

endmodule
