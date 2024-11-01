###############################################################################
# Created by write_sdc
# Sat Jun  1 21:40:28 2024
###############################################################################
current_design icache
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 25.0000 [get_ports {wb_clk_i}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_clock_latency -source -min 4.6500 [get_clocks {clk}]
set_clock_latency -source -max 5.5700 [get_clocks {clk}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.1900 [get_ports {cache_hit}]
set_load -pin_load 0.1900 [get_ports {cache_entry[127]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[126]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[125]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[124]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[123]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[122]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[121]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[120]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[119]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[118]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[117]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[116]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[115]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[114]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[113]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[112]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[111]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[110]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[109]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[108]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[107]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[106]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[105]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[104]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[103]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[102]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[101]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[100]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[99]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[98]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[97]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[96]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[95]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[94]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[93]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[92]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[91]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[90]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[89]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[88]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[87]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[86]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[85]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[84]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[83]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[82]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[81]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[80]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[79]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[78]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[77]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[76]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[75]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[74]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[73]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[72]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[71]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[70]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[69]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[68]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[67]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[66]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[65]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[64]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[63]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[62]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[61]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[60]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[59]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[58]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[57]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[56]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[55]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[54]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[53]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[52]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[51]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[50]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[49]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[48]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[47]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[46]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[45]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[44]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[43]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[42]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[41]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[40]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[39]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[38]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[37]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[36]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[35]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[34]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[33]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[32]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[31]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[30]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[29]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[28]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[27]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[26]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[25]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[24]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[23]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[22]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[21]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[20]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[19]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[18]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[17]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[16]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[15]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[14]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[13]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[12]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[11]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[10]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[9]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[8]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[7]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[6]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[5]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[4]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[3]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[2]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[1]}]
set_load -pin_load 0.1900 [get_ports {cache_entry[0]}]
set_input_transition 0.6100 [get_ports {wb_clk_i}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 1.0000 [current_design]
set_max_fanout 16.0000 [current_design]
