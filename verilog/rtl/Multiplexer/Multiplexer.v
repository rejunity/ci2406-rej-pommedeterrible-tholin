`default_nettype none
module multiplexer(
`ifdef USE_POWER_PINS
	inout vccd1,
	inout vssd1,
`endif
	input io_in_0, //Dedicated reset pin
	output [37:0] io_out, //Multiplexed outputs
	output [37:0] io_oeb, //Multiplexed inputs
	input wb_clk_i,
	input wb_rst_i,

	//Wishbone bus
	input [31:0] wbs_adr_i,
	input [31:0] wbs_dat_i,
	output [31:0] wbs_dat_o,
	input wbs_we_i,
	input wbs_cyc_i,
	input wbs_stb_i,
	output wbs_ack_o,
	
	output rst_scrapcpu,
	input [35:0] io_out_scrapcpu,
	input [35:0] io_oeb_scrapcpu,
	
	output rst_vliw,
	input [35:0] io_out_vliw,
	input [35:0] io_oeb_vliw,
	
	output rst_z80,
	input [35:0] io_out_z80,
	input [35:0] io_oeb_z80,
	
	output reg [31:0] custom_settings,
	output [39:0] la_data_out
);
reg [3:0] design_select;

//Wishbone bus states
reg wb_ready;
reg [31:0] wbs_o_buff;
reg [31:0] wb_counter;
reg wb_feedback_delay;
assign wbs_dat_o = wbs_o_buff;
assign wbs_ack_o = wb_ready;
//Allow the management controller to override the user design reset
reg wb_override_act;
reg wb_rst_override;

wire wb_valid = wbs_cyc_i && wbs_stb_i; //Is there currently a valid WB transfer request?
wire design_rst_base = wb_override_act ? wb_rst_override : io_in_0;

//These are not actually latches. The `always @(*)` is further down.
reg [35:0] design_out;
reg [35:0] design_oeb;

assign io_out = {design_out[35:2], wb_counter[25], design_out[1:0], 1'b0};
assign io_oeb = {design_oeb[35:2], 1'b0, design_oeb[1:0], 1'b1};

/*
 * Logic analyzer probe assignments
 */
assign la_data_out[37:0] = io_oeb;
assign la_data_out[38] = io_in_0;
assign la_data_out[39] = design_rst_base;

reg [31:0] wbs_dat_delaybuff;
reg [3:0] wbs_adr_delaybuff;
always @(posedge wb_clk_i) begin
	wbs_dat_delaybuff <= wbs_dat_i;
	wbs_adr_delaybuff <= {wbs_adr_i[20], wbs_adr_i[4:2]};
	if(wb_rst_i) begin
		wb_override_act <= 0;
		design_select   <= 0;
		wb_ready        <= 0;
		wb_counter      <= 0;
		wbs_o_buff      <= 0;
		wb_rst_override <= 1;
		custom_settings <= 0;
	end else begin
		wb_counter <= wb_counter + 1;
		if(wb_valid && wb_feedback_delay && !wb_ready && wbs_adr_delaybuff[3]) begin
			if(wbs_adr_delaybuff[2:0] == 1) begin
				if(wbs_we_i) begin
					wb_override_act <= wbs_dat_delaybuff[0];
					wb_rst_override <= wbs_dat_delaybuff[1];
					design_select <= wbs_dat_delaybuff[5:2];
				end
				wbs_o_buff <= {24'h0, 2'b11, design_select, wb_rst_override, wb_override_act};
			end else if(wbs_adr_delaybuff[2:0] == 2) begin
				if(wbs_we_i) wb_counter <= wbs_dat_delaybuff;
				wbs_o_buff <= wb_counter;
			end else if(wbs_adr_delaybuff[2:0] == 3) begin
				if(wbs_we_i) custom_settings <= wbs_dat_delaybuff;
				wbs_o_buff <= custom_settings;
			end else begin
				wbs_o_buff <= 32'hFFFFFFFF;
			end
		end
		wb_feedback_delay <= wb_valid;
		wb_ready <= wb_feedback_delay;
	end
end

assign rst_z80 = design_select == 1 && design_rst_base;
assign rst_scrapcpu = design_select == 2 && design_rst_base;
assign rst_vliw = design_select == 3 && design_rst_base;

always @(*) begin
	case(design_select)
		1: begin
			design_out = io_out_z80;
			design_oeb = io_oeb_z80;
		end
		2: begin
			design_out = io_out_scrapcpu;
			design_oeb = io_oeb_scrapcpu;
		end
		3: begin
			design_out = io_out_vliw;
			design_oeb = io_oeb_vliw;
		end
		default: begin
			design_out = 36'h0;
			design_oeb = 36'hFFFFFFFFF;
		end
	endcase
end

endmodule
