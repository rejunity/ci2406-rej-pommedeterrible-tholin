`default_nettype none

`define NUM_REGS 32
`define REG_IDX ($clog2(`NUM_REGS)-1)

module vliw(
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
  output [35:0] io_oeb, //Output Enable Bar ; 0 = Output, 1 = Input
  input [4:0] custom_settings, //Custom settings register, settable over mgmt controller firmware
  
  /*
   * Wiring to execution units
   */
   //1
   input [`REG_IDX:0] reg1_idx0,
   input [`REG_IDX:0] reg2_idx0,
   input [31:0] dest_val0,
   input [1:0] dest_mask0,
   input [`REG_IDX:0] dest_idx0,
   
   input [2:0] pred_idx0,
   input [2:0] dest_pred0,
   input dest_pred_val0,
   
   input [31:0] loadstore_address0,
   input is_load0,
   input is_store0,
   input sign_extend0,
   input [1:0] loadstore_size0,
   input [`REG_IDX:0] loadstore_dest0,
   
   input take_branch0,
   input [27:0] new_PC0,
   
   input eu0_busy,
   
   output [41:0] eu0_instruction,
   output [31:0] reg1_val0,
   output [31:0] reg2_val0,
   output pred_val0,
   
   //2
   input [`REG_IDX:0] reg1_idx1,
   input [`REG_IDX:0] reg2_idx1,
   input [31:0] dest_val1,
   input [1:0] dest_mask1,
   input [`REG_IDX:0] dest_idx1,
   
   input [2:0] pred_idx1,
   input [2:0] dest_pred1,
   input dest_pred_val1,
   
   input [31:0] loadstore_address1,
   input is_load1,
   input is_store1,
   input sign_extend1,
   input [1:0] loadstore_size1,
   input [`REG_IDX:0] loadstore_dest1,
   
   input take_branch1,
   input [27:0] new_PC1,
   
   input eu1_busy,
   
   output [41:0] eu1_instruction,
   output [31:0] reg1_val1,
   output [31:0] reg2_val1,
   output pred_val1,
   
   //3
   input [`REG_IDX:0] reg1_idx2,
   input [`REG_IDX:0] reg2_idx2,
   input [31:0] dest_val2,
   input [1:0] dest_mask2,
   input [`REG_IDX:0] dest_idx2,
   
   input [2:0] pred_idx2,
   input [2:0] dest_pred2,
   input dest_pred_val2,
   
   input [31:0] loadstore_address2,
   input is_load2,
   input is_store2,
   input sign_extend2,
   input [1:0] loadstore_size2,
   input [`REG_IDX:0] loadstore_dest2,
   
   input take_branch2,
   input [27:0] new_PC2,
   
   input eu2_busy,
   
   output [41:0] eu2_instruction,
   output [31:0] reg1_val2,
   output [31:0] reg2_val2,
   output pred_val2,
   
   output rst_eu,
   output [27:0] curr_PC
);
assign rst_eu = !rst_n || !startup_delay || memory_cyc[3];
assign curr_PC = PC;

assign eu0_instruction = curr_pack[41:0];
assign eu1_instruction = curr_pack[83:42];
assign eu2_instruction = curr_pack[125:84];
assign reg1_val0 = regfile[reg1_idx0];
assign reg2_val0 = regfile[reg2_idx0];
assign pred_val0 = predicates[pred_idx0] & execution_mask[0] & fetched;
assign reg1_val1 = regfile[reg1_idx1];
assign reg2_val1 = regfile[reg2_idx1];
assign pred_val1 = predicates[pred_idx1] & execution_mask[1] & fetched;
assign reg1_val2 = regfile[reg1_idx2];
assign reg2_val2 = regfile[reg2_idx2];
assign pred_val2 = predicates[pred_idx2] & execution_mask[2] & fetched;

wire blinkLED;
blink blink(
	.clk(wb_clk_i),
	.LED(blinkLED)
);

reg M1;
reg processing_load;
reg processing_store;

wire [15:0] bus_in = io_in[18:3];
wire [7:0] in_8bit = loadstore_address[0] ? bus_in[15:8] : bus_in[7:0];
wire [31:0] in_8bit_se = sign_extend ? {{24{in_8bit[7]}}, in_8bit} : {24'h000000, in_8bit};
wire [31:0] in_16bit_se = sign_extend ? {{16{bus_in[15]}}, bus_in} : {16'h0000, bus_in};

reg [30:0] requested_addr;
reg [30:0] curr_addr;
reg [1:0] requested_len;
reg [3:0] memory_cyc;

wire le_hi = curr_addr[30:16] != requested_addr[30:16] && !io_access;
wire le_lo = !le_hi && (curr_addr[15:0] != requested_addr[15:0]) && !io_access;
assign io_out[19] = le_hi && wb_clk_i && rst_n && !last_le_hi && startup_delay;
assign io_out[20] = le_lo && wb_clk_i && rst_n && !last_le_lo && startup_delay;
assign io_oeb[24:19] = 6'h00;

wire bus_dir = le_hi || le_lo || !web;
assign io_oeb[18:3] = {16{!bus_dir}};
assign io_out[18:3] = le_hi ? {1'b0, requested_addr[30:16]} : (le_lo ? requested_addr[15:0] : (processing_store ? (memory_cyc[2:0] == 0 ? mem_buff[15:0] : mem_buff[31:16]) : 0));
assign io_out[21] = !bus_dir;

assign io_out[1] = M1;
assign io_oeb[1] = 0;

wire oeb = !memory_cyc[3] || le_hi || le_lo || !rst_n || !startup_delay || processing_store || io_access;
assign io_out[22] = oeb;
wire web = !memory_cyc[3] || !processing_store || le_hi || le_lo || !rst_n || !startup_delay || io_access;
wire web_lo_pre = web || (loadstore_size == 0 && loadstore_address[0]);
wire web_hi_pre = web || (loadstore_size == 0 && !loadstore_address[0]);
assign io_out[23] = custom_settings[1:0] == 0 ? web_lo_pre : (custom_settings[1:0] == 1 ? web_lo_pre | wb_clk_i : web_lo_pre | !wb_clk_i);
assign io_out[24] = custom_settings[1:0] == 0 ? web_hi_pre : (custom_settings[1:0] == 1 ? web_hi_pre | wb_clk_i : web_hi_pre | !wb_clk_i);

reg [31:0] mem_buff;
reg [127:0] curr_pack;
reg last_le_lo;
reg last_le_hi;

//FIXME
always @(negedge wb_clk_i) begin
	if(!rst_n || !startup_delay) begin
		last_le_lo <= 0;
		last_le_hi <= 0;
	end else begin
		last_le_lo <= le_lo;
		last_le_hi <= le_hi;
	end
end

wire [1:0] stops = curr_pack[127:126];
reg [2:0] execution_mask;

reg [31:0] regfile [`NUM_REGS-1:0];
reg predicates [7:0];
reg fetched;

/*
//Execution Unit 0
wire [`REG_IDX:0] reg1_idx0;
wire [`REG_IDX:0] reg2_idx0;
wire [31:0] dest_val0;
wire [1:0] dest_mask0;
wire [`REG_IDX:0] dest_idx0;

wire [2:0] pred_idx0;
wire [2:0] dest_pred0;
wire dest_pred_val0;

wire [31:0] loadstore_address0;
wire is_load0;
wire is_store0;
wire sign_extend0;
wire [1:0] loadstore_size0;
wire [`REG_IDX:0] loadstore_dest0;

wire take_branch0;
wire [27:0] new_PC0;

wire eu0_busy;

execution_unit eu0(
	.instruction(curr_pack[41:0]),
	.reg1_idx(reg1_idx0),
	.reg2_idx(reg2_idx0),
	.reg1_val(regfile[reg1_idx0]),
	.reg2_val(regfile[reg2_idx0]),
	.dest_val(dest_val0),
	.dest_mask(dest_mask0),
	.dest_idx(dest_idx0),
	.pred_idx(pred_idx0),
	.pred_val(predicates[pred_idx0] & execution_mask[0] & fetched),
	.dest_pred(dest_pred0),
	.dest_pred_val(dest_pred_val0),

	.loadstore_address(loadstore_address0),
	.loadstore_dest(loadstore_dest0),
	.is_load(is_load0),
	.is_store(is_store0),
	.sign_extend(sign_extend0),
	.loadstore_size(loadstore_size0),
	
	.curr_PC(PC),
	.take_branch(take_branch0),
	.new_PC(new_PC0),

	.clk(wb_clk_i),
	.rst(!rst_n || !startup_delay || memory_cyc[3]),
	.busy(eu0_busy)
);

//Execution Unit 1
wire [`REG_IDX:0] reg1_idx1;
wire [`REG_IDX:0] reg2_idx1;
wire [31:0] dest_val1;
wire [1:0] dest_mask1;
wire [`REG_IDX:0] dest_idx1;

wire [2:0] pred_idx1;
wire [2:0] dest_pred1;
wire dest_pred_val1;

wire [31:0] loadstore_address1;
wire is_load1;
wire is_store1;
wire sign_extend1;
wire [1:0] loadstore_size1;
wire [`REG_IDX:0] loadstore_dest1;

wire take_branch1;
wire [27:0] new_PC1;

wire eu1_busy;

execution_unit eu1(
	.instruction(curr_pack[83:42]),
	.reg1_idx(reg1_idx1),
	.reg2_idx(reg2_idx1),
	.reg1_val(regfile[reg1_idx1]),
	.reg2_val(regfile[reg2_idx1]),
	.dest_val(dest_val1),
	.dest_mask(dest_mask1),
	.dest_idx(dest_idx1),
	.pred_idx(pred_idx1),
	.pred_val(predicates[pred_idx1] & execution_mask[1] & fetched),
	.dest_pred(dest_pred1),
	.dest_pred_val(dest_pred_val1),

	.loadstore_address(loadstore_address1),
	.loadstore_dest(loadstore_dest1),
	.is_load(is_load1),
	.is_store(is_store1),
	.sign_extend(sign_extend1),
	.loadstore_size(loadstore_size1),
	
	.curr_PC(PC),
	.take_branch(take_branch1),
	.new_PC(new_PC1),

	.clk(wb_clk_i),
	.rst(!rst_n || !startup_delay || memory_cyc[3]),
	.busy(eu1_busy)
);

//Execution Unit 2
wire [`REG_IDX:0] reg1_idx2;
wire [`REG_IDX:0] reg2_idx2;
wire [31:0] dest_val2;
wire [1:0] dest_mask2;
wire [`REG_IDX:0] dest_idx2;

wire [2:0] pred_idx2;
wire [2:0] dest_pred2;
wire dest_pred_val2;

wire [31:0] loadstore_address2;
wire is_load2;
wire is_store2;
wire sign_extend2;
wire [1:0] loadstore_size2;
wire [`REG_IDX:0] loadstore_dest2;

wire take_branch2;
wire [27:0] new_PC2;

wire eu2_busy;

execution_unit eu2(
	.instruction(curr_pack[125:84]),
	.reg1_idx(reg1_idx2),
	.reg2_idx(reg2_idx2),
	.reg1_val(regfile[reg1_idx2]),
	.reg2_val(regfile[reg2_idx2]),
	.dest_val(dest_val2),
	.dest_mask(dest_mask2),
	.dest_idx(dest_idx2),
	.pred_idx(pred_idx2),
	.pred_val(predicates[pred_idx2] & execution_mask[2] & fetched),
	.dest_pred(dest_pred2),
	.dest_pred_val(dest_pred_val2),

	.loadstore_address(loadstore_address2),
	.loadstore_dest(loadstore_dest2),
	.is_load(is_load2),
	.is_store(is_store2),
	.sign_extend(sign_extend2),
	.loadstore_size(loadstore_size2),
	
	.curr_PC(PC),
	.take_branch(take_branch2),
	.new_PC(new_PC2),

	.clk(wb_clk_i),
	.rst(!rst_n || !startup_delay || memory_cyc[3]),
	.busy(eu2_busy)
);*/

/*
 * Having multiple loadstore type instructions in one pack is illegal.
 * But without proper exception support, the best way to build this is to
 * always handle the first loadstore in the pack.
 * If there are multiple, the rest are silently ignored.
 */
wire [1:0] ls_unit = (is_load0 || is_store0) ? 0 : ((is_load1 || is_store1) ? 1 : ((is_load2 || is_store2) ? 2 : 3));
reg is_load;
reg is_store;
reg sign_extend;
reg [1:0] loadstore_size;
reg [31:0] loadstore_address;
reg [`REG_IDX:0] load_dest;
reg [1:0] load_mask;
always @(*) begin
	case(ls_unit)
		default: begin
			is_load = 0;
			is_store = 0;
			load_dest = 0;
			load_mask = 0;
		end
		0: begin
			is_load = is_load0;
			is_store = is_store0;
			sign_extend = sign_extend0;
			loadstore_size = loadstore_size0;
			loadstore_address = loadstore_address0;
			load_dest = loadstore_dest0;
			load_mask = dest_mask0;
		end
		1: begin
			is_load = is_load1;
			is_store = is_store1;
			sign_extend = sign_extend1;
			loadstore_size = loadstore_size1;
			loadstore_address = loadstore_address1;
			load_dest = loadstore_dest1;
			load_mask = dest_mask1;
		end
		2: begin
			is_load = is_load2;
			is_store = is_store2;
			sign_extend = sign_extend2;
			loadstore_size = loadstore_size2;
			loadstore_address = loadstore_address2;
			load_dest = loadstore_dest2;
			load_mask = dest_mask2;
		end
	endcase
end

wire io_access = requested_addr[30:6] == 25'h1FFFFFF && requested_len == 2 && (processing_load || processing_store) && memory_cyc[3];
wire [31:0] io_rval;
wire [7:0] ioport_out;
wire [7:0] ioport_oeb;
io_block io_block(
	.io_addr(requested_addr[5:1]),
	.io_wval(mem_buff),
	.io_rval(io_rval),
	.io_wen(processing_store && io_access),
	.UTX(io_out[25]),
	.URX(io_in[26]),
	.SCLK(io_out[27]),
	.SDO(io_out[28]),
	.SDI(io_in[29]),
	.ioport_out(ioport_out),
	.ioport_in({io_in[0], io_in[2], io_in[35:30]}),
	.ioport_oeb(ioport_oeb),
	.clk(wb_clk_i),
	.rst(!rst_n || !startup_delay)
);
assign io_out[29] = 1'b0;
assign io_out[26] = 1'b1;

assign io_oeb[25] = 1'b0;
assign io_oeb[26] = 1'b1;
assign io_oeb[28:27] = 2'b00;
assign io_oeb[29] = 1'b1;
assign io_out[35:30] = ioport_out[5:0];

assign io_out[2] = custom_settings[3] ? blinkLED : ioport_out[6];
assign io_oeb[35:30] = ioport_oeb[5:0];
assign io_oeb[2] = custom_settings[3] ? 1'b0 : ioport_oeb[6];
assign io_out[0] = custom_settings[2] ? predicates[1] : ioport_out[7];
assign io_oeb[0] = custom_settings[2] ? 1'b0 : ioport_oeb[7];

reg [27:0] PC;
wire [27:0] next_PC = take_branch0 ? new_PC0 : (take_branch1 ? new_PC1 : (take_branch2 ? new_PC2 : (PC + 1'b1)));
wire take_branch = take_branch0 || take_branch1 || take_branch2;

reg startup_delay;
always @(posedge wb_clk_i) begin
	regfile[0] <= 0;
	predicates[0] <= 1;
	M1 <= 0;
	if(!rst_n) startup_delay <= 0;
	else startup_delay <= 1;
	if(!rst_n || !startup_delay) begin
		curr_pack <= 0;
		curr_addr <= 31'h7FFFFFFF;
		requested_addr <= 0;
		requested_len <= 3;
		memory_cyc <= 8;
		predicates[1] <= 1;
		predicates[2] <= 0;
		predicates[3] <= 1;
		predicates[4] <= 1;
		predicates[5] <= 0;
		predicates[6] <= 1;
		predicates[7] <= 0;
		regfile[1] <= 0;
		regfile[2] <= 0;
		regfile[3] <= 0;
		regfile[4] <= 0;
		regfile[5] <= 0;
		regfile[6] <= 0;
		regfile[7] <= 0;
		regfile[8] <= 0;
		regfile[9] <= 0;
		regfile[10] <= 0;
		regfile[11] <= 0;
		regfile[12] <= 0;
		regfile[13] <= 0;
		regfile[14] <= 0;
		regfile[15] <= 0;
		regfile[31] <= 0;
		PC <= 0;
		processing_load <= 0;
		processing_store <= 0;
		execution_mask <= 2'b11;
		fetched <= 0;
	end else begin
		if(le_hi) curr_addr[30:16] <= requested_addr[30:16];
		if(le_lo) curr_addr[15:0] <= requested_addr[15:0];
		if(curr_addr == requested_addr || io_access) begin
			if(memory_cyc[3]) begin
				memory_cyc <= 0;
				if(io_access) begin
					if(processing_load) begin
						regfile[load_dest] <= io_rval;
					end
					next_instr(0);
				end else if(memory_cyc[2:0] == 0) begin
					if(requested_len == 0) begin
						if(processing_store || processing_load) next_instr(0);
						if(processing_load) begin
							regfile[load_dest][7:0] <= in_8bit_se[7:0];
							if(load_mask[0]) regfile[load_dest][15:8] <= in_8bit_se[15:8];
							if(load_mask[1]) regfile[load_dest][31:16] <= in_8bit_se[31:16];
						end
					end else if(requested_len == 1) begin
						if(processing_store || processing_load) next_instr(0);
						if(processing_load) begin
							regfile[load_dest][15:0] <= in_16bit_se[15:0];
							if(load_mask[1]) regfile[load_dest][31:16] <= in_16bit_se[31:16];
						end
					end else begin
						if(!processing_store) mem_buff[15:0] <= bus_in;
						memory_cyc <= 9;
						requested_addr <= requested_addr + 1;
					end
				end else if(memory_cyc[2:0] == 1) begin
					if(processing_store || processing_load) next_instr(0);
					if(processing_load) regfile[load_dest] <= {bus_in[15:0], mem_buff[15:0]};
					if(requested_len == 3) begin
						//This is an instruction pack fetch
						memory_cyc <= 10;
						curr_pack[127:96] <= {bus_in[15:0], mem_buff[15:0]};
						requested_addr <= requested_addr + 1;
					end
				end else begin
					curr_pack <= {bus_in, curr_pack[127:16]};
					if(memory_cyc != 4'hF) requested_addr <= requested_addr + 1;
					else fetched <= 1;
					memory_cyc <= memory_cyc + 1;
					execution_mask <= {bus_in[15:14] == 0, bus_in[14] == 0, 1'b1}; //Parse initial 'stop' pattern
				end
			end else if(!(eu0_busy || eu1_busy || eu2_busy)) begin
				M1 <= 1;

				if(dest_mask2[0] && dest_idx2 != 0) regfile[dest_idx2][15:0] <= dest_val2[15:0];
				if(dest_mask2[1] && dest_idx2 != 0) regfile[dest_idx2][31:16] <= dest_val2[31:16];
				if(dest_pred2 != 0) predicates[dest_pred2] <= dest_pred_val2;

				if(dest_mask1[0] && dest_idx1 != 0) regfile[dest_idx1][15:0] <= dest_val1[15:0];
				if(dest_mask1[1] && dest_idx1 != 0) regfile[dest_idx1][31:16] <= dest_val1[31:16];
				if(dest_pred1 != 0) predicates[dest_pred1] <= dest_pred_val1;

				if(dest_mask0[0] && dest_idx0 != 0) regfile[dest_idx0][15:0] <= dest_val0[15:0];
				if(dest_mask0[1] && dest_idx0 != 0) regfile[dest_idx0][31:16] <= dest_val0[31:16];
				if(dest_pred0 != 0) predicates[dest_pred0] <= dest_pred_val0;

				if(take_branch || execution_mask[2]) PC <= next_PC;
				if(is_load || is_store) begin
					requested_addr <= loadstore_address[31:1];
					requested_len <= loadstore_size;
					if(is_load) processing_load <= 1;
					else if(is_store) begin
						processing_store <= 1;
						if(loadstore_size == 0) begin
							if(loadstore_address[0]) mem_buff <= {16'h0000, regfile[load_dest][7:0], 8'h00};
							else mem_buff <= {24'h000000, regfile[load_dest][7:0]};
						end else mem_buff <= regfile[load_dest];
					end
					memory_cyc <= 8;
				end else begin
					next_instr(1);
				end
			end
		end
	end
end

task next_instr(input useNP);
	begin
		processing_load <= 0;
		processing_store <= 0;
		//Always move on to next instruction if taking a branch
		//If there are stops, instructions after the stop following the branch are aborted even though
		//They are in the same pack
		if(execution_mask[2] || take_branch) begin
			requested_addr <= {useNP ? next_PC : PC, 3'b000};
			memory_cyc <= 8;
			requested_len <= 3;
			fetched <= 0;
		//Define all possible transitions for the execution mask based on stops configuration
		end else if(execution_mask == 3'b001) begin
			execution_mask <= stops[1] ? 3'b010 : 3'b110;
		end else if(execution_mask == 3'b010) execution_mask <= 3'b100;
		else if(execution_mask == 3'b011) execution_mask <= 3'b100;
		else execution_mask <= 3'b100;

	end
endtask

`ifdef SIM
wire [31:0] r0 = regfile[0];
wire [31:0] r1 = regfile[1];
wire [31:0] r2 = regfile[2];
wire [31:0] r3 = regfile[3];
wire [31:0] r4 = regfile[4];
wire [31:0] r5 = regfile[5];
wire [31:0] r6 = regfile[6];
wire [31:0] r7 = regfile[7];
wire [31:0] r8 = regfile[8];
wire [31:0] r9 = regfile[9];
wire [31:0] r10 = regfile[10];
wire [31:0] r11 = regfile[11];
wire [31:0] r12 = regfile[12];
wire [31:0] r13 = regfile[13];
wire [31:0] r14 = regfile[14];
wire [31:0] r15 = regfile[15];
wire [31:0] r31 = regfile[31];

wire p0 = predicates[0];
wire p1 = predicates[1];
wire p2 = predicates[2];
wire p3 = predicates[3];
wire p4 = predicates[4];
wire p5 = predicates[5];
wire p6 = predicates[6];
wire p7 = predicates[7];
`endif

endmodule

module io_block(
	input [4:0] io_addr,
	input [31:0] io_wval,
	output [31:0] io_rval,
	input io_wen,

	output UTX,
	input URX,

	output SCLK,
	output SDO,
	input SDI,

	output [7:0] ioport_out,
	input [7:0] ioport_in,
	output [7:0] ioport_oeb,

	input clk,
	input rst
);

reg [7:0] io_dir;
reg [7:0] io_dat;
assign ioport_oeb = ~io_dir;
assign ioport_out = io_dat;

reg [31:0] timer0;
reg [31:0] timer1;
reg [31:0] timer0_top;
reg [31:0] timer1_top;

reg [16:0] timer0_prescaler;
reg [16:0] timer1_prescaler;
reg [16:0] timer0_pre_counter;
reg [16:0] timer1_pre_counter;

reg [15:0] udiv;
reg [7:0] sdiv;

wire uart_busy;
wire uart_has_byte;
wire spi_busy;
wire [7:0] udat;
wire [7:0] sdat;

reg [31:0] io_rval_tbl;
always @(*) begin
	case(io_addr)
		default: io_rval_tbl = 32'hFFFFFFFF;
		0: io_rval_tbl = timer0;
		1: io_rval_tbl = timer1;
		2: io_rval_tbl = timer0_top;
		3: io_rval_tbl = timer1_top;
		4: io_rval_tbl = {15'h0000, timer0_prescaler};
		5: io_rval_tbl = {15'h0000, timer1_prescaler};
		6: io_rval_tbl = {16'h0000, udiv};
		7: io_rval_tbl = {24'h000000, sdiv};
		8: io_rval_tbl = {24'h000000, udat};
		9: io_rval_tbl = {24'h000000, sdat};
		10: io_rval_tbl = {29'h0, uart_busy, spi_busy, uart_has_byte};
		11: io_rval_tbl = {24'h000000, io_dir};
		12: io_rval_tbl = {24'h000000, io_dat};
		13: io_rval_tbl = {24'h000000, ioport_in};
	endcase
end
assign io_rval = io_rval_tbl;

always @(posedge clk) begin
	if(rst) begin
		timer0 <= 0;
		timer0_prescaler <= 100;
		timer1 <= 0;
		timer1_prescaler <= 100;
		timer0_pre_counter <= 0;
		timer1_pre_counter <= 0;
		timer0_top <= 32'hFFFFFFFF;
		timer1_top <= 32'hFFFFFFFF;
		io_dir <= 0;
		io_dat <= 8'h55;
		udiv <= 16'h0080;
		sdiv <= 8'h08;
	end else begin
		timer0_pre_counter <= timer0_pre_counter + 1;
		timer1_pre_counter <= timer1_pre_counter + 1;
		if(timer0_prescaler == timer0_pre_counter) begin
			timer0_pre_counter <= 0;
			timer0 <= timer0 + 1;
			if(timer0 == timer0_top) begin
				timer0 <= 0;
			end
		end
		if(timer1_prescaler == timer1_pre_counter) begin
			timer1_pre_counter <= 0;
			timer1 <= timer1 + 1;
			if(timer1 == timer1_top) begin
				timer1 <= 0;
			end
		end
		if(io_wen) begin
			case(io_addr)
				0: timer0 <= io_wval;
				1: timer1 <= io_wval;
				2: timer0_top <= io_wval;
				3: timer1_top <= io_wval;
				4: timer0_prescaler <= io_wval[16:0];
				5: timer1_prescaler <= io_wval[16:0];
				6: udiv <= io_wval[15:0];
				7: sdiv <= io_wval[7:0];
				11: io_dir <= io_wval[7:0];
				12: io_dat <= io_wval[7:0];
			endcase
		end

	end
end

vliw_uart uart(
	.divisor(udiv),
	.din(io_wval[7:0]),
	.dout(udat),
	.TX(UTX),
	.RX(URX),
	.start(io_wen && io_addr == 8),
	.busy(uart_busy),
	.has_byte(uart_has_byte),
	.clr_hb(io_wen && io_addr == 10),
	.clk(clk),
	.rst(rst)
);

vliw_spi spi(
	.divisor(sdiv),
	.din(io_wval[7:0]),
	.dout(sdat),
	.SCLK(SCLK),
	.DO(SDO),
	.DI(SDI),
	.start(io_wen && io_addr == 9),
	.busy(spi_busy),
	.clk(clk),
	.rst(rst)
);

endmodule

module blink(
    input clk,
    output LED
    );
integer counter;
reg state;
always @ (posedge clk) begin
    counter <= counter + 1;
     if(counter >= 8000000 )begin
        counter <=0;
        state <= !state;
     end 
end 
assign LED = state;        
endmodule
