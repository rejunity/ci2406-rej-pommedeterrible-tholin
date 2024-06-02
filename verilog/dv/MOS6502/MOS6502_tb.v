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

module MOS6502_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	
	reg design_rst;
	assign mprj_io[0] = design_rst;
	
	wire C = mprj_io[1];
	wire Z = mprj_io[2];
	wire D = mprj_io[4];
	wire [15:0] addr = mprj_io[20:5];
	wire [7:0] dbus_out = mprj_io[28:21];
	wire WE = mprj_io[29];
	assign mprj_io[28:21] = WE ? 8'hzz : dbus_in;
	assign mprj_io[32:30] = 3'b111;
	wire I = mprj_io[33];
	wire V = mprj_io[34];
	wire N = mprj_io[35];
	
	assign mprj_io[3] = CSB;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
		design_rst = 0;
	end
	
	reg [7:0] dbus_in;
	always @(*) begin
		case(addr)
			default: dbus_in = 8'hEA;
			'hEAEC: dbus_in = 8'hA9;
			'hEAED: dbus_in = 8'hCC;
			'hEAEE: dbus_in = 8'h65;
			'hEAEF: dbus_in = 8'h40;
			'h0040: dbus_in = 8'h50;
			'hEAF0: dbus_in = 8'h8D;
			'hEAF1: dbus_in = 8'h55;
			'hEAF2: dbus_in = 8'h30;
		endcase
	end

	initial begin
		repeat (70) begin
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
		$dumpfile("MOS6502.vcd");
		$dumpvars(1, MOS6502_tb);
		$dumpvars(1, MOS6502_tb.uut.chip_core.mprj);
		$dumpvars(0, MOS6502_tb.uut.chip_core.mprj.multiplexer);
		$dumpvars(0, MOS6502_tb.uut.chip_core.mprj.wrapped_6502);
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
		failures += addr != 16'hFFFC || WE != 0;
		failures += Z == 0;
		failures += N != 0;
		@(posedge clock);
		#3;
		failures += addr != 16'hFFFD || WE != 0;
		@(posedge clock);
		#3;
		failures += addr != 16'hEAEA || WE != 0;
		@(posedge clock);
		#3;
		failures += WE != 0;
		failures += addr != 16'hEAEB;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAEC;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAEC;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAED;
		failures += C != 0;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAEE;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAEF;
		@(posedge clock);
		#3;
		failures += Z != 0;
		failures += N == 0;
		failures += WE != 0 || addr != 16'h0040;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAF0;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAF1;
		failures += C != 0;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAF2;
		failures += C == 0;
		failures += N != 0;
		failures += Z != 0;
		@(posedge clock);
		#3;
		failures += WE == 0 || addr != 16'h3055;
		failures += dbus_out != 8'h1C;
		@(posedge clock);
		#3;
		failures += WE != 0 || addr != 16'hEAF3;
		
		dbus_in = 8'hEA;
		repeat(5) @(posedge clock);
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
		.FILENAME("MOS6502.hex")
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
