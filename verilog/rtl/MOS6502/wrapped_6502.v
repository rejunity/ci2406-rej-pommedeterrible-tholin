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
  output io_oeb, //Output Enable Bar ; 0 = Output, 1 = Input
  input [1:0] custom_settings
);

wire WE;
wire WE_a = rst_n ? WE : 0;
assign io_out[27] = (custom_settings == 1 ? WE_a & (~wb_clk_i)  : (custom_settings == 2 ? WE_a & wb_clk_i : WE_a));
assign io_oeb = ~WE_a;
assign io_out[35:34] = 0;
assign io_out[30:28] = 0;

reg [7:0] din_latched;
always @(posedge wb_clk_i) begin
	if(rst_n) din_latched <= io_in[26:19];
	else din_latched <= 0;
end

MOS6502 MOS6502(
  .clk(wb_clk_i),
  .reset(~rst_n),
  .AB(io_out[18:3]),
  .DI(din_latched),
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
