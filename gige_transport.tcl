# Copyright (C) 1991-2009 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: gige_transport.tcl
# Generated on: Mon Nov 14 15:15:32 2011

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "gige_transport"]} {
		puts "Project gige_transport is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists gige_transport]} {
		project_open -revision gige_transport gige_transport
	} else {
		project_new -revision gige_transport gige_transport
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Stratix II"
	set_global_assignment -name DEVICE EP2S130F1508I4
	set_global_assignment -name TOP_LEVEL_ENTITY gige_transport_top
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 9.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "11:12:08  APRIL 19, 2011"
	set_global_assignment -name LAST_QUARTUS_VERSION 9.0
	set_global_assignment -name USE_GENERATED_PHYSICAL_CONSTRAINTS OFF -section_id eda_blast_fpga
	set_global_assignment -name STRATIXII_OPTIMIZATION_TECHNIQUE SPEED
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP "-40"
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name LL_ROOT_REGION ON -entity gige_transport -section_id "Root Region"
	set_global_assignment -name LL_MEMBER_STATE LOCKED -entity gige_transport -section_id "Root Region"
	set_global_assignment -name ENABLE_ADVANCED_IO_TIMING OFF
	set_global_assignment -name USE_TIMEQUEST_TIMING_ANALYZER ON
	set_global_assignment -name STRATIXII_CONFIGURATION_SCHEME "ACTIVE SERIAL"
	set_global_assignment -name GENERATE_TTF_FILE ON
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
	set_global_assignment -name RESERVE_ASDO_AFTER_CONFIGURATION "AS INPUT TRI-STATED"
	set_global_assignment -name FITTER_EFFORT "STANDARD FIT"
	set_global_assignment -name PHYSICAL_SYNTHESIS_EFFORT EXTRA
	set_global_assignment -name INCREMENTAL_COMPILATION OFF
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
	set_global_assignment -name MISC_FILE "D:/gige/gige_transport/gige_transport.dpf"
	set_global_assignment -name LL_ROOT_REGION ON -section_id "Root Region"
	set_global_assignment -name LL_MEMBER_STATE LOCKED -section_id "Root Region"
	set_global_assignment -name ENABLE_SIGNALTAP ON
	set_global_assignment -name USE_SIGNALTAP_FILE stp1.stp
	set_global_assignment -name SLD_NODE_CREATOR_ID 110 -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_ENTITY_NAME sld_signaltap -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_RAM_BLOCK_TYPE=M4K" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_INFO=805334528" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_POWER_UP_TRIGGER=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STORAGE_QUALIFIER_INVERSION_MASK_LENGTH=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ATTRIBUTE_MEM_MODE=OFF" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_FLOW_USE_GENERATED=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_BITS=11" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_BUFFER_FULL_STOP=1" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_CURRENT_RESOURCE_WIDTH=1" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL=1" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_IN_ENABLED=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ADVANCED_TRIGGER_ENTITY=basic,1," -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL_PIPELINE=1" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ENABLE_ADVANCED_TRIGGER=0" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_CREATOR_ID 110 -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_ENTITY_NAME sld_signaltap -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_RAM_BLOCK_TYPE=M4K" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_INFO=805334529" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_POWER_UP_TRIGGER=0" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STORAGE_QUALIFIER_INVERSION_MASK_LENGTH=0" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ATTRIBUTE_MEM_MODE=OFF" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_FLOW_USE_GENERATED=0" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_BITS=11" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_BUFFER_FULL_STOP=1" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_CURRENT_RESOURCE_WIDTH=1" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL=1" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_IN_ENABLED=0" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ADVANCED_TRIGGER_ENTITY=basic,1," -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL_PIPELINE=1" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ENABLE_ADVANCED_TRIGGER=0" -section_id auto_signaltap_1
	set_global_assignment -name SDC_FILE gige_transport.sdc
	set_global_assignment -name QIP_FILE gige_trans_cpu.qip
	set_global_assignment -name QIP_FILE triple_speed_ethernet.qip
	set_global_assignment -name QIP_FILE PLL_MAIN.qip
	set_global_assignment -name QIP_FILE PLL_SYS.qip
	set_global_assignment -name QIP_FILE PLL_TEST.qip
	set_global_assignment -name BDF_FILE gige_transport_top.bdf
	set_global_assignment -name VERILOG_FILE get_pRST.v
	set_global_assignment -name VERILOG_FILE cpu_read.v
	set_global_assignment -name VERILOG_FILE cpu_write.v
	set_global_assignment -name VERILOG_FILE avalon_slave_exram.v
	set_global_assignment -name SIGNALTAP_FILE stp1.stp
	set_global_assignment -name VERILOG_FILE MAC_init.v
	set_global_assignment -name VERILOG_FILE MDIO.v
	set_global_assignment -name VERILOG_FILE condition.v
	set_global_assignment -name VERILOG_FILE ingress.v
	set_global_assignment -name VERILOG_FILE ingress_out.v
	set_global_assignment -name QIP_FILE inRAM.qip
	set_global_assignment -name VERILOG_FILE dsp_engress.v
	set_global_assignment -name QIP_FILE ram_udp.qip
	set_global_assignment -name VERILOG_FILE udp_rec_test.v
	set_global_assignment -name QIP_FILE ram_test.qip
	set_global_assignment -name VERILOG_FILE pre_save.v
	set_global_assignment -name QIP_FILE ram_test2.qip
	set_global_assignment -name VERILOG_FILE gige_engress.v
	set_global_assignment -name QIP_FILE FIFO_DATAIN.qip
	set_global_assignment -name VERILOG_FILE data_source.v
	set_global_assignment -name QIP_FILE RAM_PRE.qip
	set_global_assignment -name VERILOG_FILE udp_predo.v
	set_global_assignment -name QIP_FILE RAM_POST.qip
	set_global_assignment -name VERILOG_FILE udp_packet.v
	set_global_assignment -name VERILOG_FILE rambus_sel.v
	set_global_assignment -name SLD_NODE_CREATOR_ID 110 -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_ENTITY_NAME sld_signaltap -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_RAM_BLOCK_TYPE=M4K" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_INFO=805334530" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_POWER_UP_TRIGGER=0" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STORAGE_QUALIFIER_INVERSION_MASK_LENGTH=0" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SEGMENT_SIZE=512" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ATTRIBUTE_MEM_MODE=OFF" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_FLOW_USE_GENERATED=0" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_STATE_BITS=11" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_BUFFER_FULL_STOP=1" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_CURRENT_RESOURCE_WIDTH=1" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL=1" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SAMPLE_DEPTH=512" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_IN_ENABLED=0" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ADVANCED_TRIGGER_ENTITY=basic,1," -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_LEVEL_PIPELINE=1" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_ENABLE_ADVANCED_TRIGGER=0" -section_id auto_signaltap_2
	set_global_assignment -name VERILOG_FILE data_source_s.v
	set_global_assignment -name QIP_FILE lpm_constant0.qip
	set_global_assignment -name MISC_FILE "D:/804/telemeter_ctrl_hs/gige_transport.dpf"
	set_global_assignment -name VERILOG_FILE udp_datain_check.v
	set_global_assignment -name VERILOG_FILE pre_save_v2.v
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_DATA_BITS=79" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_BITS=79" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK=000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK_LENGTH=261" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SEGMENT_SIZE=1024" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_LOWORD=56694" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_HIWORD=40376" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SAMPLE_DEPTH=1024" -section_id auto_signaltap_0
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_DATA_BITS=204" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_BITS=204" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK=000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK_LENGTH=636" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SEGMENT_SIZE=1024" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_LOWORD=11408" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_HIWORD=60082" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_SAMPLE_DEPTH=1024" -section_id auto_signaltap_1
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_DATA_BITS=93" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_TRIGGER_BITS=93" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK=00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_INVERSION_MASK_LENGTH=302" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_LOWORD=47232" -section_id auto_signaltap_2
	set_global_assignment -name SLD_NODE_PARAMETER_ASSIGNMENT "SLD_NODE_CRC_HIWORD=26010" -section_id auto_signaltap_2
	set_global_assignment -name TIMEQUEST_MULTICORNER_ANALYSIS ON
	set_global_assignment -name TIMEQUEST_DO_CCPP_REMOVAL OFF
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 1508
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 4
	set_global_assignment -name USE_CONFIGURATION_DEVICE ON
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_clk -to "gige_engress:inst2|TFCLK" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[0] -to "gige_engress:inst2|Header_cnt[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[1] -to "gige_engress:inst2|Header_cnt[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[2] -to "gige_engress:inst2|Header_cnt[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[3] -to "gige_engress:inst2|Header_cnt[12]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[4] -to "gige_engress:inst2|Header_cnt[13]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[5] -to "gige_engress:inst2|Header_cnt[14]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[6] -to "gige_engress:inst2|Header_cnt[15]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[7] -to "gige_engress:inst2|Header_cnt[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[8] -to "gige_engress:inst2|Header_cnt[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[9] -to "gige_engress:inst2|Header_cnt[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[10] -to "gige_engress:inst2|Header_cnt[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[11] -to "gige_engress:inst2|Header_cnt[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[12] -to "gige_engress:inst2|Header_cnt[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[13] -to "gige_engress:inst2|Header_cnt[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[14] -to "gige_engress:inst2|Header_cnt[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[15] -to "gige_engress:inst2|Header_cnt[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[16] -to "gige_engress:inst2|REOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[17] -to "gige_engress:inst2|RSOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[18] -to "gige_engress:inst2|TDAT[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[19] -to "gige_engress:inst2|TDAT[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[20] -to "gige_engress:inst2|TDAT[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[21] -to "gige_engress:inst2|TDAT[12]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[22] -to "gige_engress:inst2|TDAT[13]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[23] -to "gige_engress:inst2|TDAT[14]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[24] -to "gige_engress:inst2|TDAT[15]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[25] -to "gige_engress:inst2|TDAT[16]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[26] -to "gige_engress:inst2|TDAT[17]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[27] -to "gige_engress:inst2|TDAT[18]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[28] -to "gige_engress:inst2|TDAT[19]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[29] -to "gige_engress:inst2|TDAT[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[30] -to "gige_engress:inst2|TDAT[20]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[31] -to "gige_engress:inst2|TDAT[21]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[32] -to "gige_engress:inst2|TDAT[22]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[33] -to "gige_engress:inst2|TDAT[23]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[34] -to "gige_engress:inst2|TDAT[24]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[35] -to "gige_engress:inst2|TDAT[25]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[36] -to "gige_engress:inst2|TDAT[26]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[37] -to "gige_engress:inst2|TDAT[27]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[38] -to "gige_engress:inst2|TDAT[28]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[39] -to "gige_engress:inst2|TDAT[29]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[40] -to "gige_engress:inst2|TDAT[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[41] -to "gige_engress:inst2|TDAT[30]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[42] -to "gige_engress:inst2|TDAT[31]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[43] -to "gige_engress:inst2|TDAT[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[44] -to "gige_engress:inst2|TDAT[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[45] -to "gige_engress:inst2|TDAT[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[46] -to "gige_engress:inst2|TDAT[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[47] -to "gige_engress:inst2|TDAT[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[48] -to "gige_engress:inst2|TDAT[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[49] -to "gige_engress:inst2|TDAT[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[50] -to "gige_engress:inst2|TENB" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[51] -to "gige_engress:inst2|TEOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[0] -to "gige_engress:inst2|Header_cnt[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[1] -to "gige_engress:inst2|Header_cnt[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[2] -to "gige_engress:inst2|Header_cnt[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[3] -to "gige_engress:inst2|Header_cnt[12]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[4] -to "gige_engress:inst2|Header_cnt[13]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[5] -to "gige_engress:inst2|Header_cnt[14]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[6] -to "gige_engress:inst2|Header_cnt[15]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[7] -to "gige_engress:inst2|Header_cnt[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[8] -to "gige_engress:inst2|Header_cnt[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[9] -to "gige_engress:inst2|Header_cnt[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[10] -to "gige_engress:inst2|Header_cnt[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[11] -to "gige_engress:inst2|Header_cnt[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[12] -to "gige_engress:inst2|Header_cnt[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[13] -to "gige_engress:inst2|Header_cnt[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[14] -to "gige_engress:inst2|Header_cnt[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[15] -to "gige_engress:inst2|Header_cnt[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[16] -to "gige_engress:inst2|REOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[17] -to "gige_engress:inst2|RSOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[18] -to "gige_engress:inst2|TDAT[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[19] -to "gige_engress:inst2|TDAT[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[20] -to "gige_engress:inst2|TDAT[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[21] -to "gige_engress:inst2|TDAT[12]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[22] -to "gige_engress:inst2|TDAT[13]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[23] -to "gige_engress:inst2|TDAT[14]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[24] -to "gige_engress:inst2|TDAT[15]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[25] -to "gige_engress:inst2|TDAT[16]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[26] -to "gige_engress:inst2|TDAT[17]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[27] -to "gige_engress:inst2|TDAT[18]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[28] -to "gige_engress:inst2|TDAT[19]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[29] -to "gige_engress:inst2|TDAT[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[30] -to "gige_engress:inst2|TDAT[20]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[31] -to "gige_engress:inst2|TDAT[21]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[32] -to "gige_engress:inst2|TDAT[22]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[33] -to "gige_engress:inst2|TDAT[23]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[34] -to "gige_engress:inst2|TDAT[24]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[35] -to "gige_engress:inst2|TDAT[25]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[36] -to "gige_engress:inst2|TDAT[26]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[37] -to "gige_engress:inst2|TDAT[27]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[38] -to "gige_engress:inst2|TDAT[28]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[39] -to "gige_engress:inst2|TDAT[29]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[40] -to "gige_engress:inst2|TDAT[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[41] -to "gige_engress:inst2|TDAT[30]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[42] -to "gige_engress:inst2|TDAT[31]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[43] -to "gige_engress:inst2|TDAT[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[44] -to "gige_engress:inst2|TDAT[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[45] -to "gige_engress:inst2|TDAT[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[46] -to "gige_engress:inst2|TDAT[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[47] -to "gige_engress:inst2|TDAT[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[48] -to "gige_engress:inst2|TDAT[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[49] -to "gige_engress:inst2|TDAT[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[50] -to "gige_engress:inst2|TENB" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[51] -to "gige_engress:inst2|TEOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_clk -to "pre_save:inst6|clk" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[0] -to "pre_save:inst6|RDAT[0]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[1] -to "pre_save:inst6|RDAT[10]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[2] -to "pre_save:inst6|RDAT[11]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[3] -to "pre_save:inst6|RDAT[12]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[4] -to "pre_save:inst6|RDAT[13]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[5] -to "pre_save:inst6|RDAT[14]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[6] -to "pre_save:inst6|RDAT[15]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[7] -to "pre_save:inst6|RDAT[16]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[8] -to "pre_save:inst6|RDAT[17]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[9] -to "pre_save:inst6|RDAT[18]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[10] -to "pre_save:inst6|RDAT[19]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[11] -to "pre_save:inst6|RDAT[1]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[12] -to "pre_save:inst6|RDAT[20]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[13] -to "pre_save:inst6|RDAT[21]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[14] -to "pre_save:inst6|RDAT[22]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[15] -to "pre_save:inst6|RDAT[23]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[16] -to "pre_save:inst6|RDAT[24]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[17] -to "pre_save:inst6|RDAT[25]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[18] -to "pre_save:inst6|RDAT[26]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[19] -to "pre_save:inst6|RDAT[27]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[20] -to "pre_save:inst6|RDAT[28]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[21] -to "pre_save:inst6|RDAT[29]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[22] -to "pre_save:inst6|RDAT[2]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[23] -to "pre_save:inst6|RDAT[30]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[24] -to "pre_save:inst6|RDAT[31]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[25] -to "pre_save:inst6|RDAT[3]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[26] -to "pre_save:inst6|RDAT[4]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[27] -to "pre_save:inst6|RDAT[5]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[28] -to "pre_save:inst6|RDAT[6]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[29] -to "pre_save:inst6|RDAT[7]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[30] -to "pre_save:inst6|RDAT[8]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[31] -to "pre_save:inst6|RDAT[9]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[32] -to "pre_save:inst6|REOP" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[33] -to "pre_save:inst6|RSOP" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[34] -to "pre_save:inst6|data_en" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[35] -to "pre_save:inst6|dout[0]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[36] -to "pre_save:inst6|dout[10]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[37] -to "pre_save:inst6|dout[11]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[38] -to "pre_save:inst6|dout[12]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[39] -to "pre_save:inst6|dout[13]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[40] -to "pre_save:inst6|dout[14]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[41] -to "pre_save:inst6|dout[15]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[42] -to "pre_save:inst6|dout[16]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[43] -to "pre_save:inst6|dout[17]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[44] -to "pre_save:inst6|dout[18]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[45] -to "pre_save:inst6|dout[19]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[46] -to "pre_save:inst6|dout[1]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[47] -to "pre_save:inst6|dout[20]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[48] -to "pre_save:inst6|dout[21]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[49] -to "pre_save:inst6|dout[22]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[50] -to "pre_save:inst6|dout[23]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[51] -to "pre_save:inst6|dout[24]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[52] -to "pre_save:inst6|dout[25]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[53] -to "pre_save:inst6|dout[26]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[54] -to "pre_save:inst6|dout[27]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[55] -to "pre_save:inst6|dout[28]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[56] -to "pre_save:inst6|dout[29]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[57] -to "pre_save:inst6|dout[2]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[58] -to "pre_save:inst6|dout[30]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[59] -to "pre_save:inst6|dout[31]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[60] -to "pre_save:inst6|dout[3]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[61] -to "pre_save:inst6|dout[4]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[62] -to "pre_save:inst6|dout[5]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[63] -to "pre_save:inst6|dout[6]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[64] -to "pre_save:inst6|dout[7]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[65] -to "pre_save:inst6|dout[8]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[66] -to "pre_save:inst6|dout[9]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[67] -to "pre_save:inst6|pingpong" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[68] -to "pre_save:inst6|wraddr[0]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[69] -to "pre_save:inst6|wraddr[1]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[70] -to "pre_save:inst6|wraddr[2]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[71] -to "pre_save:inst6|wraddr[3]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[72] -to "pre_save:inst6|wraddr[4]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[73] -to "pre_save:inst6|wraddr[5]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[74] -to "pre_save:inst6|wraddr[6]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[75] -to "pre_save:inst6|wraddr[7]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[76] -to "pre_save:inst6|wraddr[8]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[77] -to "pre_save:inst6|wraddr[9]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[78] -to "pre_save:inst6|wren" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[0] -to "pre_save:inst6|RDAT[0]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[1] -to "pre_save:inst6|RDAT[10]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[2] -to "pre_save:inst6|RDAT[11]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[3] -to "pre_save:inst6|RDAT[12]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[4] -to "pre_save:inst6|RDAT[13]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[5] -to "pre_save:inst6|RDAT[14]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[6] -to "pre_save:inst6|RDAT[15]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[7] -to "pre_save:inst6|RDAT[16]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[8] -to "pre_save:inst6|RDAT[17]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[9] -to "pre_save:inst6|RDAT[18]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[10] -to "pre_save:inst6|RDAT[19]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[11] -to "pre_save:inst6|RDAT[1]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[12] -to "pre_save:inst6|RDAT[20]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[13] -to "pre_save:inst6|RDAT[21]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[14] -to "pre_save:inst6|RDAT[22]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[15] -to "pre_save:inst6|RDAT[23]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[16] -to "pre_save:inst6|RDAT[24]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[17] -to "pre_save:inst6|RDAT[25]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[18] -to "pre_save:inst6|RDAT[26]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[19] -to "pre_save:inst6|RDAT[27]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[20] -to "pre_save:inst6|RDAT[28]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[21] -to "pre_save:inst6|RDAT[29]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[22] -to "pre_save:inst6|RDAT[2]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[23] -to "pre_save:inst6|RDAT[30]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[24] -to "pre_save:inst6|RDAT[31]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[25] -to "pre_save:inst6|RDAT[3]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[26] -to "pre_save:inst6|RDAT[4]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[27] -to "pre_save:inst6|RDAT[5]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[28] -to "pre_save:inst6|RDAT[6]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[29] -to "pre_save:inst6|RDAT[7]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[30] -to "pre_save:inst6|RDAT[8]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[31] -to "pre_save:inst6|RDAT[9]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[32] -to "pre_save:inst6|REOP" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[33] -to "pre_save:inst6|RSOP" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[34] -to "pre_save:inst6|data_en" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[35] -to "pre_save:inst6|dout[0]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[36] -to "pre_save:inst6|dout[10]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[37] -to "pre_save:inst6|dout[11]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[38] -to "pre_save:inst6|dout[12]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[39] -to "pre_save:inst6|dout[13]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[40] -to "pre_save:inst6|dout[14]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[41] -to "pre_save:inst6|dout[15]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[42] -to "pre_save:inst6|dout[16]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[43] -to "pre_save:inst6|dout[17]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[44] -to "pre_save:inst6|dout[18]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[45] -to "pre_save:inst6|dout[19]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[46] -to "pre_save:inst6|dout[1]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[47] -to "pre_save:inst6|dout[20]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[48] -to "pre_save:inst6|dout[21]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[49] -to "pre_save:inst6|dout[22]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[50] -to "pre_save:inst6|dout[23]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[51] -to "pre_save:inst6|dout[24]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[52] -to "pre_save:inst6|dout[25]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[53] -to "pre_save:inst6|dout[26]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[54] -to "pre_save:inst6|dout[27]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[55] -to "pre_save:inst6|dout[28]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[56] -to "pre_save:inst6|dout[29]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[57] -to "pre_save:inst6|dout[2]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[58] -to "pre_save:inst6|dout[30]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[59] -to "pre_save:inst6|dout[31]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[60] -to "pre_save:inst6|dout[3]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[61] -to "pre_save:inst6|dout[4]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[62] -to "pre_save:inst6|dout[5]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[63] -to "pre_save:inst6|dout[6]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[64] -to "pre_save:inst6|dout[7]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[65] -to "pre_save:inst6|dout[8]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[66] -to "pre_save:inst6|dout[9]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[67] -to "pre_save:inst6|pingpong" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[68] -to "pre_save:inst6|wraddr[0]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[69] -to "pre_save:inst6|wraddr[1]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[70] -to "pre_save:inst6|wraddr[2]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[71] -to "pre_save:inst6|wraddr[3]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[72] -to "pre_save:inst6|wraddr[4]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[73] -to "pre_save:inst6|wraddr[5]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[74] -to "pre_save:inst6|wraddr[6]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[75] -to "pre_save:inst6|wraddr[7]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[76] -to "pre_save:inst6|wraddr[8]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[77] -to "pre_save:inst6|wraddr[9]" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[78] -to "pre_save:inst6|wren" -section_id auto_signaltap_0
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_clk -to "udp_datain_check:inst20|clk" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[0] -to "udp_datain_check:inst20|count_reg0[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[1] -to "udp_datain_check:inst20|count_reg0[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[2] -to "udp_datain_check:inst20|count_reg0[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[3] -to "udp_datain_check:inst20|count_reg0[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[4] -to "udp_datain_check:inst20|count_reg0[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[5] -to "udp_datain_check:inst20|count_reg0[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[6] -to "udp_datain_check:inst20|count_reg0[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[7] -to "udp_datain_check:inst20|count_reg0[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[8] -to "udp_datain_check:inst20|count_reg0[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[9] -to "udp_datain_check:inst20|count_reg0[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[10] -to "udp_datain_check:inst20|count_reg0[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[11] -to "udp_datain_check:inst20|count_reg0[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[12] -to "udp_datain_check:inst20|count_reg0[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[13] -to "udp_datain_check:inst20|count_reg0[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[14] -to "udp_datain_check:inst20|count_reg0[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[15] -to "udp_datain_check:inst20|count_reg0[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[16] -to "udp_datain_check:inst20|count_reg0[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[17] -to "udp_datain_check:inst20|count_reg0[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[18] -to "udp_datain_check:inst20|count_reg0[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[19] -to "udp_datain_check:inst20|count_reg0[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[20] -to "udp_datain_check:inst20|count_reg0[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[21] -to "udp_datain_check:inst20|count_reg0[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[22] -to "udp_datain_check:inst20|count_reg0[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[23] -to "udp_datain_check:inst20|count_reg0[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[24] -to "udp_datain_check:inst20|count_reg0[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[25] -to "udp_datain_check:inst20|count_reg0[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[26] -to "udp_datain_check:inst20|count_reg0[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[27] -to "udp_datain_check:inst20|count_reg0[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[28] -to "udp_datain_check:inst20|count_reg0[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[29] -to "udp_datain_check:inst20|count_reg0[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[30] -to "udp_datain_check:inst20|count_reg0[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[31] -to "udp_datain_check:inst20|count_reg0[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[32] -to "udp_datain_check:inst20|count_reg1[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[33] -to "udp_datain_check:inst20|count_reg1[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[34] -to "udp_datain_check:inst20|count_reg1[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[35] -to "udp_datain_check:inst20|count_reg1[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[36] -to "udp_datain_check:inst20|count_reg1[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[37] -to "udp_datain_check:inst20|count_reg1[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[38] -to "udp_datain_check:inst20|count_reg1[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[39] -to "udp_datain_check:inst20|count_reg1[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[40] -to "udp_datain_check:inst20|count_reg1[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[41] -to "udp_datain_check:inst20|count_reg1[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[42] -to "udp_datain_check:inst20|count_reg1[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[43] -to "udp_datain_check:inst20|count_reg1[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[44] -to "udp_datain_check:inst20|count_reg1[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[45] -to "udp_datain_check:inst20|count_reg1[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[46] -to "udp_datain_check:inst20|count_reg1[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[47] -to "udp_datain_check:inst20|count_reg1[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[48] -to "udp_datain_check:inst20|count_reg1[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[49] -to "udp_datain_check:inst20|count_reg1[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[50] -to "udp_datain_check:inst20|count_reg1[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[51] -to "udp_datain_check:inst20|count_reg1[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[52] -to "udp_datain_check:inst20|count_reg1[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[53] -to "udp_datain_check:inst20|count_reg1[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[54] -to "udp_datain_check:inst20|count_reg1[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[55] -to "udp_datain_check:inst20|count_reg1[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[56] -to "udp_datain_check:inst20|count_reg1[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[57] -to "udp_datain_check:inst20|count_reg1[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[58] -to "udp_datain_check:inst20|count_reg1[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[59] -to "udp_datain_check:inst20|count_reg1[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[60] -to "udp_datain_check:inst20|count_reg1[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[61] -to "udp_datain_check:inst20|count_reg1[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[62] -to "udp_datain_check:inst20|count_reg1[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[63] -to "udp_datain_check:inst20|count_reg1[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[64] -to "udp_datain_check:inst20|data_reg0[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[65] -to "udp_datain_check:inst20|data_reg0[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[66] -to "udp_datain_check:inst20|data_reg0[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[67] -to "udp_datain_check:inst20|data_reg0[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[68] -to "udp_datain_check:inst20|data_reg0[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[69] -to "udp_datain_check:inst20|data_reg0[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[70] -to "udp_datain_check:inst20|data_reg0[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[71] -to "udp_datain_check:inst20|data_reg0[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[72] -to "udp_datain_check:inst20|data_reg0[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[73] -to "udp_datain_check:inst20|data_reg0[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[74] -to "udp_datain_check:inst20|data_reg0[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[75] -to "udp_datain_check:inst20|data_reg0[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[76] -to "udp_datain_check:inst20|data_reg0[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[77] -to "udp_datain_check:inst20|data_reg0[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[78] -to "udp_datain_check:inst20|data_reg0[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[79] -to "udp_datain_check:inst20|data_reg0[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[80] -to "udp_datain_check:inst20|data_reg0[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[81] -to "udp_datain_check:inst20|data_reg0[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[82] -to "udp_datain_check:inst20|data_reg0[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[83] -to "udp_datain_check:inst20|data_reg0[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[84] -to "udp_datain_check:inst20|data_reg0[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[85] -to "udp_datain_check:inst20|data_reg0[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[86] -to "udp_datain_check:inst20|data_reg0[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[87] -to "udp_datain_check:inst20|data_reg0[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[88] -to "udp_datain_check:inst20|data_reg0[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[89] -to "udp_datain_check:inst20|data_reg0[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[90] -to "udp_datain_check:inst20|data_reg0[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[91] -to "udp_datain_check:inst20|data_reg0[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[92] -to "udp_datain_check:inst20|data_reg0[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[93] -to "udp_datain_check:inst20|data_reg0[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[94] -to "udp_datain_check:inst20|data_reg0[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[95] -to "udp_datain_check:inst20|data_reg0[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[96] -to "udp_datain_check:inst20|data_reg1[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[97] -to "udp_datain_check:inst20|data_reg1[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[98] -to "udp_datain_check:inst20|data_reg1[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[99] -to "udp_datain_check:inst20|data_reg1[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[100] -to "udp_datain_check:inst20|data_reg1[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[101] -to "udp_datain_check:inst20|data_reg1[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[102] -to "udp_datain_check:inst20|data_reg1[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[103] -to "udp_datain_check:inst20|data_reg1[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[104] -to "udp_datain_check:inst20|data_reg1[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[105] -to "udp_datain_check:inst20|data_reg1[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[106] -to "udp_datain_check:inst20|data_reg1[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[107] -to "udp_datain_check:inst20|data_reg1[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[108] -to "udp_datain_check:inst20|data_reg1[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[109] -to "udp_datain_check:inst20|data_reg1[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[110] -to "udp_datain_check:inst20|data_reg1[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[111] -to "udp_datain_check:inst20|data_reg1[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[112] -to "udp_datain_check:inst20|data_reg1[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[113] -to "udp_datain_check:inst20|data_reg1[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[114] -to "udp_datain_check:inst20|data_reg1[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[115] -to "udp_datain_check:inst20|data_reg1[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[116] -to "udp_datain_check:inst20|data_reg1[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[117] -to "udp_datain_check:inst20|data_reg1[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[118] -to "udp_datain_check:inst20|data_reg1[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[119] -to "udp_datain_check:inst20|data_reg1[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[120] -to "udp_datain_check:inst20|data_reg1[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[121] -to "udp_datain_check:inst20|data_reg1[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[122] -to "udp_datain_check:inst20|data_reg1[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[123] -to "udp_datain_check:inst20|data_reg1[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[124] -to "udp_datain_check:inst20|data_reg1[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[125] -to "udp_datain_check:inst20|data_reg1[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[126] -to "udp_datain_check:inst20|data_reg1[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[127] -to "udp_datain_check:inst20|data_reg1[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[128] -to "udp_datain_check:inst20|err_count0[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[129] -to "udp_datain_check:inst20|err_count0[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[130] -to "udp_datain_check:inst20|err_count0[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[131] -to "udp_datain_check:inst20|err_count0[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[132] -to "udp_datain_check:inst20|err_count0[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[133] -to "udp_datain_check:inst20|err_count0[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[134] -to "udp_datain_check:inst20|err_count0[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[135] -to "udp_datain_check:inst20|err_count0[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[136] -to "udp_datain_check:inst20|err_count0[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[137] -to "udp_datain_check:inst20|err_count0[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[138] -to "udp_datain_check:inst20|err_count0[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[139] -to "udp_datain_check:inst20|err_count0[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[140] -to "udp_datain_check:inst20|err_count0[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[141] -to "udp_datain_check:inst20|err_count0[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[142] -to "udp_datain_check:inst20|err_count0[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[143] -to "udp_datain_check:inst20|err_count0[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[144] -to "udp_datain_check:inst20|err_count1[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[145] -to "udp_datain_check:inst20|err_count1[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[146] -to "udp_datain_check:inst20|err_count1[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[147] -to "udp_datain_check:inst20|err_count1[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[148] -to "udp_datain_check:inst20|err_count1[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[149] -to "udp_datain_check:inst20|err_count1[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[150] -to "udp_datain_check:inst20|err_count1[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[151] -to "udp_datain_check:inst20|err_count1[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[152] -to "udp_datain_check:inst20|err_count1[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[153] -to "udp_datain_check:inst20|err_count1[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[154] -to "udp_datain_check:inst20|err_count1[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[155] -to "udp_datain_check:inst20|err_count1[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[156] -to "udp_datain_check:inst20|err_count1[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[157] -to "udp_datain_check:inst20|err_count1[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[158] -to "udp_datain_check:inst20|err_count1[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[159] -to "udp_datain_check:inst20|err_count1[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[160] -to "udp_datain_check:inst20|err_start" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[161] -to "udp_datain_check:inst20|pingpong" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[162] -to "udp_datain_check:inst20|ram_addr[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[163] -to "udp_datain_check:inst20|ram_addr[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[164] -to "udp_datain_check:inst20|ram_addr[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[165] -to "udp_datain_check:inst20|ram_addr[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[166] -to "udp_datain_check:inst20|ram_addr[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[167] -to "udp_datain_check:inst20|ram_addr[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[168] -to "udp_datain_check:inst20|ram_addr[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[169] -to "udp_datain_check:inst20|ram_addr[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[170] -to "udp_datain_check:inst20|ram_addr[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[171] -to "udp_datain_check:inst20|ram_addr[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[172] -to "udp_datain_check:inst20|ram_data[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[173] -to "udp_datain_check:inst20|ram_data[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[174] -to "udp_datain_check:inst20|ram_data[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[175] -to "udp_datain_check:inst20|ram_data[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[176] -to "udp_datain_check:inst20|ram_data[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[177] -to "udp_datain_check:inst20|ram_data[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[178] -to "udp_datain_check:inst20|ram_data[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[179] -to "udp_datain_check:inst20|ram_data[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[180] -to "udp_datain_check:inst20|ram_data[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[181] -to "udp_datain_check:inst20|ram_data[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[182] -to "udp_datain_check:inst20|ram_data[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[183] -to "udp_datain_check:inst20|ram_data[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[184] -to "udp_datain_check:inst20|ram_data[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[185] -to "udp_datain_check:inst20|ram_data[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[186] -to "udp_datain_check:inst20|ram_data[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[187] -to "udp_datain_check:inst20|ram_data[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[188] -to "udp_datain_check:inst20|ram_data[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[189] -to "udp_datain_check:inst20|ram_data[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[190] -to "udp_datain_check:inst20|ram_data[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[191] -to "udp_datain_check:inst20|ram_data[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[192] -to "udp_datain_check:inst20|ram_data[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[193] -to "udp_datain_check:inst20|ram_data[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[194] -to "udp_datain_check:inst20|ram_data[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[195] -to "udp_datain_check:inst20|ram_data[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[196] -to "udp_datain_check:inst20|ram_data[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[197] -to "udp_datain_check:inst20|ram_data[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[198] -to "udp_datain_check:inst20|ram_data[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[199] -to "udp_datain_check:inst20|ram_data[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[200] -to "udp_datain_check:inst20|ram_data[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[201] -to "udp_datain_check:inst20|ram_data[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[202] -to "udp_datain_check:inst20|ram_data[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[203] -to "udp_datain_check:inst20|ram_data[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[0] -to "udp_datain_check:inst20|count_reg0[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[1] -to "udp_datain_check:inst20|count_reg0[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[2] -to "udp_datain_check:inst20|count_reg0[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[3] -to "udp_datain_check:inst20|count_reg0[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[4] -to "udp_datain_check:inst20|count_reg0[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[5] -to "udp_datain_check:inst20|count_reg0[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[6] -to "udp_datain_check:inst20|count_reg0[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[7] -to "udp_datain_check:inst20|count_reg0[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[8] -to "udp_datain_check:inst20|count_reg0[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[9] -to "udp_datain_check:inst20|count_reg0[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[10] -to "udp_datain_check:inst20|count_reg0[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[11] -to "udp_datain_check:inst20|count_reg0[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[12] -to "udp_datain_check:inst20|count_reg0[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[13] -to "udp_datain_check:inst20|count_reg0[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[14] -to "udp_datain_check:inst20|count_reg0[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[15] -to "udp_datain_check:inst20|count_reg0[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[16] -to "udp_datain_check:inst20|count_reg0[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[17] -to "udp_datain_check:inst20|count_reg0[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[18] -to "udp_datain_check:inst20|count_reg0[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[19] -to "udp_datain_check:inst20|count_reg0[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[20] -to "udp_datain_check:inst20|count_reg0[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[21] -to "udp_datain_check:inst20|count_reg0[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[22] -to "udp_datain_check:inst20|count_reg0[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[23] -to "udp_datain_check:inst20|count_reg0[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[24] -to "udp_datain_check:inst20|count_reg0[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[25] -to "udp_datain_check:inst20|count_reg0[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[26] -to "udp_datain_check:inst20|count_reg0[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[27] -to "udp_datain_check:inst20|count_reg0[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[28] -to "udp_datain_check:inst20|count_reg0[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[29] -to "udp_datain_check:inst20|count_reg0[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[30] -to "udp_datain_check:inst20|count_reg0[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[31] -to "udp_datain_check:inst20|count_reg0[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[32] -to "udp_datain_check:inst20|count_reg1[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[33] -to "udp_datain_check:inst20|count_reg1[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[34] -to "udp_datain_check:inst20|count_reg1[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[35] -to "udp_datain_check:inst20|count_reg1[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[36] -to "udp_datain_check:inst20|count_reg1[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[37] -to "udp_datain_check:inst20|count_reg1[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[38] -to "udp_datain_check:inst20|count_reg1[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[39] -to "udp_datain_check:inst20|count_reg1[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[40] -to "udp_datain_check:inst20|count_reg1[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[41] -to "udp_datain_check:inst20|count_reg1[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[42] -to "udp_datain_check:inst20|count_reg1[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[43] -to "udp_datain_check:inst20|count_reg1[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[44] -to "udp_datain_check:inst20|count_reg1[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[45] -to "udp_datain_check:inst20|count_reg1[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[46] -to "udp_datain_check:inst20|count_reg1[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[47] -to "udp_datain_check:inst20|count_reg1[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[48] -to "udp_datain_check:inst20|count_reg1[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[49] -to "udp_datain_check:inst20|count_reg1[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[50] -to "udp_datain_check:inst20|count_reg1[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[51] -to "udp_datain_check:inst20|count_reg1[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[52] -to "udp_datain_check:inst20|count_reg1[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[53] -to "udp_datain_check:inst20|count_reg1[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[54] -to "udp_datain_check:inst20|count_reg1[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[55] -to "udp_datain_check:inst20|count_reg1[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[56] -to "udp_datain_check:inst20|count_reg1[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[57] -to "udp_datain_check:inst20|count_reg1[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[58] -to "udp_datain_check:inst20|count_reg1[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[59] -to "udp_datain_check:inst20|count_reg1[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[60] -to "udp_datain_check:inst20|count_reg1[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[61] -to "udp_datain_check:inst20|count_reg1[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[62] -to "udp_datain_check:inst20|count_reg1[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[63] -to "udp_datain_check:inst20|count_reg1[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[64] -to "udp_datain_check:inst20|data_reg0[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[65] -to "udp_datain_check:inst20|data_reg0[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[66] -to "udp_datain_check:inst20|data_reg0[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[67] -to "udp_datain_check:inst20|data_reg0[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[68] -to "udp_datain_check:inst20|data_reg0[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[69] -to "udp_datain_check:inst20|data_reg0[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[70] -to "udp_datain_check:inst20|data_reg0[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[71] -to "udp_datain_check:inst20|data_reg0[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[72] -to "udp_datain_check:inst20|data_reg0[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[73] -to "udp_datain_check:inst20|data_reg0[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[74] -to "udp_datain_check:inst20|data_reg0[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[75] -to "udp_datain_check:inst20|data_reg0[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[76] -to "udp_datain_check:inst20|data_reg0[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[77] -to "udp_datain_check:inst20|data_reg0[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[78] -to "udp_datain_check:inst20|data_reg0[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[79] -to "udp_datain_check:inst20|data_reg0[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[80] -to "udp_datain_check:inst20|data_reg0[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[81] -to "udp_datain_check:inst20|data_reg0[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[82] -to "udp_datain_check:inst20|data_reg0[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[83] -to "udp_datain_check:inst20|data_reg0[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[84] -to "udp_datain_check:inst20|data_reg0[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[85] -to "udp_datain_check:inst20|data_reg0[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[86] -to "udp_datain_check:inst20|data_reg0[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[87] -to "udp_datain_check:inst20|data_reg0[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[88] -to "udp_datain_check:inst20|data_reg0[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[89] -to "udp_datain_check:inst20|data_reg0[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[90] -to "udp_datain_check:inst20|data_reg0[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[91] -to "udp_datain_check:inst20|data_reg0[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[92] -to "udp_datain_check:inst20|data_reg0[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[93] -to "udp_datain_check:inst20|data_reg0[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[94] -to "udp_datain_check:inst20|data_reg0[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[95] -to "udp_datain_check:inst20|data_reg0[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[96] -to "udp_datain_check:inst20|data_reg1[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[97] -to "udp_datain_check:inst20|data_reg1[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[98] -to "udp_datain_check:inst20|data_reg1[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[99] -to "udp_datain_check:inst20|data_reg1[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[100] -to "udp_datain_check:inst20|data_reg1[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[101] -to "udp_datain_check:inst20|data_reg1[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[102] -to "udp_datain_check:inst20|data_reg1[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[103] -to "udp_datain_check:inst20|data_reg1[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[104] -to "udp_datain_check:inst20|data_reg1[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[105] -to "udp_datain_check:inst20|data_reg1[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[106] -to "udp_datain_check:inst20|data_reg1[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[107] -to "udp_datain_check:inst20|data_reg1[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[108] -to "udp_datain_check:inst20|data_reg1[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[109] -to "udp_datain_check:inst20|data_reg1[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[110] -to "udp_datain_check:inst20|data_reg1[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[111] -to "udp_datain_check:inst20|data_reg1[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[112] -to "udp_datain_check:inst20|data_reg1[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[113] -to "udp_datain_check:inst20|data_reg1[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[114] -to "udp_datain_check:inst20|data_reg1[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[115] -to "udp_datain_check:inst20|data_reg1[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[116] -to "udp_datain_check:inst20|data_reg1[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[117] -to "udp_datain_check:inst20|data_reg1[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[118] -to "udp_datain_check:inst20|data_reg1[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[119] -to "udp_datain_check:inst20|data_reg1[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[120] -to "udp_datain_check:inst20|data_reg1[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[121] -to "udp_datain_check:inst20|data_reg1[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[122] -to "udp_datain_check:inst20|data_reg1[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[123] -to "udp_datain_check:inst20|data_reg1[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[124] -to "udp_datain_check:inst20|data_reg1[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[125] -to "udp_datain_check:inst20|data_reg1[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[126] -to "udp_datain_check:inst20|data_reg1[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[127] -to "udp_datain_check:inst20|data_reg1[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[128] -to "udp_datain_check:inst20|err_count0[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[129] -to "udp_datain_check:inst20|err_count0[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[130] -to "udp_datain_check:inst20|err_count0[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[131] -to "udp_datain_check:inst20|err_count0[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[132] -to "udp_datain_check:inst20|err_count0[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[133] -to "udp_datain_check:inst20|err_count0[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[134] -to "udp_datain_check:inst20|err_count0[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[135] -to "udp_datain_check:inst20|err_count0[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[136] -to "udp_datain_check:inst20|err_count0[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[137] -to "udp_datain_check:inst20|err_count0[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[138] -to "udp_datain_check:inst20|err_count0[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[139] -to "udp_datain_check:inst20|err_count0[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[140] -to "udp_datain_check:inst20|err_count0[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[141] -to "udp_datain_check:inst20|err_count0[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[142] -to "udp_datain_check:inst20|err_count0[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[143] -to "udp_datain_check:inst20|err_count0[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[144] -to "udp_datain_check:inst20|err_count1[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[145] -to "udp_datain_check:inst20|err_count1[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[146] -to "udp_datain_check:inst20|err_count1[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[147] -to "udp_datain_check:inst20|err_count1[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[148] -to "udp_datain_check:inst20|err_count1[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[149] -to "udp_datain_check:inst20|err_count1[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[150] -to "udp_datain_check:inst20|err_count1[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[151] -to "udp_datain_check:inst20|err_count1[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[152] -to "udp_datain_check:inst20|err_count1[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[153] -to "udp_datain_check:inst20|err_count1[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[154] -to "udp_datain_check:inst20|err_count1[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[155] -to "udp_datain_check:inst20|err_count1[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[156] -to "udp_datain_check:inst20|err_count1[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[157] -to "udp_datain_check:inst20|err_count1[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[158] -to "udp_datain_check:inst20|err_count1[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[159] -to "udp_datain_check:inst20|err_count1[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[160] -to "udp_datain_check:inst20|err_start" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[161] -to "udp_datain_check:inst20|pingpong" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[162] -to "udp_datain_check:inst20|ram_addr[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[163] -to "udp_datain_check:inst20|ram_addr[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[164] -to "udp_datain_check:inst20|ram_addr[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[165] -to "udp_datain_check:inst20|ram_addr[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[166] -to "udp_datain_check:inst20|ram_addr[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[167] -to "udp_datain_check:inst20|ram_addr[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[168] -to "udp_datain_check:inst20|ram_addr[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[169] -to "udp_datain_check:inst20|ram_addr[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[170] -to "udp_datain_check:inst20|ram_addr[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[171] -to "udp_datain_check:inst20|ram_addr[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[172] -to "udp_datain_check:inst20|ram_data[0]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[173] -to "udp_datain_check:inst20|ram_data[10]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[174] -to "udp_datain_check:inst20|ram_data[11]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[175] -to "udp_datain_check:inst20|ram_data[12]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[176] -to "udp_datain_check:inst20|ram_data[13]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[177] -to "udp_datain_check:inst20|ram_data[14]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[178] -to "udp_datain_check:inst20|ram_data[15]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[179] -to "udp_datain_check:inst20|ram_data[16]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[180] -to "udp_datain_check:inst20|ram_data[17]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[181] -to "udp_datain_check:inst20|ram_data[18]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[182] -to "udp_datain_check:inst20|ram_data[19]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[183] -to "udp_datain_check:inst20|ram_data[1]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[184] -to "udp_datain_check:inst20|ram_data[20]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[185] -to "udp_datain_check:inst20|ram_data[21]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[186] -to "udp_datain_check:inst20|ram_data[22]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[187] -to "udp_datain_check:inst20|ram_data[23]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[188] -to "udp_datain_check:inst20|ram_data[24]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[189] -to "udp_datain_check:inst20|ram_data[25]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[190] -to "udp_datain_check:inst20|ram_data[26]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[191] -to "udp_datain_check:inst20|ram_data[27]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[192] -to "udp_datain_check:inst20|ram_data[28]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[193] -to "udp_datain_check:inst20|ram_data[29]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[194] -to "udp_datain_check:inst20|ram_data[2]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[195] -to "udp_datain_check:inst20|ram_data[30]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[196] -to "udp_datain_check:inst20|ram_data[31]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[197] -to "udp_datain_check:inst20|ram_data[3]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[198] -to "udp_datain_check:inst20|ram_data[4]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[199] -to "udp_datain_check:inst20|ram_data[5]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[200] -to "udp_datain_check:inst20|ram_data[6]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[201] -to "udp_datain_check:inst20|ram_data[7]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[202] -to "udp_datain_check:inst20|ram_data[8]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[203] -to "udp_datain_check:inst20|ram_data[9]" -section_id auto_signaltap_1
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[52] -to "gige_engress:inst2|TERR" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[53] -to "gige_engress:inst2|TMOD[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[54] -to "gige_engress:inst2|TMOD[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[55] -to "gige_engress:inst2|TPRTY" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[56] -to "gige_engress:inst2|TSOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[57] -to "gige_engress:inst2|TSX" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[58] -to "gige_engress:inst2|ff_crc_fwd" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[59] -to "gige_engress:inst2|ff_tx_wren" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[60] -to "gige_engress:inst2|last_packet" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[61] -to "gige_engress:inst2|length[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[62] -to "gige_engress:inst2|length[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[63] -to "gige_engress:inst2|length[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[64] -to "gige_engress:inst2|length[12]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[65] -to "gige_engress:inst2|length[13]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[66] -to "gige_engress:inst2|length[14]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[67] -to "gige_engress:inst2|length[15]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[68] -to "gige_engress:inst2|length[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[69] -to "gige_engress:inst2|length[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[70] -to "gige_engress:inst2|length[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[71] -to "gige_engress:inst2|length[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[72] -to "gige_engress:inst2|length[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[73] -to "gige_engress:inst2|length[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[74] -to "gige_engress:inst2|length[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[75] -to "gige_engress:inst2|length[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[76] -to "gige_engress:inst2|length[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[77] -to "gige_engress:inst2|q1" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[78] -to "gige_engress:inst2|q4" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[79] -to "gige_engress:inst2|rdaddr[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[80] -to "gige_engress:inst2|rdaddr[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[81] -to "gige_engress:inst2|rdaddr[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[82] -to "gige_engress:inst2|rdaddr[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[83] -to "gige_engress:inst2|rdaddr[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[84] -to "gige_engress:inst2|rdaddr[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[85] -to "gige_engress:inst2|rdaddr[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[86] -to "gige_engress:inst2|rdaddr[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[87] -to "gige_engress:inst2|rdaddr[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[88] -to "gige_engress:inst2|rdaddr[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[89] -to "gige_engress:inst2|rdaddr[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[90] -to "gige_engress:inst2|rdaddr[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[91] -to "gige_engress:inst2|start_send" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_trigger_in[92] -to "gige_engress:inst2|tx_rdy" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[52] -to "gige_engress:inst2|TERR" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[53] -to "gige_engress:inst2|TMOD[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[54] -to "gige_engress:inst2|TMOD[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[55] -to "gige_engress:inst2|TPRTY" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[56] -to "gige_engress:inst2|TSOP" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[57] -to "gige_engress:inst2|TSX" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[58] -to "gige_engress:inst2|ff_crc_fwd" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[59] -to "gige_engress:inst2|ff_tx_wren" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[60] -to "gige_engress:inst2|last_packet" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[61] -to "gige_engress:inst2|length[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[62] -to "gige_engress:inst2|length[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[63] -to "gige_engress:inst2|length[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[64] -to "gige_engress:inst2|length[12]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[65] -to "gige_engress:inst2|length[13]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[66] -to "gige_engress:inst2|length[14]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[67] -to "gige_engress:inst2|length[15]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[68] -to "gige_engress:inst2|length[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[69] -to "gige_engress:inst2|length[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[70] -to "gige_engress:inst2|length[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[71] -to "gige_engress:inst2|length[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[72] -to "gige_engress:inst2|length[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[73] -to "gige_engress:inst2|length[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[74] -to "gige_engress:inst2|length[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[75] -to "gige_engress:inst2|length[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[76] -to "gige_engress:inst2|length[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[77] -to "gige_engress:inst2|q1" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[78] -to "gige_engress:inst2|q4" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[79] -to "gige_engress:inst2|rdaddr[0]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[80] -to "gige_engress:inst2|rdaddr[10]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[81] -to "gige_engress:inst2|rdaddr[11]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[82] -to "gige_engress:inst2|rdaddr[1]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[83] -to "gige_engress:inst2|rdaddr[2]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[84] -to "gige_engress:inst2|rdaddr[3]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[85] -to "gige_engress:inst2|rdaddr[4]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[86] -to "gige_engress:inst2|rdaddr[5]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[87] -to "gige_engress:inst2|rdaddr[6]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[88] -to "gige_engress:inst2|rdaddr[7]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[89] -to "gige_engress:inst2|rdaddr[8]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[90] -to "gige_engress:inst2|rdaddr[9]" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[91] -to "gige_engress:inst2|start_send" -section_id auto_signaltap_2
	set_instance_assignment -name CONNECT_TO_SLD_NODE_ENTITY_PORT acq_data_in[92] -to "gige_engress:inst2|tx_rdy" -section_id auto_signaltap_2
set_location_assignment PIN_AF38 -to "LVDS_RX_RESERVE4(n)"
	set_location_assignment PIN_AK31 -to "X3_DATA1(n)"
	set_location_assignment PIN_AH30 -to "X3_FLAG_DQHJ(n)"
	set_location_assignment PIN_F34 -to "X15_DATA3B(n)"
	set_location_assignment PIN_AG29 -to "X3_CLK(n)"
	set_location_assignment PIN_AP36 -to "LVDS_ENIN(n)"
	set_location_assignment PIN_AG31 -to "X2_DATA1_DQHL(n)"
	set_location_assignment PIN_AE28 -to "X3_FLAG(n)"
	set_location_assignment PIN_M34 -to "X15_CLK(n)"
	set_location_assignment PIN_P34 -to "X15_DATA1B(n)"
	set_location_assignment PIN_AE38 -to "LVDS_RX_RESERVE3(n)"
	set_location_assignment PIN_AM36 -to "LVDS_CLKIN(n)"
	set_location_assignment PIN_AB33 -to "X2_DATA0(n)"
	set_location_assignment PIN_N34 -to "X15_FLAGB(n)"
	set_location_assignment PIN_H31 -to "X15_DATA2B(n)"
	set_location_assignment PIN_T33 -to "X15_DATA1(n)"
	set_location_assignment PIN_AF32 -to "X2_CLK_DQHL(n)"
	set_location_assignment PIN_AB31 -to "X2_DATA1(n)"
	set_location_assignment PIN_P32 -to "X15_DATA3(n)"
	set_location_assignment PIN_V33 -to "LVDS_TX_RESERVE1(n)"
	set_location_assignment PIN_AH32 -to "X2_FLAG_DQHL(n)"
	set_location_assignment PIN_Y34 -to "X16_FLAGC(n)"
	set_location_assignment PIN_U31 -to "X16_CLKD(n)"
	set_location_assignment PIN_J31 -to "X15_DATA2(n)"
	set_location_assignment PIN_T31 -to "X16_FLAGD(n)"
	set_location_assignment PIN_AF34 -to "X2_CLK(n)"
	set_location_assignment PIN_N32 -to "X15_DATA0(n)"
	set_location_assignment PIN_L32 -to "X15_DATA0B(n)"
	set_location_assignment PIN_Y32 -to "X16_CLKC(n)"
	set_location_assignment PIN_AE30 -to "X2_DATA1_DQ(n)"
	set_location_assignment PIN_AA32 -to "X16_CATA3C(n)"
	set_location_assignment PIN_W32 -to "X16_DATA3D(n)"
	set_location_assignment PIN_AE34 -to "X2_FLAG(n)"
	set_location_assignment PIN_R33 -to "X16_CATA2C(n)"
	set_location_assignment PIN_AA28 -to "X16_DATA2D(n)"
	set_location_assignment PIN_AE32 -to "X2_CLK_DQ(n)"
	set_location_assignment PIN_AA30 -to "X16_DATA1D(n)"
	set_location_assignment PIN_V31 -to "LVDS_TX_RESERVE2(n)"
	set_location_assignment PIN_AD33 -to "X2_FLAG_DQ(n)"
	set_location_assignment PIN_P38 -to "LVDS_RX_RESERVE1(n)"
	set_location_assignment PIN_AC31 -to "X16_CATA0C(n)"
	set_location_assignment PIN_AC33 -to "X16_DATA0D(n)"
	set_location_assignment PIN_R38 -to "LVDS_RX_RESERVE2(n)"
	set_location_assignment PIN_R31 -to "X16_CATA1C(n)"
	set_location_assignment PIN_AJ32 -to "X3_DATA1_DQHJ(n)"
	set_location_assignment PIN_AC29 -to "X3_CLK_DQHJ(n)"
	set_location_assignment PIN_E34 -to "X15_CLKB(n)"
	set_location_assignment PIN_AF39 -to LVDS_RX_RESERVE4
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_RX_RESERVE4
	set_location_assignment PIN_AK32 -to X3_DATA1
	set_instance_assignment -name IO_STANDARD LVDS -to X3_DATA1
	set_location_assignment PIN_AH31 -to X3_FLAG_DQHJ
	set_instance_assignment -name IO_STANDARD LVDS -to X3_FLAG_DQHJ
	set_location_assignment PIN_F35 -to X15_DATA3B
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA3B
	set_location_assignment PIN_AG30 -to X3_CLK
	set_instance_assignment -name IO_STANDARD LVDS -to X3_CLK
	set_location_assignment PIN_AP37 -to LVDS_ENIN
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_ENIN
	set_location_assignment PIN_AG32 -to X2_DATA1_DQHL
	set_instance_assignment -name IO_STANDARD LVDS -to X2_DATA1_DQHL
	set_location_assignment PIN_AE29 -to X3_FLAG
	set_instance_assignment -name IO_STANDARD LVDS -to X3_FLAG
	set_location_assignment PIN_M35 -to X15_CLK
	set_instance_assignment -name IO_STANDARD LVDS -to X15_CLK
	set_location_assignment PIN_P35 -to X15_DATA1B
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA1B
	set_location_assignment PIN_AE39 -to LVDS_RX_RESERVE3
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_RX_RESERVE3
	set_location_assignment PIN_AM37 -to LVDS_CLKIN
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_CLKIN
	set_location_assignment PIN_AB34 -to X2_DATA0
	set_instance_assignment -name IO_STANDARD LVDS -to X2_DATA0
	set_location_assignment PIN_N35 -to X15_FLAGB
	set_instance_assignment -name IO_STANDARD LVDS -to X15_FLAGB
	set_location_assignment PIN_H32 -to X15_DATA2B
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA2B
	set_location_assignment PIN_T34 -to X15_DATA1
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA1
	set_location_assignment PIN_AF33 -to X2_CLK_DQHL
	set_instance_assignment -name IO_STANDARD LVDS -to X2_CLK_DQHL
	set_location_assignment PIN_AB32 -to X2_DATA1
	set_instance_assignment -name IO_STANDARD LVDS -to X2_DATA1
	set_location_assignment PIN_P33 -to X15_DATA3
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA3
	set_location_assignment PIN_V34 -to LVDS_TX_RESERVE1
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_TX_RESERVE1
	set_location_assignment PIN_AH33 -to X2_FLAG_DQHL
	set_instance_assignment -name IO_STANDARD LVDS -to X2_FLAG_DQHL
	set_location_assignment PIN_Y35 -to X16_FLAGC
	set_instance_assignment -name IO_STANDARD LVDS -to X16_FLAGC
	set_location_assignment PIN_U32 -to X16_CLKD
	set_instance_assignment -name IO_STANDARD LVDS -to X16_CLKD
	set_location_assignment PIN_J32 -to X15_DATA2
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA2
	set_location_assignment PIN_T32 -to X16_FLAGD
	set_instance_assignment -name IO_STANDARD LVDS -to X16_FLAGD
	set_location_assignment PIN_AF35 -to X2_CLK
	set_instance_assignment -name IO_STANDARD LVDS -to X2_CLK
	set_location_assignment PIN_N33 -to X15_DATA0
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA0
	set_location_assignment PIN_L33 -to X15_DATA0B
	set_instance_assignment -name IO_STANDARD LVDS -to X15_DATA0B
	set_location_assignment PIN_Y33 -to X16_CLKC
	set_instance_assignment -name IO_STANDARD LVDS -to X16_CLKC
	set_location_assignment PIN_AE31 -to X2_DATA1_DQ
	set_instance_assignment -name IO_STANDARD LVDS -to X2_DATA1_DQ
	set_location_assignment PIN_AA33 -to X16_CATA3C
	set_instance_assignment -name IO_STANDARD LVDS -to X16_CATA3C
	set_location_assignment PIN_W33 -to X16_DATA3D
	set_instance_assignment -name IO_STANDARD LVDS -to X16_DATA3D
	set_location_assignment PIN_AE35 -to X2_FLAG
	set_instance_assignment -name IO_STANDARD LVDS -to X2_FLAG
	set_location_assignment PIN_R34 -to X16_CATA2C
	set_instance_assignment -name IO_STANDARD LVDS -to X16_CATA2C
	set_location_assignment PIN_AA29 -to X16_DATA2D
	set_instance_assignment -name IO_STANDARD LVDS -to X16_DATA2D
	set_location_assignment PIN_AE33 -to X2_CLK_DQ
	set_instance_assignment -name IO_STANDARD LVDS -to X2_CLK_DQ
	set_location_assignment PIN_AA31 -to X16_DATA1D
	set_instance_assignment -name IO_STANDARD LVDS -to X16_DATA1D
	set_location_assignment PIN_V32 -to LVDS_TX_RESERVE2
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_TX_RESERVE2
	set_location_assignment PIN_AD34 -to X2_FLAG_DQ
	set_instance_assignment -name IO_STANDARD LVDS -to X2_FLAG_DQ
	set_location_assignment PIN_P39 -to LVDS_RX_RESERVE1
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_RX_RESERVE1
	set_location_assignment PIN_AC32 -to X16_CATA0C
	set_instance_assignment -name IO_STANDARD LVDS -to X16_CATA0C
	set_location_assignment PIN_AC34 -to X16_DATA0D
	set_instance_assignment -name IO_STANDARD LVDS -to X16_DATA0D
	set_location_assignment PIN_R39 -to LVDS_RX_RESERVE2
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_RX_RESERVE2
	set_location_assignment PIN_R32 -to X16_CATA1C
	set_instance_assignment -name IO_STANDARD LVDS -to X16_CATA1C
	set_location_assignment PIN_AJ33 -to X3_DATA1_DQHJ
	set_instance_assignment -name IO_STANDARD LVDS -to X3_DATA1_DQHJ
	set_location_assignment PIN_AC30 -to X3_CLK_DQHJ
	set_instance_assignment -name IO_STANDARD LVDS -to X3_CLK_DQHJ
	set_location_assignment PIN_E35 -to X15_CLKB
	set_instance_assignment -name IO_STANDARD LVDS -to X15_CLKB
	set_location_assignment PIN_L27 -to U1_RXD[0]
	set_location_assignment PIN_M28 -to U1_RXD[1]
	set_location_assignment PIN_L28 -to U1_RXD[2]
	set_location_assignment PIN_B35 -to U1_RXD[3]
	set_location_assignment PIN_A35 -to U1_RXD[4]
	set_location_assignment PIN_B34 -to U1_RXD[5]
	set_location_assignment PIN_A34 -to U1_RXD[6]
	set_location_assignment PIN_B33 -to U1_RXD[7]
	set_location_assignment PIN_A33 -to U1_RXD[8]
	set_location_assignment PIN_B32 -to U1_RXD[9]
	set_location_assignment PIN_A32 -to U1_RXD[10]
	set_location_assignment PIN_N27 -to U1_RXD[11]
	set_location_assignment PIN_B31 -to U1_RXD[12]
	set_location_assignment PIN_A31 -to U1_RXD[13]
	set_location_assignment PIN_B30 -to U1_RXD[14]
	set_location_assignment PIN_A30 -to U1_RXD[15]
	set_location_assignment PIN_J29 -to U1_TXD[0]
	set_location_assignment PIN_H28 -to U1_TXD[1]
	set_location_assignment PIN_H30 -to U1_TXD[2]
	set_location_assignment PIN_E28 -to U1_TXD[3]
	set_location_assignment PIN_E30 -to U1_TXD[4]
	set_location_assignment PIN_E29 -to U1_TXD[5]
	set_location_assignment PIN_E31 -to U1_TXD[6]
	set_location_assignment PIN_E32 -to U1_TXD[7]
	set_location_assignment PIN_M27 -to U1_TXD[8]
	set_location_assignment PIN_N26 -to U1_TXD[9]
	set_location_assignment PIN_M26 -to U1_TXD[10]
	set_location_assignment PIN_C23 -to U1_TXD[11]
	set_location_assignment PIN_A23 -to U1_TXD[12]
	set_location_assignment PIN_B23 -to U1_TXD[13]
	set_location_assignment PIN_B24 -to U1_TXD[14]
	set_location_assignment PIN_A25 -to U1_TXD[15]
	set_location_assignment PIN_H11 -to U2_TXD[0]
	set_location_assignment PIN_H12 -to U2_TXD[1]
	set_location_assignment PIN_L13 -to U2_TXD[2]
	set_location_assignment PIN_B5 -to U2_TXD[3]
	set_location_assignment PIN_A5 -to U2_TXD[4]
	set_location_assignment PIN_B6 -to U2_TXD[5]
	set_location_assignment PIN_A6 -to U2_TXD[6]
	set_location_assignment PIN_C5 -to U2_TXD[7]
	set_location_assignment PIN_C6 -to U2_TXD[8]
	set_location_assignment PIN_D9 -to U2_TXD[9]
	set_location_assignment PIN_C8 -to U2_TXD[10]
	set_location_assignment PIN_D8 -to U2_TXD[11]
	set_location_assignment PIN_D7 -to U2_TXD[12]
	set_location_assignment PIN_E8 -to U2_TXD[13]
	set_location_assignment PIN_C9 -to U2_TXD[14]
	set_location_assignment PIN_D10 -to U2_TXD[15]
	set_location_assignment PIN_F11 -to U3_TXD[0]
	set_location_assignment PIN_F10 -to U3_TXD[1]
	set_location_assignment PIN_G11 -to U3_TXD[2]
	set_location_assignment PIN_A7 -to U3_TXD[3]
	set_location_assignment PIN_B7 -to U3_TXD[4]
	set_location_assignment PIN_A8 -to U3_TXD[5]
	set_location_assignment PIN_B8 -to U3_TXD[6]
	set_location_assignment PIN_A9 -to U3_TXD[7]
	set_location_assignment PIN_A10 -to U3_TXD[8]
	set_location_assignment PIN_B10 -to U3_TXD[9]
	set_location_assignment PIN_A11 -to U3_TXD[10]
	set_location_assignment PIN_B11 -to U3_TXD[11]
	set_location_assignment PIN_A12 -to U3_TXD[12]
	set_location_assignment PIN_B12 -to U3_TXD[13]
	set_location_assignment PIN_A13 -to U3_TXD[14]
	set_location_assignment PIN_B13 -to U3_TXD[15]
	set_location_assignment PIN_C11 -to U4_TXD[0]
	set_location_assignment PIN_E10 -to U4_TXD[1]
	set_location_assignment PIN_D11 -to U4_TXD[2]
	set_location_assignment PIN_C27 -to U4_TXD[3]
	set_location_assignment PIN_D27 -to U4_TXD[4]
	set_location_assignment PIN_C28 -to U4_TXD[5]
	set_location_assignment PIN_D28 -to U4_TXD[6]
	set_location_assignment PIN_C29 -to U4_TXD[7]
	set_location_assignment PIN_C32 -to U4_TXD[8]
	set_location_assignment PIN_D32 -to U4_TXD[9]
	set_location_assignment PIN_D31 -to U4_TXD[10]
	set_location_assignment PIN_D30 -to U4_TXD[11]
	set_location_assignment PIN_C31 -to U4_TXD[12]
	set_location_assignment PIN_C30 -to U4_TXD[13]
	set_location_assignment PIN_C33 -to U4_TXD[14]
	set_location_assignment PIN_C34 -to U4_TXD[15]
	set_location_assignment PIN_AH19 -to ATA1_DA[0]
	set_location_assignment PIN_AJ18 -to ATA1_DA[1]
	set_location_assignment PIN_AL24 -to ATA1_DA[2]
	set_location_assignment PIN_AP14 -to ATA1_DD[0]
	set_location_assignment PIN_AP13 -to ATA1_DD[1]
	set_location_assignment PIN_AF4 -to ATA1_DD[2]
	set_location_assignment PIN_AD5 -to ATA1_DD[3]
	set_location_assignment PIN_AK6 -to ATA1_DD[4]
	set_location_assignment PIN_AH6 -to ATA1_DD[5]
	set_location_assignment PIN_AF6 -to ATA1_DD[6]
	set_location_assignment PIN_AD6 -to ATA1_DD[7]
	set_location_assignment PIN_AE6 -to ATA1_DD[8]
	set_location_assignment PIN_AG7 -to ATA1_DD[9]
	set_location_assignment PIN_AJ6 -to ATA1_DD[10]
	set_location_assignment PIN_AL6 -to ATA1_DD[11]
	set_location_assignment PIN_AE4 -to ATA1_DD[12]
	set_location_assignment PIN_AF3 -to ATA1_DD[13]
	set_location_assignment PIN_AN12 -to ATA1_DD[14]
	set_location_assignment PIN_AN16 -to ATA1_DD[15]
	set_location_assignment PIN_AU18 -to ATA2_DA[0]
	set_location_assignment PIN_AT17 -to ATA2_DA[1]
	set_location_assignment PIN_AR18 -to ATA2_DA[2]
	set_location_assignment PIN_AT15 -to ATA2_DD[0]
	set_location_assignment PIN_AU14 -to ATA2_DD[1]
	set_location_assignment PIN_AT12 -to ATA2_DD[2]
	set_location_assignment PIN_AT11 -to ATA2_DD[3]
	set_location_assignment PIN_AT10 -to ATA2_DD[4]
	set_location_assignment PIN_AT9 -to ATA2_DD[5]
	set_location_assignment PIN_AU8 -to ATA2_DD[6]
	set_location_assignment PIN_AU7 -to ATA2_DD[7]
	set_location_assignment PIN_AT8 -to ATA2_DD[8]
	set_location_assignment PIN_AR9 -to ATA2_DD[9]
	set_location_assignment PIN_AR10 -to ATA2_DD[10]
	set_location_assignment PIN_AU10 -to ATA2_DD[11]
	set_location_assignment PIN_AU11 -to ATA2_DD[12]
	set_location_assignment PIN_AU12 -to ATA2_DD[13]
	set_location_assignment PIN_AT14 -to ATA2_DD[14]
	set_location_assignment PIN_AU15 -to ATA2_DD[15]
	set_location_assignment PIN_AR14 -to ATA3_DA[0]
	set_location_assignment PIN_AR3 -to ATA3_DA[1]
	set_location_assignment PIN_AP3 -to ATA3_DA[2]
	set_location_assignment PIN_AN9 -to ATA3_DD[0]
	set_location_assignment PIN_AR8 -to ATA3_DD[1]
	set_location_assignment PIN_AM3 -to ATA3_DD[2]
	set_location_assignment PIN_AL3 -to ATA3_DD[3]
	set_location_assignment PIN_AK3 -to ATA3_DD[4]
	set_location_assignment PIN_AJ3 -to ATA3_DD[5]
	set_location_assignment PIN_AH3 -to ATA3_DD[6]
	set_location_assignment PIN_AG3 -to ATA3_DD[7]
	set_location_assignment PIN_AH4 -to ATA3_DD[8]
	set_location_assignment PIN_AJ4 -to ATA3_DD[9]
	set_location_assignment PIN_AK4 -to ATA3_DD[10]
	set_location_assignment PIN_AL4 -to ATA3_DD[11]
	set_location_assignment PIN_AM4 -to ATA3_DD[12]
	set_location_assignment PIN_AN4 -to ATA3_DD[13]
	set_location_assignment PIN_AL8 -to ATA3_DD[14]
	set_location_assignment PIN_AN7 -to ATA3_DD[15]
	set_location_assignment PIN_AN1 -to ATA4_DA[0]
	set_location_assignment PIN_AM2 -to ATA4_DA[1]
	set_location_assignment PIN_AN2 -to ATA4_DA[2]
	set_location_assignment PIN_AU5 -to ATA4_DD[0]
	set_location_assignment PIN_AU6 -to ATA4_DD[1]
	set_location_assignment PIN_AJ1 -to ATA4_DD[2]
	set_location_assignment PIN_AH1 -to ATA4_DD[3]
	set_location_assignment PIN_AR4 -to ATA4_DD[4]
	set_location_assignment PIN_AF2 -to ATA4_DD[5]
	set_location_assignment PIN_AE2 -to ATA4_DD[6]
	set_location_assignment PIN_AC2 -to ATA4_DD[7]
	set_location_assignment PIN_AE1 -to ATA4_DD[8]
	set_location_assignment PIN_AF1 -to ATA4_DD[9]
	set_location_assignment PIN_AG1 -to ATA4_DD[10]
	set_location_assignment PIN_AG2 -to ATA4_DD[11]
	set_location_assignment PIN_AH2 -to ATA4_DD[12]
	set_location_assignment PIN_AJ2 -to ATA4_DD[13]
	set_location_assignment PIN_AR6 -to ATA4_DD[14]
	set_location_assignment PIN_AK1 -to ATA4_DD[15]
	set_location_assignment PIN_AV13 -to ATA5_DA[0]
	set_location_assignment PIN_AW13 -to ATA5_DA[1]
	set_location_assignment PIN_AW14 -to ATA5_DA[2]
	set_location_assignment PIN_AW9 -to ATA5_DD[0]
	set_location_assignment PIN_AW8 -to ATA5_DD[1]
	set_location_assignment PIN_AW7 -to ATA5_DD[2]
	set_location_assignment PIN_AW6 -to ATA5_DD[3]
	set_location_assignment PIN_AW5 -to ATA5_DD[4]
	set_location_assignment PIN_AV3 -to ATA5_DD[5]
	set_location_assignment PIN_AV2 -to ATA5_DD[6]
	set_location_assignment PIN_AR2 -to ATA5_DD[7]
	set_location_assignment PIN_AT3 -to ATA5_DD[8]
	set_location_assignment PIN_AU3 -to ATA5_DD[9]
	set_location_assignment PIN_AU4 -to ATA5_DD[10]
	set_location_assignment PIN_AV5 -to ATA5_DD[11]
	set_location_assignment PIN_AV6 -to ATA5_DD[12]
	set_location_assignment PIN_AV7 -to ATA5_DD[13]
	set_location_assignment PIN_AV8 -to ATA5_DD[14]
	set_location_assignment PIN_AV9 -to ATA5_DD[15]
	set_location_assignment PIN_AG18 -to SDRAM_A_A[0]
	set_location_assignment PIN_AL9 -to SDRAM_A_A[1]
	set_location_assignment PIN_AH18 -to SDRAM_A_A[2]
	set_location_assignment PIN_AK8 -to SDRAM_A_A[3]
	set_location_assignment PIN_AJ8 -to SDRAM_A_A[4]
	set_location_assignment PIN_AM25 -to SDRAM_A_A[5]
	set_location_assignment PIN_AM11 -to SDRAM_A_A[6]
	set_location_assignment PIN_AM24 -to SDRAM_A_A[7]
	set_location_assignment PIN_AM13 -to SDRAM_A_A[8]
	set_location_assignment PIN_AG20 -to SDRAM_A_A[9]
	set_location_assignment PIN_AM12 -to SDRAM_A_A[10]
	set_location_assignment PIN_AN13 -to SDRAM_A_A[11]
	set_location_assignment PIN_AH20 -to SDRAM_A_A[12]
	set_location_assignment PIN_AN14 -to SDRAM_A_A[13]
	set_location_assignment PIN_AG19 -to SDRAM_A_A[14]
	set_location_assignment PIN_AV16 -to SDRAM_A_D[0]
	set_location_assignment PIN_AW17 -to SDRAM_A_D[1]
	set_location_assignment PIN_AV17 -to SDRAM_A_D[2]
	set_location_assignment PIN_AV18 -to SDRAM_A_D[3]
	set_location_assignment PIN_AW21 -to SDRAM_A_D[4]
	set_location_assignment PIN_AV21 -to SDRAM_A_D[5]
	set_location_assignment PIN_AV22 -to SDRAM_A_D[6]
	set_location_assignment PIN_AW23 -to SDRAM_A_D[7]
	set_location_assignment PIN_AV23 -to SDRAM_A_D[8]
	set_location_assignment PIN_AV24 -to SDRAM_A_D[9]
	set_location_assignment PIN_AW25 -to SDRAM_A_D[10]
	set_location_assignment PIN_AV25 -to SDRAM_A_D[11]
	set_location_assignment PIN_AW26 -to SDRAM_A_D[12]
	set_location_assignment PIN_AV26 -to SDRAM_A_D[13]
	set_location_assignment PIN_AW27 -to SDRAM_A_D[14]
	set_location_assignment PIN_AV27 -to SDRAM_A_D[15]
	set_location_assignment PIN_AT26 -to SDRAM_A_D[16]
	set_location_assignment PIN_AU26 -to SDRAM_A_D[17]
	set_location_assignment PIN_AT25 -to SDRAM_A_D[18]
	set_location_assignment PIN_AU25 -to SDRAM_A_D[19]
	set_location_assignment PIN_AT24 -to SDRAM_A_D[20]
	set_location_assignment PIN_AU24 -to SDRAM_A_D[21]
	set_location_assignment PIN_AR24 -to SDRAM_A_D[22]
	set_location_assignment PIN_AU23 -to SDRAM_A_D[23]
	set_location_assignment PIN_AT22 -to SDRAM_A_D[24]
	set_location_assignment PIN_AU22 -to SDRAM_A_D[25]
	set_location_assignment PIN_AR22 -to SDRAM_A_D[26]
	set_location_assignment PIN_AP21 -to SDRAM_A_D[27]
	set_location_assignment PIN_AR20 -to SDRAM_A_D[28]
	set_location_assignment PIN_AP20 -to SDRAM_A_D[29]
	set_location_assignment PIN_AN21 -to SDRAM_A_D[30]
	set_location_assignment PIN_AN20 -to SDRAM_A_D[31]
	set_location_assignment PIN_AR29 -to SDRAM_B_A[0]
	set_location_assignment PIN_AT18 -to SDRAM_B_A[1]
	set_location_assignment PIN_AR27 -to SDRAM_B_A[2]
	set_location_assignment PIN_AN17 -to SDRAM_B_A[3]
	set_location_assignment PIN_AR25 -to SDRAM_B_A[4]
	set_location_assignment PIN_AR26 -to SDRAM_B_A[5]
	set_location_assignment PIN_AP18 -to SDRAM_B_A[6]
	set_location_assignment PIN_AR28 -to SDRAM_B_A[7]
	set_location_assignment PIN_AP19 -to SDRAM_B_A[8]
	set_location_assignment PIN_AR30 -to SDRAM_B_A[9]
	set_location_assignment PIN_AM22 -to SDRAM_B_A[10]
	set_location_assignment PIN_AM21 -to SDRAM_B_A[11]
	set_location_assignment PIN_AP30 -to SDRAM_B_A[12]
	set_location_assignment PIN_AM20 -to SDRAM_B_A[13]
	set_location_assignment PIN_AR31 -to SDRAM_B_A[14]
	set_location_assignment PIN_AU35 -to SDRAM_B_D[0]
	set_location_assignment PIN_AU34 -to SDRAM_B_D[1]
	set_location_assignment PIN_AT33 -to SDRAM_B_D[2]
	set_location_assignment PIN_AU33 -to SDRAM_B_D[3]
	set_location_assignment PIN_AT32 -to SDRAM_B_D[4]
	set_location_assignment PIN_AU32 -to SDRAM_B_D[5]
	set_location_assignment PIN_AT31 -to SDRAM_B_D[6]
	set_location_assignment PIN_AU31 -to SDRAM_B_D[7]
	set_location_assignment PIN_AT30 -to SDRAM_B_D[8]
	set_location_assignment PIN_AU30 -to SDRAM_B_D[9]
	set_location_assignment PIN_AT29 -to SDRAM_B_D[10]
	set_location_assignment PIN_AU29 -to SDRAM_B_D[11]
	set_location_assignment PIN_AT28 -to SDRAM_B_D[12]
	set_location_assignment PIN_AU28 -to SDRAM_B_D[13]
	set_location_assignment PIN_AT27 -to SDRAM_B_D[14]
	set_location_assignment PIN_AU27 -to SDRAM_B_D[15]
	set_location_assignment PIN_AW28 -to SDRAM_B_D[16]
	set_location_assignment PIN_AV28 -to SDRAM_B_D[17]
	set_location_assignment PIN_AW29 -to SDRAM_B_D[18]
	set_location_assignment PIN_AV29 -to SDRAM_B_D[19]
	set_location_assignment PIN_AW30 -to SDRAM_B_D[20]
	set_location_assignment PIN_AV30 -to SDRAM_B_D[21]
	set_location_assignment PIN_AW31 -to SDRAM_B_D[22]
	set_location_assignment PIN_AV31 -to SDRAM_B_D[23]
	set_location_assignment PIN_AW32 -to SDRAM_B_D[24]
	set_location_assignment PIN_AV32 -to SDRAM_B_D[25]
	set_location_assignment PIN_AW33 -to SDRAM_B_D[26]
	set_location_assignment PIN_AV33 -to SDRAM_B_D[27]
	set_location_assignment PIN_AW34 -to SDRAM_B_D[28]
	set_location_assignment PIN_AV34 -to SDRAM_B_D[29]
	set_location_assignment PIN_AW35 -to SDRAM_B_D[30]
	set_location_assignment PIN_AV35 -to SDRAM_B_D[31]
	set_location_assignment PIN_AL2 -to ATA4_DMACK
	set_location_assignment PIN_C1 -to CLK_IN_1
	set_location_assignment PIN_W1 -to SMA_CLKIN5
	set_location_assignment PIN_U2 -to SCL_5338A
	set_location_assignment PIN_E18 -to M88_LED_LINK1000
	set_location_assignment PIN_L26 -to U1_TXCLK
	set_location_assignment PIN_H18 -to KEY_RST
	set_location_assignment PIN_F23 -to PHY_INTN
	set_location_assignment PIN_E24 -to PHY_MDC
	set_location_assignment PIN_E25 -to PHY_125MO
	set_location_assignment PIN_B25 -to U1_TKMSB
	set_location_assignment PIN_E26 -to PHY_MDIO
	set_location_assignment PIN_B26 -to U1_TKLSB
	set_location_assignment PIN_A26 -to U1_LOOPEN
	set_location_assignment PIN_M25 -to M88_LED_DUPLEX
	set_location_assignment PIN_G25 -to PHY_RXDV
	set_location_assignment PIN_E27 -to PHY_RST_N
	set_location_assignment PIN_B27 -to U1_LCKREFN
	set_location_assignment PIN_A27 -to U1_ENABLE
	set_location_assignment PIN_W3 -to U1_RXCLK
	set_location_assignment PIN_G26 -to PHY_RXCLK
	set_location_assignment PIN_F26 -to PHY_RXER
	set_location_assignment PIN_D29 -to U4_TXCLK
	set_location_assignment PIN_B28 -to U1_TESTEN
	set_location_assignment PIN_A28 -to U1_PRBSEN
	set_location_assignment PIN_F30 -to PHY_TXEN
	set_location_assignment PIN_F27 -to PHY_TX_CLK
	set_location_assignment PIN_B29 -to U1_RKMSB
	set_location_assignment PIN_A29 -to U1_RKLSB
	set_location_assignment PIN_G28 -to PHY_TXER
	set_location_assignment PIN_AM28 -to SDRAM_B_CLK
	set_location_assignment PIN_F29 -to PHY_GTXCLK
	set_location_assignment PIN_G29 -to U1_PRE
	set_location_assignment PIN_D33 -to U4_TKMSB
	set_location_assignment PIN_AP24 -to SDRAM_B_DQMH
	set_location_assignment PIN_E33 -to U4_TKLSB
	set_location_assignment PIN_C35 -to U4_LOOPEN
	set_location_assignment PIN_AP22 -to SDRAM_B_RAS_N
	set_location_assignment PIN_AP23 -to SDRAM_B_DQML
	set_location_assignment PIN_AN22 -to SDRAM_B_CKE
	set_location_assignment PIN_G31 -to U4_LCKREFN
	set_location_assignment PIN_F32 -to U4_ENABLE
	set_location_assignment PIN_AN29 -to SDRAM_B_CAS_N
	set_location_assignment PIN_AR32 -to SDRAM_B_CS_N
	set_location_assignment PIN_L25 -to U4_RXCLK
	set_location_assignment PIN_A21 -to U4_RKLSB
	set_location_assignment PIN_J28 -to U4_TESTEN
	set_location_assignment PIN_H29 -to U4_PRBSEN
	set_location_assignment PIN_AM29 -to SDRAM_B_WE_N
	set_location_assignment PIN_W39 -to SMA_CLKIN2
	set_location_assignment PIN_C20 -to SMA_CLKIN1
	set_location_assignment PIN_AW20 -to SMA_CLKIN_RESERVE5
	set_location_assignment PIN_B22 -to U4_RKMSB
	set_location_assignment PIN_G4 -to FPGA_SCL
	set_location_assignment PIN_AJ7 -to FLASH_CE
	set_location_assignment PIN_AJ16 -to FLASH_OE
	set_location_assignment PIN_AJ27 -to FLASH_RESET
	set_location_assignment PIN_G3 -to FPGA_SDA
	set_location_assignment PIN_C39 -to CLK_IN_2
	set_location_assignment PIN_C21 -to SMA_CLKIN4
	set_location_assignment PIN_AL26 -to FLASH_WE
	set_location_assignment PIN_AR1 -to ATA5_RESETN
	set_location_assignment PIN_AM1 -to ATA4_INTRQ
	set_location_assignment PIN_AL1 -to ATA4_DIORN
	set_location_assignment PIN_AK2 -to ATA4_DIOWN
	set_location_assignment PIN_AA1 -to SCL_5338B
	set_location_assignment PIN_U1 -to SDA_5338A
	set_location_assignment PIN_AT7 -to ATA2_RESETN
	set_location_assignment PIN_AR5 -to ATA4_DMARQ
	set_location_assignment PIN_AC1 -to ATA4_RESETN
	set_location_assignment PIN_AB2 -to INTR_5338B
	set_location_assignment PIN_Y3 -to SMA_CLKIN7
	set_location_assignment PIN_Y1 -to SMA_CLKIN6
	set_location_assignment PIN_AU19 -to SMA_CLKIN8
	set_location_assignment PIN_G2 -to JP2_4
	set_location_assignment PIN_F2 -to JP2_2
	set_location_assignment PIN_E2 -to JP1_5
	set_location_assignment PIN_C4 -to JP1_3
	set_location_assignment PIN_B3 -to JP1_1
	set_location_assignment PIN_M3 -to UA_LOCK
	set_location_assignment PIN_J11 -to U2_PRE
	set_location_assignment PIN_AT4 -to ATA4_IORDY
	set_location_assignment PIN_Y5 -to SDA_5338B
	set_location_assignment PIN_V2 -to INTR_5338A
	set_location_assignment PIN_G1 -to JP2_5
	set_location_assignment PIN_F1 -to JP2_3
	set_location_assignment PIN_E1 -to JP2_1
	set_location_assignment PIN_C3 -to JP1_4
	set_location_assignment PIN_B2 -to JP1_2
	set_location_assignment PIN_AV10 -to ATA5_DIOWN
	set_location_assignment PIN_AW10 -to ATA5_DMARQ
	set_location_assignment PIN_AV11 -to ATA5_IORDY
	set_location_assignment PIN_AW11 -to ATA5_DIORN
	set_location_assignment PIN_AV12 -to ATA5_INTRQ
	set_location_assignment PIN_AW12 -to ATA5_DMACK
	set_location_assignment PIN_AP16 -to SDRAM_A_CKE
	set_location_assignment PIN_AR15 -to SDRAM_A_RAS_N
	set_location_assignment PIN_H2 -to UART_RX1
	set_location_assignment PIN_E9 -to U3_PRE
	set_location_assignment PIN_AT16 -to ATA2_DIOWN
	set_location_assignment PIN_AU16 -to ATA2_DIORN
	set_location_assignment PIN_AJ23 -to SDRAM_A_DQML
	set_location_assignment PIN_AN15 -to ATA1_DMARQ
	set_location_assignment PIN_AM5 -to ATA2_IORDY
	set_location_assignment PIN_AL5 -to ATA2_DMARQ
	set_location_assignment PIN_AG6 -to UA_SYNC
	set_location_assignment PIN_AE5 -to UA_TCLK
	set_location_assignment PIN_H1 -to UART_TX1
	set_location_assignment PIN_B9 -to U3_TXCLK
	set_location_assignment PIN_AR16 -to ATA2_DMACK
	set_location_assignment PIN_AU17 -to ATA2_INTRQ
	set_location_assignment PIN_AJ17 -to SDRAM_A_DQMH
	set_location_assignment PIN_AM17 -to ATA1_DIOWN
	set_location_assignment PIN_D6 -to U2_TXCLK
	set_location_assignment PIN_AP5 -to ATA3_INTRQ
	set_location_assignment PIN_AN18 -to ATA1_DIORN
	set_location_assignment PIN_D12 -to U4_PRE
	set_location_assignment PIN_AP6 -to ATA3_DIORN
	set_location_assignment PIN_AM18 -to ATA1_IORDY
	set_location_assignment PIN_AA4 -to UA_REFCLK
	set_location_assignment PIN_AG4 -to ATA3_RESETN
	set_location_assignment PIN_AC6 -to ATA1_RESETN
	set_location_assignment PIN_AL23 -to SDRAM_A_CLK
	set_location_assignment PIN_G12 -to PHY_CRSB
	set_location_assignment PIN_AN19 -to ATA1_DMACK
	set_location_assignment PIN_AL11 -to TEMPSCL
	set_location_assignment PIN_AN6 -to UA_RCLK
	set_location_assignment PIN_F13 -to PHY_COLB
	set_location_assignment PIN_A14 -to U3_TKMSB
	set_location_assignment PIN_B14 -to U3_LOOPEN
	set_location_assignment PIN_AM19 -to ATA1_INTRQ
	set_location_assignment PIN_AN26 -to FPGA_RESET
	set_location_assignment PIN_AV15 -to TEMPSDA
	set_location_assignment PIN_C10 -to U2_TKMSB
	set_location_assignment PIN_G14 -to U2_LOOPEN
	set_location_assignment PIN_A15 -to U3_TKLSB
	set_location_assignment PIN_B15 -to U3_ENABLE
	set_location_assignment PIN_G16 -to U2_TKLSB
	set_location_assignment PIN_C24 -to U2_RKLSB
	set_location_assignment PIN_B16 -to U3_LCKREFN
	set_location_assignment PIN_A17 -to U3_PRBSEN
	set_location_assignment PIN_AP10 -to ATA3_DMARQ
	set_location_assignment PIN_AN27 -to FPGA_RESET1
	set_location_assignment PIN_C7 -to U2_RKMSB
	set_location_assignment PIN_D24 -to U2_PRBSEN
	set_location_assignment PIN_B17 -to U3_TESTEN
	set_location_assignment PIN_AH21 -to SDRAM_A_CS_N
	set_location_assignment PIN_AR12 -to ATA3_IORDY
	set_location_assignment PIN_AR11 -to ATA3_DIOWN
	set_location_assignment PIN_C25 -to U2_TESTEN
	set_location_assignment PIN_D25 -to U2_ENABLE
	set_location_assignment PIN_B18 -to U3_RKLSB
	set_location_assignment PIN_B19 -to U3_RKMSB
	set_location_assignment PIN_AJ22 -to SDRAM_A_WE_N
	set_location_assignment PIN_AR13 -to ATA3_DMACK
	set_location_assignment PIN_C26 -to U2_LCKREFN
	set_location_assignment PIN_D26 -to U2_RXCLK
	set_location_assignment PIN_B21 -to U3_RXCLK
	set_location_assignment PIN_AU20 -to SMA_CLKIN_RESERVE2
	set_location_assignment PIN_AJ24 -to SDRAM_A_CAS_N
	set_location_assignment PIN_W37 -to CLK_1
	set_location_assignment PIN_C19 -to SMA_CLKIN_RESERVE3
	set_location_assignment PIN_Y39 -to SMA_CLKIN3
	set_location_assignment PIN_AU21 -to SMA_CLKIN_RESERVE1
	set_location_assignment PIN_Y37 -to CLK_2
	set_location_assignment PIN_A20 -to SMA_CLKIN_RESERVE4
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED_DUPLEX
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_125MO
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_COLB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_CRSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_GTXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_INTN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_MDC
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_MDIO
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RST_N
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXDV
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXER
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TX_CLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXER
	set_instance_assignment -name IO_STANDARD "2.5 V" -to SMA_CLKIN_RESERVE4
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_ENABLE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_LCKREFN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_LOOPEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_PRBSEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_PRE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RKLSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RKMSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[15]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[14]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[13]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[12]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[11]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[10]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_RXD[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TESTEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TKLSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TKMSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[15]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[14]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[13]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[12]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[11]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[10]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U1_TXD[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_ENABLE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_LCKREFN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_LOOPEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_PRBSEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_RXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TESTEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TKLSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TKMSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[15]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[14]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[13]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[12]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[11]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[10]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to CLK_1
	set_instance_assignment -name IO_STANDARD "2.5 V" -to SMA_CLKIN_RESERVE3
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_ENABLE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_LCKREFN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_LOOPEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_PRBSEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_PRE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_RKLSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_RKMSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_RXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TESTEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TKLSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TKMSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[15]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[14]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[13]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[12]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[11]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[10]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U2_TXD[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_ENABLE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_LCKREFN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_LOOPEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_PRBSEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_PRE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TESTEN
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TKLSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TKMSB
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[15]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[14]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[13]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[12]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[11]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[10]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U3_TXD[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_PRE
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to U4_TXD[0]
	set_location_assignment PIN_K32 -to X15_FLAG
	set_instance_assignment -name IO_STANDARD LVDS -to X15_FLAG
	set_location_assignment PIN_K31 -to "X15_FLAG(n)"
	set_location_assignment PIN_Y27 -to LVDS_RESERVE
	set_instance_assignment -name IO_STANDARD LVDS -to LVDS_RESERVE
	set_location_assignment PIN_ -to "FLASH_WE |(n)"
	set_location_assignment PIN_AH28 -to "X4_DATA1_DQHL(n)"
	set_location_assignment PIN_AJ30 -to "X4_DATA1_DQ(n)"
	set_location_assignment PIN_AL31 -to "X4_CLK_DQHL(n)"
	set_location_assignment PIN_AM31 -to "X4_FLAG_DQHL(n)"
	set_location_assignment PIN_Y26 -to "LVDS_RESERVE(n)"
	set_location_assignment PIN_AH29 -to X4_DATA1_DQHL
	set_instance_assignment -name IO_STANDARD LVDS -to X4_DATA1_DQHL
	set_location_assignment PIN_AJ31 -to X4_DATA1_DQ
	set_instance_assignment -name IO_STANDARD LVDS -to X4_DATA1_DQ
	set_location_assignment PIN_AL32 -to X4_CLK_DQHL
	set_instance_assignment -name IO_STANDARD LVDS -to X4_CLK_DQHL
	set_location_assignment PIN_AM32 -to X4_FLAG_DQHL
	set_instance_assignment -name IO_STANDARD LVDS -to X4_FLAG_DQHL
	set_instance_assignment -name IO_STANDARD LVDS -to "X3_DATA1(n)"
	set_instance_assignment -name IO_STANDARD LVDS -to "X15_CLK(n)"
	set_instance_assignment -name IO_STANDARD LVDS -to "X15_DATA2(n)"
	set_instance_assignment -name IO_STANDARD LVDS -to "X16_FLAGD(n)"
	set_instance_assignment -name IO_STANDARD LVDS -to "LVDS_RX_RESERVE2(n)"
	set_instance_assignment -name IO_STANDARD LVDS -to "X15_FLAG(n)"
	set_instance_assignment -name IO_STANDARD "2.5 V" -to SMA_CLKIN1
	set_instance_assignment -name IO_STANDARD "2.5 V" -to SMA_CLKIN4
	set_instance_assignment -name IO_STANDARD "2.5 V" -to KEY_RST
	set_instance_assignment -name IO_STANDARD "2.5 V" -to SMA_CLKIN3
	set_instance_assignment -name IO_STANDARD "2.5 V" -to CLK_2
	set_instance_assignment -name IO_STANDARD "2.5 V" -to CLK_IN_2
	set_instance_assignment -name IO_STANDARD "2.5 V" -to SMA_CLKIN2
	set_location_assignment PIN_AM16 -to FLASH_A[0]
	set_location_assignment PIN_AG24 -to FLASH_A[1]
	set_location_assignment PIN_AH24 -to FLASH_A[2]
	set_location_assignment PIN_AG25 -to FLASH_A[3]
	set_location_assignment PIN_AG26 -to FLASH_A[4]
	set_location_assignment PIN_AH25 -to FLASH_A[5]
	set_location_assignment PIN_AH26 -to FLASH_A[6]
	set_location_assignment PIN_AH27 -to FLASH_A[7]
	set_location_assignment PIN_AL27 -to FLASH_A[8]
	set_location_assignment PIN_AM27 -to FLASH_A[9]
	set_location_assignment PIN_AK9 -to FLASH_A[10]
	set_location_assignment PIN_AM26 -to FLASH_A[11]
	set_location_assignment PIN_AJ25 -to FLASH_A[12]
	set_location_assignment PIN_AL25 -to FLASH_A[13]
	set_location_assignment PIN_AH23 -to FLASH_A[14]
	set_location_assignment PIN_AG22 -to FLASH_A[15]
	set_location_assignment PIN_AH22 -to FLASH_A[16]
	set_location_assignment PIN_AJ9 -to FLASH_A[17]
	set_location_assignment PIN_AJ26 -to FLASH_A[18]
	set_location_assignment PIN_AG8 -to FLASH_A[19]
	set_location_assignment PIN_AF7 -to FLASH_A[20]
	set_location_assignment PIN_AH7 -to FLASH_A[21]
	set_location_assignment PIN_AM15 -to FLASH_D[0]
	set_location_assignment PIN_AH17 -to FLASH_D[1]
	set_location_assignment PIN_AM14 -to FLASH_D[2]
	set_location_assignment PIN_AJ13 -to FLASH_D[3]
	set_location_assignment PIN_AL12 -to FLASH_D[4]
	set_location_assignment PIN_AJ12 -to FLASH_D[5]
	set_location_assignment PIN_AH11 -to FLASH_D[6]
	set_location_assignment PIN_AJ10 -to FLASH_D[7]
	set_location_assignment PIN_U3 -to LED[0]
	set_location_assignment PIN_T2 -to LED[1]
	set_location_assignment PIN_R1 -to LED[2]
	set_location_assignment PIN_R2 -to LED[3]
	set_location_assignment PIN_P1 -to LED[4]
	set_location_assignment PIN_P2 -to LED[5]
	set_location_assignment PIN_N1 -to LED[6]
	set_location_assignment PIN_N2 -to LED[7]
	set_location_assignment PIN_M1 -to LED[8]
	set_location_assignment PIN_M2 -to LED[9]
	set_location_assignment PIN_L1 -to LED[10]
	set_location_assignment PIN_L2 -to LED[11]
	set_location_assignment PIN_K1 -to LED[12]
	set_location_assignment PIN_K2 -to LED[13]
	set_location_assignment PIN_J1 -to LED[14]
	set_location_assignment PIN_J2 -to LED[15]
	set_location_assignment PIN_H19 -to M88_LED[0]
	set_location_assignment PIN_H13 -to M88_LED[1]
	set_location_assignment PIN_G13 -to M88_LED[2]
	set_location_assignment PIN_F14 -to M88_LED[3]
	set_location_assignment PIN_G15 -to M88_LED[4]
	set_location_assignment PIN_F16 -to M88_LED[5]
	set_location_assignment PIN_G17 -to M88_LED[6]
	set_location_assignment PIN_F18 -to M88_LED[7]
	set_location_assignment PIN_G18 -to M88_LED[8]
	set_location_assignment PIN_F20 -to M88_LED[9]
	set_location_assignment PIN_G19 -to M88_LED[10]
	set_location_assignment PIN_G20 -to M88_LED[11]
	set_location_assignment PIN_N24 -to M88_SW[0]
	set_location_assignment PIN_L24 -to M88_SW[1]
	set_location_assignment PIN_L23 -to M88_SW[2]
	set_location_assignment PIN_H26 -to M88_SW[3]
	set_location_assignment PIN_H25 -to M88_SW[4]
	set_location_assignment PIN_H24 -to M88_SW[5]
	set_location_assignment PIN_M22 -to M88_SW[6]
	set_location_assignment PIN_M21 -to M88_SW[7]
	set_location_assignment PIN_F24 -to PHY_RXD[0]
	set_location_assignment PIN_E11 -to PHY_RXD[1]
	set_location_assignment PIN_E12 -to PHY_RXD[2]
	set_location_assignment PIN_E13 -to PHY_RXD[3]
	set_location_assignment PIN_E14 -to PHY_RXD[4]
	set_location_assignment PIN_E15 -to PHY_RXD[5]
	set_location_assignment PIN_E16 -to PHY_RXD[6]
	set_location_assignment PIN_H17 -to PHY_RXD[7]
	set_location_assignment PIN_G27 -to PHY_TXD[0]
	set_location_assignment PIN_H27 -to PHY_TXD[1]
	set_location_assignment PIN_H23 -to PHY_TXD[2]
	set_location_assignment PIN_G23 -to PHY_TXD[3]
	set_location_assignment PIN_G21 -to PHY_TXD[4]
	set_location_assignment PIN_F21 -to PHY_TXD[5]
	set_location_assignment PIN_D22 -to PHY_TXD[6]
	set_location_assignment PIN_E22 -to PHY_TXD[7]
	set_location_assignment PIN_C16 -to RECEIVED[0]
	set_location_assignment PIN_C17 -to RECEIVED[1]
	set_location_assignment PIN_C18 -to RECEIVED[2]
	set_location_assignment PIN_E20 -to RECEIVED[3]
	set_location_assignment PIN_D17 -to RECEIVED[4]
	set_location_assignment PIN_D18 -to RECEIVED[5]
	set_location_assignment PIN_F19 -to RECEIVED[6]
	set_location_assignment PIN_L22 -to RECEIVED[7]
	set_location_assignment PIN_C12 -to RECEIVED[8]
	set_location_assignment PIN_C13 -to RECEIVED[9]
	set_location_assignment PIN_C14 -to RECEIVED[10]
	set_location_assignment PIN_C15 -to RECEIVED[11]
	set_location_assignment PIN_D13 -to RECEIVED[12]
	set_location_assignment PIN_D14 -to RECEIVED[13]
	set_location_assignment PIN_D15 -to RECEIVED[14]
	set_location_assignment PIN_D16 -to RECEIVED[15]
	set_location_assignment PIN_AP29 -to SW[0]
	set_location_assignment PIN_AN28 -to SW[1]
	set_location_assignment PIN_AP27 -to SW[2]
	set_location_assignment PIN_AP26 -to SW[3]
	set_location_assignment PIN_AN25 -to SW[4]
	set_location_assignment PIN_AN24 -to SW[5]
	set_location_assignment PIN_AN23 -to SW[6]
	set_location_assignment PIN_AM23 -to SW[7]
	set_location_assignment PIN_N3 -to UA_DIN[0]
	set_location_assignment PIN_N4 -to UA_DIN[1]
	set_location_assignment PIN_P4 -to UA_DIN[2]
	set_location_assignment PIN_R4 -to UA_DIN[3]
	set_location_assignment PIN_R3 -to UA_DIN[4]
	set_location_assignment PIN_T4 -to UA_DIN[5]
	set_location_assignment PIN_T3 -to UA_DIN[6]
	set_location_assignment PIN_U4 -to UA_DIN[7]
	set_location_assignment PIN_V4 -to UA_DIN[8]
	set_location_assignment PIN_V3 -to UA_DIN[9]
	set_location_assignment PIN_W7 -to UA_DIN[10]
	set_location_assignment PIN_Y8 -to UA_DIN[11]
	set_location_assignment PIN_AA8 -to UA_DIN[12]
	set_location_assignment PIN_Y7 -to UA_DIN[13]
	set_location_assignment PIN_AA7 -to UA_DIN[14]
	set_location_assignment PIN_AB6 -to UA_DIN[15]
	set_location_assignment PIN_AF5 -to UA_DIN[16]
	set_location_assignment PIN_Y6 -to UA_DIN[17]
	set_location_assignment PIN_AN11 -to UA_ROUT[0]
	set_location_assignment PIN_AM9 -to UA_ROUT[1]
	set_location_assignment PIN_AP8 -to UA_ROUT[2]
	set_location_assignment PIN_AM8 -to UA_ROUT[3]
	set_location_assignment PIN_AM6 -to UA_ROUT[4]
	set_location_assignment PIN_AK5 -to UA_ROUT[5]
	set_location_assignment PIN_AJ5 -to UA_ROUT[6]
	set_location_assignment PIN_AH5 -to UA_ROUT[7]
	set_location_assignment PIN_AD4 -to UA_ROUT[8]
	set_location_assignment PIN_AE3 -to UA_ROUT[9]
	set_location_assignment PIN_AD3 -to UA_ROUT[10]
	set_location_assignment PIN_AD2 -to UA_ROUT[11]
	set_location_assignment PIN_AC4 -to UA_ROUT[12]
	set_location_assignment PIN_AC3 -to UA_ROUT[13]
	set_location_assignment PIN_AB4 -to UA_ROUT[14]
	set_location_assignment PIN_AB3 -to UA_ROUT[15]
	set_location_assignment PIN_M4 -to UA_ROUT[16]
	set_location_assignment PIN_AA3 -to UA_ROUT[17]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_SW[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[11]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[10]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to M88_LED[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_RXD[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[15]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[14]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[13]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[12]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[11]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[10]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to RECEIVED[0]
	set_location_assignment PIN_AP11 -to ATA1_IDE_CS[0]
	set_location_assignment PIN_AB5 -to ATA1_IDE_CS[1]
	set_location_assignment PIN_AU13 -to ATA2_IDE_CS[0]
	set_location_assignment PIN_AT13 -to ATA2_IDE_CS[1]
	set_location_assignment PIN_AP4 -to ATA3_IDE_CS[0]
	set_location_assignment PIN_AN3 -to ATA3_IDE_CS[1]
	set_location_assignment PIN_AP2 -to ATA4_IDE_CS[0]
	set_location_assignment PIN_AP1 -to ATA4_IDE_CS[1]
	set_location_assignment PIN_AW15 -to ATA5_IDE_CS[0]
	set_location_assignment PIN_AV14 -to ATA5_IDE_CS[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to PHY_TXD[7]
	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
