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

module AS1802_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	
	reg design_rst;
	assign mprj_io[0] = design_rst;
	
	reg [7:0] dbus_in;
	wire IE = mprj_io[1];
	wire EXTEND = mprj_io[2];
	wire DF = mprj_io[4];
	wire [7:0] addr = mprj_io[12:5];
	wire [7:0] dbus_out = mprj_io[20:13];
	wire MRD = mprj_io[21];
	wire MWR = mprj_io[22];
	assign mprj_io[20:13] = MWR && !TPA ? dbus_in : 8'hzz;
	wire Q = mprj_io[23];
	wire TPA = mprj_io[24];
	wire SC0 = mprj_io[25];
	wire SC1 = mprj_io[26];
	assign mprj_io[27] = 1; //intr
	assign mprj_io[31:28] = 4'hF; //EF0, EF1, EF2, EF3
	wire [2:0] N = mprj_io[34:32];
	
	assign mprj_io[3] = CSB;
	
	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
		design_rst = 0;
		dbus_in = 8'hC4;
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
		$dumpfile("AS1802.vcd");
		$dumpvars(1, AS1802_tb);
		$dumpvars(1, AS1802_tb.uut.chip_core.mprj);
		$dumpvars(0, AS1802_tb.uut.chip_core.mprj.multiplexer);
		$dumpvars(0, AS1802_tb.uut.chip_core.mprj.wrapped_as1802);
		$display("Monitor: Test started");
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		#3;
		design_rst = 1;
		@(posedge clock);
		#3;
		failures += MWR == 0 || MRD == 0 || TPA != 0;
		@(posedge clock);
		#3;
		failures += TPA == 0;
		failures += addr != 0;
		failures += MRD != 0 || MWR == 0;
		repeat(2) begin
			@(posedge clock);
			#3;
			failures += TPA != 0;
			failures += addr != 0;
			failures += MRD != 0 || MWR == 0;
		end
		repeat(3) begin
			@(posedge clock);
			#3;
			failures += TPA != 0 || addr != 0 || MRD == 0 || MWR == 0;
		end
		@(posedge clock);
		#3;
		failures += addr != 1;
		failures += TPA != 0 || MWR == 0 || MRD != 0;
		dbus_in = 8'hF8; //LDI
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || addr != 2;
		dbus_in = 8'h39;
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || addr != 3;
		dbus_in = 8'hA3; //PLO R3
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || addr != 4;
		dbus_in = 8'hF8; //LDI
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || addr != 5;
		dbus_in = 8'h20;
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || addr != 6;
		dbus_in = 8'hB3; //PHI R3
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || addr != 7;
		dbus_in = 8'hF4; //ADD
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA == 0 || addr != 8'h20 || DF != 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 8'h20;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 8'h39;
		dbus_in = 8'hF3;
		@(posedge clock);
		#3;
		failures += MRD == 0 || TPA != 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD == 0 || TPA != 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA == 0 || addr != 0 || DF == 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 8;
		dbus_in = 8'h60; //IRX
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 9;
		dbus_in = 8'h53; //STR R3
		@(posedge clock);
		#3;
		failures += MRD == 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA == 0 || addr != 8'h20 || DF == 0 || MWR == 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 8'h20 || MWR == 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 8'h3A || MWR == 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 8'h3A || MWR != 0;
		failures += dbus_out != 8'h13;
		@(posedge clock);
		#3;
		failures += MRD == 0 || TPA != 0 || addr != 8'h3A || MWR == 0;
		@(posedge clock);
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA == 0 || addr != 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 0;
		@(posedge clock);
		#3;
		failures += MRD != 0 || TPA != 0 || addr != 10;
		
		dbus_in = 8'hC4;
		repeat(8) @(posedge clock);
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
		.FILENAME("AS1802.hex")
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
