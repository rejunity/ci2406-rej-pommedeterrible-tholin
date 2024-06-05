// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

`define OP_NOP 0
`define OP_ALU 1
`define OP_IMM 2
`define OP_PRED 3
`define OP_LOADSTORE 4
`define OP_BRANCH 5
`define OP_JUMP 6

`define ALU_ADD 0
`define ALU_SUB 128
`define ALU_ASR 8
`define ALU_LSR 16
`define ALU_LSL 144
`define ALU_LT 24
`define ALU_SLT 32
`define ALU_AND 40
`define ALU_OR 48
`define ALU_XOR 56
`define ALU_MUL 64
`define ALU_MULU 72
`define ALU_DIV 80
`define ALU_MOD 88

`define BR_EQL 0
`define BR_LT 8
`define BR_LTE 24
`define BR_NEQL 32
`define BR_GTE 40
`define BR_GT 56
`define BR_SIGN 64
`define BR_LTS 72
`define BR_LTES 88
`define BR_NSIGN 96
`define BR_GTES 104
`define BR_GTS 120

`define P0 0
`define P1 256
`define P2 512
`define P3 768
`define P4 1024
`define P5 1280
`define P6 1536
`define P7 1792

`define IMM_UPPER (1 << 25)

`define OP_LLI (`OP_IMM | 32 | 128 | (1 << 17))
`define OP_LLI_extend (`OP_LLI | 16777216 | (1 << 17))
`define OP_LUI (`OP_IMM | 32 | 128 | 33554432 | (1 << 17))

`define ALU_IMM(x) (x << 26)
`define MISC_IMM(x) (x << 25)

`define DEST(x) (x << 11)
`define RS1(x) (x << 18)
`define RS2(x) (x << 25)
`define PREDICATE(x) (x << 8)

`define INSTR_LLI(re,val) (`OP_LLI | `DEST(re) | `ALU_IMM(val))
`define INSTR_LLI_extend(re,val) (`OP_LLI_extend | `DEST(re) | `ALU_IMM(val))
`define INSTR_LUI(re,val) (`OP_LUI | `DEST(re) | `ALU_IMM(val))

`define INSTR_ALU(re1,re2,dest,operation) (`OP_ALU | operation | `RS1(re1) | `RS2(re2) | `DEST(dest))
`define INSTR_IMM(re1,val,dest,operation) (`OP_IMM | operation | `RS1(re1) | `ALU_IMM(val) | `DEST(dest))

`define INSTR_STORE32(re1,re2,disp) (`OP_LOADSTORE | 8 | 64 | `RS1(re1) | `DEST(re2) | `MISC_IMM(disp))
`define INSTR_STORE16(re1,re2,disp) (`OP_LOADSTORE | 8 | 32 | `RS1(re1) | `DEST(re2) | `MISC_IMM(disp))
`define INSTR_STORE8(re1,re2,disp) (`OP_LOADSTORE | 8 | `RS1(re1) | `DEST(re2) | `MISC_IMM(disp))

`define INSTR_LOAD32(re1,dest,disp) (`OP_LOADSTORE | 64 | `RS1(re1) | `DEST(dest) | `MISC_IMM(disp))
`define INSTR_LOAD16(re1,dest,disp) (`OP_LOADSTORE | 32 | `RS1(re1) | `DEST(dest) | `MISC_IMM(disp))
`define INSTR_LOAD8(re1,dest,disp) (`OP_LOADSTORE | `RS1(re1) | `DEST(dest) | `MISC_IMM(disp))
`define INSTR_LOAD16SE(re1,dest,disp) (`OP_LOADSTORE | 16 | 32 | `RS1(re1) | `DEST(dest) | `MISC_IMM(disp))
`define INSTR_LOAD8SE(re1,dest,disp) (`OP_LOADSTORE | 16 | `RS1(re1) | `DEST(dest) | `MISC_IMM(disp))

`define INSTR_BRANCH(re1,re2,disp) (`OP_BRANCH | `DEST(re1) | `RS1(re2) | `MISC_IMM(disp))
`define INSTR_JUMP(re1,dest,disp) (`OP_JUMP | `DEST(dest) | `RS1(re1) | `MISC_IMM(disp))
`define INSTR_PREDICATE(re1,re2,dest,cond) (`OP_PRED | `RS1(re1) | `RS2(re2) | `DEST(dest) | cond)

module vliw_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	
	wire [15:0] bus_out = mprj_io[20:5];
	wire le_hi = mprj_io[21];
	wire le_lo = mprj_io[22];
	wire bus_dir = mprj_io[23];
	
	wire OEb = mprj_io[24];
	wire WEb_lo = mprj_io[25];
	wire WEb_hi = mprj_io[26];
	
	reg URX;
	assign mprj_io[28] = URX;
	reg SDI;
	assign mprj_io[31] = SDI;
	wire UTX = mprj_io[27];
	wire SCLK = mprj_io[29];
	wire SDO = mprj_io[30];
	
	wire predicate = mprj_io[1];
	wire M1 = mprj_io[2];
	wire ioport = mprj_io[4];
	reg [5:0] ioport_in;
	assign mprj_io[37:32] = ioport_in;
	
	reg [15:0] test_input;
	reg [15:0] bus_in;
	reg design_rst;
	assign mprj_io[20:5] = !bus_dir ? 16'hzzzz : bus_in;
	
	reg [31:0] addr_latch;
	wire [31:0] curr_addr = {le_hi ? bus_out : addr_latch[31:16], le_lo ? bus_out : addr_latch[15:0]};
	
	assign mprj_io[0] = design_rst;
	assign mprj_io[3] = CSB;

	reg [41:0] i0;
	reg [41:0] i1;
	reg [41:0] i2;
	reg [1:0] stops;
	wire [127:0] pack = {stops, i2, i1, i0};

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
		addr_latch = 32'hFFFFAAAA;
		bus_in = 0;
		stops = 0;
		i0 = 0;
		i1 = 0;
		i2 = 0;
		design_rst = 0;
		test_input = 0;
		ioport_in = 0;
		URX = 1;
		SDI = 0;
	end
	
	always @(negedge le_lo) addr_latch[15:0] <= bus_out;
	always @(negedge le_hi) addr_latch[31:16] <= bus_out;

	always @(curr_addr) begin
		if(curr_addr[30]) begin
			bus_in <= test_input;
		end else begin
			case(curr_addr[2:0])
				0: bus_in <= pack[15:0];
				1: bus_in <= pack[31:16];
				2: bus_in <= pack[47:32];
				3: bus_in <= pack[63:48];
				4: bus_in <= pack[79:64];
				5: bus_in <= pack[95:80];
				6: bus_in <= pack[111:96];
				7: bus_in <= pack[127:112];
			endcase
		end
	end

	initial begin
		repeat (73) begin
			repeat (800) @(posedge clock);
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end
	
	reg [15:0] address;
	task check_reg(input [4:0] register, input [31:0] value);
		begin
			address = $random;
			address[0] = 0;
			$display(address);
			i0 = `INSTR_STORE32(0, register, {1'b0, address});
			i1 = `OP_NOP;
			i2 = `OP_NOP;
			instr_exec();
			failures += le_lo == 0;
			failures += le_hi != 0;
			failures += WEb_hi == 0 || WEb_lo == 0;
			@(posedge clock);
			#3;
			failures += le_lo != 0 || le_hi != 0;
			failures += WEb_hi != 0 || WEb_lo != 0;
			failures += OEb == 0;
			failures += bus_out != value[15:0];
			failures += curr_addr != (address >> 1);
			@(posedge clock);
			#3;
			failures += le_lo == 0;
			failures += le_hi != 0;
			failures += WEb_hi == 0 || WEb_lo == 0;
			@(posedge clock);
			#3;
			failures += le_lo != 0 || le_hi != 0;
			failures += WEb_hi != 0 || WEb_lo != 0;
			failures += OEb == 0;
			failures += bus_out != value[31:16];
			failures += curr_addr != ((address >> 1) + 1);
			i0 = `OP_NOP;
			@(posedge clock);
		end
	endtask
	
	integer failures = 0;
	reg [31:0] expected_PC;
	
	task instr_exec();
		begin
			if(expected_PC[31:16] != addr_latch[31:16]) begin
				#3;
				failures += le_lo != 0;
				failures += le_hi == 0;
				failures += OEb == 0;
				failures += WEb_hi == 0;
				failures += WEb_lo == 0;
				@(negedge clock);
				#3;
				failures += le_hi != 0;
				failures += le_lo != 0;
				failures += OEb == 0;
				failures += WEb_hi == 0;
				failures += WEb_lo == 0;
				@(posedge clock);
			end
			repeat(8) begin
				#3;
				failures += le_lo == 0;
				failures += le_hi != 0;
				failures += OEb == 0;
				failures += WEb_hi == 0;
				failures += WEb_lo == 0;
				@(negedge clock);
				#3;
				failures += le_lo != 0;
				failures += le_hi != 0;
				failures += OEb == 0;
				failures += WEb_hi == 0;
				failures += WEb_lo == 0;
				failures += curr_addr != expected_PC;
				expected_PC = expected_PC + 1;
				@(posedge clock);
				#3;
				failures += le_lo != 0;
				failures += le_hi != 0;
				failures += OEb != 0;
				failures += WEb_hi == 0;
				failures += WEb_lo == 0;
				@(posedge clock);
			end
			#3;
			failures += OEb == 0;
			failures += M1 != 0;
			@(posedge clock);
			#3;
			failures += OEb == 0;
			failures += M1 == 0;
		end
	endtask

	integer counter;
	reg [8:0] expected_states;
	initial begin
		$dumpfile("vliw.vcd");
		$dumpvars(1, vliw_tb);
		$dumpvars(1, vliw_tb.uut.chip_core.mprj);
		$dumpvars(0, vliw_tb.uut.chip_core.mprj.multiplexer);
		$dumpvars(0, vliw_tb.uut.chip_core.mprj.vliw);
		$dumpvars(0, vliw_tb.uut.chip_core.mprj.eu0);
		$dumpvars(0, vliw_tb.uut.chip_core.mprj.eu1);
		$dumpvars(0, vliw_tb.uut.chip_core.mprj.eu2);
		$dumpvars(0, vliw_tb.uut.chip_core.mprj.icache);
		wait(gpio == 0);
		wait(gpio == 1);
		$display("Monitor: Test started");
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		
		i0 = `INSTR_LLI(1, 16'hB017);
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		design_rst = 1;
		expected_PC = 0;
		addr_latch = 32'hFFFFAAAA;
		@(posedge clock);
		instr_exec();
		i0 = `INSTR_LUI(1, 16'h2024);
		instr_exec();
		i0 = `INSTR_STORE32(0, 1, 17'h003A8);
		instr_exec();
		failures += le_lo == 0;
		failures += le_hi != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_lo != 0 || le_hi != 0;
		failures += WEb_hi != 0 || WEb_lo != 0;
		failures += OEb == 0;
		failures += bus_out != 16'hB017;
		failures += curr_addr != 32'h000001D4;
		@(posedge clock);
		#3;
		failures += le_lo == 0;
		failures += le_hi != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_lo != 0 || le_hi != 0;
		failures += WEb_hi != 0 || WEb_lo != 0;
		failures += OEb == 0;
		failures += bus_out != 16'h2024;
		failures += curr_addr != 32'h000001D5;
		i0 = `INSTR_STORE16(1, 1, 17'h1FFFF);
		@(posedge clock);
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		@(posedge clock);
		#3;
		failures += le_lo != 0 || le_hi != 0;
		failures += WEb_hi != 0 || WEb_lo != 0;
		failures += OEb == 0;
		failures += bus_out != 16'hB017;
		failures += curr_addr != (32'h2024B016 >> 1);
		i0 = `INSTR_STORE8(0, 1, 17'h014AA);
		@(posedge clock);
		instr_exec();
		failures += le_lo == 0;
		failures += le_hi != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_lo != 0 || le_hi != 0;
		failures += WEb_hi == 0 || WEb_lo != 0;
		failures += OEb == 0;
		failures += bus_out[7:0] != 8'h17;
		failures += curr_addr != (32'h000014AA >> 1);
		i0 = `INSTR_STORE8(0, 1, 17'h014AB);
		@(posedge clock);
		instr_exec();
		failures += le_lo == 0;
		failures += le_hi != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_lo != 0 || le_hi != 0;
		failures += WEb_hi != 0 || WEb_lo == 0;
		failures += OEb == 0;
		failures += bus_out[15:8] != 8'h17;
		failures += curr_addr != (32'h000014AA >> 1);
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(1, 32'h2024B017);
		i0 = `INSTR_LUI(2, 16'h0001);
		instr_exec();
		i0 = `INSTR_LLI(2, 16'h8FC9);
		instr_exec();
		check_reg(2, 32'h00018FC9);
		i0 = `INSTR_ALU(1, 2, 3, `ALU_ADD);
		instr_exec();
		check_reg(3, 32'h20263FE0);
		i0 = `INSTR_ALU(1, 2, 3, `ALU_OR) | (1 << 40);
		instr_exec();
		check_reg(3, 32'h2026BFDF);
		i0 = `INSTR_ALU(3, 3, 3, `ALU_XOR) | (3 << 40);
		instr_exec();
		check_reg(3, 32'h0000BFDF);
		i0 = `INSTR_IMM(3, 16'h0304, 3, `ALU_OR) | `IMM_UPPER | (1 << 17);
		instr_exec();
		check_reg(3, 32'h0304BFDF);
		i0 = `INSTR_IMM(0, 32, 4, `ALU_ASR); //Actually rs1 + PC => dest
		instr_exec();
		check_reg(4, 32'h00000013);
		i0 = `INSTR_LLI(4, 16'h0130);
		instr_exec();
		i0 = `INSTR_IMM(4, 1, 4, `ALU_ASR);
		instr_exec();
		check_reg(4, 32'h00000098);
		i0 = `INSTR_IMM(4, 32768, 4, `ALU_OR) | `IMM_UPPER | (1 << 17);
		instr_exec();
		i0 = `INSTR_IMM(4, 2, 4, `ALU_ASR);
		instr_exec();
		check_reg(4, 32'hE0000026);
		i0 = `INSTR_IMM(4, 1, 4, `ALU_LSR);
		instr_exec();
		check_reg(4, 32'h70000013);
		i0 = `INSTR_IMM(4, 1, 4, `ALU_LSL);
		instr_exec();
		check_reg(4, 32'hE0000026);
		i0 = `INSTR_LOAD32(4, 3, 0);
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		test_input = 16'h39B8;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != (32'hE0000026 >> 1);
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		test_input = 16'h0938;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != (32'hE0000026 >> 1) + 1;
		i0 = `INSTR_LUI(10, 32768);
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'h093839B8);
		i0 = `INSTR_LOAD16(10, 3, 17'h02022);
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		test_input = 16'hAC29;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != 32'h40001011;
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'h0000AC29);
		i0 = `INSTR_LOAD16SE(10, 3, 17'h02822);
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		test_input = 16'hAC29;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != 32'h40001411;
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'hFFFFAC29);
		i0 = `INSTR_LOAD16(10, 3, 17'h04022) | 128;
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		test_input = 16'h2222;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != 32'h40002011;
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'hFFFF2222);
		i0 = `INSTR_LOAD8(10, 3, 17'h00010);
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		test_input = 16'hE234;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != 32'h40000008;
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'h00000034);
		i0 = `INSTR_LOAD8SE(10, 3, 17'h00011);
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		test_input = 16'hE234;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != 32'h40000008;
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'hFFFFFFE2);
		i0 = `INSTR_LUI(3, 16'h1234);
		instr_exec();
		i0 = `INSTR_LOAD8SE(10, 3, 17'h00010) | 128 | (1 << 24);
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		test_input = 16'h1012;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != 32'h40000008;
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'h1234FF12);
		i0 = `INSTR_LOAD8SE(10, 3, 17'h0002D) | 128;
		instr_exec();
		failures += le_hi == 0;
		failures += le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		test_input = 16'h2738;
		@(posedge clock);
		#3;
		failures += le_hi != 0;
		failures += le_lo == 0;
		failures += WEb_hi == 0 || WEb_lo == 0 || OEb == 0;
		@(posedge clock);
		#3;
		failures += le_hi != 0 || le_lo != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		failures += OEb != 0;
		failures += curr_addr != 32'h40000016;
		i0 = `OP_NOP;
		@(posedge clock);
		instr_exec();
		check_reg(3, 32'h12340027);
		
		//Branch and Jump instructions test
		i0 = `OP_NOP;
		instr_exec();
		i0 = `INSTR_BRANCH(3, 3, 17'h00010);
		instr_exec();
		expected_PC = expected_PC - 8 + 'h80;
		i0 = `OP_NOP;
		instr_exec();
		i0 = `INSTR_BRANCH(3, 10, 17'h00010);
		instr_exec();
		i0 = `OP_NOP;
		instr_exec();
		i0 = `INSTR_BRANCH(10, 3, 17'h1FFF0) | `BR_GTES;
		instr_exec();
		i0 = `OP_NOP;
		instr_exec();
		i0 = `INSTR_BRANCH(10, 3, 17'h1FFF0) | `BR_GTE;
		instr_exec();
		expected_PC = expected_PC - 8 - 'h80;
		i0 = `OP_NOP;
		instr_exec();
		
		i0 = `INSTR_IMM(3, 4, 3, `ALU_LSR);
		instr_exec();
		check_reg(3, 32'h01234002);
		i0 = `INSTR_JUMP(3, 10, 0);
		instr_exec();
		counter = expected_PC;
		expected_PC = 'h91A0010;
		i0 = `OP_NOP;
		instr_exec();
		i0 = `OP_NOP;
		instr_exec();
		i0 = `INSTR_JUMP(10, 0, 0);
		instr_exec();
		expected_PC = counter;
		i0 = `OP_NOP;
		instr_exec();
		i0 = `OP_NOP;
		instr_exec();
		
		//Predicate instructions test
		failures += predicate != 1;
		i0 = `INSTR_PREDICATE(3, 10, 1, `BR_EQL);
		instr_exec();
		failures += predicate != 0;
		i0 = `INSTR_LUI(5, 16'h0294);
		instr_exec();
		i0 = `INSTR_LLI(5, 16'h0202);
		instr_exec();
		check_reg(5, 32'h02940202);
		i0 = `INSTR_ALU(5, 3, 5, `ALU_SUB) | 256;
		instr_exec();
		check_reg(5, 32'h02940202);
		i0 = `INSTR_ALU(5, 3, 5, `ALU_SUB) | 768;
		instr_exec();
		check_reg(5, 32'h0170C200);
		i0 = `INSTR_PREDICATE(3, 10, 1, `BR_SIGN);
		instr_exec();
		failures += predicate != 1;
		i0 = `INSTR_PREDICATE(0, 0, 1, `BR_NEQL);
		instr_exec();
		failures += predicate != 0;
		i0 = `INSTR_PREDICATE(3, 5, 1, `BR_LTES);
		instr_exec();
		failures += predicate != 1;
		
		//Test executing multiple instructions now
		i0 = `INSTR_LUI(2, 16'hDEAD);
		i1 = `INSTR_LLI(2, 16'hBEEF);
		instr_exec();
		check_reg(2, 32'hDEADBEEF);
		
		i0 = `INSTR_STORE32(0, 2, 17'h00000);
		i1 = `INSTR_IMM(2, 1, 2, `ALU_ADD);
		i2 = `INSTR_IMM(2, 3, 3, `ALU_SUB);
		instr_exec();
		failures += le_lo == 0;
		failures += le_hi != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_lo != 0 || le_hi != 0;
		failures += WEb_hi != 0 || WEb_lo != 0;
		failures += OEb == 0;
		failures += bus_out != 16'hBEEF;
		@(posedge clock);
		#3;
		failures += le_lo == 0;
		failures += le_hi != 0;
		failures += WEb_hi == 0 || WEb_lo == 0;
		@(posedge clock);
		#3;
		failures += le_lo != 0 || le_hi != 0;
		failures += WEb_hi != 0 || WEb_lo != 0;
		failures += OEb == 0;
		failures += bus_out != 16'hDEAD;
		@(posedge clock);
		check_reg(2, 32'hDEADBEF0);
		check_reg(3, 32'hDEADBEEC);
		
		//Test built-in memory-mapped IO
		i0 = `INSTR_LUI(2, 16'hFFFF);
		i1 = `INSTR_LLI(3, 16'h0041);
		i2 = `INSTR_LLI(2, 16'hFF80);
		instr_exec();
		check_reg(2, 32'hFFFFFF80);
		//Enable icache already
		i0 = `INSTR_STORE32(2, 3, 17'h00034);
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		@(posedge clock);
		#3;
		i0 = `INSTR_STORE32(2, 3, 17'h0002C);
		i1 = `INSTR_LLI(3, 16'h0000);
		i2 = `OP_NOP;
		instr_exec();
		@(posedge clock);
		#3;
		failures += ioport != 1;
		i0 = `INSTR_STORE32(2, 3, 17'h00030);
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		@(posedge clock);
		#3;
		failures += ioport != 0;
		ioport_in = 6'h0A;
		i0 = `INSTR_LOAD32(2, 3, 17'h00034);
		i1 = `INSTR_LLI(31, 16'h0003);
		instr_exec();
		@(posedge clock);
		#3;
		check_reg(3, 32'h0000008A); //MSB is 1 because its reading the predicate presented at that pin
		i0 = `INSTR_STORE32(2, 31, 17'h00018);
		i1 = `INSTR_LLI(3, 16'h0069);
		i2 = `OP_NOP;
		instr_exec();
		@(posedge clock);
		#3;
		i0 = `INSTR_STORE32(2, 3, 17'h00020);
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		@(posedge clock);
		#3;
		i0 = `OP_NOP;
		@(negedge UTX);
		expected_states = 9'b100101101;
		repeat(9) begin
			repeat(4) @(posedge clock);
			#5;
			failures += UTX != expected_states[8];
			expected_states = {expected_states[7:0], 1'b1};
		end
		@(posedge M1);
		#3;
		expected_PC = addr_latch + 1;
		instr_exec();
		
		//Enable interrupts rq
		i0 = `INSTR_LUI(40, 16'hFFFF);
		i1 = `INSTR_LLI(50, 16'h0018);
		i2 = `INSTR_LLI(40, 16'hFF80);
		instr_exec();
		i0 = `INSTR_STORE32(40, 50, 17'h0003C);
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		@(posedge clock);
		#3;
		
		//Test stops
		check_reg(31, 32'h00000003);
		i0 = `INSTR_LLI(1, 1);
		i1 = `INSTR_LUI(1, 0);
		i2 = `OP_NOP;
		instr_exec();
		//This pack is technically bad because all three ops try to modify the same register
		//Only i0 will succeed, and so r31 is incremented by only 1
		i0 = `INSTR_ALU(31, 1, 31, `ALU_ADD);
		i1 = `INSTR_ALU(31, 1, 31, `ALU_ADD);
		i2 = `INSTR_ALU(31, 1, 31, `ALU_ADD);
		instr_exec();
		check_reg(31, 32'h00000004);
		//Now again, but with stops, so they are forced to execute in sequence
		i0 = `INSTR_ALU(31, 1, 31, `ALU_ADD);
		i1 = `INSTR_ALU(31, 1, 31, `ALU_ADD);
		i2 = `INSTR_ALU(31, 1, 31, `ALU_ADD);
		stops = 2'b11;
		instr_exec();
		@(posedge clock);
		#3;
		failures += M1 == 0 || OEb == 0 || le_lo != 0 || le_hi != 0;
		@(posedge clock);
		#3;
		failures += M1 == 0 || OEb == 0 || le_lo == 0 || le_hi != 0;
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		stops = 2'b00;
		instr_exec();
		check_reg(31, 32'h00000007); //With each instruction having executed in sequence, r31 got incremented 3 times
		
		//Test multiplication
		i0 = `INSTR_LLI(1, 16'h8007);
		i1 = `INSTR_LUI(1, 16'h1AC6);
		instr_exec();
		i0 = `INSTR_LLI(2, 16'h0909);
		i1 = `INSTR_LUI(2, 16'hA5C3);
		instr_exec();
		check_reg(1, 32'h1AC68007);
		check_reg(2, 32'hA5C30909);
		i0 = `INSTR_ALU(1, 2, 3, `ALU_MUL);
		i1 = `OP_NOP;
		i2 = `INSTR_ALU(1, 2, 4, `ALU_MULU);
		instr_exec();
		check_reg(3, 32'hF3CFBF3F);
		check_reg(4, 32'h115656A9);
		i0 = `INSTR_LUI(4, 0);
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		i0 = `INSTR_ALU(3, 4, 1, `ALU_DIV);
		i1 = `INSTR_ALU(3, 4, 2, `ALU_MOD);
		i2 = `OP_NOP;
		counter = 2;
		repeat(17) @(posedge clock);
		#3;
		counter = 1;
		repeat(33) begin
			failures += M1 != 0;
			failures += le_lo != 0 || le_hi != 0;
			failures += OEb == 0 || WEb_hi == 0 || WEb_lo == 0;
			@(posedge clock);
			#3;
		end
		failures += M1 == 0;
		failures += OEb == 0;
		expected_PC = expected_PC + 8;
		check_reg(1, 32'h0002D03C);
		check_reg(2, 32'h00001FA3);
		
		i0 = `INSTR_ALU(1, 2, 3, `ALU_DIV);
		i1 = `INSTR_ALU(1, 2, 4, `ALU_MOD);
		i2 = `OP_NOP;
		counter = 2;
		repeat(17) @(posedge clock);
		#3;
		counter = 1;
		repeat(33) begin
			failures += M1 != 0;
			failures += le_lo != 0 || le_hi != 0;
			failures += OEb == 0 || WEb_hi == 0 || WEb_lo == 0;
			@(posedge clock);
			#3;
		end
		failures += M1 == 0;
		failures += OEb == 0;
		expected_PC = expected_PC + 8;
		check_reg(3, 32'h00000016);
		check_reg(4, 32'h0000183A);
		
		//Test icache
		i0 = `INSTR_IMM(4, 4, 4, `ALU_ADD);
		i1 = `INSTR_IMM(3, 2, 3, `ALU_MUL);
		i2 = `OP_NOP;
		instr_exec();
		i2 = `INSTR_ALU(4, 3, 1, `ALU_XOR);
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		instr_exec();
		//Now branch back but also make sure this branch will not be taken again
		i0 = `INSTR_BRANCH(0, 0, 17'h1FFFE) | `BR_EQL | 256;
		i1 = `INSTR_PREDICATE(0, 0, 1, `BR_NEQL);
		i2 = `OP_NOP;
		instr_exec();
		//Now expecting three cache hits
		@(posedge clock); //One clock delay on first cache hit
		repeat(2) begin
			@(posedge clock);
			#3;
			failures += M1 == 0;
			failures += le_lo != 0 || le_hi != 0 || OEb == 0;
		end
		@(posedge clock);
		#3;
		failures += M1 == 0;
		failures += le_lo == 0 || le_hi != 0 || OEb == 0;
		check_reg(4, 32'h00001842);
		check_reg(3, 32'h00000058);
		check_reg(1, 32'h0000181A);
		
		//Trigger trap interrupt
		i0 = `OP_NOP;
		i1 = `INSTR_LLI(50, 16'h0004);
		i2 = `INSTR_LUI(50, 16'h0000);
		instr_exec();
		i0 = `INSTR_STORE32(40, 50, 17'h0003C);
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		@(posedge clock);
		#3;
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		i0 = `INSTR_LLI(50, 16'h0020);
		i1 = `INSTR_STORE32(40, 50, 17'h0003C);
		i2 = `OP_NOP;
		stops = 1;
		counter = expected_PC;
		expected_PC = 24; //Now in interrupt
		instr_exec();
		@(posedge clock);
		@(posedge clock);
		#3;
		stops = 0;
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		i1 = `INSTR_JUMP(63,0,0);
		instr_exec();
		expected_PC = counter;
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		instr_exec();
		
		i0 = `OP_NOP;
		i1 = `OP_NOP;
		i2 = `OP_NOP;
		@(posedge clock);
		@(posedge clock);
		if(failures == 0) begin
			$display("%c[1;32m",27);
			`ifdef GL
				$display("Monitor: Test (GL) Passed");
			`else
				$display("Monitor: Test (RTL) Passed");
			`endif
			$display("%c[0m",27);
		end else begin
			$display(failures);
			$display("%c[1;31m",27);
			`ifdef GL
				$display ("Monitor: Test (GL) Failed");
			`else
				$display ("Monitor: Test (RTL) Failed");
			`endif
			$display("%c[0m",27);
		end
	    $finish;
	end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#100000;
		//CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3 = power1;
	wire VDD1V8 = power2;
	wire USER_VDD3V3 = power3;
	wire USER_VDD1V8 = power4;
	wire VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("vliw.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
