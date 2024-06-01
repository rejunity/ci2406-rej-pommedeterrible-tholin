// This is the unpowered netlist.
module user_project_wrapper (user_clock2,
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
 wire rst_scrapcpu;
 wire rst_vliw;
 wire rst_z80;

 ci2406_z80 ci2406_z80 (.rst_n(rst_z80),
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
 multiplexer multiplexer (.io_in_0(io_in[0]),
    .rst_scrapcpu(rst_scrapcpu),
    .rst_vliw(rst_vliw),
    .rst_z80(rst_z80),
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
 unused_tie unused_tie (.wb_clk_i(wb_clk_i),
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
endmodule

