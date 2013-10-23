// megafunction wizard: %FIFO%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: dcfifo_mixed_widths 

// ============================================================
// File Name: FIFO_OUT_8TO4.v
// Megafunction Name(s):
// 			dcfifo_mixed_widths
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 9.0 Build 132 02/25/2009 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2009 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module FIFO_OUT_8TO4 (
	aclr,
	data,
	rdclk,
	rdreq,
	wrclk,
	wrreq,
	q,
	wrusedw);

	input	  aclr;
	input	[15:0]  data;
	input	  rdclk;
	input	  rdreq;
	input	  wrclk;
	input	  wrreq;
	output	[3:0]  q;
	output	[6:0]  wrusedw;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0	  aclr;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [6:0] sub_wire0;
	wire [3:0] sub_wire1;
	wire [6:0] wrusedw = sub_wire0[6:0];
	wire [3:0] q = sub_wire1[3:0];

	dcfifo_mixed_widths	dcfifo_mixed_widths_component (
				.wrclk (wrclk),
				.rdreq (rdreq),
				.aclr (aclr),
				.rdclk (rdclk),
				.wrreq (wrreq),
				.data (data),
				.wrusedw (sub_wire0),
				.q (sub_wire1)
				// synopsys translate_off
				,
				.rdempty (),
				.rdfull (),
				.rdusedw (),
				.wrempty (),
				.wrfull ()
				// synopsys translate_on
				);
	defparam
		dcfifo_mixed_widths_component.add_usedw_msb_bit = "ON",
		dcfifo_mixed_widths_component.intended_device_family = "Stratix II",
		dcfifo_mixed_widths_component.lpm_hint = "MAXIMIZE_SPEED=5,RAM_BLOCK_TYPE=M4K",
		dcfifo_mixed_widths_component.lpm_numwords = 64,
		dcfifo_mixed_widths_component.lpm_showahead = "ON",
		dcfifo_mixed_widths_component.lpm_type = "dcfifo",
		dcfifo_mixed_widths_component.lpm_width = 16,
		dcfifo_mixed_widths_component.lpm_widthu = 7,
		dcfifo_mixed_widths_component.lpm_widthu_r = 9,
		dcfifo_mixed_widths_component.lpm_width_r = 4,
		dcfifo_mixed_widths_component.overflow_checking = "ON",
		dcfifo_mixed_widths_component.rdsync_delaypipe = 4,
		dcfifo_mixed_widths_component.underflow_checking = "ON",
		dcfifo_mixed_widths_component.use_eab = "ON",
		dcfifo_mixed_widths_component.write_aclr_synch = "OFF",
		dcfifo_mixed_widths_component.wrsync_delaypipe = 4;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: AlmostEmpty NUMERIC "0"
// Retrieval info: PRIVATE: AlmostEmptyThr NUMERIC "-1"
// Retrieval info: PRIVATE: AlmostFull NUMERIC "0"
// Retrieval info: PRIVATE: AlmostFullThr NUMERIC "-1"
// Retrieval info: PRIVATE: CLOCKS_ARE_SYNCHRONIZED NUMERIC "0"
// Retrieval info: PRIVATE: Clock NUMERIC "4"
// Retrieval info: PRIVATE: Depth NUMERIC "64"
// Retrieval info: PRIVATE: Empty NUMERIC "1"
// Retrieval info: PRIVATE: Full NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix II"
// Retrieval info: PRIVATE: LE_BasedFIFO NUMERIC "0"
// Retrieval info: PRIVATE: LegacyRREQ NUMERIC "0"
// Retrieval info: PRIVATE: MAX_DEPTH_BY_9 NUMERIC "0"
// Retrieval info: PRIVATE: OVERFLOW_CHECKING NUMERIC "0"
// Retrieval info: PRIVATE: Optimize NUMERIC "2"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "2"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: UNDERFLOW_CHECKING NUMERIC "0"
// Retrieval info: PRIVATE: UsedW NUMERIC "1"
// Retrieval info: PRIVATE: Width NUMERIC "16"
// Retrieval info: PRIVATE: dc_aclr NUMERIC "1"
// Retrieval info: PRIVATE: diff_widths NUMERIC "1"
// Retrieval info: PRIVATE: msb_usedw NUMERIC "1"
// Retrieval info: PRIVATE: output_width NUMERIC "4"
// Retrieval info: PRIVATE: rsEmpty NUMERIC "0"
// Retrieval info: PRIVATE: rsFull NUMERIC "0"
// Retrieval info: PRIVATE: rsUsedW NUMERIC "0"
// Retrieval info: PRIVATE: sc_aclr NUMERIC "0"
// Retrieval info: PRIVATE: sc_sclr NUMERIC "0"
// Retrieval info: PRIVATE: wsEmpty NUMERIC "0"
// Retrieval info: PRIVATE: wsFull NUMERIC "0"
// Retrieval info: PRIVATE: wsUsedW NUMERIC "1"
// Retrieval info: CONSTANT: ADD_USEDW_MSB_BIT STRING "ON"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix II"
// Retrieval info: CONSTANT: LPM_HINT STRING "MAXIMIZE_SPEED=5,RAM_BLOCK_TYPE=M4K"
// Retrieval info: CONSTANT: LPM_NUMWORDS NUMERIC "64"
// Retrieval info: CONSTANT: LPM_SHOWAHEAD STRING "ON"
// Retrieval info: CONSTANT: LPM_TYPE STRING "dcfifo"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "16"
// Retrieval info: CONSTANT: LPM_WIDTHU NUMERIC "7"
// Retrieval info: CONSTANT: LPM_WIDTHU_R NUMERIC "9"
// Retrieval info: CONSTANT: LPM_WIDTH_R NUMERIC "4"
// Retrieval info: CONSTANT: OVERFLOW_CHECKING STRING "ON"
// Retrieval info: CONSTANT: RDSYNC_DELAYPIPE NUMERIC "4"
// Retrieval info: CONSTANT: UNDERFLOW_CHECKING STRING "ON"
// Retrieval info: CONSTANT: USE_EAB STRING "ON"
// Retrieval info: CONSTANT: WRITE_ACLR_SYNCH STRING "OFF"
// Retrieval info: CONSTANT: WRSYNC_DELAYPIPE NUMERIC "4"
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT GND aclr
// Retrieval info: USED_PORT: data 0 0 16 0 INPUT NODEFVAL data[15..0]
// Retrieval info: USED_PORT: q 0 0 4 0 OUTPUT NODEFVAL q[3..0]
// Retrieval info: USED_PORT: rdclk 0 0 0 0 INPUT NODEFVAL rdclk
// Retrieval info: USED_PORT: rdreq 0 0 0 0 INPUT NODEFVAL rdreq
// Retrieval info: USED_PORT: wrclk 0 0 0 0 INPUT NODEFVAL wrclk
// Retrieval info: USED_PORT: wrreq 0 0 0 0 INPUT NODEFVAL wrreq
// Retrieval info: USED_PORT: wrusedw 0 0 7 0 OUTPUT NODEFVAL wrusedw[6..0]
// Retrieval info: CONNECT: @data 0 0 16 0 data 0 0 16 0
// Retrieval info: CONNECT: q 0 0 4 0 @q 0 0 4 0
// Retrieval info: CONNECT: @wrreq 0 0 0 0 wrreq 0 0 0 0
// Retrieval info: CONNECT: @rdreq 0 0 0 0 rdreq 0 0 0 0
// Retrieval info: CONNECT: @rdclk 0 0 0 0 rdclk 0 0 0 0
// Retrieval info: CONNECT: @wrclk 0 0 0 0 wrclk 0 0 0 0
// Retrieval info: CONNECT: wrusedw 0 0 7 0 @wrusedw 0 0 7 0
// Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4_bb.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4_waveforms.html TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL FIFO_OUT_8TO4_wave*.jpg FALSE
// Retrieval info: LIB_FILE: altera_mf