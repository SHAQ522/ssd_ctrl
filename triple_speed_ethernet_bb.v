// Generated by Triple Speed Ethernet 9.0 [Altera, IP Toolbench 1.3.0 Build 132]
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
// ************************************************************
// Copyright (C) 1991-2011 Altera Corporation
// Any megafunction design, and related net list (encrypted or decrypted),
// support information, device programming or simulation file, and any other
// associated documentation or information provided by Altera or a partner
// under Altera's Megafunction Partnership Program may be used only to
// program PLD devices (but not masked PLD devices) from Altera.  Any other
// use of such megafunction design, net list, support information, device
// programming or simulation file, or any other related documentation or
// information is prohibited for any other purpose, including, but not
// limited to modification, reverse engineering, de-compiling, or use with
// any other silicon devices, unless such use is explicitly licensed under
// a separate agreement with Altera or a megafunction partner.  Title to
// the intellectual property, including patents, copyrights, trademarks,
// trade secrets, or maskworks, embodied in any such megafunction design,
// net list, support information, device programming or simulation file, or
// any other related documentation or information provided by Altera or a
// megafunction partner, remains with Altera, the megafunction partner, or
// their respective licensors.  No other licenses, including any licenses
// needed under any third party's intellectual property, are provided herein.

module triple_speed_ethernet (
	ff_tx_data,
	ff_tx_eop,
	ff_tx_err,
	ff_tx_mod,
	ff_tx_sop,
	ff_tx_wren,
	ff_tx_clk,
	ff_rx_rdy,
	ff_rx_clk,
	address,
	read,
	writedata,
	write,
	clk,
	reset,
	gm_rx_d,
	gm_rx_dv,
	gm_rx_err,
	m_rx_d,
	m_rx_en,
	m_rx_err,
	tx_clk,
	rx_clk,
	set_10,
	set_1000,
	mdio_in,
	ff_tx_crc_fwd,
	ff_tx_rdy,
	ff_rx_data,
	ff_rx_dval,
	ff_rx_eop,
	ff_rx_mod,
	ff_rx_sop,
	rx_err,
	readdata,
	waitrequest,
	gm_tx_d,
	gm_tx_en,
	gm_tx_err,
	m_tx_d,
	m_tx_en,
	m_tx_err,
	ena_10,
	eth_mode,
	mdio_out,
	mdio_oen,
	mdc,
	ff_tx_septy,
	tx_ff_uflow,
	ff_tx_a_full,
	ff_tx_a_empty,
	rx_err_stat,
	rx_frm_type,
	ff_rx_dsav,
	ff_rx_a_full,
	ff_rx_a_empty);

	input	[31:0]	ff_tx_data;
	input		ff_tx_eop;
	input		ff_tx_err;
	input	[1:0]	ff_tx_mod;
	input		ff_tx_sop;
	input		ff_tx_wren;
	input		ff_tx_clk;
	input		ff_rx_rdy;
	input		ff_rx_clk;
	input	[7:0]	address;
	input		read;
	input	[31:0]	writedata;
	input		write;
	input		clk;
	input		reset;
	input	[7:0]	gm_rx_d;
	input		gm_rx_dv;
	input		gm_rx_err;
	input	[3:0]	m_rx_d;
	input		m_rx_en;
	input		m_rx_err;
	input		tx_clk;
	input		rx_clk;
	input		set_10;
	input		set_1000;
	input		mdio_in;
	input		ff_tx_crc_fwd;
	output		ff_tx_rdy;
	output	[31:0]	ff_rx_data;
	output		ff_rx_dval;
	output		ff_rx_eop;
	output	[1:0]	ff_rx_mod;
	output		ff_rx_sop;
	output	[5:0]	rx_err;
	output	[31:0]	readdata;
	output		waitrequest;
	output	[7:0]	gm_tx_d;
	output		gm_tx_en;
	output		gm_tx_err;
	output	[3:0]	m_tx_d;
	output		m_tx_en;
	output		m_tx_err;
	output		ena_10;
	output		eth_mode;
	output		mdio_out;
	output		mdio_oen;
	output		mdc;
	output		ff_tx_septy;
	output		tx_ff_uflow;
	output		ff_tx_a_full;
	output		ff_tx_a_empty;
	output	[17:0]	rx_err_stat;
	output	[3:0]	rx_frm_type;
	output		ff_rx_dsav;
	output		ff_rx_a_full;
	output		ff_rx_a_empty;
endmodule
