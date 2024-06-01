`default_nettype none

module wrapped_6502(
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

wire WE;
assign io_out[27] = WE;
assign io_oeb[18:0] = 0;
assign io_oeb[26:19] = {8{~WE}};
assign io_oeb[30:28] = 3'b111;
assign io_oeb[33:31] = 0;
assign io_out[35:34] = 0;
assign io_oeb[35:34] = 2'b11;
assign io_out[30:28] = 0;

MOS6502 MOS6502(
  .clk(wb_clk_i),
  .reset(~rst_n),
  .AB(io_out[18:3]),
  .DI(io_in[26:19]),
  .DO(io_out[26:19]),
  .WE(WE),
  .IRQ(io_in[28]),
  .NMI(io_in[29]),
  .RDY(io_in[30]),
  .C(io_out[0]),
  .Z(io_out[1]),
  .D(io_out[2]),
  .I(io_out[31]),
  .V(io_out[32]),
  .N(io_out[33])
);

endmodule
