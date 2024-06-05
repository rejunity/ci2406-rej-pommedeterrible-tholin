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
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

wire [31:0] custom_settings;
wire [35:0] designs_io_in = {io_in[37:4], io_in[2:1]};

wire rst_scrapcpu;
wire [35:0] io_out_scrapcpu;
wire [35:0] io_oeb_scrapcpu;
wire rst_vliw;
wire [35:0] io_out_vliw;
wire [35:0] io_oeb_vliw;
wire rst_z80;
wire [35:0] io_out_z80;
wire [35:0] io_oeb_z80;
wire rst_6502;
wire [35:0] io_out_6502;
wire io_oeb_6502;
wire rst_as1802;
wire [35:0] io_out_as1802;
wire io_oeb_as1802;
wire rst_8x305;
wire [35:0] io_out_8x305;
wire [4:0] io_oeb_8x305;
wire [8:0] cap_addr;

multiplexer multiplexer(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_dat_i(wbs_dat_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_dat_o(wbs_dat_o),
    .la_data_out(la_data_out[39:0]),
    
    .rst_scrapcpu(rst_scrapcpu),
    .io_out_scrapcpu(io_out_scrapcpu),
    .io_oeb_scrapcpu(io_oeb_scrapcpu),
    
    .rst_vliw(rst_vliw),
    .io_out_vliw(io_out_vliw),
    .io_oeb_vliw(io_oeb_vliw),
    
    .rst_z80(rst_z80),
    .io_out_z80(io_out_z80),
    .io_oeb_z80(io_oeb_z80),
    
    .rst_6502(rst_6502),
    .io_out_6502(io_out_6502),
    .io_oeb_6502(io_oeb_6502),
    
    .rst_as1802(rst_as1802),
    .io_out_as1802(io_out_as1802),
    .io_oeb_as1802(io_oeb_as1802),
    
    .rst_8x305(rst_8x305),
    .io_out_8x305(io_out_8x305),
    .io_oeb_8x305(io_oeb_8x305),
    
    .io_in_0(io_in[0]),
    .cap_io_in(io_in[12:4]),
    .io_out(io_out),
    .io_oeb(io_oeb),
    
    .custom_settings(custom_settings),
    .cap_addr(cap_addr)
);

scrapcpu scrapcpu(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .rst_n(rst_scrapcpu),
    .io_in(designs_io_in),
    .io_out(io_out_scrapcpu),
    .io_oeb(io_oeb_scrapcpu)
);

unused_tie unused_tie(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .irq(user_irq),
    .la_data_out(la_data_out[127:40])
);

ci2406_z80 ci2406_z80(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .rst_n(rst_z80),
    .io_in(designs_io_in),
    .io_out(io_out_z80),
    .io_oeb(io_oeb_z80),
    .custom_settings(custom_settings[1:0])
);

wrapped_6502 wrapped_6502(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .io_in(designs_io_in),
    .rst_n(rst_6502),
    .io_out(io_out_6502),
    .io_oeb(io_oeb_6502),
    .custom_settings(custom_settings[1:0])
);

wrapped_as1802 wrapped_as1802(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .io_in(designs_io_in),
    .rst_n(rst_as1802),
    .io_out(io_out_as1802),
    .io_oeb(io_oeb_as1802),
    .custom_settings(custom_settings[29:0])
);

wrapped_8x305 wrapped_8x305(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .rst_n(rst_8x305),
    .io_out(io_out_8x305),
    .io_oeb(io_oeb_8x305),
    .io_in(designs_io_in),
    .custom_settings(custom_settings[1:0])
);

top_fgcaptest top_fgcaptest(
`ifdef USE_POWER_PINS
	.vccd2(vccd2),	// User area 1 1.8V power
	.vssd2(vssd2),	// User area 1 digital ground
`endif
    .addr(cap_addr)
);

`define NUM_REGS 64
`define REG_IDX ($clog2(`NUM_REGS)-1)

wire rst_eu;
wire [27:0] curr_PC;

wire [`REG_IDX:0] reg1_idx0;
wire [`REG_IDX:0] reg2_idx0;
wire [31:0]       dest_val0;
wire [1:0]        dest_mask0;
wire [`REG_IDX:0] dest_idx0;
wire [2:0]        pred_idx0;
wire [2:0]        dest_pred0;
wire              dest_pred_val0;
wire [31:0]       loadstore_address0;
wire              is_load0;
wire              is_store0;
wire              sign_extend0;
wire [1:0]        loadstore_size0;
wire [`REG_IDX:0] loadstore_dest0;
wire              take_branch0;
wire [27:0]       new_PC0;
wire              eu0_busy;
wire [41:0]       eu0_instruction;
wire [31:0]       reg1_val0;
wire [31:0]       reg2_val0;
wire              pred_val0;
wire              int_return0;

wire [`REG_IDX:0] reg1_idx1;
wire [`REG_IDX:0] reg2_idx1;
wire [31:0]       dest_val1;
wire [1:0]        dest_mask1;
wire [`REG_IDX:0] dest_idx1;
wire [2:0]        pred_idx1;
wire [2:0]        dest_pred1;
wire              dest_pred_val1;
wire [31:0]       loadstore_address1;
wire              is_load1;
wire              is_store1;
wire              sign_extend1;
wire [1:0]        loadstore_size1;
wire [`REG_IDX:0] loadstore_dest1;
wire              take_branch1;
wire [27:0]       new_PC1;
wire              eu1_busy;
wire [41:0]       eu1_instruction;
wire [31:0]       reg1_val1;
wire [31:0]       reg2_val1;
wire              pred_val1;
wire              int_return1;

wire [`REG_IDX:0] reg1_idx2;
wire [`REG_IDX:0] reg2_idx2;
wire [31:0]       dest_val2;
wire [1:0]        dest_mask2;
wire [`REG_IDX:0] dest_idx2;
wire [2:0]        pred_idx2;
wire [2:0]        dest_pred2;
wire              dest_pred_val2;
wire [31:0]       loadstore_address2;
wire              is_load2;
wire              is_store2;
wire              sign_extend2;
wire [1:0]        loadstore_size2;
wire [`REG_IDX:0] loadstore_dest2;
wire              take_branch2;
wire [27:0]       new_PC2;
wire              eu2_busy;
wire [41:0]       eu2_instruction;
wire [31:0]       reg1_val2;
wire [31:0]       reg2_val2;
wire              pred_val2;
wire              int_return2;

wire cache_hit;
wire cache_invalidate;
wire [127:0] cache_entry;
wire [127:0] cache_new_entry;
wire [27:0] cache_PC;
wire cache_rst;
wire cache_entry_valid;

vliw vliw(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
	.wb_clk_i(wb_clk_i),
	.rst_n(rst_vliw),
	.io_in(designs_io_in),
	.io_out(io_out_vliw),
	.io_oeb(io_oeb_vliw),
	.custom_settings(custom_settings[4:0]),
	
	.rst_eu(rst_eu),
	.curr_PC(curr_PC),
	
	.reg1_idx0(reg1_idx0),
	.reg2_idx0(reg2_idx0),
	.dest_val0(dest_val0),
	.dest_mask0(dest_mask0),
	.dest_idx0(dest_idx0),
	.pred_idx0(pred_idx0),
	.dest_pred0(dest_pred0),
	.dest_pred_val0(dest_pred_val0),
	.loadstore_address0(loadstore_address0),
	.is_load0(is_load0),
	.is_store0(is_store0),
	.sign_extend0(sign_extend0),
	.loadstore_size0(loadstore_size0),
	.loadstore_dest0(loadstore_dest0),
	.take_branch0(take_branch0),
	.new_PC0(new_PC0),
	.eu0_busy(eu0_busy),
	.eu0_instruction(eu0_instruction),
	.reg1_val0(reg1_val0),
	.reg2_val0(reg2_val0),
	.pred_val0(pred_val0),
	.int_return0(int_return0),
	
	.reg1_idx1(reg1_idx1),
	.reg2_idx1(reg2_idx1),
	.dest_val1(dest_val1),
	.dest_mask1(dest_mask1),
	.dest_idx1(dest_idx1),
	.pred_idx1(pred_idx1),
	.dest_pred1(dest_pred1),
	.dest_pred_val1(dest_pred_val1),
	.loadstore_address1(loadstore_address1),
	.is_load1(is_load1),
	.is_store1(is_store1),
	.sign_extend1(sign_extend1),
	.loadstore_size1(loadstore_size1),
	.loadstore_dest1(loadstore_dest1),
	.take_branch1(take_branch1),
	.new_PC1(new_PC1),
	.eu1_busy(eu1_busy),
	.eu1_instruction(eu1_instruction),
	.reg1_val1(reg1_val1),
	.reg2_val1(reg2_val1),
	.pred_val1(pred_val1),
	.int_return1(int_return1),
	
	.reg1_idx2(reg1_idx2),
	.reg2_idx2(reg2_idx2),
	.dest_val2(dest_val2),
	.dest_mask2(dest_mask2),
	.dest_idx2(dest_idx2),
	.pred_idx2(pred_idx2),
	.dest_pred2(dest_pred2),
	.dest_pred_val2(dest_pred_val2),
	.loadstore_address2(loadstore_address2),
	.is_load2(is_load2),
	.is_store2(is_store2),
	.sign_extend2(sign_extend2),
	.loadstore_size2(loadstore_size2),
	.loadstore_dest2(loadstore_dest2),
	.take_branch2(take_branch2),
	.new_PC2(new_PC2),
	.eu2_busy(eu2_busy),
	.eu2_instruction(eu2_instruction),
	.reg1_val2(reg1_val2),
	.reg2_val2(reg2_val2),
	.pred_val2(pred_val2),
	.int_return2(int_return2),
	
	.cache_hit(cache_hit),
	.cache_invalidate(cache_invalidate),
	.cache_entry(cache_entry),
	.cache_new_entry(cache_new_entry),
	.cache_PC(cache_PC),
	.cache_rst(cache_rst),
	.cache_entry_valid(cache_entry_valid)
);

icache icache(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .rst(cache_rst),
    .curr_PC(cache_PC),
    .cache_entry(cache_entry),
    .cache_hit(cache_hit),
    .new_entry(cache_new_entry),
    .entry_valid(cache_entry_valid),
    .invalidate(cache_invalidate)
);

execution_unit eu0(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .rst(rst_eu),
    .curr_PC(curr_PC),
    
    .instruction(eu0_instruction),
    .reg1_idx(reg1_idx0),
    .reg2_idx(reg2_idx0),
    .reg1_val(reg1_val0),
    .reg2_val(reg2_val0),
    .dest_val(dest_val0),
    .dest_mask(dest_mask0),
    .dest_idx(dest_idx0),
    .pred_idx(pred_idx0),
    .pred_val(pred_val0),
    .dest_pred(dest_pred0),
    .dest_pred_val(dest_pred_val0),
    .loadstore_address(loadstore_address0),
    .loadstore_dest(loadstore_dest0),
    .is_load(is_load0),
    .is_store(is_store0),
    .sign_extend(sign_extend0),
    .loadstore_size(loadstore_size0),
    .take_branch(take_branch0),
    .new_PC(new_PC0),
    .busy(eu0_busy),
    .int_return(int_return0)
);

execution_unit eu1(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .rst(rst_eu),
    .curr_PC(curr_PC),
    
    .instruction(eu1_instruction),
    .reg1_idx(reg1_idx1),
    .reg2_idx(reg2_idx1),
    .reg1_val(reg1_val1),
    .reg2_val(reg2_val1),
    .dest_val(dest_val1),
    .dest_mask(dest_mask1),
    .dest_idx(dest_idx1),
    .pred_idx(pred_idx1),
    .pred_val(pred_val1),
    .dest_pred(dest_pred1),
    .dest_pred_val(dest_pred_val1),
    .loadstore_address(loadstore_address1),
    .loadstore_dest(loadstore_dest1),
    .is_load(is_load1),
    .is_store(is_store1),
    .sign_extend(sign_extend1),
    .loadstore_size(loadstore_size1),
    .take_branch(take_branch1),
    .new_PC(new_PC1),
    .busy(eu1_busy),
    .int_return(int_return1)
);

execution_unit eu2(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .rst(rst_eu),
    .curr_PC(curr_PC),
    
    .instruction(eu2_instruction),
    .reg1_idx(reg1_idx2),
    .reg2_idx(reg2_idx2),
    .reg1_val(reg1_val2),
    .reg2_val(reg2_val2),
    .dest_val(dest_val2),
    .dest_mask(dest_mask2),
    .dest_idx(dest_idx2),
    .pred_idx(pred_idx2),
    .pred_val(pred_val2),
    .dest_pred(dest_pred2),
    .dest_pred_val(dest_pred_val2),
    .loadstore_address(loadstore_address2),
    .loadstore_dest(loadstore_dest2),
    .is_load(is_load2),
    .is_store(is_store2),
    .sign_extend(sign_extend2),
    .loadstore_size(loadstore_size2),
    .take_branch(take_branch2),
    .new_PC(new_PC2),
    .busy(eu2_busy),
    .int_return(int_return2)
);

endmodule	// user_project_wrapper

`default_nettype wire
