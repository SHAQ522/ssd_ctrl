#####################################################################################
# Copyright (C) 1991-2007 Altera Corporation
# Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
# support information,  device programming or simulation file,  and any other
# associated  documentation or information  provided by  Altera  or a partner
# under  Altera's   Megafunction   Partnership   Program  may  be  used  only
# to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
# other  use  of such  megafunction  design,  netlist,  support  information,
# device programming or simulation file,  or any other  related documentation
# or information  is prohibited  for  any  other purpose,  including, but not
# limited to  modification,  reverse engineering,  de-compiling, or use  with
# any other  silicon devices,  unless such use is  explicitly  licensed under
# a separate agreement with  Altera  or a megafunction partner.  Title to the
# intellectual property,  including patents,  copyrights,  trademarks,  trade
# secrets,  or maskworks,  embodied in any such megafunction design, netlist,
# support  information,  device programming or simulation file,  or any other
# related documentation or information provided by  Altera  or a megafunction
# partner, remains with Altera, the megafunction partner, or their respective
# licensors. No other licenses, including any licenses needed under any third
# party's intellectual property, are provided herein.
#####################################################################################

#####################################################################################
# Altera Triple-Speed Ethernet Megacore NativeLink TCL script
#
# This script should be sourced from the Quartus II TCL console prior to 
# simulating using NativeLink 
#
# Generated on Thu Apr 21 15:40:50 CST 2011
#
#####################################################################################


#Set time scale
set_global_assignment -name EDA_TIME_SCALE "1 ns" -section_id eda_simulation

#Set eda netlist writer options
set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG" -section_id eda_simulation

#Set to work in test bench mode
set_global_assignment -name EDA_TEST_BENCH_ENABLE_STATUS TEST_BENCH_MODE -section_id eda_simulation

#Set testbench top level name and module name
set_global_assignment -name EDA_NATIVELINK_SIMULATION_TEST_BENCH triple_speed_ethernet_tb -section_id eda_simulation
set_global_assignment -name EDA_TEST_BENCH_NAME triple_speed_ethernet_tb -section_id eda_simulation
set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME tb -section_id triple_speed_ethernet_tb

#Set design instance
set_global_assignment -name EDA_DESIGN_INSTANCE_NAME triple_speed_ethernet -section_id triple_speed_ethernet_tb

#Set simulation time
set_global_assignment -name EDA_TEST_BENCH_RUN_SIM_FOR "50 us" -section_id triple_speed_ethernet_tb

#Set testbench component files
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/ethgen.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/ethgen2.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/ethgen32.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/ethmon.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/ethmon2.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/ethmon_32.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/top_ethmon32.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/mdio_reg.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/mdio_slave.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/top_mdio_slave.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/loopback_adapter.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/loopback_adapter_fifo.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/timing_adapter_8.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/timing_adapter_fifo_8.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/timing_adapter_32.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/top_ethgen8.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/top_ethgen32.v -section_id triple_speed_ethernet_tb
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/model/timing_adapter_fifo_32.v -section_id triple_speed_ethernet_tb

#Set memory initialization files
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/triple_speed_ethernet/sdpm_altsyncram.hex -section_id triple_speed_ethernet_tb

#Set top level testbench files
set_global_assignment -name EDA_TEST_BENCH_FILE testbench/triple_speed_ethernet/triple_speed_ethernet_tb.v -section_id triple_speed_ethernet_tb

