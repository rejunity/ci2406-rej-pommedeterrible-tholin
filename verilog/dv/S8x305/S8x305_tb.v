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

`include "W25Q128JVxIM.v"

`timescale 1 ns / 1 ps

module S8x305_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	
	reg design_rst;
	assign mprj_io[0] = design_rst;
	wire IV_out = mprj_io[12:5];
	wire RB = mprj_io[13];
	wire LB = mprj_io[14];
	wire SC = mprj_io[15];
	wire WC = mprj_io[16];
	wire MCLK = mprj_io[17];
	reg IV_in;
	assign mprj_io[12:5] = WC || SC ? 8'hzz : IV_in;
	wire ROM_cs = mprj_io[22];
	wire ROM_sclk = mprj_io[23];
	wire [3:0] romlines = mprj_io[21:18];
	
	wire [7:0] outp = {mprj_io[1], mprj_io[37:31]};
	wire instr_ready = mprj_io[2];
	reg [7:0] inp;
	assign mprj_io[4] = inp[7];
	assign mprj_io[30:24] = inp[6:0];
	
	assign mprj_io[3] = CSB;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
		design_rst = 0;
		IV_in = 0;
		inp = 0;
	end

	initial begin
		repeat (71) begin
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

	integer failures = 0;
	initial begin
		wait(gpio == 0);
		wait(gpio == 1);
		$dumpfile("S8x305.vcd");
		$dumpvars(1, S8x305_tb);
		$dumpvars(1, S8x305_tb.uut.chip_core.mprj);
		$dumpvars(0, S8x305_tb.uut.chip_core.mprj.multiplexer);
		$dumpvars(0, S8x305_tb.uut.chip_core.mprj.wrapped_8x305);
		$display("Monitor: Test started");
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		#3;
		design_rst = 1;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		#3;
		repeat(10) @(negedge instr_ready);
		#3;
		failures += outp != 8'h59;
		
		@(negedge instr_ready);
		repeat(60) @(posedge clock);
		if(failures != 0) begin
			$display(failures);
			$display("%c[1;31m",27);
			`ifdef GL
				$display ("Monitor: Test (GL) Failed");
			`else
				$display ("Monitor: Test (RTL) Failed");
			`endif
			$display("%c[0m",27);
		end else begin
			$display("%c[1;32m",27);
			`ifdef GL
				$display("Monitor: Test (GL) Passed");
			`else
				$display("Monitor: Test (RTL) Passed");
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
		.FILENAME("S8x305.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);
	
	W25Q128JVxIM W25Q128JVxIM(
		.CSn(ROM_cs),
		.CLK(ROM_sclk),
		.DIO(mprj_io[18]),
		.DO(mprj_io[19]),
		.WPn(mprj_io[20]),
		.HOLDn(mprj_io[21])
	);
endmodule
`default_nettype wire
