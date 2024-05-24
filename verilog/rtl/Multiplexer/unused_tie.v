`default_nettype none

module unused_tie(
`ifdef USE_POWER_PINS
	inout vccd1,
	inout vssd1,
`endif
	output [2:0] irq,
	output [87:0] la_data_out,
	input wb_clk_i,
	input wb_rst_i
);

assign irq = 3'b000;
reg [87:0] test;
assign la_data_out = test;

always @(posedge wb_clk_i) begin
	if(wb_rst_i) begin
		test <= 1;
	end else begin
		test <= {test[0], test[87:1]};
	end
end

endmodule
