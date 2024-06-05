`default_nettype none

module wrapped_8x305(
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
  output [4:0] io_oeb, //Output Enable Bar ; 0 = Output, 1 = Input
  input [1:0] custom_settings
);

wire IV_oeb;
assign io_oeb[0] = IV_oeb;

assign io_out[2] = 1'b1;
wire [7:0] inp = {io_in[2], io_in[28:22]};
reg [7:0] outp;
assign io_out[35:29] = outp[6:0];
assign io_out[28:22] = 0;
assign io_out[0] = outp[7];
assign io_out[1] = instr_ready;

/*
 * Regs & IO for spiflash memory interface
 */
reg [4:0] ROM_spi_cycle;
reg [6:0] startup_cycle;
reg [5:0] mem_cycle;
reg CS_ROM;
reg SCLK_ROM;
reg [3:0] ROM_DO;
wire [3:0] ROM_DI = io_in[19:16];
assign io_out[19:16] = ROM_DO;
reg ROM_OEB;
reg ROM_spi_mode;
reg [7:0] ROM_spi_dat_out;
assign io_oeb[4:1] = ROM_spi_mode ? 4'b0010 : {ROM_OEB, ROM_OEB, ROM_OEB, ROM_OEB};
assign io_out[20] = CS_ROM;
assign io_out[21] = SCLK_ROM;
reg [13:0] ROM_addr_buff;
reg [13:0] last_addr;
reg spi_clkdiv;
/*
 *
 */

reg [7:0] memory [15:0];
`ifdef SIM
wire [7:0] test_m = memory[5];
`endif
wire SC;
wire WC;
wire LB;
wire RB;
wire MCLK;
assign io_out[11] = RB;
assign io_out[12] = LB;
assign io_out[13] = SC;
assign io_out[14] = WC;
assign io_out[15] = MCLK;
wire [7:0] IV_in = custom_settings[0] && cmdl == 8'h00 && !LB ? ~{inp[0], inp[1], inp[2], inp[3], inp[4], inp[5], inp[6], inp[7]} : (custom_settings[1] && !RB && cmdr[7:4] == 4'h0 ? memory[cmdr[3:0]] : io_in[10:3]);
wire [7:0] IV_out;
assign io_out[10:3] = IV_out;
reg [7:0] cmdl;
reg [7:0] cmdr;
wire [12:0] A;
reg [15:0] I;
reg [12:0] last_A;
reg instr_ready;
wire [7:0] IV_out_corr = {~IV_out[0], ~IV_out[1], ~IV_out[2], ~IV_out[3], ~IV_out[4], ~IV_out[5], ~IV_out[6], ~IV_out[7]};
always @(posedge wb_clk_i) begin
	/*
	 * spiflash memory interface
	 */
	if(SC && MCLK) begin
		if(!LB) cmdl <= IV_out_corr;
		if(!RB) cmdr <= IV_out_corr;
	end
	if(WC && !LB && cmdl == 8'h00 && MCLK) outp <= IV_out_corr;
	if(WC && !RB && cmdr[7:4] == 4'h0 && MCLK) memory[cmdr[3:0]] <= IV_out;
	if(!rst_n) begin
		I <= 0;
		last_A <= 13'h1EFE;
		instr_ready <= 1'b0;
		ROM_spi_cycle <= 5'h00;
		startup_cycle <= 7'h01;
		mem_cycle <= 6'h00;
		CS_ROM <= 1'b1;
		SCLK_ROM <= 1'b0;
		ROM_DO <= 4'b1100;
		ROM_OEB <= 1'b1;
		ROM_spi_mode <= 1'b1;
		ROM_spi_dat_out <= 8'h00;
		ROM_spi_cycle <= 5'h00;
		ROM_addr_buff <= 0;
		last_addr <= 999;
		spi_clkdiv <= 1'b0;
		outp <= 8'h00;
		cmdl <= 8'h00;
		cmdr <= 8'h00;
		memory[5] <= 8'h21;
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
				if(last_addr + 2 == ROM_addr_buff) begin
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
				ROM_DO <= {2'b00, ROM_addr_buff[13:12]};
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
				I[15:12] <= ROM_DI;
			end
			28: SCLK_ROM <= 0;
			29: begin
				SCLK_ROM <= 1;
				I[11:8] <= ROM_DI;
			end
			30: SCLK_ROM <= 0;
			31: begin
				SCLK_ROM <= 1;
				I[7:4] <= ROM_DI;
			end
			32: SCLK_ROM <= 0;
			33: begin
				SCLK_ROM <= 1;
				I[3:0] <= ROM_DI;
			end
			34: begin
				SCLK_ROM <= 0;
				instr_ready <= 1;
				mem_cycle <= 0;
			end
		endcase
	end else begin
		if(A != last_A) begin
			instr_ready <= 0;
			last_A <= A;
			mem_cycle <= 1;
			ROM_addr_buff <= {A, 1'b0};
		end
	end
end

S8x305 S8x305(
	.x1(wb_clk_i),
	.reset(rst_n),
	.IV_in(IV_in),
	.IV_out(IV_out),
	.IV_oeb(IV_oeb),
	.RB(RB),
	.LB(LB),
	.SC(SC),
	.WC(WC),
	.A(A),
	.I(I),
	.instr_ready(instr_ready),
	.MCLK(MCLK)
);

endmodule
