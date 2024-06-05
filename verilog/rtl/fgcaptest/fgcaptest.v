`default_nettype none
(* blackbox *)
module top_fgcaptest(
`ifdef USE_POWER_PINS
  inout vccd2,	// User area 1 1.8V supply
  inout vssd2,	// User area 1 digital ground
`endif
  input [8:0] addr
);

endmodule
