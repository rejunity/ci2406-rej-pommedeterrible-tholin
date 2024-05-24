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

module scrapcpu_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	wire ROM_cs = mprj_io[9];
	wire ROM_sclk = mprj_io[10];
	wire [5:0] port1 = mprj_io[16:11];
	wire [3:0] port2 = mprj_io[20:17];
	reg [2:0] port_in;
	assign mprj_io[22:21] = port_in;
	wire instr = mprj_io[23];
	wire zero_flag = mprj_io[1];
	wire carry_flag = mprj_io[2];
	
	assign mprj_io[31] = 1'b0;
	
	assign mprj_io[0] = 1'b0;
	
	assign mprj_io[3] = CSB;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
		port_in = 0;
	end

	initial begin
		repeat (53) begin
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
		wait(gpio == 0);
		$dumpfile("scrapcpu.vcd");
		$dumpvars(1, scrapcpu_tb);
		$dumpvars(1, scrapcpu_tb.W25Q128JVxIM);
		$dumpvars(1, scrapcpu_tb.uut.chip_core.mprj);
		$dumpvars(0, scrapcpu_tb.uut.chip_core.mprj.multiplexer);
		$dumpvars(0, scrapcpu_tb.uut.chip_core.mprj.scrapcpu);
		$display("Monitor: Test started");
		repeat (6) @(posedge instr);
		#3;
		failures += port1 != 0;
		failures += port2 != 0;
		repeat (5) @(posedge instr);
		#3;
		failures += port1 != 28;
		@(posedge instr);
		failures += port1 != 28;
		repeat (5) @(posedge instr);
		#3;
		failures += port1 != 21;
		failures += carry_flag != 0;
		failures += zero_flag != 0;
		@(posedge instr);
		#3;
		failures += port1 != 5;
		repeat (3) @(posedge instr);
		#3;
		failures += port1 != 27;
		failures += carry_flag == 0;
		failures += zero_flag != 0;
		repeat (3) @(posedge instr);
		#3;
		failures += port1 != 60;
		failures += carry_flag != 0;
		failures += zero_flag != 0;
		repeat (4) @(posedge instr);
		#3;
		failures += port1 != 26;
		failures += carry_flag == 0;
		failures += zero_flag != 0;
		@(posedge instr);
		#3;
		failures += carry_flag != 0;
		repeat (2) @(posedge instr);
		#3;
		failures += zero_flag != 1;
		failures += carry_flag != 0;
		failures += port1 != 0;
		@(posedge instr);
		#3;
		failures += port1 != 32;
		failures += zero_flag != 0;
		failures += carry_flag != 0;
		repeat (4) @(posedge instr);
		#3;
		failures += port1 != 63;
		failures += zero_flag != 0;
		repeat (8) @(posedge instr);
		#3;
		failures += port1 != 0;
		failures += zero_flag == 0;
		repeat (4) @(posedge instr);
		#3;
		failures += port1 != 34;
		
		@(posedge instr);
		#3;
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
		.FILENAME("scrapcpu.hex")
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
		.DIO(mprj_io[5]),
		.DO(mprj_io[6]),
		.WPn(mprj_io[7]),
		.HOLDn(mprj_io[8])
	);

endmodule
`default_nettype wire
