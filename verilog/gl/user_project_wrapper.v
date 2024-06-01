module user_project_wrapper (user_clock2,
    vccd1,
    vccd2,
    vdda1,
    vdda2,
    vssa1,
    vssa2,
    vssd1,
    vssd2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input vccd1;
 input vccd2;
 input vdda1;
 input vdda2;
 input vssa1;
 input vssa2;
 input vssd1;
 input vssd2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;

 wire \curr_PC[0] ;
 wire \curr_PC[10] ;
 wire \curr_PC[11] ;
 wire \curr_PC[12] ;
 wire \curr_PC[13] ;
 wire \curr_PC[14] ;
 wire \curr_PC[15] ;
 wire \curr_PC[16] ;
 wire \curr_PC[17] ;
 wire \curr_PC[18] ;
 wire \curr_PC[19] ;
 wire \curr_PC[1] ;
 wire \curr_PC[20] ;
 wire \curr_PC[21] ;
 wire \curr_PC[22] ;
 wire \curr_PC[23] ;
 wire \curr_PC[24] ;
 wire \curr_PC[25] ;
 wire \curr_PC[26] ;
 wire \curr_PC[27] ;
 wire \curr_PC[2] ;
 wire \curr_PC[3] ;
 wire \curr_PC[4] ;
 wire \curr_PC[5] ;
 wire \curr_PC[6] ;
 wire \curr_PC[7] ;
 wire \curr_PC[8] ;
 wire \curr_PC[9] ;
 wire \custom_settings[0] ;
 wire \custom_settings[10] ;
 wire \custom_settings[11] ;
 wire \custom_settings[12] ;
 wire \custom_settings[13] ;
 wire \custom_settings[14] ;
 wire \custom_settings[15] ;
 wire \custom_settings[16] ;
 wire \custom_settings[17] ;
 wire \custom_settings[18] ;
 wire \custom_settings[19] ;
 wire \custom_settings[1] ;
 wire \custom_settings[20] ;
 wire \custom_settings[21] ;
 wire \custom_settings[22] ;
 wire \custom_settings[23] ;
 wire \custom_settings[24] ;
 wire \custom_settings[25] ;
 wire \custom_settings[26] ;
 wire \custom_settings[27] ;
 wire \custom_settings[28] ;
 wire \custom_settings[29] ;
 wire \custom_settings[2] ;
 wire \custom_settings[30] ;
 wire \custom_settings[31] ;
 wire \custom_settings[3] ;
 wire \custom_settings[4] ;
 wire \custom_settings[5] ;
 wire \custom_settings[6] ;
 wire \custom_settings[7] ;
 wire \custom_settings[8] ;
 wire \custom_settings[9] ;
 wire \dest_idx0[0] ;
 wire \dest_idx0[1] ;
 wire \dest_idx0[2] ;
 wire \dest_idx0[3] ;
 wire \dest_idx0[4] ;
 wire \dest_idx1[0] ;
 wire \dest_idx1[1] ;
 wire \dest_idx1[2] ;
 wire \dest_idx1[3] ;
 wire \dest_idx1[4] ;
 wire \dest_idx2[0] ;
 wire \dest_idx2[1] ;
 wire \dest_idx2[2] ;
 wire \dest_idx2[3] ;
 wire \dest_idx2[4] ;
 wire \dest_mask0[0] ;
 wire \dest_mask0[1] ;
 wire \dest_mask1[0] ;
 wire \dest_mask1[1] ;
 wire \dest_mask2[0] ;
 wire \dest_mask2[1] ;
 wire \dest_pred0[0] ;
 wire \dest_pred0[1] ;
 wire \dest_pred0[2] ;
 wire \dest_pred1[0] ;
 wire \dest_pred1[1] ;
 wire \dest_pred1[2] ;
 wire \dest_pred2[0] ;
 wire \dest_pred2[1] ;
 wire \dest_pred2[2] ;
 wire dest_pred_val0;
 wire dest_pred_val1;
 wire dest_pred_val2;
 wire \dest_val0[0] ;
 wire \dest_val0[10] ;
 wire \dest_val0[11] ;
 wire \dest_val0[12] ;
 wire \dest_val0[13] ;
 wire \dest_val0[14] ;
 wire \dest_val0[15] ;
 wire \dest_val0[16] ;
 wire \dest_val0[17] ;
 wire \dest_val0[18] ;
 wire \dest_val0[19] ;
 wire \dest_val0[1] ;
 wire \dest_val0[20] ;
 wire \dest_val0[21] ;
 wire \dest_val0[22] ;
 wire \dest_val0[23] ;
 wire \dest_val0[24] ;
 wire \dest_val0[25] ;
 wire \dest_val0[26] ;
 wire \dest_val0[27] ;
 wire \dest_val0[28] ;
 wire \dest_val0[29] ;
 wire \dest_val0[2] ;
 wire \dest_val0[30] ;
 wire \dest_val0[31] ;
 wire \dest_val0[3] ;
 wire \dest_val0[4] ;
 wire \dest_val0[5] ;
 wire \dest_val0[6] ;
 wire \dest_val0[7] ;
 wire \dest_val0[8] ;
 wire \dest_val0[9] ;
 wire \dest_val1[0] ;
 wire \dest_val1[10] ;
 wire \dest_val1[11] ;
 wire \dest_val1[12] ;
 wire \dest_val1[13] ;
 wire \dest_val1[14] ;
 wire \dest_val1[15] ;
 wire \dest_val1[16] ;
 wire \dest_val1[17] ;
 wire \dest_val1[18] ;
 wire \dest_val1[19] ;
 wire \dest_val1[1] ;
 wire \dest_val1[20] ;
 wire \dest_val1[21] ;
 wire \dest_val1[22] ;
 wire \dest_val1[23] ;
 wire \dest_val1[24] ;
 wire \dest_val1[25] ;
 wire \dest_val1[26] ;
 wire \dest_val1[27] ;
 wire \dest_val1[28] ;
 wire \dest_val1[29] ;
 wire \dest_val1[2] ;
 wire \dest_val1[30] ;
 wire \dest_val1[31] ;
 wire \dest_val1[3] ;
 wire \dest_val1[4] ;
 wire \dest_val1[5] ;
 wire \dest_val1[6] ;
 wire \dest_val1[7] ;
 wire \dest_val1[8] ;
 wire \dest_val1[9] ;
 wire \dest_val2[0] ;
 wire \dest_val2[10] ;
 wire \dest_val2[11] ;
 wire \dest_val2[12] ;
 wire \dest_val2[13] ;
 wire \dest_val2[14] ;
 wire \dest_val2[15] ;
 wire \dest_val2[16] ;
 wire \dest_val2[17] ;
 wire \dest_val2[18] ;
 wire \dest_val2[19] ;
 wire \dest_val2[1] ;
 wire \dest_val2[20] ;
 wire \dest_val2[21] ;
 wire \dest_val2[22] ;
 wire \dest_val2[23] ;
 wire \dest_val2[24] ;
 wire \dest_val2[25] ;
 wire \dest_val2[26] ;
 wire \dest_val2[27] ;
 wire \dest_val2[28] ;
 wire \dest_val2[29] ;
 wire \dest_val2[2] ;
 wire \dest_val2[30] ;
 wire \dest_val2[31] ;
 wire \dest_val2[3] ;
 wire \dest_val2[4] ;
 wire \dest_val2[5] ;
 wire \dest_val2[6] ;
 wire \dest_val2[7] ;
 wire \dest_val2[8] ;
 wire \dest_val2[9] ;
 wire eu0_busy;
 wire \eu0_instruction[0] ;
 wire \eu0_instruction[10] ;
 wire \eu0_instruction[11] ;
 wire \eu0_instruction[12] ;
 wire \eu0_instruction[13] ;
 wire \eu0_instruction[14] ;
 wire \eu0_instruction[15] ;
 wire \eu0_instruction[16] ;
 wire \eu0_instruction[17] ;
 wire \eu0_instruction[18] ;
 wire \eu0_instruction[19] ;
 wire \eu0_instruction[1] ;
 wire \eu0_instruction[20] ;
 wire \eu0_instruction[21] ;
 wire \eu0_instruction[22] ;
 wire \eu0_instruction[23] ;
 wire \eu0_instruction[24] ;
 wire \eu0_instruction[25] ;
 wire \eu0_instruction[26] ;
 wire \eu0_instruction[27] ;
 wire \eu0_instruction[28] ;
 wire \eu0_instruction[29] ;
 wire \eu0_instruction[2] ;
 wire \eu0_instruction[30] ;
 wire \eu0_instruction[31] ;
 wire \eu0_instruction[32] ;
 wire \eu0_instruction[33] ;
 wire \eu0_instruction[34] ;
 wire \eu0_instruction[35] ;
 wire \eu0_instruction[36] ;
 wire \eu0_instruction[37] ;
 wire \eu0_instruction[38] ;
 wire \eu0_instruction[39] ;
 wire \eu0_instruction[3] ;
 wire \eu0_instruction[40] ;
 wire \eu0_instruction[41] ;
 wire \eu0_instruction[4] ;
 wire \eu0_instruction[5] ;
 wire \eu0_instruction[6] ;
 wire \eu0_instruction[7] ;
 wire \eu0_instruction[8] ;
 wire \eu0_instruction[9] ;
 wire eu1_busy;
 wire \eu1_instruction[0] ;
 wire \eu1_instruction[10] ;
 wire \eu1_instruction[11] ;
 wire \eu1_instruction[12] ;
 wire \eu1_instruction[13] ;
 wire \eu1_instruction[14] ;
 wire \eu1_instruction[15] ;
 wire \eu1_instruction[16] ;
 wire \eu1_instruction[17] ;
 wire \eu1_instruction[18] ;
 wire \eu1_instruction[19] ;
 wire \eu1_instruction[1] ;
 wire \eu1_instruction[20] ;
 wire \eu1_instruction[21] ;
 wire \eu1_instruction[22] ;
 wire \eu1_instruction[23] ;
 wire \eu1_instruction[24] ;
 wire \eu1_instruction[25] ;
 wire \eu1_instruction[26] ;
 wire \eu1_instruction[27] ;
 wire \eu1_instruction[28] ;
 wire \eu1_instruction[29] ;
 wire \eu1_instruction[2] ;
 wire \eu1_instruction[30] ;
 wire \eu1_instruction[31] ;
 wire \eu1_instruction[32] ;
 wire \eu1_instruction[33] ;
 wire \eu1_instruction[34] ;
 wire \eu1_instruction[35] ;
 wire \eu1_instruction[36] ;
 wire \eu1_instruction[37] ;
 wire \eu1_instruction[38] ;
 wire \eu1_instruction[39] ;
 wire \eu1_instruction[3] ;
 wire \eu1_instruction[40] ;
 wire \eu1_instruction[41] ;
 wire \eu1_instruction[4] ;
 wire \eu1_instruction[5] ;
 wire \eu1_instruction[6] ;
 wire \eu1_instruction[7] ;
 wire \eu1_instruction[8] ;
 wire \eu1_instruction[9] ;
 wire eu2_busy;
 wire \eu2_instruction[0] ;
 wire \eu2_instruction[10] ;
 wire \eu2_instruction[11] ;
 wire \eu2_instruction[12] ;
 wire \eu2_instruction[13] ;
 wire \eu2_instruction[14] ;
 wire \eu2_instruction[15] ;
 wire \eu2_instruction[16] ;
 wire \eu2_instruction[17] ;
 wire \eu2_instruction[18] ;
 wire \eu2_instruction[19] ;
 wire \eu2_instruction[1] ;
 wire \eu2_instruction[20] ;
 wire \eu2_instruction[21] ;
 wire \eu2_instruction[22] ;
 wire \eu2_instruction[23] ;
 wire \eu2_instruction[24] ;
 wire \eu2_instruction[25] ;
 wire \eu2_instruction[26] ;
 wire \eu2_instruction[27] ;
 wire \eu2_instruction[28] ;
 wire \eu2_instruction[29] ;
 wire \eu2_instruction[2] ;
 wire \eu2_instruction[30] ;
 wire \eu2_instruction[31] ;
 wire \eu2_instruction[32] ;
 wire \eu2_instruction[33] ;
 wire \eu2_instruction[34] ;
 wire \eu2_instruction[35] ;
 wire \eu2_instruction[36] ;
 wire \eu2_instruction[37] ;
 wire \eu2_instruction[38] ;
 wire \eu2_instruction[39] ;
 wire \eu2_instruction[3] ;
 wire \eu2_instruction[40] ;
 wire \eu2_instruction[41] ;
 wire \eu2_instruction[4] ;
 wire \eu2_instruction[5] ;
 wire \eu2_instruction[6] ;
 wire \eu2_instruction[7] ;
 wire \eu2_instruction[8] ;
 wire \eu2_instruction[9] ;
 wire \io_oeb_scrapcpu[0] ;
 wire \io_oeb_scrapcpu[10] ;
 wire \io_oeb_scrapcpu[11] ;
 wire \io_oeb_scrapcpu[12] ;
 wire \io_oeb_scrapcpu[13] ;
 wire \io_oeb_scrapcpu[14] ;
 wire \io_oeb_scrapcpu[15] ;
 wire \io_oeb_scrapcpu[16] ;
 wire \io_oeb_scrapcpu[17] ;
 wire \io_oeb_scrapcpu[18] ;
 wire \io_oeb_scrapcpu[19] ;
 wire \io_oeb_scrapcpu[1] ;
 wire \io_oeb_scrapcpu[20] ;
 wire \io_oeb_scrapcpu[21] ;
 wire \io_oeb_scrapcpu[22] ;
 wire \io_oeb_scrapcpu[23] ;
 wire \io_oeb_scrapcpu[24] ;
 wire \io_oeb_scrapcpu[25] ;
 wire \io_oeb_scrapcpu[26] ;
 wire \io_oeb_scrapcpu[27] ;
 wire \io_oeb_scrapcpu[28] ;
 wire \io_oeb_scrapcpu[29] ;
 wire \io_oeb_scrapcpu[2] ;
 wire \io_oeb_scrapcpu[30] ;
 wire \io_oeb_scrapcpu[31] ;
 wire \io_oeb_scrapcpu[32] ;
 wire \io_oeb_scrapcpu[33] ;
 wire \io_oeb_scrapcpu[34] ;
 wire \io_oeb_scrapcpu[35] ;
 wire \io_oeb_scrapcpu[3] ;
 wire \io_oeb_scrapcpu[4] ;
 wire \io_oeb_scrapcpu[5] ;
 wire \io_oeb_scrapcpu[6] ;
 wire \io_oeb_scrapcpu[7] ;
 wire \io_oeb_scrapcpu[8] ;
 wire \io_oeb_scrapcpu[9] ;
 wire \io_oeb_vliw[0] ;
 wire \io_oeb_vliw[10] ;
 wire \io_oeb_vliw[11] ;
 wire \io_oeb_vliw[12] ;
 wire \io_oeb_vliw[13] ;
 wire \io_oeb_vliw[14] ;
 wire \io_oeb_vliw[15] ;
 wire \io_oeb_vliw[16] ;
 wire \io_oeb_vliw[17] ;
 wire \io_oeb_vliw[18] ;
 wire \io_oeb_vliw[19] ;
 wire \io_oeb_vliw[1] ;
 wire \io_oeb_vliw[20] ;
 wire \io_oeb_vliw[21] ;
 wire \io_oeb_vliw[22] ;
 wire \io_oeb_vliw[23] ;
 wire \io_oeb_vliw[24] ;
 wire \io_oeb_vliw[25] ;
 wire \io_oeb_vliw[26] ;
 wire \io_oeb_vliw[27] ;
 wire \io_oeb_vliw[28] ;
 wire \io_oeb_vliw[29] ;
 wire \io_oeb_vliw[2] ;
 wire \io_oeb_vliw[30] ;
 wire \io_oeb_vliw[31] ;
 wire \io_oeb_vliw[32] ;
 wire \io_oeb_vliw[33] ;
 wire \io_oeb_vliw[34] ;
 wire \io_oeb_vliw[35] ;
 wire \io_oeb_vliw[3] ;
 wire \io_oeb_vliw[4] ;
 wire \io_oeb_vliw[5] ;
 wire \io_oeb_vliw[6] ;
 wire \io_oeb_vliw[7] ;
 wire \io_oeb_vliw[8] ;
 wire \io_oeb_vliw[9] ;
 wire \io_oeb_z80[0] ;
 wire \io_oeb_z80[10] ;
 wire \io_oeb_z80[11] ;
 wire \io_oeb_z80[12] ;
 wire \io_oeb_z80[13] ;
 wire \io_oeb_z80[14] ;
 wire \io_oeb_z80[15] ;
 wire \io_oeb_z80[16] ;
 wire \io_oeb_z80[17] ;
 wire \io_oeb_z80[18] ;
 wire \io_oeb_z80[19] ;
 wire \io_oeb_z80[1] ;
 wire \io_oeb_z80[20] ;
 wire \io_oeb_z80[21] ;
 wire \io_oeb_z80[22] ;
 wire \io_oeb_z80[23] ;
 wire \io_oeb_z80[24] ;
 wire \io_oeb_z80[25] ;
 wire \io_oeb_z80[26] ;
 wire \io_oeb_z80[27] ;
 wire \io_oeb_z80[28] ;
 wire \io_oeb_z80[29] ;
 wire \io_oeb_z80[2] ;
 wire \io_oeb_z80[30] ;
 wire \io_oeb_z80[31] ;
 wire \io_oeb_z80[32] ;
 wire \io_oeb_z80[33] ;
 wire \io_oeb_z80[34] ;
 wire \io_oeb_z80[35] ;
 wire \io_oeb_z80[3] ;
 wire \io_oeb_z80[4] ;
 wire \io_oeb_z80[5] ;
 wire \io_oeb_z80[6] ;
 wire \io_oeb_z80[7] ;
 wire \io_oeb_z80[8] ;
 wire \io_oeb_z80[9] ;
 wire \io_out_scrapcpu[0] ;
 wire \io_out_scrapcpu[10] ;
 wire \io_out_scrapcpu[11] ;
 wire \io_out_scrapcpu[12] ;
 wire \io_out_scrapcpu[13] ;
 wire \io_out_scrapcpu[14] ;
 wire \io_out_scrapcpu[15] ;
 wire \io_out_scrapcpu[16] ;
 wire \io_out_scrapcpu[17] ;
 wire \io_out_scrapcpu[18] ;
 wire \io_out_scrapcpu[19] ;
 wire \io_out_scrapcpu[1] ;
 wire \io_out_scrapcpu[20] ;
 wire \io_out_scrapcpu[21] ;
 wire \io_out_scrapcpu[22] ;
 wire \io_out_scrapcpu[23] ;
 wire \io_out_scrapcpu[24] ;
 wire \io_out_scrapcpu[25] ;
 wire \io_out_scrapcpu[26] ;
 wire \io_out_scrapcpu[27] ;
 wire \io_out_scrapcpu[28] ;
 wire \io_out_scrapcpu[29] ;
 wire \io_out_scrapcpu[2] ;
 wire \io_out_scrapcpu[30] ;
 wire \io_out_scrapcpu[31] ;
 wire \io_out_scrapcpu[32] ;
 wire \io_out_scrapcpu[33] ;
 wire \io_out_scrapcpu[34] ;
 wire \io_out_scrapcpu[35] ;
 wire \io_out_scrapcpu[3] ;
 wire \io_out_scrapcpu[4] ;
 wire \io_out_scrapcpu[5] ;
 wire \io_out_scrapcpu[6] ;
 wire \io_out_scrapcpu[7] ;
 wire \io_out_scrapcpu[8] ;
 wire \io_out_scrapcpu[9] ;
 wire \io_out_vliw[0] ;
 wire \io_out_vliw[10] ;
 wire \io_out_vliw[11] ;
 wire \io_out_vliw[12] ;
 wire \io_out_vliw[13] ;
 wire \io_out_vliw[14] ;
 wire \io_out_vliw[15] ;
 wire \io_out_vliw[16] ;
 wire \io_out_vliw[17] ;
 wire \io_out_vliw[18] ;
 wire \io_out_vliw[19] ;
 wire \io_out_vliw[1] ;
 wire \io_out_vliw[20] ;
 wire \io_out_vliw[21] ;
 wire \io_out_vliw[22] ;
 wire \io_out_vliw[23] ;
 wire \io_out_vliw[24] ;
 wire \io_out_vliw[25] ;
 wire \io_out_vliw[26] ;
 wire \io_out_vliw[27] ;
 wire \io_out_vliw[28] ;
 wire \io_out_vliw[29] ;
 wire \io_out_vliw[2] ;
 wire \io_out_vliw[30] ;
 wire \io_out_vliw[31] ;
 wire \io_out_vliw[32] ;
 wire \io_out_vliw[33] ;
 wire \io_out_vliw[34] ;
 wire \io_out_vliw[35] ;
 wire \io_out_vliw[3] ;
 wire \io_out_vliw[4] ;
 wire \io_out_vliw[5] ;
 wire \io_out_vliw[6] ;
 wire \io_out_vliw[7] ;
 wire \io_out_vliw[8] ;
 wire \io_out_vliw[9] ;
 wire \io_out_z80[0] ;
 wire \io_out_z80[10] ;
 wire \io_out_z80[11] ;
 wire \io_out_z80[12] ;
 wire \io_out_z80[13] ;
 wire \io_out_z80[14] ;
 wire \io_out_z80[15] ;
 wire \io_out_z80[16] ;
 wire \io_out_z80[17] ;
 wire \io_out_z80[18] ;
 wire \io_out_z80[19] ;
 wire \io_out_z80[1] ;
 wire \io_out_z80[20] ;
 wire \io_out_z80[21] ;
 wire \io_out_z80[22] ;
 wire \io_out_z80[23] ;
 wire \io_out_z80[24] ;
 wire \io_out_z80[25] ;
 wire \io_out_z80[26] ;
 wire \io_out_z80[27] ;
 wire \io_out_z80[28] ;
 wire \io_out_z80[29] ;
 wire \io_out_z80[2] ;
 wire \io_out_z80[30] ;
 wire \io_out_z80[31] ;
 wire \io_out_z80[32] ;
 wire \io_out_z80[33] ;
 wire \io_out_z80[34] ;
 wire \io_out_z80[35] ;
 wire \io_out_z80[3] ;
 wire \io_out_z80[4] ;
 wire \io_out_z80[5] ;
 wire \io_out_z80[6] ;
 wire \io_out_z80[7] ;
 wire \io_out_z80[8] ;
 wire \io_out_z80[9] ;
 wire is_load0;
 wire is_load1;
 wire is_load2;
 wire is_store0;
 wire is_store1;
 wire is_store2;
 wire \loadstore_address0[0] ;
 wire \loadstore_address0[10] ;
 wire \loadstore_address0[11] ;
 wire \loadstore_address0[12] ;
 wire \loadstore_address0[13] ;
 wire \loadstore_address0[14] ;
 wire \loadstore_address0[15] ;
 wire \loadstore_address0[16] ;
 wire \loadstore_address0[17] ;
 wire \loadstore_address0[18] ;
 wire \loadstore_address0[19] ;
 wire \loadstore_address0[1] ;
 wire \loadstore_address0[20] ;
 wire \loadstore_address0[21] ;
 wire \loadstore_address0[22] ;
 wire \loadstore_address0[23] ;
 wire \loadstore_address0[24] ;
 wire \loadstore_address0[25] ;
 wire \loadstore_address0[26] ;
 wire \loadstore_address0[27] ;
 wire \loadstore_address0[28] ;
 wire \loadstore_address0[29] ;
 wire \loadstore_address0[2] ;
 wire \loadstore_address0[30] ;
 wire \loadstore_address0[31] ;
 wire \loadstore_address0[3] ;
 wire \loadstore_address0[4] ;
 wire \loadstore_address0[5] ;
 wire \loadstore_address0[6] ;
 wire \loadstore_address0[7] ;
 wire \loadstore_address0[8] ;
 wire \loadstore_address0[9] ;
 wire \loadstore_address1[0] ;
 wire \loadstore_address1[10] ;
 wire \loadstore_address1[11] ;
 wire \loadstore_address1[12] ;
 wire \loadstore_address1[13] ;
 wire \loadstore_address1[14] ;
 wire \loadstore_address1[15] ;
 wire \loadstore_address1[16] ;
 wire \loadstore_address1[17] ;
 wire \loadstore_address1[18] ;
 wire \loadstore_address1[19] ;
 wire \loadstore_address1[1] ;
 wire \loadstore_address1[20] ;
 wire \loadstore_address1[21] ;
 wire \loadstore_address1[22] ;
 wire \loadstore_address1[23] ;
 wire \loadstore_address1[24] ;
 wire \loadstore_address1[25] ;
 wire \loadstore_address1[26] ;
 wire \loadstore_address1[27] ;
 wire \loadstore_address1[28] ;
 wire \loadstore_address1[29] ;
 wire \loadstore_address1[2] ;
 wire \loadstore_address1[30] ;
 wire \loadstore_address1[31] ;
 wire \loadstore_address1[3] ;
 wire \loadstore_address1[4] ;
 wire \loadstore_address1[5] ;
 wire \loadstore_address1[6] ;
 wire \loadstore_address1[7] ;
 wire \loadstore_address1[8] ;
 wire \loadstore_address1[9] ;
 wire \loadstore_address2[0] ;
 wire \loadstore_address2[10] ;
 wire \loadstore_address2[11] ;
 wire \loadstore_address2[12] ;
 wire \loadstore_address2[13] ;
 wire \loadstore_address2[14] ;
 wire \loadstore_address2[15] ;
 wire \loadstore_address2[16] ;
 wire \loadstore_address2[17] ;
 wire \loadstore_address2[18] ;
 wire \loadstore_address2[19] ;
 wire \loadstore_address2[1] ;
 wire \loadstore_address2[20] ;
 wire \loadstore_address2[21] ;
 wire \loadstore_address2[22] ;
 wire \loadstore_address2[23] ;
 wire \loadstore_address2[24] ;
 wire \loadstore_address2[25] ;
 wire \loadstore_address2[26] ;
 wire \loadstore_address2[27] ;
 wire \loadstore_address2[28] ;
 wire \loadstore_address2[29] ;
 wire \loadstore_address2[2] ;
 wire \loadstore_address2[30] ;
 wire \loadstore_address2[31] ;
 wire \loadstore_address2[3] ;
 wire \loadstore_address2[4] ;
 wire \loadstore_address2[5] ;
 wire \loadstore_address2[6] ;
 wire \loadstore_address2[7] ;
 wire \loadstore_address2[8] ;
 wire \loadstore_address2[9] ;
 wire \loadstore_dest0[0] ;
 wire \loadstore_dest0[1] ;
 wire \loadstore_dest0[2] ;
 wire \loadstore_dest0[3] ;
 wire \loadstore_dest0[4] ;
 wire \loadstore_dest1[0] ;
 wire \loadstore_dest1[1] ;
 wire \loadstore_dest1[2] ;
 wire \loadstore_dest1[3] ;
 wire \loadstore_dest1[4] ;
 wire \loadstore_dest2[0] ;
 wire \loadstore_dest2[1] ;
 wire \loadstore_dest2[2] ;
 wire \loadstore_dest2[3] ;
 wire \loadstore_dest2[4] ;
 wire \loadstore_size0[0] ;
 wire \loadstore_size0[1] ;
 wire \loadstore_size1[0] ;
 wire \loadstore_size1[1] ;
 wire \loadstore_size2[0] ;
 wire \loadstore_size2[1] ;
 wire \new_PC0[0] ;
 wire \new_PC0[10] ;
 wire \new_PC0[11] ;
 wire \new_PC0[12] ;
 wire \new_PC0[13] ;
 wire \new_PC0[14] ;
 wire \new_PC0[15] ;
 wire \new_PC0[16] ;
 wire \new_PC0[17] ;
 wire \new_PC0[18] ;
 wire \new_PC0[19] ;
 wire \new_PC0[1] ;
 wire \new_PC0[20] ;
 wire \new_PC0[21] ;
 wire \new_PC0[22] ;
 wire \new_PC0[23] ;
 wire \new_PC0[24] ;
 wire \new_PC0[25] ;
 wire \new_PC0[26] ;
 wire \new_PC0[27] ;
 wire \new_PC0[2] ;
 wire \new_PC0[3] ;
 wire \new_PC0[4] ;
 wire \new_PC0[5] ;
 wire \new_PC0[6] ;
 wire \new_PC0[7] ;
 wire \new_PC0[8] ;
 wire \new_PC0[9] ;
 wire \new_PC1[0] ;
 wire \new_PC1[10] ;
 wire \new_PC1[11] ;
 wire \new_PC1[12] ;
 wire \new_PC1[13] ;
 wire \new_PC1[14] ;
 wire \new_PC1[15] ;
 wire \new_PC1[16] ;
 wire \new_PC1[17] ;
 wire \new_PC1[18] ;
 wire \new_PC1[19] ;
 wire \new_PC1[1] ;
 wire \new_PC1[20] ;
 wire \new_PC1[21] ;
 wire \new_PC1[22] ;
 wire \new_PC1[23] ;
 wire \new_PC1[24] ;
 wire \new_PC1[25] ;
 wire \new_PC1[26] ;
 wire \new_PC1[27] ;
 wire \new_PC1[2] ;
 wire \new_PC1[3] ;
 wire \new_PC1[4] ;
 wire \new_PC1[5] ;
 wire \new_PC1[6] ;
 wire \new_PC1[7] ;
 wire \new_PC1[8] ;
 wire \new_PC1[9] ;
 wire \new_PC2[0] ;
 wire \new_PC2[10] ;
 wire \new_PC2[11] ;
 wire \new_PC2[12] ;
 wire \new_PC2[13] ;
 wire \new_PC2[14] ;
 wire \new_PC2[15] ;
 wire \new_PC2[16] ;
 wire \new_PC2[17] ;
 wire \new_PC2[18] ;
 wire \new_PC2[19] ;
 wire \new_PC2[1] ;
 wire \new_PC2[20] ;
 wire \new_PC2[21] ;
 wire \new_PC2[22] ;
 wire \new_PC2[23] ;
 wire \new_PC2[24] ;
 wire \new_PC2[25] ;
 wire \new_PC2[26] ;
 wire \new_PC2[27] ;
 wire \new_PC2[2] ;
 wire \new_PC2[3] ;
 wire \new_PC2[4] ;
 wire \new_PC2[5] ;
 wire \new_PC2[6] ;
 wire \new_PC2[7] ;
 wire \new_PC2[8] ;
 wire \new_PC2[9] ;
 wire \pred_idx0[0] ;
 wire \pred_idx0[1] ;
 wire \pred_idx0[2] ;
 wire \pred_idx1[0] ;
 wire \pred_idx1[1] ;
 wire \pred_idx1[2] ;
 wire \pred_idx2[0] ;
 wire \pred_idx2[1] ;
 wire \pred_idx2[2] ;
 wire pred_val0;
 wire pred_val1;
 wire pred_val2;
 wire \reg1_idx0[0] ;
 wire \reg1_idx0[1] ;
 wire \reg1_idx0[2] ;
 wire \reg1_idx0[3] ;
 wire \reg1_idx0[4] ;
 wire \reg1_idx1[0] ;
 wire \reg1_idx1[1] ;
 wire \reg1_idx1[2] ;
 wire \reg1_idx1[3] ;
 wire \reg1_idx1[4] ;
 wire \reg1_idx2[0] ;
 wire \reg1_idx2[1] ;
 wire \reg1_idx2[2] ;
 wire \reg1_idx2[3] ;
 wire \reg1_idx2[4] ;
 wire \reg1_val0[0] ;
 wire \reg1_val0[10] ;
 wire \reg1_val0[11] ;
 wire \reg1_val0[12] ;
 wire \reg1_val0[13] ;
 wire \reg1_val0[14] ;
 wire \reg1_val0[15] ;
 wire \reg1_val0[16] ;
 wire \reg1_val0[17] ;
 wire \reg1_val0[18] ;
 wire \reg1_val0[19] ;
 wire \reg1_val0[1] ;
 wire \reg1_val0[20] ;
 wire \reg1_val0[21] ;
 wire \reg1_val0[22] ;
 wire \reg1_val0[23] ;
 wire \reg1_val0[24] ;
 wire \reg1_val0[25] ;
 wire \reg1_val0[26] ;
 wire \reg1_val0[27] ;
 wire \reg1_val0[28] ;
 wire \reg1_val0[29] ;
 wire \reg1_val0[2] ;
 wire \reg1_val0[30] ;
 wire \reg1_val0[31] ;
 wire \reg1_val0[3] ;
 wire \reg1_val0[4] ;
 wire \reg1_val0[5] ;
 wire \reg1_val0[6] ;
 wire \reg1_val0[7] ;
 wire \reg1_val0[8] ;
 wire \reg1_val0[9] ;
 wire \reg1_val1[0] ;
 wire \reg1_val1[10] ;
 wire \reg1_val1[11] ;
 wire \reg1_val1[12] ;
 wire \reg1_val1[13] ;
 wire \reg1_val1[14] ;
 wire \reg1_val1[15] ;
 wire \reg1_val1[16] ;
 wire \reg1_val1[17] ;
 wire \reg1_val1[18] ;
 wire \reg1_val1[19] ;
 wire \reg1_val1[1] ;
 wire \reg1_val1[20] ;
 wire \reg1_val1[21] ;
 wire \reg1_val1[22] ;
 wire \reg1_val1[23] ;
 wire \reg1_val1[24] ;
 wire \reg1_val1[25] ;
 wire \reg1_val1[26] ;
 wire \reg1_val1[27] ;
 wire \reg1_val1[28] ;
 wire \reg1_val1[29] ;
 wire \reg1_val1[2] ;
 wire \reg1_val1[30] ;
 wire \reg1_val1[31] ;
 wire \reg1_val1[3] ;
 wire \reg1_val1[4] ;
 wire \reg1_val1[5] ;
 wire \reg1_val1[6] ;
 wire \reg1_val1[7] ;
 wire \reg1_val1[8] ;
 wire \reg1_val1[9] ;
 wire \reg1_val2[0] ;
 wire \reg1_val2[10] ;
 wire \reg1_val2[11] ;
 wire \reg1_val2[12] ;
 wire \reg1_val2[13] ;
 wire \reg1_val2[14] ;
 wire \reg1_val2[15] ;
 wire \reg1_val2[16] ;
 wire \reg1_val2[17] ;
 wire \reg1_val2[18] ;
 wire \reg1_val2[19] ;
 wire \reg1_val2[1] ;
 wire \reg1_val2[20] ;
 wire \reg1_val2[21] ;
 wire \reg1_val2[22] ;
 wire \reg1_val2[23] ;
 wire \reg1_val2[24] ;
 wire \reg1_val2[25] ;
 wire \reg1_val2[26] ;
 wire \reg1_val2[27] ;
 wire \reg1_val2[28] ;
 wire \reg1_val2[29] ;
 wire \reg1_val2[2] ;
 wire \reg1_val2[30] ;
 wire \reg1_val2[31] ;
 wire \reg1_val2[3] ;
 wire \reg1_val2[4] ;
 wire \reg1_val2[5] ;
 wire \reg1_val2[6] ;
 wire \reg1_val2[7] ;
 wire \reg1_val2[8] ;
 wire \reg1_val2[9] ;
 wire \reg2_idx0[0] ;
 wire \reg2_idx0[1] ;
 wire \reg2_idx0[2] ;
 wire \reg2_idx0[3] ;
 wire \reg2_idx0[4] ;
 wire \reg2_idx1[0] ;
 wire \reg2_idx1[1] ;
 wire \reg2_idx1[2] ;
 wire \reg2_idx1[3] ;
 wire \reg2_idx1[4] ;
 wire \reg2_idx2[0] ;
 wire \reg2_idx2[1] ;
 wire \reg2_idx2[2] ;
 wire \reg2_idx2[3] ;
 wire \reg2_idx2[4] ;
 wire \reg2_val0[0] ;
 wire \reg2_val0[10] ;
 wire \reg2_val0[11] ;
 wire \reg2_val0[12] ;
 wire \reg2_val0[13] ;
 wire \reg2_val0[14] ;
 wire \reg2_val0[15] ;
 wire \reg2_val0[16] ;
 wire \reg2_val0[17] ;
 wire \reg2_val0[18] ;
 wire \reg2_val0[19] ;
 wire \reg2_val0[1] ;
 wire \reg2_val0[20] ;
 wire \reg2_val0[21] ;
 wire \reg2_val0[22] ;
 wire \reg2_val0[23] ;
 wire \reg2_val0[24] ;
 wire \reg2_val0[25] ;
 wire \reg2_val0[26] ;
 wire \reg2_val0[27] ;
 wire \reg2_val0[28] ;
 wire \reg2_val0[29] ;
 wire \reg2_val0[2] ;
 wire \reg2_val0[30] ;
 wire \reg2_val0[31] ;
 wire \reg2_val0[3] ;
 wire \reg2_val0[4] ;
 wire \reg2_val0[5] ;
 wire \reg2_val0[6] ;
 wire \reg2_val0[7] ;
 wire \reg2_val0[8] ;
 wire \reg2_val0[9] ;
 wire \reg2_val1[0] ;
 wire \reg2_val1[10] ;
 wire \reg2_val1[11] ;
 wire \reg2_val1[12] ;
 wire \reg2_val1[13] ;
 wire \reg2_val1[14] ;
 wire \reg2_val1[15] ;
 wire \reg2_val1[16] ;
 wire \reg2_val1[17] ;
 wire \reg2_val1[18] ;
 wire \reg2_val1[19] ;
 wire \reg2_val1[1] ;
 wire \reg2_val1[20] ;
 wire \reg2_val1[21] ;
 wire \reg2_val1[22] ;
 wire \reg2_val1[23] ;
 wire \reg2_val1[24] ;
 wire \reg2_val1[25] ;
 wire \reg2_val1[26] ;
 wire \reg2_val1[27] ;
 wire \reg2_val1[28] ;
 wire \reg2_val1[29] ;
 wire \reg2_val1[2] ;
 wire \reg2_val1[30] ;
 wire \reg2_val1[31] ;
 wire \reg2_val1[3] ;
 wire \reg2_val1[4] ;
 wire \reg2_val1[5] ;
 wire \reg2_val1[6] ;
 wire \reg2_val1[7] ;
 wire \reg2_val1[8] ;
 wire \reg2_val1[9] ;
 wire \reg2_val2[0] ;
 wire \reg2_val2[10] ;
 wire \reg2_val2[11] ;
 wire \reg2_val2[12] ;
 wire \reg2_val2[13] ;
 wire \reg2_val2[14] ;
 wire \reg2_val2[15] ;
 wire \reg2_val2[16] ;
 wire \reg2_val2[17] ;
 wire \reg2_val2[18] ;
 wire \reg2_val2[19] ;
 wire \reg2_val2[1] ;
 wire \reg2_val2[20] ;
 wire \reg2_val2[21] ;
 wire \reg2_val2[22] ;
 wire \reg2_val2[23] ;
 wire \reg2_val2[24] ;
 wire \reg2_val2[25] ;
 wire \reg2_val2[26] ;
 wire \reg2_val2[27] ;
 wire \reg2_val2[28] ;
 wire \reg2_val2[29] ;
 wire \reg2_val2[2] ;
 wire \reg2_val2[30] ;
 wire \reg2_val2[31] ;
 wire \reg2_val2[3] ;
 wire \reg2_val2[4] ;
 wire \reg2_val2[5] ;
 wire \reg2_val2[6] ;
 wire \reg2_val2[7] ;
 wire \reg2_val2[8] ;
 wire \reg2_val2[9] ;
 wire rst_eu;
 wire rst_scrapcpu;
 wire rst_vliw;
 wire rst_z80;
 wire sign_extend0;
 wire sign_extend1;
 wire sign_extend2;
 wire take_branch0;
 wire take_branch1;
 wire take_branch2;

 ci2406_z80 ci2406_z80 (.rst_n(rst_z80),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .io_in({io_in[37],
    io_in[36],
    io_in[35],
    io_in[34],
    io_in[33],
    io_in[32],
    io_in[31],
    io_in[30],
    io_in[29],
    io_in[28],
    io_in[27],
    io_in[26],
    io_in[25],
    io_in[24],
    io_in[23],
    io_in[22],
    io_in[21],
    io_in[20],
    io_in[19],
    io_in[18],
    io_in[17],
    io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12],
    io_in[11],
    io_in[10],
    io_in[9],
    io_in[8],
    io_in[7],
    io_in[6],
    io_in[5],
    io_in[4],
    io_in[2],
    io_in[1]}),
    .io_oeb({\io_oeb_z80[35] ,
    \io_oeb_z80[34] ,
    \io_oeb_z80[33] ,
    \io_oeb_z80[32] ,
    \io_oeb_z80[31] ,
    \io_oeb_z80[30] ,
    \io_oeb_z80[29] ,
    \io_oeb_z80[28] ,
    \io_oeb_z80[27] ,
    \io_oeb_z80[26] ,
    \io_oeb_z80[25] ,
    \io_oeb_z80[24] ,
    \io_oeb_z80[23] ,
    \io_oeb_z80[22] ,
    \io_oeb_z80[21] ,
    \io_oeb_z80[20] ,
    \io_oeb_z80[19] ,
    \io_oeb_z80[18] ,
    \io_oeb_z80[17] ,
    \io_oeb_z80[16] ,
    \io_oeb_z80[15] ,
    \io_oeb_z80[14] ,
    \io_oeb_z80[13] ,
    \io_oeb_z80[12] ,
    \io_oeb_z80[11] ,
    \io_oeb_z80[10] ,
    \io_oeb_z80[9] ,
    \io_oeb_z80[8] ,
    \io_oeb_z80[7] ,
    \io_oeb_z80[6] ,
    \io_oeb_z80[5] ,
    \io_oeb_z80[4] ,
    \io_oeb_z80[3] ,
    \io_oeb_z80[2] ,
    \io_oeb_z80[1] ,
    \io_oeb_z80[0] }),
    .io_out({\io_out_z80[35] ,
    \io_out_z80[34] ,
    \io_out_z80[33] ,
    \io_out_z80[32] ,
    \io_out_z80[31] ,
    \io_out_z80[30] ,
    \io_out_z80[29] ,
    \io_out_z80[28] ,
    \io_out_z80[27] ,
    \io_out_z80[26] ,
    \io_out_z80[25] ,
    \io_out_z80[24] ,
    \io_out_z80[23] ,
    \io_out_z80[22] ,
    \io_out_z80[21] ,
    \io_out_z80[20] ,
    \io_out_z80[19] ,
    \io_out_z80[18] ,
    \io_out_z80[17] ,
    \io_out_z80[16] ,
    \io_out_z80[15] ,
    \io_out_z80[14] ,
    \io_out_z80[13] ,
    \io_out_z80[12] ,
    \io_out_z80[11] ,
    \io_out_z80[10] ,
    \io_out_z80[9] ,
    \io_out_z80[8] ,
    \io_out_z80[7] ,
    \io_out_z80[6] ,
    \io_out_z80[5] ,
    \io_out_z80[4] ,
    \io_out_z80[3] ,
    \io_out_z80[2] ,
    \io_out_z80[1] ,
    \io_out_z80[0] }));
 execution_unit eu0 (.busy(eu0_busy),
    .dest_pred_val(dest_pred_val0),
    .is_load(is_load0),
    .is_store(is_store0),
    .pred_val(pred_val0),
    .rst(rst_eu),
    .sign_extend(sign_extend0),
    .take_branch(take_branch0),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .curr_PC({\curr_PC[27] ,
    \curr_PC[26] ,
    \curr_PC[25] ,
    \curr_PC[24] ,
    \curr_PC[23] ,
    \curr_PC[22] ,
    \curr_PC[21] ,
    \curr_PC[20] ,
    \curr_PC[19] ,
    \curr_PC[18] ,
    \curr_PC[17] ,
    \curr_PC[16] ,
    \curr_PC[15] ,
    \curr_PC[14] ,
    \curr_PC[13] ,
    \curr_PC[12] ,
    \curr_PC[11] ,
    \curr_PC[10] ,
    \curr_PC[9] ,
    \curr_PC[8] ,
    \curr_PC[7] ,
    \curr_PC[6] ,
    \curr_PC[5] ,
    \curr_PC[4] ,
    \curr_PC[3] ,
    \curr_PC[2] ,
    \curr_PC[1] ,
    \curr_PC[0] }),
    .dest_idx({\dest_idx0[4] ,
    \dest_idx0[3] ,
    \dest_idx0[2] ,
    \dest_idx0[1] ,
    \dest_idx0[0] }),
    .dest_mask({\dest_mask0[1] ,
    \dest_mask0[0] }),
    .dest_pred({\dest_pred0[2] ,
    \dest_pred0[1] ,
    \dest_pred0[0] }),
    .dest_val({\dest_val0[31] ,
    \dest_val0[30] ,
    \dest_val0[29] ,
    \dest_val0[28] ,
    \dest_val0[27] ,
    \dest_val0[26] ,
    \dest_val0[25] ,
    \dest_val0[24] ,
    \dest_val0[23] ,
    \dest_val0[22] ,
    \dest_val0[21] ,
    \dest_val0[20] ,
    \dest_val0[19] ,
    \dest_val0[18] ,
    \dest_val0[17] ,
    \dest_val0[16] ,
    \dest_val0[15] ,
    \dest_val0[14] ,
    \dest_val0[13] ,
    \dest_val0[12] ,
    \dest_val0[11] ,
    \dest_val0[10] ,
    \dest_val0[9] ,
    \dest_val0[8] ,
    \dest_val0[7] ,
    \dest_val0[6] ,
    \dest_val0[5] ,
    \dest_val0[4] ,
    \dest_val0[3] ,
    \dest_val0[2] ,
    \dest_val0[1] ,
    \dest_val0[0] }),
    .instruction({\eu0_instruction[41] ,
    \eu0_instruction[40] ,
    \eu0_instruction[39] ,
    \eu0_instruction[38] ,
    \eu0_instruction[37] ,
    \eu0_instruction[36] ,
    \eu0_instruction[35] ,
    \eu0_instruction[34] ,
    \eu0_instruction[33] ,
    \eu0_instruction[32] ,
    \eu0_instruction[31] ,
    \eu0_instruction[30] ,
    \eu0_instruction[29] ,
    \eu0_instruction[28] ,
    \eu0_instruction[27] ,
    \eu0_instruction[26] ,
    \eu0_instruction[25] ,
    \eu0_instruction[24] ,
    \eu0_instruction[23] ,
    \eu0_instruction[22] ,
    \eu0_instruction[21] ,
    \eu0_instruction[20] ,
    \eu0_instruction[19] ,
    \eu0_instruction[18] ,
    \eu0_instruction[17] ,
    \eu0_instruction[16] ,
    \eu0_instruction[15] ,
    \eu0_instruction[14] ,
    \eu0_instruction[13] ,
    \eu0_instruction[12] ,
    \eu0_instruction[11] ,
    \eu0_instruction[10] ,
    \eu0_instruction[9] ,
    \eu0_instruction[8] ,
    \eu0_instruction[7] ,
    \eu0_instruction[6] ,
    \eu0_instruction[5] ,
    \eu0_instruction[4] ,
    \eu0_instruction[3] ,
    \eu0_instruction[2] ,
    \eu0_instruction[1] ,
    \eu0_instruction[0] }),
    .loadstore_address({\loadstore_address0[31] ,
    \loadstore_address0[30] ,
    \loadstore_address0[29] ,
    \loadstore_address0[28] ,
    \loadstore_address0[27] ,
    \loadstore_address0[26] ,
    \loadstore_address0[25] ,
    \loadstore_address0[24] ,
    \loadstore_address0[23] ,
    \loadstore_address0[22] ,
    \loadstore_address0[21] ,
    \loadstore_address0[20] ,
    \loadstore_address0[19] ,
    \loadstore_address0[18] ,
    \loadstore_address0[17] ,
    \loadstore_address0[16] ,
    \loadstore_address0[15] ,
    \loadstore_address0[14] ,
    \loadstore_address0[13] ,
    \loadstore_address0[12] ,
    \loadstore_address0[11] ,
    \loadstore_address0[10] ,
    \loadstore_address0[9] ,
    \loadstore_address0[8] ,
    \loadstore_address0[7] ,
    \loadstore_address0[6] ,
    \loadstore_address0[5] ,
    \loadstore_address0[4] ,
    \loadstore_address0[3] ,
    \loadstore_address0[2] ,
    \loadstore_address0[1] ,
    \loadstore_address0[0] }),
    .loadstore_dest({\loadstore_dest0[4] ,
    \loadstore_dest0[3] ,
    \loadstore_dest0[2] ,
    \loadstore_dest0[1] ,
    \loadstore_dest0[0] }),
    .loadstore_size({\loadstore_size0[1] ,
    \loadstore_size0[0] }),
    .new_PC({\new_PC0[27] ,
    \new_PC0[26] ,
    \new_PC0[25] ,
    \new_PC0[24] ,
    \new_PC0[23] ,
    \new_PC0[22] ,
    \new_PC0[21] ,
    \new_PC0[20] ,
    \new_PC0[19] ,
    \new_PC0[18] ,
    \new_PC0[17] ,
    \new_PC0[16] ,
    \new_PC0[15] ,
    \new_PC0[14] ,
    \new_PC0[13] ,
    \new_PC0[12] ,
    \new_PC0[11] ,
    \new_PC0[10] ,
    \new_PC0[9] ,
    \new_PC0[8] ,
    \new_PC0[7] ,
    \new_PC0[6] ,
    \new_PC0[5] ,
    \new_PC0[4] ,
    \new_PC0[3] ,
    \new_PC0[2] ,
    \new_PC0[1] ,
    \new_PC0[0] }),
    .pred_idx({\pred_idx0[2] ,
    \pred_idx0[1] ,
    \pred_idx0[0] }),
    .reg1_idx({\reg1_idx0[4] ,
    \reg1_idx0[3] ,
    \reg1_idx0[2] ,
    \reg1_idx0[1] ,
    \reg1_idx0[0] }),
    .reg1_val({\reg1_val0[31] ,
    \reg1_val0[30] ,
    \reg1_val0[29] ,
    \reg1_val0[28] ,
    \reg1_val0[27] ,
    \reg1_val0[26] ,
    \reg1_val0[25] ,
    \reg1_val0[24] ,
    \reg1_val0[23] ,
    \reg1_val0[22] ,
    \reg1_val0[21] ,
    \reg1_val0[20] ,
    \reg1_val0[19] ,
    \reg1_val0[18] ,
    \reg1_val0[17] ,
    \reg1_val0[16] ,
    \reg1_val0[15] ,
    \reg1_val0[14] ,
    \reg1_val0[13] ,
    \reg1_val0[12] ,
    \reg1_val0[11] ,
    \reg1_val0[10] ,
    \reg1_val0[9] ,
    \reg1_val0[8] ,
    \reg1_val0[7] ,
    \reg1_val0[6] ,
    \reg1_val0[5] ,
    \reg1_val0[4] ,
    \reg1_val0[3] ,
    \reg1_val0[2] ,
    \reg1_val0[1] ,
    \reg1_val0[0] }),
    .reg2_idx({\reg2_idx0[4] ,
    \reg2_idx0[3] ,
    \reg2_idx0[2] ,
    \reg2_idx0[1] ,
    \reg2_idx0[0] }),
    .reg2_val({\reg2_val0[31] ,
    \reg2_val0[30] ,
    \reg2_val0[29] ,
    \reg2_val0[28] ,
    \reg2_val0[27] ,
    \reg2_val0[26] ,
    \reg2_val0[25] ,
    \reg2_val0[24] ,
    \reg2_val0[23] ,
    \reg2_val0[22] ,
    \reg2_val0[21] ,
    \reg2_val0[20] ,
    \reg2_val0[19] ,
    \reg2_val0[18] ,
    \reg2_val0[17] ,
    \reg2_val0[16] ,
    \reg2_val0[15] ,
    \reg2_val0[14] ,
    \reg2_val0[13] ,
    \reg2_val0[12] ,
    \reg2_val0[11] ,
    \reg2_val0[10] ,
    \reg2_val0[9] ,
    \reg2_val0[8] ,
    \reg2_val0[7] ,
    \reg2_val0[6] ,
    \reg2_val0[5] ,
    \reg2_val0[4] ,
    \reg2_val0[3] ,
    \reg2_val0[2] ,
    \reg2_val0[1] ,
    \reg2_val0[0] }));
 execution_unit eu1 (.busy(eu1_busy),
    .dest_pred_val(dest_pred_val1),
    .is_load(is_load1),
    .is_store(is_store1),
    .pred_val(pred_val1),
    .rst(rst_eu),
    .sign_extend(sign_extend1),
    .take_branch(take_branch1),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .curr_PC({\curr_PC[27] ,
    \curr_PC[26] ,
    \curr_PC[25] ,
    \curr_PC[24] ,
    \curr_PC[23] ,
    \curr_PC[22] ,
    \curr_PC[21] ,
    \curr_PC[20] ,
    \curr_PC[19] ,
    \curr_PC[18] ,
    \curr_PC[17] ,
    \curr_PC[16] ,
    \curr_PC[15] ,
    \curr_PC[14] ,
    \curr_PC[13] ,
    \curr_PC[12] ,
    \curr_PC[11] ,
    \curr_PC[10] ,
    \curr_PC[9] ,
    \curr_PC[8] ,
    \curr_PC[7] ,
    \curr_PC[6] ,
    \curr_PC[5] ,
    \curr_PC[4] ,
    \curr_PC[3] ,
    \curr_PC[2] ,
    \curr_PC[1] ,
    \curr_PC[0] }),
    .dest_idx({\dest_idx1[4] ,
    \dest_idx1[3] ,
    \dest_idx1[2] ,
    \dest_idx1[1] ,
    \dest_idx1[0] }),
    .dest_mask({\dest_mask1[1] ,
    \dest_mask1[0] }),
    .dest_pred({\dest_pred1[2] ,
    \dest_pred1[1] ,
    \dest_pred1[0] }),
    .dest_val({\dest_val1[31] ,
    \dest_val1[30] ,
    \dest_val1[29] ,
    \dest_val1[28] ,
    \dest_val1[27] ,
    \dest_val1[26] ,
    \dest_val1[25] ,
    \dest_val1[24] ,
    \dest_val1[23] ,
    \dest_val1[22] ,
    \dest_val1[21] ,
    \dest_val1[20] ,
    \dest_val1[19] ,
    \dest_val1[18] ,
    \dest_val1[17] ,
    \dest_val1[16] ,
    \dest_val1[15] ,
    \dest_val1[14] ,
    \dest_val1[13] ,
    \dest_val1[12] ,
    \dest_val1[11] ,
    \dest_val1[10] ,
    \dest_val1[9] ,
    \dest_val1[8] ,
    \dest_val1[7] ,
    \dest_val1[6] ,
    \dest_val1[5] ,
    \dest_val1[4] ,
    \dest_val1[3] ,
    \dest_val1[2] ,
    \dest_val1[1] ,
    \dest_val1[0] }),
    .instruction({\eu1_instruction[41] ,
    \eu1_instruction[40] ,
    \eu1_instruction[39] ,
    \eu1_instruction[38] ,
    \eu1_instruction[37] ,
    \eu1_instruction[36] ,
    \eu1_instruction[35] ,
    \eu1_instruction[34] ,
    \eu1_instruction[33] ,
    \eu1_instruction[32] ,
    \eu1_instruction[31] ,
    \eu1_instruction[30] ,
    \eu1_instruction[29] ,
    \eu1_instruction[28] ,
    \eu1_instruction[27] ,
    \eu1_instruction[26] ,
    \eu1_instruction[25] ,
    \eu1_instruction[24] ,
    \eu1_instruction[23] ,
    \eu1_instruction[22] ,
    \eu1_instruction[21] ,
    \eu1_instruction[20] ,
    \eu1_instruction[19] ,
    \eu1_instruction[18] ,
    \eu1_instruction[17] ,
    \eu1_instruction[16] ,
    \eu1_instruction[15] ,
    \eu1_instruction[14] ,
    \eu1_instruction[13] ,
    \eu1_instruction[12] ,
    \eu1_instruction[11] ,
    \eu1_instruction[10] ,
    \eu1_instruction[9] ,
    \eu1_instruction[8] ,
    \eu1_instruction[7] ,
    \eu1_instruction[6] ,
    \eu1_instruction[5] ,
    \eu1_instruction[4] ,
    \eu1_instruction[3] ,
    \eu1_instruction[2] ,
    \eu1_instruction[1] ,
    \eu1_instruction[0] }),
    .loadstore_address({\loadstore_address1[31] ,
    \loadstore_address1[30] ,
    \loadstore_address1[29] ,
    \loadstore_address1[28] ,
    \loadstore_address1[27] ,
    \loadstore_address1[26] ,
    \loadstore_address1[25] ,
    \loadstore_address1[24] ,
    \loadstore_address1[23] ,
    \loadstore_address1[22] ,
    \loadstore_address1[21] ,
    \loadstore_address1[20] ,
    \loadstore_address1[19] ,
    \loadstore_address1[18] ,
    \loadstore_address1[17] ,
    \loadstore_address1[16] ,
    \loadstore_address1[15] ,
    \loadstore_address1[14] ,
    \loadstore_address1[13] ,
    \loadstore_address1[12] ,
    \loadstore_address1[11] ,
    \loadstore_address1[10] ,
    \loadstore_address1[9] ,
    \loadstore_address1[8] ,
    \loadstore_address1[7] ,
    \loadstore_address1[6] ,
    \loadstore_address1[5] ,
    \loadstore_address1[4] ,
    \loadstore_address1[3] ,
    \loadstore_address1[2] ,
    \loadstore_address1[1] ,
    \loadstore_address1[0] }),
    .loadstore_dest({\loadstore_dest1[4] ,
    \loadstore_dest1[3] ,
    \loadstore_dest1[2] ,
    \loadstore_dest1[1] ,
    \loadstore_dest1[0] }),
    .loadstore_size({\loadstore_size1[1] ,
    \loadstore_size1[0] }),
    .new_PC({\new_PC1[27] ,
    \new_PC1[26] ,
    \new_PC1[25] ,
    \new_PC1[24] ,
    \new_PC1[23] ,
    \new_PC1[22] ,
    \new_PC1[21] ,
    \new_PC1[20] ,
    \new_PC1[19] ,
    \new_PC1[18] ,
    \new_PC1[17] ,
    \new_PC1[16] ,
    \new_PC1[15] ,
    \new_PC1[14] ,
    \new_PC1[13] ,
    \new_PC1[12] ,
    \new_PC1[11] ,
    \new_PC1[10] ,
    \new_PC1[9] ,
    \new_PC1[8] ,
    \new_PC1[7] ,
    \new_PC1[6] ,
    \new_PC1[5] ,
    \new_PC1[4] ,
    \new_PC1[3] ,
    \new_PC1[2] ,
    \new_PC1[1] ,
    \new_PC1[0] }),
    .pred_idx({\pred_idx1[2] ,
    \pred_idx1[1] ,
    \pred_idx1[0] }),
    .reg1_idx({\reg1_idx1[4] ,
    \reg1_idx1[3] ,
    \reg1_idx1[2] ,
    \reg1_idx1[1] ,
    \reg1_idx1[0] }),
    .reg1_val({\reg1_val1[31] ,
    \reg1_val1[30] ,
    \reg1_val1[29] ,
    \reg1_val1[28] ,
    \reg1_val1[27] ,
    \reg1_val1[26] ,
    \reg1_val1[25] ,
    \reg1_val1[24] ,
    \reg1_val1[23] ,
    \reg1_val1[22] ,
    \reg1_val1[21] ,
    \reg1_val1[20] ,
    \reg1_val1[19] ,
    \reg1_val1[18] ,
    \reg1_val1[17] ,
    \reg1_val1[16] ,
    \reg1_val1[15] ,
    \reg1_val1[14] ,
    \reg1_val1[13] ,
    \reg1_val1[12] ,
    \reg1_val1[11] ,
    \reg1_val1[10] ,
    \reg1_val1[9] ,
    \reg1_val1[8] ,
    \reg1_val1[7] ,
    \reg1_val1[6] ,
    \reg1_val1[5] ,
    \reg1_val1[4] ,
    \reg1_val1[3] ,
    \reg1_val1[2] ,
    \reg1_val1[1] ,
    \reg1_val1[0] }),
    .reg2_idx({\reg2_idx1[4] ,
    \reg2_idx1[3] ,
    \reg2_idx1[2] ,
    \reg2_idx1[1] ,
    \reg2_idx1[0] }),
    .reg2_val({\reg2_val1[31] ,
    \reg2_val1[30] ,
    \reg2_val1[29] ,
    \reg2_val1[28] ,
    \reg2_val1[27] ,
    \reg2_val1[26] ,
    \reg2_val1[25] ,
    \reg2_val1[24] ,
    \reg2_val1[23] ,
    \reg2_val1[22] ,
    \reg2_val1[21] ,
    \reg2_val1[20] ,
    \reg2_val1[19] ,
    \reg2_val1[18] ,
    \reg2_val1[17] ,
    \reg2_val1[16] ,
    \reg2_val1[15] ,
    \reg2_val1[14] ,
    \reg2_val1[13] ,
    \reg2_val1[12] ,
    \reg2_val1[11] ,
    \reg2_val1[10] ,
    \reg2_val1[9] ,
    \reg2_val1[8] ,
    \reg2_val1[7] ,
    \reg2_val1[6] ,
    \reg2_val1[5] ,
    \reg2_val1[4] ,
    \reg2_val1[3] ,
    \reg2_val1[2] ,
    \reg2_val1[1] ,
    \reg2_val1[0] }));
 execution_unit eu2 (.busy(eu2_busy),
    .dest_pred_val(dest_pred_val2),
    .is_load(is_load2),
    .is_store(is_store2),
    .pred_val(pred_val2),
    .rst(rst_eu),
    .sign_extend(sign_extend2),
    .take_branch(take_branch2),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .curr_PC({\curr_PC[27] ,
    \curr_PC[26] ,
    \curr_PC[25] ,
    \curr_PC[24] ,
    \curr_PC[23] ,
    \curr_PC[22] ,
    \curr_PC[21] ,
    \curr_PC[20] ,
    \curr_PC[19] ,
    \curr_PC[18] ,
    \curr_PC[17] ,
    \curr_PC[16] ,
    \curr_PC[15] ,
    \curr_PC[14] ,
    \curr_PC[13] ,
    \curr_PC[12] ,
    \curr_PC[11] ,
    \curr_PC[10] ,
    \curr_PC[9] ,
    \curr_PC[8] ,
    \curr_PC[7] ,
    \curr_PC[6] ,
    \curr_PC[5] ,
    \curr_PC[4] ,
    \curr_PC[3] ,
    \curr_PC[2] ,
    \curr_PC[1] ,
    \curr_PC[0] }),
    .dest_idx({\dest_idx2[4] ,
    \dest_idx2[3] ,
    \dest_idx2[2] ,
    \dest_idx2[1] ,
    \dest_idx2[0] }),
    .dest_mask({\dest_mask2[1] ,
    \dest_mask2[0] }),
    .dest_pred({\dest_pred2[2] ,
    \dest_pred2[1] ,
    \dest_pred2[0] }),
    .dest_val({\dest_val2[31] ,
    \dest_val2[30] ,
    \dest_val2[29] ,
    \dest_val2[28] ,
    \dest_val2[27] ,
    \dest_val2[26] ,
    \dest_val2[25] ,
    \dest_val2[24] ,
    \dest_val2[23] ,
    \dest_val2[22] ,
    \dest_val2[21] ,
    \dest_val2[20] ,
    \dest_val2[19] ,
    \dest_val2[18] ,
    \dest_val2[17] ,
    \dest_val2[16] ,
    \dest_val2[15] ,
    \dest_val2[14] ,
    \dest_val2[13] ,
    \dest_val2[12] ,
    \dest_val2[11] ,
    \dest_val2[10] ,
    \dest_val2[9] ,
    \dest_val2[8] ,
    \dest_val2[7] ,
    \dest_val2[6] ,
    \dest_val2[5] ,
    \dest_val2[4] ,
    \dest_val2[3] ,
    \dest_val2[2] ,
    \dest_val2[1] ,
    \dest_val2[0] }),
    .instruction({\eu2_instruction[41] ,
    \eu2_instruction[40] ,
    \eu2_instruction[39] ,
    \eu2_instruction[38] ,
    \eu2_instruction[37] ,
    \eu2_instruction[36] ,
    \eu2_instruction[35] ,
    \eu2_instruction[34] ,
    \eu2_instruction[33] ,
    \eu2_instruction[32] ,
    \eu2_instruction[31] ,
    \eu2_instruction[30] ,
    \eu2_instruction[29] ,
    \eu2_instruction[28] ,
    \eu2_instruction[27] ,
    \eu2_instruction[26] ,
    \eu2_instruction[25] ,
    \eu2_instruction[24] ,
    \eu2_instruction[23] ,
    \eu2_instruction[22] ,
    \eu2_instruction[21] ,
    \eu2_instruction[20] ,
    \eu2_instruction[19] ,
    \eu2_instruction[18] ,
    \eu2_instruction[17] ,
    \eu2_instruction[16] ,
    \eu2_instruction[15] ,
    \eu2_instruction[14] ,
    \eu2_instruction[13] ,
    \eu2_instruction[12] ,
    \eu2_instruction[11] ,
    \eu2_instruction[10] ,
    \eu2_instruction[9] ,
    \eu2_instruction[8] ,
    \eu2_instruction[7] ,
    \eu2_instruction[6] ,
    \eu2_instruction[5] ,
    \eu2_instruction[4] ,
    \eu2_instruction[3] ,
    \eu2_instruction[2] ,
    \eu2_instruction[1] ,
    \eu2_instruction[0] }),
    .loadstore_address({\loadstore_address2[31] ,
    \loadstore_address2[30] ,
    \loadstore_address2[29] ,
    \loadstore_address2[28] ,
    \loadstore_address2[27] ,
    \loadstore_address2[26] ,
    \loadstore_address2[25] ,
    \loadstore_address2[24] ,
    \loadstore_address2[23] ,
    \loadstore_address2[22] ,
    \loadstore_address2[21] ,
    \loadstore_address2[20] ,
    \loadstore_address2[19] ,
    \loadstore_address2[18] ,
    \loadstore_address2[17] ,
    \loadstore_address2[16] ,
    \loadstore_address2[15] ,
    \loadstore_address2[14] ,
    \loadstore_address2[13] ,
    \loadstore_address2[12] ,
    \loadstore_address2[11] ,
    \loadstore_address2[10] ,
    \loadstore_address2[9] ,
    \loadstore_address2[8] ,
    \loadstore_address2[7] ,
    \loadstore_address2[6] ,
    \loadstore_address2[5] ,
    \loadstore_address2[4] ,
    \loadstore_address2[3] ,
    \loadstore_address2[2] ,
    \loadstore_address2[1] ,
    \loadstore_address2[0] }),
    .loadstore_dest({\loadstore_dest2[4] ,
    \loadstore_dest2[3] ,
    \loadstore_dest2[2] ,
    \loadstore_dest2[1] ,
    \loadstore_dest2[0] }),
    .loadstore_size({\loadstore_size2[1] ,
    \loadstore_size2[0] }),
    .new_PC({\new_PC2[27] ,
    \new_PC2[26] ,
    \new_PC2[25] ,
    \new_PC2[24] ,
    \new_PC2[23] ,
    \new_PC2[22] ,
    \new_PC2[21] ,
    \new_PC2[20] ,
    \new_PC2[19] ,
    \new_PC2[18] ,
    \new_PC2[17] ,
    \new_PC2[16] ,
    \new_PC2[15] ,
    \new_PC2[14] ,
    \new_PC2[13] ,
    \new_PC2[12] ,
    \new_PC2[11] ,
    \new_PC2[10] ,
    \new_PC2[9] ,
    \new_PC2[8] ,
    \new_PC2[7] ,
    \new_PC2[6] ,
    \new_PC2[5] ,
    \new_PC2[4] ,
    \new_PC2[3] ,
    \new_PC2[2] ,
    \new_PC2[1] ,
    \new_PC2[0] }),
    .pred_idx({\pred_idx2[2] ,
    \pred_idx2[1] ,
    \pred_idx2[0] }),
    .reg1_idx({\reg1_idx2[4] ,
    \reg1_idx2[3] ,
    \reg1_idx2[2] ,
    \reg1_idx2[1] ,
    \reg1_idx2[0] }),
    .reg1_val({\reg1_val2[31] ,
    \reg1_val2[30] ,
    \reg1_val2[29] ,
    \reg1_val2[28] ,
    \reg1_val2[27] ,
    \reg1_val2[26] ,
    \reg1_val2[25] ,
    \reg1_val2[24] ,
    \reg1_val2[23] ,
    \reg1_val2[22] ,
    \reg1_val2[21] ,
    \reg1_val2[20] ,
    \reg1_val2[19] ,
    \reg1_val2[18] ,
    \reg1_val2[17] ,
    \reg1_val2[16] ,
    \reg1_val2[15] ,
    \reg1_val2[14] ,
    \reg1_val2[13] ,
    \reg1_val2[12] ,
    \reg1_val2[11] ,
    \reg1_val2[10] ,
    \reg1_val2[9] ,
    \reg1_val2[8] ,
    \reg1_val2[7] ,
    \reg1_val2[6] ,
    \reg1_val2[5] ,
    \reg1_val2[4] ,
    \reg1_val2[3] ,
    \reg1_val2[2] ,
    \reg1_val2[1] ,
    \reg1_val2[0] }),
    .reg2_idx({\reg2_idx2[4] ,
    \reg2_idx2[3] ,
    \reg2_idx2[2] ,
    \reg2_idx2[1] ,
    \reg2_idx2[0] }),
    .reg2_val({\reg2_val2[31] ,
    \reg2_val2[30] ,
    \reg2_val2[29] ,
    \reg2_val2[28] ,
    \reg2_val2[27] ,
    \reg2_val2[26] ,
    \reg2_val2[25] ,
    \reg2_val2[24] ,
    \reg2_val2[23] ,
    \reg2_val2[22] ,
    \reg2_val2[21] ,
    \reg2_val2[20] ,
    \reg2_val2[19] ,
    \reg2_val2[18] ,
    \reg2_val2[17] ,
    \reg2_val2[16] ,
    \reg2_val2[15] ,
    \reg2_val2[14] ,
    \reg2_val2[13] ,
    \reg2_val2[12] ,
    \reg2_val2[11] ,
    \reg2_val2[10] ,
    \reg2_val2[9] ,
    \reg2_val2[8] ,
    \reg2_val2[7] ,
    \reg2_val2[6] ,
    \reg2_val2[5] ,
    \reg2_val2[4] ,
    \reg2_val2[3] ,
    \reg2_val2[2] ,
    \reg2_val2[1] ,
    \reg2_val2[0] }));
 multiplexer multiplexer (.io_in_0(io_in[0]),
    .rst_scrapcpu(rst_scrapcpu),
    .rst_vliw(rst_vliw),
    .rst_z80(rst_z80),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .custom_settings({\custom_settings[31] ,
    \custom_settings[30] ,
    \custom_settings[29] ,
    \custom_settings[28] ,
    \custom_settings[27] ,
    \custom_settings[26] ,
    \custom_settings[25] ,
    \custom_settings[24] ,
    \custom_settings[23] ,
    \custom_settings[22] ,
    \custom_settings[21] ,
    \custom_settings[20] ,
    \custom_settings[19] ,
    \custom_settings[18] ,
    \custom_settings[17] ,
    \custom_settings[16] ,
    \custom_settings[15] ,
    \custom_settings[14] ,
    \custom_settings[13] ,
    \custom_settings[12] ,
    \custom_settings[11] ,
    \custom_settings[10] ,
    \custom_settings[9] ,
    \custom_settings[8] ,
    \custom_settings[7] ,
    \custom_settings[6] ,
    \custom_settings[5] ,
    \custom_settings[4] ,
    \custom_settings[3] ,
    \custom_settings[2] ,
    \custom_settings[1] ,
    \custom_settings[0] }),
    .io_oeb({io_oeb[37],
    io_oeb[36],
    io_oeb[35],
    io_oeb[34],
    io_oeb[33],
    io_oeb[32],
    io_oeb[31],
    io_oeb[30],
    io_oeb[29],
    io_oeb[28],
    io_oeb[27],
    io_oeb[26],
    io_oeb[25],
    io_oeb[24],
    io_oeb[23],
    io_oeb[22],
    io_oeb[21],
    io_oeb[20],
    io_oeb[19],
    io_oeb[18],
    io_oeb[17],
    io_oeb[16],
    io_oeb[15],
    io_oeb[14],
    io_oeb[13],
    io_oeb[12],
    io_oeb[11],
    io_oeb[10],
    io_oeb[9],
    io_oeb[8],
    io_oeb[7],
    io_oeb[6],
    io_oeb[5],
    io_oeb[4],
    io_oeb[3],
    io_oeb[2],
    io_oeb[1],
    io_oeb[0]}),
    .io_oeb_scrapcpu({\io_oeb_scrapcpu[35] ,
    \io_oeb_scrapcpu[34] ,
    \io_oeb_scrapcpu[33] ,
    \io_oeb_scrapcpu[32] ,
    \io_oeb_scrapcpu[31] ,
    \io_oeb_scrapcpu[30] ,
    \io_oeb_scrapcpu[29] ,
    \io_oeb_scrapcpu[28] ,
    \io_oeb_scrapcpu[27] ,
    \io_oeb_scrapcpu[26] ,
    \io_oeb_scrapcpu[25] ,
    \io_oeb_scrapcpu[24] ,
    \io_oeb_scrapcpu[23] ,
    \io_oeb_scrapcpu[22] ,
    \io_oeb_scrapcpu[21] ,
    \io_oeb_scrapcpu[20] ,
    \io_oeb_scrapcpu[19] ,
    \io_oeb_scrapcpu[18] ,
    \io_oeb_scrapcpu[17] ,
    \io_oeb_scrapcpu[16] ,
    \io_oeb_scrapcpu[15] ,
    \io_oeb_scrapcpu[14] ,
    \io_oeb_scrapcpu[13] ,
    \io_oeb_scrapcpu[12] ,
    \io_oeb_scrapcpu[11] ,
    \io_oeb_scrapcpu[10] ,
    \io_oeb_scrapcpu[9] ,
    \io_oeb_scrapcpu[8] ,
    \io_oeb_scrapcpu[7] ,
    \io_oeb_scrapcpu[6] ,
    \io_oeb_scrapcpu[5] ,
    \io_oeb_scrapcpu[4] ,
    \io_oeb_scrapcpu[3] ,
    \io_oeb_scrapcpu[2] ,
    \io_oeb_scrapcpu[1] ,
    \io_oeb_scrapcpu[0] }),
    .io_oeb_vliw({\io_oeb_vliw[35] ,
    \io_oeb_vliw[34] ,
    \io_oeb_vliw[33] ,
    \io_oeb_vliw[32] ,
    \io_oeb_vliw[31] ,
    \io_oeb_vliw[30] ,
    \io_oeb_vliw[29] ,
    \io_oeb_vliw[28] ,
    \io_oeb_vliw[27] ,
    \io_oeb_vliw[26] ,
    \io_oeb_vliw[25] ,
    \io_oeb_vliw[24] ,
    \io_oeb_vliw[23] ,
    \io_oeb_vliw[22] ,
    \io_oeb_vliw[21] ,
    \io_oeb_vliw[20] ,
    \io_oeb_vliw[19] ,
    \io_oeb_vliw[18] ,
    \io_oeb_vliw[17] ,
    \io_oeb_vliw[16] ,
    \io_oeb_vliw[15] ,
    \io_oeb_vliw[14] ,
    \io_oeb_vliw[13] ,
    \io_oeb_vliw[12] ,
    \io_oeb_vliw[11] ,
    \io_oeb_vliw[10] ,
    \io_oeb_vliw[9] ,
    \io_oeb_vliw[8] ,
    \io_oeb_vliw[7] ,
    \io_oeb_vliw[6] ,
    \io_oeb_vliw[5] ,
    \io_oeb_vliw[4] ,
    \io_oeb_vliw[3] ,
    \io_oeb_vliw[2] ,
    \io_oeb_vliw[1] ,
    \io_oeb_vliw[0] }),
    .io_oeb_z80({\io_oeb_z80[35] ,
    \io_oeb_z80[34] ,
    \io_oeb_z80[33] ,
    \io_oeb_z80[32] ,
    \io_oeb_z80[31] ,
    \io_oeb_z80[30] ,
    \io_oeb_z80[29] ,
    \io_oeb_z80[28] ,
    \io_oeb_z80[27] ,
    \io_oeb_z80[26] ,
    \io_oeb_z80[25] ,
    \io_oeb_z80[24] ,
    \io_oeb_z80[23] ,
    \io_oeb_z80[22] ,
    \io_oeb_z80[21] ,
    \io_oeb_z80[20] ,
    \io_oeb_z80[19] ,
    \io_oeb_z80[18] ,
    \io_oeb_z80[17] ,
    \io_oeb_z80[16] ,
    \io_oeb_z80[15] ,
    \io_oeb_z80[14] ,
    \io_oeb_z80[13] ,
    \io_oeb_z80[12] ,
    \io_oeb_z80[11] ,
    \io_oeb_z80[10] ,
    \io_oeb_z80[9] ,
    \io_oeb_z80[8] ,
    \io_oeb_z80[7] ,
    \io_oeb_z80[6] ,
    \io_oeb_z80[5] ,
    \io_oeb_z80[4] ,
    \io_oeb_z80[3] ,
    \io_oeb_z80[2] ,
    \io_oeb_z80[1] ,
    \io_oeb_z80[0] }),
    .io_out({io_out[37],
    io_out[36],
    io_out[35],
    io_out[34],
    io_out[33],
    io_out[32],
    io_out[31],
    io_out[30],
    io_out[29],
    io_out[28],
    io_out[27],
    io_out[26],
    io_out[25],
    io_out[24],
    io_out[23],
    io_out[22],
    io_out[21],
    io_out[20],
    io_out[19],
    io_out[18],
    io_out[17],
    io_out[16],
    io_out[15],
    io_out[14],
    io_out[13],
    io_out[12],
    io_out[11],
    io_out[10],
    io_out[9],
    io_out[8],
    io_out[7],
    io_out[6],
    io_out[5],
    io_out[4],
    io_out[3],
    io_out[2],
    io_out[1],
    io_out[0]}),
    .io_out_scrapcpu({\io_out_scrapcpu[35] ,
    \io_out_scrapcpu[34] ,
    \io_out_scrapcpu[33] ,
    \io_out_scrapcpu[32] ,
    \io_out_scrapcpu[31] ,
    \io_out_scrapcpu[30] ,
    \io_out_scrapcpu[29] ,
    \io_out_scrapcpu[28] ,
    \io_out_scrapcpu[27] ,
    \io_out_scrapcpu[26] ,
    \io_out_scrapcpu[25] ,
    \io_out_scrapcpu[24] ,
    \io_out_scrapcpu[23] ,
    \io_out_scrapcpu[22] ,
    \io_out_scrapcpu[21] ,
    \io_out_scrapcpu[20] ,
    \io_out_scrapcpu[19] ,
    \io_out_scrapcpu[18] ,
    \io_out_scrapcpu[17] ,
    \io_out_scrapcpu[16] ,
    \io_out_scrapcpu[15] ,
    \io_out_scrapcpu[14] ,
    \io_out_scrapcpu[13] ,
    \io_out_scrapcpu[12] ,
    \io_out_scrapcpu[11] ,
    \io_out_scrapcpu[10] ,
    \io_out_scrapcpu[9] ,
    \io_out_scrapcpu[8] ,
    \io_out_scrapcpu[7] ,
    \io_out_scrapcpu[6] ,
    \io_out_scrapcpu[5] ,
    \io_out_scrapcpu[4] ,
    \io_out_scrapcpu[3] ,
    \io_out_scrapcpu[2] ,
    \io_out_scrapcpu[1] ,
    \io_out_scrapcpu[0] }),
    .io_out_vliw({\io_out_vliw[35] ,
    \io_out_vliw[34] ,
    \io_out_vliw[33] ,
    \io_out_vliw[32] ,
    \io_out_vliw[31] ,
    \io_out_vliw[30] ,
    \io_out_vliw[29] ,
    \io_out_vliw[28] ,
    \io_out_vliw[27] ,
    \io_out_vliw[26] ,
    \io_out_vliw[25] ,
    \io_out_vliw[24] ,
    \io_out_vliw[23] ,
    \io_out_vliw[22] ,
    \io_out_vliw[21] ,
    \io_out_vliw[20] ,
    \io_out_vliw[19] ,
    \io_out_vliw[18] ,
    \io_out_vliw[17] ,
    \io_out_vliw[16] ,
    \io_out_vliw[15] ,
    \io_out_vliw[14] ,
    \io_out_vliw[13] ,
    \io_out_vliw[12] ,
    \io_out_vliw[11] ,
    \io_out_vliw[10] ,
    \io_out_vliw[9] ,
    \io_out_vliw[8] ,
    \io_out_vliw[7] ,
    \io_out_vliw[6] ,
    \io_out_vliw[5] ,
    \io_out_vliw[4] ,
    \io_out_vliw[3] ,
    \io_out_vliw[2] ,
    \io_out_vliw[1] ,
    \io_out_vliw[0] }),
    .io_out_z80({\io_out_z80[35] ,
    \io_out_z80[34] ,
    \io_out_z80[33] ,
    \io_out_z80[32] ,
    \io_out_z80[31] ,
    \io_out_z80[30] ,
    \io_out_z80[29] ,
    \io_out_z80[28] ,
    \io_out_z80[27] ,
    \io_out_z80[26] ,
    \io_out_z80[25] ,
    \io_out_z80[24] ,
    \io_out_z80[23] ,
    \io_out_z80[22] ,
    \io_out_z80[21] ,
    \io_out_z80[20] ,
    \io_out_z80[19] ,
    \io_out_z80[18] ,
    \io_out_z80[17] ,
    \io_out_z80[16] ,
    \io_out_z80[15] ,
    \io_out_z80[14] ,
    \io_out_z80[13] ,
    \io_out_z80[12] ,
    \io_out_z80[11] ,
    \io_out_z80[10] ,
    \io_out_z80[9] ,
    \io_out_z80[8] ,
    \io_out_z80[7] ,
    \io_out_z80[6] ,
    \io_out_z80[5] ,
    \io_out_z80[4] ,
    \io_out_z80[3] ,
    \io_out_z80[2] ,
    \io_out_z80[1] ,
    \io_out_z80[0] }),
    .la_data_out({la_data_out[39],
    la_data_out[38],
    la_data_out[37],
    la_data_out[36],
    la_data_out[35],
    la_data_out[34],
    la_data_out[33],
    la_data_out[32],
    la_data_out[31],
    la_data_out[30],
    la_data_out[29],
    la_data_out[28],
    la_data_out[27],
    la_data_out[26],
    la_data_out[25],
    la_data_out[24],
    la_data_out[23],
    la_data_out[22],
    la_data_out[21],
    la_data_out[20],
    la_data_out[19],
    la_data_out[18],
    la_data_out[17],
    la_data_out[16],
    la_data_out[15],
    la_data_out[14],
    la_data_out[13],
    la_data_out[12],
    la_data_out[11],
    la_data_out[10],
    la_data_out[9],
    la_data_out[8],
    la_data_out[7],
    la_data_out[6],
    la_data_out[5],
    la_data_out[4],
    la_data_out[3],
    la_data_out[2],
    la_data_out[1],
    la_data_out[0]}),
    .wbs_adr_i({wbs_adr_i[31],
    wbs_adr_i[30],
    wbs_adr_i[29],
    wbs_adr_i[28],
    wbs_adr_i[27],
    wbs_adr_i[26],
    wbs_adr_i[25],
    wbs_adr_i[24],
    wbs_adr_i[23],
    wbs_adr_i[22],
    wbs_adr_i[21],
    wbs_adr_i[20],
    wbs_adr_i[19],
    wbs_adr_i[18],
    wbs_adr_i[17],
    wbs_adr_i[16],
    wbs_adr_i[15],
    wbs_adr_i[14],
    wbs_adr_i[13],
    wbs_adr_i[12],
    wbs_adr_i[11],
    wbs_adr_i[10],
    wbs_adr_i[9],
    wbs_adr_i[8],
    wbs_adr_i[7],
    wbs_adr_i[6],
    wbs_adr_i[5],
    wbs_adr_i[4],
    wbs_adr_i[3],
    wbs_adr_i[2],
    wbs_adr_i[1],
    wbs_adr_i[0]}),
    .wbs_dat_i({wbs_dat_i[31],
    wbs_dat_i[30],
    wbs_dat_i[29],
    wbs_dat_i[28],
    wbs_dat_i[27],
    wbs_dat_i[26],
    wbs_dat_i[25],
    wbs_dat_i[24],
    wbs_dat_i[23],
    wbs_dat_i[22],
    wbs_dat_i[21],
    wbs_dat_i[20],
    wbs_dat_i[19],
    wbs_dat_i[18],
    wbs_dat_i[17],
    wbs_dat_i[16],
    wbs_dat_i[15],
    wbs_dat_i[14],
    wbs_dat_i[13],
    wbs_dat_i[12],
    wbs_dat_i[11],
    wbs_dat_i[10],
    wbs_dat_i[9],
    wbs_dat_i[8],
    wbs_dat_i[7],
    wbs_dat_i[6],
    wbs_dat_i[5],
    wbs_dat_i[4],
    wbs_dat_i[3],
    wbs_dat_i[2],
    wbs_dat_i[1],
    wbs_dat_i[0]}),
    .wbs_dat_o({wbs_dat_o[31],
    wbs_dat_o[30],
    wbs_dat_o[29],
    wbs_dat_o[28],
    wbs_dat_o[27],
    wbs_dat_o[26],
    wbs_dat_o[25],
    wbs_dat_o[24],
    wbs_dat_o[23],
    wbs_dat_o[22],
    wbs_dat_o[21],
    wbs_dat_o[20],
    wbs_dat_o[19],
    wbs_dat_o[18],
    wbs_dat_o[17],
    wbs_dat_o[16],
    wbs_dat_o[15],
    wbs_dat_o[14],
    wbs_dat_o[13],
    wbs_dat_o[12],
    wbs_dat_o[11],
    wbs_dat_o[10],
    wbs_dat_o[9],
    wbs_dat_o[8],
    wbs_dat_o[7],
    wbs_dat_o[6],
    wbs_dat_o[5],
    wbs_dat_o[4],
    wbs_dat_o[3],
    wbs_dat_o[2],
    wbs_dat_o[1],
    wbs_dat_o[0]}));
 scrapcpu scrapcpu (.rst_n(rst_scrapcpu),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .io_in({io_in[37],
    io_in[36],
    io_in[35],
    io_in[34],
    io_in[33],
    io_in[32],
    io_in[31],
    io_in[30],
    io_in[29],
    io_in[28],
    io_in[27],
    io_in[26],
    io_in[25],
    io_in[24],
    io_in[23],
    io_in[22],
    io_in[21],
    io_in[20],
    io_in[19],
    io_in[18],
    io_in[17],
    io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12],
    io_in[11],
    io_in[10],
    io_in[9],
    io_in[8],
    io_in[7],
    io_in[6],
    io_in[5],
    io_in[4],
    io_in[2],
    io_in[1]}),
    .io_oeb({\io_oeb_scrapcpu[35] ,
    \io_oeb_scrapcpu[34] ,
    \io_oeb_scrapcpu[33] ,
    \io_oeb_scrapcpu[32] ,
    \io_oeb_scrapcpu[31] ,
    \io_oeb_scrapcpu[30] ,
    \io_oeb_scrapcpu[29] ,
    \io_oeb_scrapcpu[28] ,
    \io_oeb_scrapcpu[27] ,
    \io_oeb_scrapcpu[26] ,
    \io_oeb_scrapcpu[25] ,
    \io_oeb_scrapcpu[24] ,
    \io_oeb_scrapcpu[23] ,
    \io_oeb_scrapcpu[22] ,
    \io_oeb_scrapcpu[21] ,
    \io_oeb_scrapcpu[20] ,
    \io_oeb_scrapcpu[19] ,
    \io_oeb_scrapcpu[18] ,
    \io_oeb_scrapcpu[17] ,
    \io_oeb_scrapcpu[16] ,
    \io_oeb_scrapcpu[15] ,
    \io_oeb_scrapcpu[14] ,
    \io_oeb_scrapcpu[13] ,
    \io_oeb_scrapcpu[12] ,
    \io_oeb_scrapcpu[11] ,
    \io_oeb_scrapcpu[10] ,
    \io_oeb_scrapcpu[9] ,
    \io_oeb_scrapcpu[8] ,
    \io_oeb_scrapcpu[7] ,
    \io_oeb_scrapcpu[6] ,
    \io_oeb_scrapcpu[5] ,
    \io_oeb_scrapcpu[4] ,
    \io_oeb_scrapcpu[3] ,
    \io_oeb_scrapcpu[2] ,
    \io_oeb_scrapcpu[1] ,
    \io_oeb_scrapcpu[0] }),
    .io_out({\io_out_scrapcpu[35] ,
    \io_out_scrapcpu[34] ,
    \io_out_scrapcpu[33] ,
    \io_out_scrapcpu[32] ,
    \io_out_scrapcpu[31] ,
    \io_out_scrapcpu[30] ,
    \io_out_scrapcpu[29] ,
    \io_out_scrapcpu[28] ,
    \io_out_scrapcpu[27] ,
    \io_out_scrapcpu[26] ,
    \io_out_scrapcpu[25] ,
    \io_out_scrapcpu[24] ,
    \io_out_scrapcpu[23] ,
    \io_out_scrapcpu[22] ,
    \io_out_scrapcpu[21] ,
    \io_out_scrapcpu[20] ,
    \io_out_scrapcpu[19] ,
    \io_out_scrapcpu[18] ,
    \io_out_scrapcpu[17] ,
    \io_out_scrapcpu[16] ,
    \io_out_scrapcpu[15] ,
    \io_out_scrapcpu[14] ,
    \io_out_scrapcpu[13] ,
    \io_out_scrapcpu[12] ,
    \io_out_scrapcpu[11] ,
    \io_out_scrapcpu[10] ,
    \io_out_scrapcpu[9] ,
    \io_out_scrapcpu[8] ,
    \io_out_scrapcpu[7] ,
    \io_out_scrapcpu[6] ,
    \io_out_scrapcpu[5] ,
    \io_out_scrapcpu[4] ,
    \io_out_scrapcpu[3] ,
    \io_out_scrapcpu[2] ,
    \io_out_scrapcpu[1] ,
    \io_out_scrapcpu[0] }));
 unused_tie unused_tie (.vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .irq({user_irq[2],
    user_irq[1],
    user_irq[0]}),
    .la_data_out({la_data_out[127],
    la_data_out[126],
    la_data_out[125],
    la_data_out[124],
    la_data_out[123],
    la_data_out[122],
    la_data_out[121],
    la_data_out[120],
    la_data_out[119],
    la_data_out[118],
    la_data_out[117],
    la_data_out[116],
    la_data_out[115],
    la_data_out[114],
    la_data_out[113],
    la_data_out[112],
    la_data_out[111],
    la_data_out[110],
    la_data_out[109],
    la_data_out[108],
    la_data_out[107],
    la_data_out[106],
    la_data_out[105],
    la_data_out[104],
    la_data_out[103],
    la_data_out[102],
    la_data_out[101],
    la_data_out[100],
    la_data_out[99],
    la_data_out[98],
    la_data_out[97],
    la_data_out[96],
    la_data_out[95],
    la_data_out[94],
    la_data_out[93],
    la_data_out[92],
    la_data_out[91],
    la_data_out[90],
    la_data_out[89],
    la_data_out[88],
    la_data_out[87],
    la_data_out[86],
    la_data_out[85],
    la_data_out[84],
    la_data_out[83],
    la_data_out[82],
    la_data_out[81],
    la_data_out[80],
    la_data_out[79],
    la_data_out[78],
    la_data_out[77],
    la_data_out[76],
    la_data_out[75],
    la_data_out[74],
    la_data_out[73],
    la_data_out[72],
    la_data_out[71],
    la_data_out[70],
    la_data_out[69],
    la_data_out[68],
    la_data_out[67],
    la_data_out[66],
    la_data_out[65],
    la_data_out[64],
    la_data_out[63],
    la_data_out[62],
    la_data_out[61],
    la_data_out[60],
    la_data_out[59],
    la_data_out[58],
    la_data_out[57],
    la_data_out[56],
    la_data_out[55],
    la_data_out[54],
    la_data_out[53],
    la_data_out[52],
    la_data_out[51],
    la_data_out[50],
    la_data_out[49],
    la_data_out[48],
    la_data_out[47],
    la_data_out[46],
    la_data_out[45],
    la_data_out[44],
    la_data_out[43],
    la_data_out[42],
    la_data_out[41],
    la_data_out[40]}));
 vliw vliw (.dest_pred_val0(dest_pred_val0),
    .dest_pred_val1(dest_pred_val1),
    .dest_pred_val2(dest_pred_val2),
    .eu0_busy(eu0_busy),
    .eu1_busy(eu1_busy),
    .eu2_busy(eu2_busy),
    .is_load0(is_load0),
    .is_load1(is_load1),
    .is_load2(is_load2),
    .is_store0(is_store0),
    .is_store1(is_store1),
    .is_store2(is_store2),
    .pred_val0(pred_val0),
    .pred_val1(pred_val1),
    .pred_val2(pred_val2),
    .rst_eu(rst_eu),
    .rst_n(rst_vliw),
    .sign_extend0(sign_extend0),
    .sign_extend1(sign_extend1),
    .sign_extend2(sign_extend2),
    .take_branch0(take_branch0),
    .take_branch1(take_branch1),
    .take_branch2(take_branch2),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .curr_PC({\curr_PC[27] ,
    \curr_PC[26] ,
    \curr_PC[25] ,
    \curr_PC[24] ,
    \curr_PC[23] ,
    \curr_PC[22] ,
    \curr_PC[21] ,
    \curr_PC[20] ,
    \curr_PC[19] ,
    \curr_PC[18] ,
    \curr_PC[17] ,
    \curr_PC[16] ,
    \curr_PC[15] ,
    \curr_PC[14] ,
    \curr_PC[13] ,
    \curr_PC[12] ,
    \curr_PC[11] ,
    \curr_PC[10] ,
    \curr_PC[9] ,
    \curr_PC[8] ,
    \curr_PC[7] ,
    \curr_PC[6] ,
    \curr_PC[5] ,
    \curr_PC[4] ,
    \curr_PC[3] ,
    \curr_PC[2] ,
    \curr_PC[1] ,
    \curr_PC[0] }),
    .custom_settings({\custom_settings[4] ,
    \custom_settings[3] ,
    \custom_settings[2] ,
    \custom_settings[1] ,
    \custom_settings[0] }),
    .dest_idx0({\dest_idx0[4] ,
    \dest_idx0[3] ,
    \dest_idx0[2] ,
    \dest_idx0[1] ,
    \dest_idx0[0] }),
    .dest_idx1({\dest_idx1[4] ,
    \dest_idx1[3] ,
    \dest_idx1[2] ,
    \dest_idx1[1] ,
    \dest_idx1[0] }),
    .dest_idx2({\dest_idx2[4] ,
    \dest_idx2[3] ,
    \dest_idx2[2] ,
    \dest_idx2[1] ,
    \dest_idx2[0] }),
    .dest_mask0({\dest_mask0[1] ,
    \dest_mask0[0] }),
    .dest_mask1({\dest_mask1[1] ,
    \dest_mask1[0] }),
    .dest_mask2({\dest_mask2[1] ,
    \dest_mask2[0] }),
    .dest_pred0({\dest_pred0[2] ,
    \dest_pred0[1] ,
    \dest_pred0[0] }),
    .dest_pred1({\dest_pred1[2] ,
    \dest_pred1[1] ,
    \dest_pred1[0] }),
    .dest_pred2({\dest_pred2[2] ,
    \dest_pred2[1] ,
    \dest_pred2[0] }),
    .dest_val0({\dest_val0[31] ,
    \dest_val0[30] ,
    \dest_val0[29] ,
    \dest_val0[28] ,
    \dest_val0[27] ,
    \dest_val0[26] ,
    \dest_val0[25] ,
    \dest_val0[24] ,
    \dest_val0[23] ,
    \dest_val0[22] ,
    \dest_val0[21] ,
    \dest_val0[20] ,
    \dest_val0[19] ,
    \dest_val0[18] ,
    \dest_val0[17] ,
    \dest_val0[16] ,
    \dest_val0[15] ,
    \dest_val0[14] ,
    \dest_val0[13] ,
    \dest_val0[12] ,
    \dest_val0[11] ,
    \dest_val0[10] ,
    \dest_val0[9] ,
    \dest_val0[8] ,
    \dest_val0[7] ,
    \dest_val0[6] ,
    \dest_val0[5] ,
    \dest_val0[4] ,
    \dest_val0[3] ,
    \dest_val0[2] ,
    \dest_val0[1] ,
    \dest_val0[0] }),
    .dest_val1({\dest_val1[31] ,
    \dest_val1[30] ,
    \dest_val1[29] ,
    \dest_val1[28] ,
    \dest_val1[27] ,
    \dest_val1[26] ,
    \dest_val1[25] ,
    \dest_val1[24] ,
    \dest_val1[23] ,
    \dest_val1[22] ,
    \dest_val1[21] ,
    \dest_val1[20] ,
    \dest_val1[19] ,
    \dest_val1[18] ,
    \dest_val1[17] ,
    \dest_val1[16] ,
    \dest_val1[15] ,
    \dest_val1[14] ,
    \dest_val1[13] ,
    \dest_val1[12] ,
    \dest_val1[11] ,
    \dest_val1[10] ,
    \dest_val1[9] ,
    \dest_val1[8] ,
    \dest_val1[7] ,
    \dest_val1[6] ,
    \dest_val1[5] ,
    \dest_val1[4] ,
    \dest_val1[3] ,
    \dest_val1[2] ,
    \dest_val1[1] ,
    \dest_val1[0] }),
    .dest_val2({\dest_val2[31] ,
    \dest_val2[30] ,
    \dest_val2[29] ,
    \dest_val2[28] ,
    \dest_val2[27] ,
    \dest_val2[26] ,
    \dest_val2[25] ,
    \dest_val2[24] ,
    \dest_val2[23] ,
    \dest_val2[22] ,
    \dest_val2[21] ,
    \dest_val2[20] ,
    \dest_val2[19] ,
    \dest_val2[18] ,
    \dest_val2[17] ,
    \dest_val2[16] ,
    \dest_val2[15] ,
    \dest_val2[14] ,
    \dest_val2[13] ,
    \dest_val2[12] ,
    \dest_val2[11] ,
    \dest_val2[10] ,
    \dest_val2[9] ,
    \dest_val2[8] ,
    \dest_val2[7] ,
    \dest_val2[6] ,
    \dest_val2[5] ,
    \dest_val2[4] ,
    \dest_val2[3] ,
    \dest_val2[2] ,
    \dest_val2[1] ,
    \dest_val2[0] }),
    .eu0_instruction({\eu0_instruction[41] ,
    \eu0_instruction[40] ,
    \eu0_instruction[39] ,
    \eu0_instruction[38] ,
    \eu0_instruction[37] ,
    \eu0_instruction[36] ,
    \eu0_instruction[35] ,
    \eu0_instruction[34] ,
    \eu0_instruction[33] ,
    \eu0_instruction[32] ,
    \eu0_instruction[31] ,
    \eu0_instruction[30] ,
    \eu0_instruction[29] ,
    \eu0_instruction[28] ,
    \eu0_instruction[27] ,
    \eu0_instruction[26] ,
    \eu0_instruction[25] ,
    \eu0_instruction[24] ,
    \eu0_instruction[23] ,
    \eu0_instruction[22] ,
    \eu0_instruction[21] ,
    \eu0_instruction[20] ,
    \eu0_instruction[19] ,
    \eu0_instruction[18] ,
    \eu0_instruction[17] ,
    \eu0_instruction[16] ,
    \eu0_instruction[15] ,
    \eu0_instruction[14] ,
    \eu0_instruction[13] ,
    \eu0_instruction[12] ,
    \eu0_instruction[11] ,
    \eu0_instruction[10] ,
    \eu0_instruction[9] ,
    \eu0_instruction[8] ,
    \eu0_instruction[7] ,
    \eu0_instruction[6] ,
    \eu0_instruction[5] ,
    \eu0_instruction[4] ,
    \eu0_instruction[3] ,
    \eu0_instruction[2] ,
    \eu0_instruction[1] ,
    \eu0_instruction[0] }),
    .eu1_instruction({\eu1_instruction[41] ,
    \eu1_instruction[40] ,
    \eu1_instruction[39] ,
    \eu1_instruction[38] ,
    \eu1_instruction[37] ,
    \eu1_instruction[36] ,
    \eu1_instruction[35] ,
    \eu1_instruction[34] ,
    \eu1_instruction[33] ,
    \eu1_instruction[32] ,
    \eu1_instruction[31] ,
    \eu1_instruction[30] ,
    \eu1_instruction[29] ,
    \eu1_instruction[28] ,
    \eu1_instruction[27] ,
    \eu1_instruction[26] ,
    \eu1_instruction[25] ,
    \eu1_instruction[24] ,
    \eu1_instruction[23] ,
    \eu1_instruction[22] ,
    \eu1_instruction[21] ,
    \eu1_instruction[20] ,
    \eu1_instruction[19] ,
    \eu1_instruction[18] ,
    \eu1_instruction[17] ,
    \eu1_instruction[16] ,
    \eu1_instruction[15] ,
    \eu1_instruction[14] ,
    \eu1_instruction[13] ,
    \eu1_instruction[12] ,
    \eu1_instruction[11] ,
    \eu1_instruction[10] ,
    \eu1_instruction[9] ,
    \eu1_instruction[8] ,
    \eu1_instruction[7] ,
    \eu1_instruction[6] ,
    \eu1_instruction[5] ,
    \eu1_instruction[4] ,
    \eu1_instruction[3] ,
    \eu1_instruction[2] ,
    \eu1_instruction[1] ,
    \eu1_instruction[0] }),
    .eu2_instruction({\eu2_instruction[41] ,
    \eu2_instruction[40] ,
    \eu2_instruction[39] ,
    \eu2_instruction[38] ,
    \eu2_instruction[37] ,
    \eu2_instruction[36] ,
    \eu2_instruction[35] ,
    \eu2_instruction[34] ,
    \eu2_instruction[33] ,
    \eu2_instruction[32] ,
    \eu2_instruction[31] ,
    \eu2_instruction[30] ,
    \eu2_instruction[29] ,
    \eu2_instruction[28] ,
    \eu2_instruction[27] ,
    \eu2_instruction[26] ,
    \eu2_instruction[25] ,
    \eu2_instruction[24] ,
    \eu2_instruction[23] ,
    \eu2_instruction[22] ,
    \eu2_instruction[21] ,
    \eu2_instruction[20] ,
    \eu2_instruction[19] ,
    \eu2_instruction[18] ,
    \eu2_instruction[17] ,
    \eu2_instruction[16] ,
    \eu2_instruction[15] ,
    \eu2_instruction[14] ,
    \eu2_instruction[13] ,
    \eu2_instruction[12] ,
    \eu2_instruction[11] ,
    \eu2_instruction[10] ,
    \eu2_instruction[9] ,
    \eu2_instruction[8] ,
    \eu2_instruction[7] ,
    \eu2_instruction[6] ,
    \eu2_instruction[5] ,
    \eu2_instruction[4] ,
    \eu2_instruction[3] ,
    \eu2_instruction[2] ,
    \eu2_instruction[1] ,
    \eu2_instruction[0] }),
    .io_in({io_in[37],
    io_in[36],
    io_in[35],
    io_in[34],
    io_in[33],
    io_in[32],
    io_in[31],
    io_in[30],
    io_in[29],
    io_in[28],
    io_in[27],
    io_in[26],
    io_in[25],
    io_in[24],
    io_in[23],
    io_in[22],
    io_in[21],
    io_in[20],
    io_in[19],
    io_in[18],
    io_in[17],
    io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12],
    io_in[11],
    io_in[10],
    io_in[9],
    io_in[8],
    io_in[7],
    io_in[6],
    io_in[5],
    io_in[4],
    io_in[2],
    io_in[1]}),
    .io_oeb({\io_oeb_vliw[35] ,
    \io_oeb_vliw[34] ,
    \io_oeb_vliw[33] ,
    \io_oeb_vliw[32] ,
    \io_oeb_vliw[31] ,
    \io_oeb_vliw[30] ,
    \io_oeb_vliw[29] ,
    \io_oeb_vliw[28] ,
    \io_oeb_vliw[27] ,
    \io_oeb_vliw[26] ,
    \io_oeb_vliw[25] ,
    \io_oeb_vliw[24] ,
    \io_oeb_vliw[23] ,
    \io_oeb_vliw[22] ,
    \io_oeb_vliw[21] ,
    \io_oeb_vliw[20] ,
    \io_oeb_vliw[19] ,
    \io_oeb_vliw[18] ,
    \io_oeb_vliw[17] ,
    \io_oeb_vliw[16] ,
    \io_oeb_vliw[15] ,
    \io_oeb_vliw[14] ,
    \io_oeb_vliw[13] ,
    \io_oeb_vliw[12] ,
    \io_oeb_vliw[11] ,
    \io_oeb_vliw[10] ,
    \io_oeb_vliw[9] ,
    \io_oeb_vliw[8] ,
    \io_oeb_vliw[7] ,
    \io_oeb_vliw[6] ,
    \io_oeb_vliw[5] ,
    \io_oeb_vliw[4] ,
    \io_oeb_vliw[3] ,
    \io_oeb_vliw[2] ,
    \io_oeb_vliw[1] ,
    \io_oeb_vliw[0] }),
    .io_out({\io_out_vliw[35] ,
    \io_out_vliw[34] ,
    \io_out_vliw[33] ,
    \io_out_vliw[32] ,
    \io_out_vliw[31] ,
    \io_out_vliw[30] ,
    \io_out_vliw[29] ,
    \io_out_vliw[28] ,
    \io_out_vliw[27] ,
    \io_out_vliw[26] ,
    \io_out_vliw[25] ,
    \io_out_vliw[24] ,
    \io_out_vliw[23] ,
    \io_out_vliw[22] ,
    \io_out_vliw[21] ,
    \io_out_vliw[20] ,
    \io_out_vliw[19] ,
    \io_out_vliw[18] ,
    \io_out_vliw[17] ,
    \io_out_vliw[16] ,
    \io_out_vliw[15] ,
    \io_out_vliw[14] ,
    \io_out_vliw[13] ,
    \io_out_vliw[12] ,
    \io_out_vliw[11] ,
    \io_out_vliw[10] ,
    \io_out_vliw[9] ,
    \io_out_vliw[8] ,
    \io_out_vliw[7] ,
    \io_out_vliw[6] ,
    \io_out_vliw[5] ,
    \io_out_vliw[4] ,
    \io_out_vliw[3] ,
    \io_out_vliw[2] ,
    \io_out_vliw[1] ,
    \io_out_vliw[0] }),
    .loadstore_address0({\loadstore_address0[31] ,
    \loadstore_address0[30] ,
    \loadstore_address0[29] ,
    \loadstore_address0[28] ,
    \loadstore_address0[27] ,
    \loadstore_address0[26] ,
    \loadstore_address0[25] ,
    \loadstore_address0[24] ,
    \loadstore_address0[23] ,
    \loadstore_address0[22] ,
    \loadstore_address0[21] ,
    \loadstore_address0[20] ,
    \loadstore_address0[19] ,
    \loadstore_address0[18] ,
    \loadstore_address0[17] ,
    \loadstore_address0[16] ,
    \loadstore_address0[15] ,
    \loadstore_address0[14] ,
    \loadstore_address0[13] ,
    \loadstore_address0[12] ,
    \loadstore_address0[11] ,
    \loadstore_address0[10] ,
    \loadstore_address0[9] ,
    \loadstore_address0[8] ,
    \loadstore_address0[7] ,
    \loadstore_address0[6] ,
    \loadstore_address0[5] ,
    \loadstore_address0[4] ,
    \loadstore_address0[3] ,
    \loadstore_address0[2] ,
    \loadstore_address0[1] ,
    \loadstore_address0[0] }),
    .loadstore_address1({\loadstore_address1[31] ,
    \loadstore_address1[30] ,
    \loadstore_address1[29] ,
    \loadstore_address1[28] ,
    \loadstore_address1[27] ,
    \loadstore_address1[26] ,
    \loadstore_address1[25] ,
    \loadstore_address1[24] ,
    \loadstore_address1[23] ,
    \loadstore_address1[22] ,
    \loadstore_address1[21] ,
    \loadstore_address1[20] ,
    \loadstore_address1[19] ,
    \loadstore_address1[18] ,
    \loadstore_address1[17] ,
    \loadstore_address1[16] ,
    \loadstore_address1[15] ,
    \loadstore_address1[14] ,
    \loadstore_address1[13] ,
    \loadstore_address1[12] ,
    \loadstore_address1[11] ,
    \loadstore_address1[10] ,
    \loadstore_address1[9] ,
    \loadstore_address1[8] ,
    \loadstore_address1[7] ,
    \loadstore_address1[6] ,
    \loadstore_address1[5] ,
    \loadstore_address1[4] ,
    \loadstore_address1[3] ,
    \loadstore_address1[2] ,
    \loadstore_address1[1] ,
    \loadstore_address1[0] }),
    .loadstore_address2({\loadstore_address2[31] ,
    \loadstore_address2[30] ,
    \loadstore_address2[29] ,
    \loadstore_address2[28] ,
    \loadstore_address2[27] ,
    \loadstore_address2[26] ,
    \loadstore_address2[25] ,
    \loadstore_address2[24] ,
    \loadstore_address2[23] ,
    \loadstore_address2[22] ,
    \loadstore_address2[21] ,
    \loadstore_address2[20] ,
    \loadstore_address2[19] ,
    \loadstore_address2[18] ,
    \loadstore_address2[17] ,
    \loadstore_address2[16] ,
    \loadstore_address2[15] ,
    \loadstore_address2[14] ,
    \loadstore_address2[13] ,
    \loadstore_address2[12] ,
    \loadstore_address2[11] ,
    \loadstore_address2[10] ,
    \loadstore_address2[9] ,
    \loadstore_address2[8] ,
    \loadstore_address2[7] ,
    \loadstore_address2[6] ,
    \loadstore_address2[5] ,
    \loadstore_address2[4] ,
    \loadstore_address2[3] ,
    \loadstore_address2[2] ,
    \loadstore_address2[1] ,
    \loadstore_address2[0] }),
    .loadstore_dest0({\loadstore_dest0[4] ,
    \loadstore_dest0[3] ,
    \loadstore_dest0[2] ,
    \loadstore_dest0[1] ,
    \loadstore_dest0[0] }),
    .loadstore_dest1({\loadstore_dest1[4] ,
    \loadstore_dest1[3] ,
    \loadstore_dest1[2] ,
    \loadstore_dest1[1] ,
    \loadstore_dest1[0] }),
    .loadstore_dest2({\loadstore_dest2[4] ,
    \loadstore_dest2[3] ,
    \loadstore_dest2[2] ,
    \loadstore_dest2[1] ,
    \loadstore_dest2[0] }),
    .loadstore_size0({\loadstore_size0[1] ,
    \loadstore_size0[0] }),
    .loadstore_size1({\loadstore_size1[1] ,
    \loadstore_size1[0] }),
    .loadstore_size2({\loadstore_size2[1] ,
    \loadstore_size2[0] }),
    .new_PC0({\new_PC0[27] ,
    \new_PC0[26] ,
    \new_PC0[25] ,
    \new_PC0[24] ,
    \new_PC0[23] ,
    \new_PC0[22] ,
    \new_PC0[21] ,
    \new_PC0[20] ,
    \new_PC0[19] ,
    \new_PC0[18] ,
    \new_PC0[17] ,
    \new_PC0[16] ,
    \new_PC0[15] ,
    \new_PC0[14] ,
    \new_PC0[13] ,
    \new_PC0[12] ,
    \new_PC0[11] ,
    \new_PC0[10] ,
    \new_PC0[9] ,
    \new_PC0[8] ,
    \new_PC0[7] ,
    \new_PC0[6] ,
    \new_PC0[5] ,
    \new_PC0[4] ,
    \new_PC0[3] ,
    \new_PC0[2] ,
    \new_PC0[1] ,
    \new_PC0[0] }),
    .new_PC1({\new_PC1[27] ,
    \new_PC1[26] ,
    \new_PC1[25] ,
    \new_PC1[24] ,
    \new_PC1[23] ,
    \new_PC1[22] ,
    \new_PC1[21] ,
    \new_PC1[20] ,
    \new_PC1[19] ,
    \new_PC1[18] ,
    \new_PC1[17] ,
    \new_PC1[16] ,
    \new_PC1[15] ,
    \new_PC1[14] ,
    \new_PC1[13] ,
    \new_PC1[12] ,
    \new_PC1[11] ,
    \new_PC1[10] ,
    \new_PC1[9] ,
    \new_PC1[8] ,
    \new_PC1[7] ,
    \new_PC1[6] ,
    \new_PC1[5] ,
    \new_PC1[4] ,
    \new_PC1[3] ,
    \new_PC1[2] ,
    \new_PC1[1] ,
    \new_PC1[0] }),
    .new_PC2({\new_PC2[27] ,
    \new_PC2[26] ,
    \new_PC2[25] ,
    \new_PC2[24] ,
    \new_PC2[23] ,
    \new_PC2[22] ,
    \new_PC2[21] ,
    \new_PC2[20] ,
    \new_PC2[19] ,
    \new_PC2[18] ,
    \new_PC2[17] ,
    \new_PC2[16] ,
    \new_PC2[15] ,
    \new_PC2[14] ,
    \new_PC2[13] ,
    \new_PC2[12] ,
    \new_PC2[11] ,
    \new_PC2[10] ,
    \new_PC2[9] ,
    \new_PC2[8] ,
    \new_PC2[7] ,
    \new_PC2[6] ,
    \new_PC2[5] ,
    \new_PC2[4] ,
    \new_PC2[3] ,
    \new_PC2[2] ,
    \new_PC2[1] ,
    \new_PC2[0] }),
    .pred_idx0({\pred_idx0[2] ,
    \pred_idx0[1] ,
    \pred_idx0[0] }),
    .pred_idx1({\pred_idx1[2] ,
    \pred_idx1[1] ,
    \pred_idx1[0] }),
    .pred_idx2({\pred_idx2[2] ,
    \pred_idx2[1] ,
    \pred_idx2[0] }),
    .reg1_idx0({\reg1_idx0[4] ,
    \reg1_idx0[3] ,
    \reg1_idx0[2] ,
    \reg1_idx0[1] ,
    \reg1_idx0[0] }),
    .reg1_idx1({\reg1_idx1[4] ,
    \reg1_idx1[3] ,
    \reg1_idx1[2] ,
    \reg1_idx1[1] ,
    \reg1_idx1[0] }),
    .reg1_idx2({\reg1_idx2[4] ,
    \reg1_idx2[3] ,
    \reg1_idx2[2] ,
    \reg1_idx2[1] ,
    \reg1_idx2[0] }),
    .reg1_val0({\reg1_val0[31] ,
    \reg1_val0[30] ,
    \reg1_val0[29] ,
    \reg1_val0[28] ,
    \reg1_val0[27] ,
    \reg1_val0[26] ,
    \reg1_val0[25] ,
    \reg1_val0[24] ,
    \reg1_val0[23] ,
    \reg1_val0[22] ,
    \reg1_val0[21] ,
    \reg1_val0[20] ,
    \reg1_val0[19] ,
    \reg1_val0[18] ,
    \reg1_val0[17] ,
    \reg1_val0[16] ,
    \reg1_val0[15] ,
    \reg1_val0[14] ,
    \reg1_val0[13] ,
    \reg1_val0[12] ,
    \reg1_val0[11] ,
    \reg1_val0[10] ,
    \reg1_val0[9] ,
    \reg1_val0[8] ,
    \reg1_val0[7] ,
    \reg1_val0[6] ,
    \reg1_val0[5] ,
    \reg1_val0[4] ,
    \reg1_val0[3] ,
    \reg1_val0[2] ,
    \reg1_val0[1] ,
    \reg1_val0[0] }),
    .reg1_val1({\reg1_val1[31] ,
    \reg1_val1[30] ,
    \reg1_val1[29] ,
    \reg1_val1[28] ,
    \reg1_val1[27] ,
    \reg1_val1[26] ,
    \reg1_val1[25] ,
    \reg1_val1[24] ,
    \reg1_val1[23] ,
    \reg1_val1[22] ,
    \reg1_val1[21] ,
    \reg1_val1[20] ,
    \reg1_val1[19] ,
    \reg1_val1[18] ,
    \reg1_val1[17] ,
    \reg1_val1[16] ,
    \reg1_val1[15] ,
    \reg1_val1[14] ,
    \reg1_val1[13] ,
    \reg1_val1[12] ,
    \reg1_val1[11] ,
    \reg1_val1[10] ,
    \reg1_val1[9] ,
    \reg1_val1[8] ,
    \reg1_val1[7] ,
    \reg1_val1[6] ,
    \reg1_val1[5] ,
    \reg1_val1[4] ,
    \reg1_val1[3] ,
    \reg1_val1[2] ,
    \reg1_val1[1] ,
    \reg1_val1[0] }),
    .reg1_val2({\reg1_val2[31] ,
    \reg1_val2[30] ,
    \reg1_val2[29] ,
    \reg1_val2[28] ,
    \reg1_val2[27] ,
    \reg1_val2[26] ,
    \reg1_val2[25] ,
    \reg1_val2[24] ,
    \reg1_val2[23] ,
    \reg1_val2[22] ,
    \reg1_val2[21] ,
    \reg1_val2[20] ,
    \reg1_val2[19] ,
    \reg1_val2[18] ,
    \reg1_val2[17] ,
    \reg1_val2[16] ,
    \reg1_val2[15] ,
    \reg1_val2[14] ,
    \reg1_val2[13] ,
    \reg1_val2[12] ,
    \reg1_val2[11] ,
    \reg1_val2[10] ,
    \reg1_val2[9] ,
    \reg1_val2[8] ,
    \reg1_val2[7] ,
    \reg1_val2[6] ,
    \reg1_val2[5] ,
    \reg1_val2[4] ,
    \reg1_val2[3] ,
    \reg1_val2[2] ,
    \reg1_val2[1] ,
    \reg1_val2[0] }),
    .reg2_idx0({\reg2_idx0[4] ,
    \reg2_idx0[3] ,
    \reg2_idx0[2] ,
    \reg2_idx0[1] ,
    \reg2_idx0[0] }),
    .reg2_idx1({\reg2_idx1[4] ,
    \reg2_idx1[3] ,
    \reg2_idx1[2] ,
    \reg2_idx1[1] ,
    \reg2_idx1[0] }),
    .reg2_idx2({\reg2_idx2[4] ,
    \reg2_idx2[3] ,
    \reg2_idx2[2] ,
    \reg2_idx2[1] ,
    \reg2_idx2[0] }),
    .reg2_val0({\reg2_val0[31] ,
    \reg2_val0[30] ,
    \reg2_val0[29] ,
    \reg2_val0[28] ,
    \reg2_val0[27] ,
    \reg2_val0[26] ,
    \reg2_val0[25] ,
    \reg2_val0[24] ,
    \reg2_val0[23] ,
    \reg2_val0[22] ,
    \reg2_val0[21] ,
    \reg2_val0[20] ,
    \reg2_val0[19] ,
    \reg2_val0[18] ,
    \reg2_val0[17] ,
    \reg2_val0[16] ,
    \reg2_val0[15] ,
    \reg2_val0[14] ,
    \reg2_val0[13] ,
    \reg2_val0[12] ,
    \reg2_val0[11] ,
    \reg2_val0[10] ,
    \reg2_val0[9] ,
    \reg2_val0[8] ,
    \reg2_val0[7] ,
    \reg2_val0[6] ,
    \reg2_val0[5] ,
    \reg2_val0[4] ,
    \reg2_val0[3] ,
    \reg2_val0[2] ,
    \reg2_val0[1] ,
    \reg2_val0[0] }),
    .reg2_val1({\reg2_val1[31] ,
    \reg2_val1[30] ,
    \reg2_val1[29] ,
    \reg2_val1[28] ,
    \reg2_val1[27] ,
    \reg2_val1[26] ,
    \reg2_val1[25] ,
    \reg2_val1[24] ,
    \reg2_val1[23] ,
    \reg2_val1[22] ,
    \reg2_val1[21] ,
    \reg2_val1[20] ,
    \reg2_val1[19] ,
    \reg2_val1[18] ,
    \reg2_val1[17] ,
    \reg2_val1[16] ,
    \reg2_val1[15] ,
    \reg2_val1[14] ,
    \reg2_val1[13] ,
    \reg2_val1[12] ,
    \reg2_val1[11] ,
    \reg2_val1[10] ,
    \reg2_val1[9] ,
    \reg2_val1[8] ,
    \reg2_val1[7] ,
    \reg2_val1[6] ,
    \reg2_val1[5] ,
    \reg2_val1[4] ,
    \reg2_val1[3] ,
    \reg2_val1[2] ,
    \reg2_val1[1] ,
    \reg2_val1[0] }),
    .reg2_val2({\reg2_val2[31] ,
    \reg2_val2[30] ,
    \reg2_val2[29] ,
    \reg2_val2[28] ,
    \reg2_val2[27] ,
    \reg2_val2[26] ,
    \reg2_val2[25] ,
    \reg2_val2[24] ,
    \reg2_val2[23] ,
    \reg2_val2[22] ,
    \reg2_val2[21] ,
    \reg2_val2[20] ,
    \reg2_val2[19] ,
    \reg2_val2[18] ,
    \reg2_val2[17] ,
    \reg2_val2[16] ,
    \reg2_val2[15] ,
    \reg2_val2[14] ,
    \reg2_val2[13] ,
    \reg2_val2[12] ,
    \reg2_val2[11] ,
    \reg2_val2[10] ,
    \reg2_val2[9] ,
    \reg2_val2[8] ,
    \reg2_val2[7] ,
    \reg2_val2[6] ,
    \reg2_val2[5] ,
    \reg2_val2[4] ,
    \reg2_val2[3] ,
    \reg2_val2[2] ,
    \reg2_val2[1] ,
    \reg2_val2[0] }));
endmodule
