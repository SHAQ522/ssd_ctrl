## Generated SDC file "gige_transport.sdc"

## Copyright (C) 1991-2009 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 9.0 Build 132 02/25/2009 SJ Full Version"

## DATE    "Mon Jun 18 10:04:34 2012"

##
## DEVICE  "EP2S180F1508I4"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {CLK_2} -period 8.000 -waveform { 0.000 4.000 } [get_ports {CLK_2}]
create_clock -name {CLK_1} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLK_1}]
create_clock -name {CLK_IN} -period 6.667 -waveform { 0.000 3.333 } [get_ports {SMA_CLKIN5 SMA_CLKIN6 SMA_CLKIN7 SMA_CLKIN8}]
create_clock -name {CLK_SDRAM} -period 6.667 -waveform { 0.000 3.333 } [get_ports {SDRAM_A_CLK SDRAM_B_CLK SDRAM_C_CLK SDRAM_D_CLK}]
create_clock -name {CLK_OUT} -period 6.667 -waveform { 0.000 3.333 } [get_ports {LVDS1_DATA[0] LVDS1_DATA[3] LVDS1_DATA[6] LVDS1_DATA[9] LVDS2_DATA[0] LVDS2_DATA[3] LVDS2_DATA[6]}]


#**************************************************************
# Create Generated Clock
#**************************************************************

derive_pll_clocks -use_tan_name


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_SYN}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_CLK}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_DATA[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_DATA[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_DATA[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_DATA[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_DATA[8]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS1_DATA[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS2_SYN}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS2_CLK}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS2_DATA[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS2_DATA[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS2_DATA[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_OUT}]  0.000 [get_ports {LVDS2_DATA[4]}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -exclusive -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {  PLL_SYS:inst36|altpll:altpll_component|_clk0  PLL_MAIN:inst5|altpll:altpll_component|_clk0  PLL_MAIN:inst5|altpll:altpll_component|_clk1  PLL_TEST:inst7|altpll:altpll_component|_clk3  CLK_1  }] -group [get_clocks {  sdram_phase180:inst25|altpll:altpll_component|_clk0  CLK_2  }] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_8f9:dffpipe14|dffe15a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_7f9:dffpipe11|dffe12a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_id9:dffpipe11|dffe12a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_hd9:dffpipe8|dffe9a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_df9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_cf9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_bf9:dffpipe17|dffe18a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_9f9:dffpipe13|dffe14a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_se9:dffpipe18|dffe19a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_qe9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_ue9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_te9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_1f9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_ve9:dffpipe8|dffe9a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_hf9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_gf9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_3f9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_2f9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_od9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_nd9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_ff9:dffpipe8|dffe9a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_ef9:dffpipe5|dffe6a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_kd9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_jd9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_md9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_ld9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_gd9:dffpipe14|dffe15a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_fd9:dffpipe10|dffe11a*}]
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -from [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_nios2_oci_break:the_cpu_0_nios2_oci_break|break_readreg*}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_tck:the_cpu_0_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_nios2_oci_debug:the_cpu_0_nios2_oci_debug|*resetlatch}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_tck:the_cpu_0_jtag_debug_module_tck|*sr[33]}]
set_false_path -from [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_nios2_oci_debug:the_cpu_0_nios2_oci_debug|monitor_ready}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_tck:the_cpu_0_jtag_debug_module_tck|*sr[0]}]
set_false_path -from [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_nios2_oci_debug:the_cpu_0_nios2_oci_debug|monitor_error}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_tck:the_cpu_0_jtag_debug_module_tck|*sr[34]}]
set_false_path -from [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_nios2_ocimem:the_cpu_0_nios2_ocimem|*MonDReg*}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_tck:the_cpu_0_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_tck:the_cpu_0_jtag_debug_module_tck|*sr*}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_sysclk:the_cpu_0_jtag_debug_module_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:sld_hub_inst|irf_reg*}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_jtag_debug_module_wrapper:the_cpu_0_jtag_debug_module_wrapper|cpu_0_jtag_debug_module_sysclk:the_cpu_0_jtag_debug_module_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:sld_hub_inst|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*cpu_0:the_cpu_0|cpu_0_nios2_oci:the_cpu_0_nios2_oci|cpu_0_nios2_oci_debug:the_cpu_0_nios2_oci_debug|monitor_go}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

