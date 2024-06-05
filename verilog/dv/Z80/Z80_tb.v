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

module Z80_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	
	reg design_rst;
	assign mprj_io[0] = design_rst;
	
    // 5th revision:
    // c[]  - caravel mprj_io[] pin
    // io[] - multiplexer's io_in/out/oebp[] port
    //                   ,----------------.___.----------------.
    //      <--    A11 1 |io[17] c[19] 57       55 c[18] io[16]|40 A10    -->
    //      <--    A12 2 |io[18] c[20] 58       54 c[17] io[15]|39 A9     -->
    //      <--    A13 3 |io[29] c[21] 59       53 c[16] io[14]|38 A8     -->
    //      <--    A14 4 |io[20] c[22] 60       51 c[15] io[13]|37 A7     -->
    //      <--    A15 5 |io[21] c[23] 61       50 c[14] io[12]|36 A6     -->
    //      -->    CLK 6 |------ ocs_o 22       48 c[13] io[11]|35 A5     -->
    //      <->     D4 7 |io[22] c[24] 62       42 c[ 8] io[ 6]|34 A4     -->
    //      <->     D3 8 |io[23] c[25]  2       43 c[ 9] io[ 7]|33 A3     -->
    //      <->     D5 9 |io[24] c[26]  3       44 c[10] io[ 8]|32 A2     -->
    //      <->     D6 10|io[25] c[27]  4       46 c[12] io[10]|31 A1     -->
    //         VCC_5V0 11|                      45 c[11] io[ 9]|30 A0     -->
    //      <->     D2 12|io[26] c[28]  5                      |29 GND
    //      <->     D7 13|io[27] c[29]  6       41 c[ 7] io[ 5]|28 /RFSH  -->
    //      <->     D0 14|io[29] c[31]  8       33 c[ 2] io[*1]|27 /M1    -->
    //      <->     D1 15|io[28] c[30]  7       31 c[ 0] ------|26 /RESET <--
    //      -->   /INT 16|io[31] c[33] 12       16 c[37] io[35]|25 /BUSRQ <--
    //      -->   /NMI 17|io[30] c[32] 11       37 c[ 6] io[ 4]|24 /WAIT  <--
    //      <--  /HALT 18|io[32] c[34] 13 *     32 c[ 1] io[*0]|23 /BUSAK -->
    //      <--  /MREQ 19|io[33] c[35] 14 *     36 c[ 5] io[ 3]|22 /WR    -->
    //      <--  /IORQ 20|io[34] c[36] 15 *     35 c[ 4] io[ 2]|21 /RD    -->
    //                   `-------------------------------------'

	wire busak_n = mprj_io[1];
	wire m1_n = mprj_io[2];
	wire rd_n = mprj_io[4];
	wire wr_n = mprj_io[5];
	wire rfsh_n = mprj_io[7];
	wire halt_n = mprj_io[34];
	wire mreq_n = mprj_io[35];
	wire iorq_n = mprj_io[36];
	wire [15:0] address = {mprj_io[23:13], mprj_io[8], mprj_io[9], mprj_io[10], mprj_io[12], mprj_io[11]};
	wire [7:0] dbus_out = {	mprj_io[29],  // D7
							mprj_io[27],
							mprj_io[26],
							mprj_io[24],
							mprj_io[25],
							mprj_io[28],
							mprj_io[30],
							mprj_io[31]}; // D0
	reg [7:0] dbus_in;
	assign mprj_io[29] = rd_n ? 1'bz : dbus_in[7];
	assign mprj_io[27] = rd_n ? 1'bz : dbus_in[6];
	assign mprj_io[26] = rd_n ? 1'bz : dbus_in[5];
	assign mprj_io[24] = rd_n ? 1'bz : dbus_in[4];
	assign mprj_io[25] = rd_n ? 1'bz : dbus_in[3];
	assign mprj_io[28] = rd_n ? 1'bz : dbus_in[2];
	assign mprj_io[30] = rd_n ? 1'bz : dbus_in[1];
	assign mprj_io[31] = rd_n ? 1'bz : dbus_in[0];
	
	reg int_n;
	reg nmi_n;
	reg wait_n;
	reg busrq_n;
	assign mprj_io[6] = wait_n;
	assign mprj_io[32] = nmi_n;
	assign mprj_io[33] = int_n;
	assign mprj_io[37] = busrq_n;
	
	assign mprj_io[3] = CSB;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
		design_rst = 0;
		dbus_in = 0;
		int_n = 1;
		nmi_n = 1;
		wait_n = 1;
		busrq_n = 1;
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

	integer refresh = 1;
	integer failures = 0;
	initial begin
		wait(gpio == 0);
		wait(gpio == 1);
		$dumpfile("Z80.vcd");
		$dumpvars(1, Z80_tb);
		$dumpvars(1, Z80_tb.uut.chip_core.mprj);
		$dumpvars(0, Z80_tb.uut.chip_core.mprj.multiplexer);
		$dumpvars(0, Z80_tb.uut.chip_core.mprj.ci2406_z80);
		$display("Monitor: Test started");
		@(posedge clock);
		@(posedge clock);
		@(posedge clock);
		design_rst = 1;
`ifndef GL
		@(posedge clock);
`endif
		@(posedge clock);
		#3;
		failures += mreq_n != 0;
		failures += address != 0;
		failures += rd_n != 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 0;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == refresh;
		failures += address != 0;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 1;
		failures += rd_n == 0;
		
		@(posedge clock);
		#3;
		failures += mreq_n != 0;
		failures += address != 1;
		failures += rd_n != 0;
		dbus_in = 8'h3E; //ld a,n
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 1;
		failures += rd_n == 0;
		failures += wr_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == refresh;
		failures += address != 1;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 2;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n != 0;
		failures += address != 2;
		failures += rd_n != 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 2;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 3;
		failures += rd_n == 0;
		//a should now be 0x3E
		
		@(posedge clock);
		#3;
		failures += mreq_n != 0;
		failures += address != 3;
		failures += rd_n != 0;
		dbus_in = 8'hD6; //sub a,n
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 2;// refresh adrress otherwise 3
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == refresh;
		failures += address != 2; // refresh adrress otherwise 3
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 4;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n != 0;
		failures += address != 4;
		failures += rd_n != 0;
		dbus_in = 8'h21;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 4;
		failures += rd_n == 0;
		failures += wr_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 5;
		failures += rd_n == 0;
		failures += wr_n == 0;
		//a should now be 0x1D
		
		@(posedge clock);
		#3;
		failures += mreq_n != 0 || iorq_n == 0;
		failures += address != 5;
		failures += rd_n != 0;
		dbus_in = 8'h32; //ld (nn),a
		@(posedge clock);
		#3;
		failures += mreq_n == 0 || iorq_n == 0;
		failures += address != 3;  // refresh adrress otherwise 5
		failures += rd_n == 0;
		failures += wr_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == refresh;
		failures += address != 3; // refresh adrress otherwise 5
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 6;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n != 0 || iorq_n == 0;
		failures += address != 6;
		failures += rd_n != 0;
		failures += wr_n == 0;
		dbus_in = 8'h20;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 6;
		failures += rd_n == 0;
		failures += wr_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 7;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n != 0 || iorq_n == 0;
		failures += address != 7;
		failures += rd_n != 0;
		failures += wr_n == 0;
		dbus_in = 8'hAA;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 7;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 16'hAA20;
		failures += rd_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n != 0;
		failures += address != 16'hAA20;
		failures += rd_n == 0;
		failures += wr_n != 0;
		failures += dbus_out != 8'h1D;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 16'hAA20;
		failures += rd_n == 0;
		failures += wr_n == 0;
		@(posedge clock);
		#3;
		failures += mreq_n == 0;
		failures += address != 8;
		failures += rd_n == 0;
		failures += wr_n == 0;
		
		@(posedge clock);
		#3;
		failures += mreq_n != 0 || iorq_n == 0;
		failures += address != 8;
		failures += rd_n != 0;
		
		dbus_in = 0;
		repeat(5) @(posedge clock);
		$display(failures);
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
		.FILENAME("Z80.hex")
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
