//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2012 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module SCL_A_s1_arbitrator (
                             // inputs:
                              SCL_A_s1_readdata,
                              clk,
                              cpu_0_data_master_address_to_slave,
                              cpu_0_data_master_read,
                              cpu_0_data_master_waitrequest,
                              cpu_0_data_master_write,
                              cpu_0_data_master_writedata,
                              reset_n,

                             // outputs:
                              SCL_A_s1_address,
                              SCL_A_s1_chipselect,
                              SCL_A_s1_readdata_from_sa,
                              SCL_A_s1_reset_n,
                              SCL_A_s1_write_n,
                              SCL_A_s1_writedata,
                              cpu_0_data_master_granted_SCL_A_s1,
                              cpu_0_data_master_qualified_request_SCL_A_s1,
                              cpu_0_data_master_read_data_valid_SCL_A_s1,
                              cpu_0_data_master_requests_SCL_A_s1,
                              d1_SCL_A_s1_end_xfer
                           )
;

  output  [  1: 0] SCL_A_s1_address;
  output           SCL_A_s1_chipselect;
  output           SCL_A_s1_readdata_from_sa;
  output           SCL_A_s1_reset_n;
  output           SCL_A_s1_write_n;
  output           SCL_A_s1_writedata;
  output           cpu_0_data_master_granted_SCL_A_s1;
  output           cpu_0_data_master_qualified_request_SCL_A_s1;
  output           cpu_0_data_master_read_data_valid_SCL_A_s1;
  output           cpu_0_data_master_requests_SCL_A_s1;
  output           d1_SCL_A_s1_end_xfer;
  input            SCL_A_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] SCL_A_s1_address;
  wire             SCL_A_s1_allgrants;
  wire             SCL_A_s1_allow_new_arb_cycle;
  wire             SCL_A_s1_any_bursting_master_saved_grant;
  wire             SCL_A_s1_any_continuerequest;
  wire             SCL_A_s1_arb_counter_enable;
  reg     [  2: 0] SCL_A_s1_arb_share_counter;
  wire    [  2: 0] SCL_A_s1_arb_share_counter_next_value;
  wire    [  2: 0] SCL_A_s1_arb_share_set_values;
  wire             SCL_A_s1_beginbursttransfer_internal;
  wire             SCL_A_s1_begins_xfer;
  wire             SCL_A_s1_chipselect;
  wire             SCL_A_s1_end_xfer;
  wire             SCL_A_s1_firsttransfer;
  wire             SCL_A_s1_grant_vector;
  wire             SCL_A_s1_in_a_read_cycle;
  wire             SCL_A_s1_in_a_write_cycle;
  wire             SCL_A_s1_master_qreq_vector;
  wire             SCL_A_s1_non_bursting_master_requests;
  wire             SCL_A_s1_readdata_from_sa;
  reg              SCL_A_s1_reg_firsttransfer;
  wire             SCL_A_s1_reset_n;
  reg              SCL_A_s1_slavearbiterlockenable;
  wire             SCL_A_s1_slavearbiterlockenable2;
  wire             SCL_A_s1_unreg_firsttransfer;
  wire             SCL_A_s1_waits_for_read;
  wire             SCL_A_s1_waits_for_write;
  wire             SCL_A_s1_write_n;
  wire             SCL_A_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_SCL_A_s1;
  wire             cpu_0_data_master_qualified_request_SCL_A_s1;
  wire             cpu_0_data_master_read_data_valid_SCL_A_s1;
  wire             cpu_0_data_master_requests_SCL_A_s1;
  wire             cpu_0_data_master_saved_grant_SCL_A_s1;
  reg              d1_SCL_A_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_SCL_A_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_SCL_A_s1_from_cpu_0_data_master;
  wire             wait_for_SCL_A_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~SCL_A_s1_end_xfer;
    end


  assign SCL_A_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_SCL_A_s1));
  //assign SCL_A_s1_readdata_from_sa = SCL_A_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign SCL_A_s1_readdata_from_sa = SCL_A_s1_readdata;

  assign cpu_0_data_master_requests_SCL_A_s1 = ({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h8013040) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //SCL_A_s1_arb_share_counter set values, which is an e_mux
  assign SCL_A_s1_arb_share_set_values = 1;

  //SCL_A_s1_non_bursting_master_requests mux, which is an e_mux
  assign SCL_A_s1_non_bursting_master_requests = cpu_0_data_master_requests_SCL_A_s1;

  //SCL_A_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign SCL_A_s1_any_bursting_master_saved_grant = 0;

  //SCL_A_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign SCL_A_s1_arb_share_counter_next_value = SCL_A_s1_firsttransfer ? (SCL_A_s1_arb_share_set_values - 1) : |SCL_A_s1_arb_share_counter ? (SCL_A_s1_arb_share_counter - 1) : 0;

  //SCL_A_s1_allgrants all slave grants, which is an e_mux
  assign SCL_A_s1_allgrants = |SCL_A_s1_grant_vector;

  //SCL_A_s1_end_xfer assignment, which is an e_assign
  assign SCL_A_s1_end_xfer = ~(SCL_A_s1_waits_for_read | SCL_A_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_SCL_A_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_SCL_A_s1 = SCL_A_s1_end_xfer & (~SCL_A_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //SCL_A_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign SCL_A_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_SCL_A_s1 & SCL_A_s1_allgrants) | (end_xfer_arb_share_counter_term_SCL_A_s1 & ~SCL_A_s1_non_bursting_master_requests);

  //SCL_A_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SCL_A_s1_arb_share_counter <= 0;
      else if (SCL_A_s1_arb_counter_enable)
          SCL_A_s1_arb_share_counter <= SCL_A_s1_arb_share_counter_next_value;
    end


  //SCL_A_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SCL_A_s1_slavearbiterlockenable <= 0;
      else if ((|SCL_A_s1_master_qreq_vector & end_xfer_arb_share_counter_term_SCL_A_s1) | (end_xfer_arb_share_counter_term_SCL_A_s1 & ~SCL_A_s1_non_bursting_master_requests))
          SCL_A_s1_slavearbiterlockenable <= |SCL_A_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master SCL_A/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = SCL_A_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //SCL_A_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign SCL_A_s1_slavearbiterlockenable2 = |SCL_A_s1_arb_share_counter_next_value;

  //cpu_0/data_master SCL_A/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = SCL_A_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //SCL_A_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign SCL_A_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_SCL_A_s1 = cpu_0_data_master_requests_SCL_A_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //SCL_A_s1_writedata mux, which is an e_mux
  assign SCL_A_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_SCL_A_s1 = cpu_0_data_master_qualified_request_SCL_A_s1;

  //cpu_0/data_master saved-grant SCL_A/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_SCL_A_s1 = cpu_0_data_master_requests_SCL_A_s1;

  //allow new arb cycle for SCL_A/s1, which is an e_assign
  assign SCL_A_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign SCL_A_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign SCL_A_s1_master_qreq_vector = 1;

  //SCL_A_s1_reset_n assignment, which is an e_assign
  assign SCL_A_s1_reset_n = reset_n;

  assign SCL_A_s1_chipselect = cpu_0_data_master_granted_SCL_A_s1;
  //SCL_A_s1_firsttransfer first transaction, which is an e_assign
  assign SCL_A_s1_firsttransfer = SCL_A_s1_begins_xfer ? SCL_A_s1_unreg_firsttransfer : SCL_A_s1_reg_firsttransfer;

  //SCL_A_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign SCL_A_s1_unreg_firsttransfer = ~(SCL_A_s1_slavearbiterlockenable & SCL_A_s1_any_continuerequest);

  //SCL_A_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SCL_A_s1_reg_firsttransfer <= 1'b1;
      else if (SCL_A_s1_begins_xfer)
          SCL_A_s1_reg_firsttransfer <= SCL_A_s1_unreg_firsttransfer;
    end


  //SCL_A_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign SCL_A_s1_beginbursttransfer_internal = SCL_A_s1_begins_xfer;

  //~SCL_A_s1_write_n assignment, which is an e_mux
  assign SCL_A_s1_write_n = ~(cpu_0_data_master_granted_SCL_A_s1 & cpu_0_data_master_write);

  assign shifted_address_to_SCL_A_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //SCL_A_s1_address mux, which is an e_mux
  assign SCL_A_s1_address = shifted_address_to_SCL_A_s1_from_cpu_0_data_master >> 2;

  //d1_SCL_A_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_SCL_A_s1_end_xfer <= 1;
      else 
        d1_SCL_A_s1_end_xfer <= SCL_A_s1_end_xfer;
    end


  //SCL_A_s1_waits_for_read in a cycle, which is an e_mux
  assign SCL_A_s1_waits_for_read = SCL_A_s1_in_a_read_cycle & SCL_A_s1_begins_xfer;

  //SCL_A_s1_in_a_read_cycle assignment, which is an e_assign
  assign SCL_A_s1_in_a_read_cycle = cpu_0_data_master_granted_SCL_A_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = SCL_A_s1_in_a_read_cycle;

  //SCL_A_s1_waits_for_write in a cycle, which is an e_mux
  assign SCL_A_s1_waits_for_write = SCL_A_s1_in_a_write_cycle & 0;

  //SCL_A_s1_in_a_write_cycle assignment, which is an e_assign
  assign SCL_A_s1_in_a_write_cycle = cpu_0_data_master_granted_SCL_A_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = SCL_A_s1_in_a_write_cycle;

  assign wait_for_SCL_A_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //SCL_A/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module SCL_B_s1_arbitrator (
                             // inputs:
                              SCL_B_s1_readdata,
                              clk,
                              cpu_0_data_master_address_to_slave,
                              cpu_0_data_master_read,
                              cpu_0_data_master_waitrequest,
                              cpu_0_data_master_write,
                              cpu_0_data_master_writedata,
                              reset_n,

                             // outputs:
                              SCL_B_s1_address,
                              SCL_B_s1_chipselect,
                              SCL_B_s1_readdata_from_sa,
                              SCL_B_s1_reset_n,
                              SCL_B_s1_write_n,
                              SCL_B_s1_writedata,
                              cpu_0_data_master_granted_SCL_B_s1,
                              cpu_0_data_master_qualified_request_SCL_B_s1,
                              cpu_0_data_master_read_data_valid_SCL_B_s1,
                              cpu_0_data_master_requests_SCL_B_s1,
                              d1_SCL_B_s1_end_xfer
                           )
;

  output  [  1: 0] SCL_B_s1_address;
  output           SCL_B_s1_chipselect;
  output           SCL_B_s1_readdata_from_sa;
  output           SCL_B_s1_reset_n;
  output           SCL_B_s1_write_n;
  output           SCL_B_s1_writedata;
  output           cpu_0_data_master_granted_SCL_B_s1;
  output           cpu_0_data_master_qualified_request_SCL_B_s1;
  output           cpu_0_data_master_read_data_valid_SCL_B_s1;
  output           cpu_0_data_master_requests_SCL_B_s1;
  output           d1_SCL_B_s1_end_xfer;
  input            SCL_B_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] SCL_B_s1_address;
  wire             SCL_B_s1_allgrants;
  wire             SCL_B_s1_allow_new_arb_cycle;
  wire             SCL_B_s1_any_bursting_master_saved_grant;
  wire             SCL_B_s1_any_continuerequest;
  wire             SCL_B_s1_arb_counter_enable;
  reg     [  2: 0] SCL_B_s1_arb_share_counter;
  wire    [  2: 0] SCL_B_s1_arb_share_counter_next_value;
  wire    [  2: 0] SCL_B_s1_arb_share_set_values;
  wire             SCL_B_s1_beginbursttransfer_internal;
  wire             SCL_B_s1_begins_xfer;
  wire             SCL_B_s1_chipselect;
  wire             SCL_B_s1_end_xfer;
  wire             SCL_B_s1_firsttransfer;
  wire             SCL_B_s1_grant_vector;
  wire             SCL_B_s1_in_a_read_cycle;
  wire             SCL_B_s1_in_a_write_cycle;
  wire             SCL_B_s1_master_qreq_vector;
  wire             SCL_B_s1_non_bursting_master_requests;
  wire             SCL_B_s1_readdata_from_sa;
  reg              SCL_B_s1_reg_firsttransfer;
  wire             SCL_B_s1_reset_n;
  reg              SCL_B_s1_slavearbiterlockenable;
  wire             SCL_B_s1_slavearbiterlockenable2;
  wire             SCL_B_s1_unreg_firsttransfer;
  wire             SCL_B_s1_waits_for_read;
  wire             SCL_B_s1_waits_for_write;
  wire             SCL_B_s1_write_n;
  wire             SCL_B_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_SCL_B_s1;
  wire             cpu_0_data_master_qualified_request_SCL_B_s1;
  wire             cpu_0_data_master_read_data_valid_SCL_B_s1;
  wire             cpu_0_data_master_requests_SCL_B_s1;
  wire             cpu_0_data_master_saved_grant_SCL_B_s1;
  reg              d1_SCL_B_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_SCL_B_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_SCL_B_s1_from_cpu_0_data_master;
  wire             wait_for_SCL_B_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~SCL_B_s1_end_xfer;
    end


  assign SCL_B_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_SCL_B_s1));
  //assign SCL_B_s1_readdata_from_sa = SCL_B_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign SCL_B_s1_readdata_from_sa = SCL_B_s1_readdata;

  assign cpu_0_data_master_requests_SCL_B_s1 = ({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h8013050) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //SCL_B_s1_arb_share_counter set values, which is an e_mux
  assign SCL_B_s1_arb_share_set_values = 1;

  //SCL_B_s1_non_bursting_master_requests mux, which is an e_mux
  assign SCL_B_s1_non_bursting_master_requests = cpu_0_data_master_requests_SCL_B_s1;

  //SCL_B_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign SCL_B_s1_any_bursting_master_saved_grant = 0;

  //SCL_B_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign SCL_B_s1_arb_share_counter_next_value = SCL_B_s1_firsttransfer ? (SCL_B_s1_arb_share_set_values - 1) : |SCL_B_s1_arb_share_counter ? (SCL_B_s1_arb_share_counter - 1) : 0;

  //SCL_B_s1_allgrants all slave grants, which is an e_mux
  assign SCL_B_s1_allgrants = |SCL_B_s1_grant_vector;

  //SCL_B_s1_end_xfer assignment, which is an e_assign
  assign SCL_B_s1_end_xfer = ~(SCL_B_s1_waits_for_read | SCL_B_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_SCL_B_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_SCL_B_s1 = SCL_B_s1_end_xfer & (~SCL_B_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //SCL_B_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign SCL_B_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_SCL_B_s1 & SCL_B_s1_allgrants) | (end_xfer_arb_share_counter_term_SCL_B_s1 & ~SCL_B_s1_non_bursting_master_requests);

  //SCL_B_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SCL_B_s1_arb_share_counter <= 0;
      else if (SCL_B_s1_arb_counter_enable)
          SCL_B_s1_arb_share_counter <= SCL_B_s1_arb_share_counter_next_value;
    end


  //SCL_B_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SCL_B_s1_slavearbiterlockenable <= 0;
      else if ((|SCL_B_s1_master_qreq_vector & end_xfer_arb_share_counter_term_SCL_B_s1) | (end_xfer_arb_share_counter_term_SCL_B_s1 & ~SCL_B_s1_non_bursting_master_requests))
          SCL_B_s1_slavearbiterlockenable <= |SCL_B_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master SCL_B/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = SCL_B_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //SCL_B_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign SCL_B_s1_slavearbiterlockenable2 = |SCL_B_s1_arb_share_counter_next_value;

  //cpu_0/data_master SCL_B/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = SCL_B_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //SCL_B_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign SCL_B_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_SCL_B_s1 = cpu_0_data_master_requests_SCL_B_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //SCL_B_s1_writedata mux, which is an e_mux
  assign SCL_B_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_SCL_B_s1 = cpu_0_data_master_qualified_request_SCL_B_s1;

  //cpu_0/data_master saved-grant SCL_B/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_SCL_B_s1 = cpu_0_data_master_requests_SCL_B_s1;

  //allow new arb cycle for SCL_B/s1, which is an e_assign
  assign SCL_B_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign SCL_B_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign SCL_B_s1_master_qreq_vector = 1;

  //SCL_B_s1_reset_n assignment, which is an e_assign
  assign SCL_B_s1_reset_n = reset_n;

  assign SCL_B_s1_chipselect = cpu_0_data_master_granted_SCL_B_s1;
  //SCL_B_s1_firsttransfer first transaction, which is an e_assign
  assign SCL_B_s1_firsttransfer = SCL_B_s1_begins_xfer ? SCL_B_s1_unreg_firsttransfer : SCL_B_s1_reg_firsttransfer;

  //SCL_B_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign SCL_B_s1_unreg_firsttransfer = ~(SCL_B_s1_slavearbiterlockenable & SCL_B_s1_any_continuerequest);

  //SCL_B_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SCL_B_s1_reg_firsttransfer <= 1'b1;
      else if (SCL_B_s1_begins_xfer)
          SCL_B_s1_reg_firsttransfer <= SCL_B_s1_unreg_firsttransfer;
    end


  //SCL_B_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign SCL_B_s1_beginbursttransfer_internal = SCL_B_s1_begins_xfer;

  //~SCL_B_s1_write_n assignment, which is an e_mux
  assign SCL_B_s1_write_n = ~(cpu_0_data_master_granted_SCL_B_s1 & cpu_0_data_master_write);

  assign shifted_address_to_SCL_B_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //SCL_B_s1_address mux, which is an e_mux
  assign SCL_B_s1_address = shifted_address_to_SCL_B_s1_from_cpu_0_data_master >> 2;

  //d1_SCL_B_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_SCL_B_s1_end_xfer <= 1;
      else 
        d1_SCL_B_s1_end_xfer <= SCL_B_s1_end_xfer;
    end


  //SCL_B_s1_waits_for_read in a cycle, which is an e_mux
  assign SCL_B_s1_waits_for_read = SCL_B_s1_in_a_read_cycle & SCL_B_s1_begins_xfer;

  //SCL_B_s1_in_a_read_cycle assignment, which is an e_assign
  assign SCL_B_s1_in_a_read_cycle = cpu_0_data_master_granted_SCL_B_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = SCL_B_s1_in_a_read_cycle;

  //SCL_B_s1_waits_for_write in a cycle, which is an e_mux
  assign SCL_B_s1_waits_for_write = SCL_B_s1_in_a_write_cycle & 0;

  //SCL_B_s1_in_a_write_cycle assignment, which is an e_assign
  assign SCL_B_s1_in_a_write_cycle = cpu_0_data_master_granted_SCL_B_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = SCL_B_s1_in_a_write_cycle;

  assign wait_for_SCL_B_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //SCL_B/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module SDA_A_s1_arbitrator (
                             // inputs:
                              SDA_A_s1_readdata,
                              clk,
                              cpu_0_data_master_address_to_slave,
                              cpu_0_data_master_read,
                              cpu_0_data_master_waitrequest,
                              cpu_0_data_master_write,
                              cpu_0_data_master_writedata,
                              reset_n,

                             // outputs:
                              SDA_A_s1_address,
                              SDA_A_s1_chipselect,
                              SDA_A_s1_readdata_from_sa,
                              SDA_A_s1_reset_n,
                              SDA_A_s1_write_n,
                              SDA_A_s1_writedata,
                              cpu_0_data_master_granted_SDA_A_s1,
                              cpu_0_data_master_qualified_request_SDA_A_s1,
                              cpu_0_data_master_read_data_valid_SDA_A_s1,
                              cpu_0_data_master_requests_SDA_A_s1,
                              d1_SDA_A_s1_end_xfer
                           )
;

  output  [  1: 0] SDA_A_s1_address;
  output           SDA_A_s1_chipselect;
  output           SDA_A_s1_readdata_from_sa;
  output           SDA_A_s1_reset_n;
  output           SDA_A_s1_write_n;
  output           SDA_A_s1_writedata;
  output           cpu_0_data_master_granted_SDA_A_s1;
  output           cpu_0_data_master_qualified_request_SDA_A_s1;
  output           cpu_0_data_master_read_data_valid_SDA_A_s1;
  output           cpu_0_data_master_requests_SDA_A_s1;
  output           d1_SDA_A_s1_end_xfer;
  input            SDA_A_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] SDA_A_s1_address;
  wire             SDA_A_s1_allgrants;
  wire             SDA_A_s1_allow_new_arb_cycle;
  wire             SDA_A_s1_any_bursting_master_saved_grant;
  wire             SDA_A_s1_any_continuerequest;
  wire             SDA_A_s1_arb_counter_enable;
  reg     [  2: 0] SDA_A_s1_arb_share_counter;
  wire    [  2: 0] SDA_A_s1_arb_share_counter_next_value;
  wire    [  2: 0] SDA_A_s1_arb_share_set_values;
  wire             SDA_A_s1_beginbursttransfer_internal;
  wire             SDA_A_s1_begins_xfer;
  wire             SDA_A_s1_chipselect;
  wire             SDA_A_s1_end_xfer;
  wire             SDA_A_s1_firsttransfer;
  wire             SDA_A_s1_grant_vector;
  wire             SDA_A_s1_in_a_read_cycle;
  wire             SDA_A_s1_in_a_write_cycle;
  wire             SDA_A_s1_master_qreq_vector;
  wire             SDA_A_s1_non_bursting_master_requests;
  wire             SDA_A_s1_readdata_from_sa;
  reg              SDA_A_s1_reg_firsttransfer;
  wire             SDA_A_s1_reset_n;
  reg              SDA_A_s1_slavearbiterlockenable;
  wire             SDA_A_s1_slavearbiterlockenable2;
  wire             SDA_A_s1_unreg_firsttransfer;
  wire             SDA_A_s1_waits_for_read;
  wire             SDA_A_s1_waits_for_write;
  wire             SDA_A_s1_write_n;
  wire             SDA_A_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_SDA_A_s1;
  wire             cpu_0_data_master_qualified_request_SDA_A_s1;
  wire             cpu_0_data_master_read_data_valid_SDA_A_s1;
  wire             cpu_0_data_master_requests_SDA_A_s1;
  wire             cpu_0_data_master_saved_grant_SDA_A_s1;
  reg              d1_SDA_A_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_SDA_A_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_SDA_A_s1_from_cpu_0_data_master;
  wire             wait_for_SDA_A_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~SDA_A_s1_end_xfer;
    end


  assign SDA_A_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_SDA_A_s1));
  //assign SDA_A_s1_readdata_from_sa = SDA_A_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign SDA_A_s1_readdata_from_sa = SDA_A_s1_readdata;

  assign cpu_0_data_master_requests_SDA_A_s1 = ({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h8013060) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //SDA_A_s1_arb_share_counter set values, which is an e_mux
  assign SDA_A_s1_arb_share_set_values = 1;

  //SDA_A_s1_non_bursting_master_requests mux, which is an e_mux
  assign SDA_A_s1_non_bursting_master_requests = cpu_0_data_master_requests_SDA_A_s1;

  //SDA_A_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign SDA_A_s1_any_bursting_master_saved_grant = 0;

  //SDA_A_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign SDA_A_s1_arb_share_counter_next_value = SDA_A_s1_firsttransfer ? (SDA_A_s1_arb_share_set_values - 1) : |SDA_A_s1_arb_share_counter ? (SDA_A_s1_arb_share_counter - 1) : 0;

  //SDA_A_s1_allgrants all slave grants, which is an e_mux
  assign SDA_A_s1_allgrants = |SDA_A_s1_grant_vector;

  //SDA_A_s1_end_xfer assignment, which is an e_assign
  assign SDA_A_s1_end_xfer = ~(SDA_A_s1_waits_for_read | SDA_A_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_SDA_A_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_SDA_A_s1 = SDA_A_s1_end_xfer & (~SDA_A_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //SDA_A_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign SDA_A_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_SDA_A_s1 & SDA_A_s1_allgrants) | (end_xfer_arb_share_counter_term_SDA_A_s1 & ~SDA_A_s1_non_bursting_master_requests);

  //SDA_A_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SDA_A_s1_arb_share_counter <= 0;
      else if (SDA_A_s1_arb_counter_enable)
          SDA_A_s1_arb_share_counter <= SDA_A_s1_arb_share_counter_next_value;
    end


  //SDA_A_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SDA_A_s1_slavearbiterlockenable <= 0;
      else if ((|SDA_A_s1_master_qreq_vector & end_xfer_arb_share_counter_term_SDA_A_s1) | (end_xfer_arb_share_counter_term_SDA_A_s1 & ~SDA_A_s1_non_bursting_master_requests))
          SDA_A_s1_slavearbiterlockenable <= |SDA_A_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master SDA_A/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = SDA_A_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //SDA_A_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign SDA_A_s1_slavearbiterlockenable2 = |SDA_A_s1_arb_share_counter_next_value;

  //cpu_0/data_master SDA_A/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = SDA_A_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //SDA_A_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign SDA_A_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_SDA_A_s1 = cpu_0_data_master_requests_SDA_A_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //SDA_A_s1_writedata mux, which is an e_mux
  assign SDA_A_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_SDA_A_s1 = cpu_0_data_master_qualified_request_SDA_A_s1;

  //cpu_0/data_master saved-grant SDA_A/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_SDA_A_s1 = cpu_0_data_master_requests_SDA_A_s1;

  //allow new arb cycle for SDA_A/s1, which is an e_assign
  assign SDA_A_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign SDA_A_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign SDA_A_s1_master_qreq_vector = 1;

  //SDA_A_s1_reset_n assignment, which is an e_assign
  assign SDA_A_s1_reset_n = reset_n;

  assign SDA_A_s1_chipselect = cpu_0_data_master_granted_SDA_A_s1;
  //SDA_A_s1_firsttransfer first transaction, which is an e_assign
  assign SDA_A_s1_firsttransfer = SDA_A_s1_begins_xfer ? SDA_A_s1_unreg_firsttransfer : SDA_A_s1_reg_firsttransfer;

  //SDA_A_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign SDA_A_s1_unreg_firsttransfer = ~(SDA_A_s1_slavearbiterlockenable & SDA_A_s1_any_continuerequest);

  //SDA_A_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SDA_A_s1_reg_firsttransfer <= 1'b1;
      else if (SDA_A_s1_begins_xfer)
          SDA_A_s1_reg_firsttransfer <= SDA_A_s1_unreg_firsttransfer;
    end


  //SDA_A_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign SDA_A_s1_beginbursttransfer_internal = SDA_A_s1_begins_xfer;

  //~SDA_A_s1_write_n assignment, which is an e_mux
  assign SDA_A_s1_write_n = ~(cpu_0_data_master_granted_SDA_A_s1 & cpu_0_data_master_write);

  assign shifted_address_to_SDA_A_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //SDA_A_s1_address mux, which is an e_mux
  assign SDA_A_s1_address = shifted_address_to_SDA_A_s1_from_cpu_0_data_master >> 2;

  //d1_SDA_A_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_SDA_A_s1_end_xfer <= 1;
      else 
        d1_SDA_A_s1_end_xfer <= SDA_A_s1_end_xfer;
    end


  //SDA_A_s1_waits_for_read in a cycle, which is an e_mux
  assign SDA_A_s1_waits_for_read = SDA_A_s1_in_a_read_cycle & SDA_A_s1_begins_xfer;

  //SDA_A_s1_in_a_read_cycle assignment, which is an e_assign
  assign SDA_A_s1_in_a_read_cycle = cpu_0_data_master_granted_SDA_A_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = SDA_A_s1_in_a_read_cycle;

  //SDA_A_s1_waits_for_write in a cycle, which is an e_mux
  assign SDA_A_s1_waits_for_write = SDA_A_s1_in_a_write_cycle & 0;

  //SDA_A_s1_in_a_write_cycle assignment, which is an e_assign
  assign SDA_A_s1_in_a_write_cycle = cpu_0_data_master_granted_SDA_A_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = SDA_A_s1_in_a_write_cycle;

  assign wait_for_SDA_A_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //SDA_A/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module SDA_B_s1_arbitrator (
                             // inputs:
                              SDA_B_s1_readdata,
                              clk,
                              cpu_0_data_master_address_to_slave,
                              cpu_0_data_master_read,
                              cpu_0_data_master_waitrequest,
                              cpu_0_data_master_write,
                              cpu_0_data_master_writedata,
                              reset_n,

                             // outputs:
                              SDA_B_s1_address,
                              SDA_B_s1_chipselect,
                              SDA_B_s1_readdata_from_sa,
                              SDA_B_s1_reset_n,
                              SDA_B_s1_write_n,
                              SDA_B_s1_writedata,
                              cpu_0_data_master_granted_SDA_B_s1,
                              cpu_0_data_master_qualified_request_SDA_B_s1,
                              cpu_0_data_master_read_data_valid_SDA_B_s1,
                              cpu_0_data_master_requests_SDA_B_s1,
                              d1_SDA_B_s1_end_xfer
                           )
;

  output  [  1: 0] SDA_B_s1_address;
  output           SDA_B_s1_chipselect;
  output           SDA_B_s1_readdata_from_sa;
  output           SDA_B_s1_reset_n;
  output           SDA_B_s1_write_n;
  output           SDA_B_s1_writedata;
  output           cpu_0_data_master_granted_SDA_B_s1;
  output           cpu_0_data_master_qualified_request_SDA_B_s1;
  output           cpu_0_data_master_read_data_valid_SDA_B_s1;
  output           cpu_0_data_master_requests_SDA_B_s1;
  output           d1_SDA_B_s1_end_xfer;
  input            SDA_B_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] SDA_B_s1_address;
  wire             SDA_B_s1_allgrants;
  wire             SDA_B_s1_allow_new_arb_cycle;
  wire             SDA_B_s1_any_bursting_master_saved_grant;
  wire             SDA_B_s1_any_continuerequest;
  wire             SDA_B_s1_arb_counter_enable;
  reg     [  2: 0] SDA_B_s1_arb_share_counter;
  wire    [  2: 0] SDA_B_s1_arb_share_counter_next_value;
  wire    [  2: 0] SDA_B_s1_arb_share_set_values;
  wire             SDA_B_s1_beginbursttransfer_internal;
  wire             SDA_B_s1_begins_xfer;
  wire             SDA_B_s1_chipselect;
  wire             SDA_B_s1_end_xfer;
  wire             SDA_B_s1_firsttransfer;
  wire             SDA_B_s1_grant_vector;
  wire             SDA_B_s1_in_a_read_cycle;
  wire             SDA_B_s1_in_a_write_cycle;
  wire             SDA_B_s1_master_qreq_vector;
  wire             SDA_B_s1_non_bursting_master_requests;
  wire             SDA_B_s1_readdata_from_sa;
  reg              SDA_B_s1_reg_firsttransfer;
  wire             SDA_B_s1_reset_n;
  reg              SDA_B_s1_slavearbiterlockenable;
  wire             SDA_B_s1_slavearbiterlockenable2;
  wire             SDA_B_s1_unreg_firsttransfer;
  wire             SDA_B_s1_waits_for_read;
  wire             SDA_B_s1_waits_for_write;
  wire             SDA_B_s1_write_n;
  wire             SDA_B_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_SDA_B_s1;
  wire             cpu_0_data_master_qualified_request_SDA_B_s1;
  wire             cpu_0_data_master_read_data_valid_SDA_B_s1;
  wire             cpu_0_data_master_requests_SDA_B_s1;
  wire             cpu_0_data_master_saved_grant_SDA_B_s1;
  reg              d1_SDA_B_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_SDA_B_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_SDA_B_s1_from_cpu_0_data_master;
  wire             wait_for_SDA_B_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~SDA_B_s1_end_xfer;
    end


  assign SDA_B_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_SDA_B_s1));
  //assign SDA_B_s1_readdata_from_sa = SDA_B_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign SDA_B_s1_readdata_from_sa = SDA_B_s1_readdata;

  assign cpu_0_data_master_requests_SDA_B_s1 = ({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h8013070) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //SDA_B_s1_arb_share_counter set values, which is an e_mux
  assign SDA_B_s1_arb_share_set_values = 1;

  //SDA_B_s1_non_bursting_master_requests mux, which is an e_mux
  assign SDA_B_s1_non_bursting_master_requests = cpu_0_data_master_requests_SDA_B_s1;

  //SDA_B_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign SDA_B_s1_any_bursting_master_saved_grant = 0;

  //SDA_B_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign SDA_B_s1_arb_share_counter_next_value = SDA_B_s1_firsttransfer ? (SDA_B_s1_arb_share_set_values - 1) : |SDA_B_s1_arb_share_counter ? (SDA_B_s1_arb_share_counter - 1) : 0;

  //SDA_B_s1_allgrants all slave grants, which is an e_mux
  assign SDA_B_s1_allgrants = |SDA_B_s1_grant_vector;

  //SDA_B_s1_end_xfer assignment, which is an e_assign
  assign SDA_B_s1_end_xfer = ~(SDA_B_s1_waits_for_read | SDA_B_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_SDA_B_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_SDA_B_s1 = SDA_B_s1_end_xfer & (~SDA_B_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //SDA_B_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign SDA_B_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_SDA_B_s1 & SDA_B_s1_allgrants) | (end_xfer_arb_share_counter_term_SDA_B_s1 & ~SDA_B_s1_non_bursting_master_requests);

  //SDA_B_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SDA_B_s1_arb_share_counter <= 0;
      else if (SDA_B_s1_arb_counter_enable)
          SDA_B_s1_arb_share_counter <= SDA_B_s1_arb_share_counter_next_value;
    end


  //SDA_B_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SDA_B_s1_slavearbiterlockenable <= 0;
      else if ((|SDA_B_s1_master_qreq_vector & end_xfer_arb_share_counter_term_SDA_B_s1) | (end_xfer_arb_share_counter_term_SDA_B_s1 & ~SDA_B_s1_non_bursting_master_requests))
          SDA_B_s1_slavearbiterlockenable <= |SDA_B_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master SDA_B/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = SDA_B_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //SDA_B_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign SDA_B_s1_slavearbiterlockenable2 = |SDA_B_s1_arb_share_counter_next_value;

  //cpu_0/data_master SDA_B/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = SDA_B_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //SDA_B_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign SDA_B_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_SDA_B_s1 = cpu_0_data_master_requests_SDA_B_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //SDA_B_s1_writedata mux, which is an e_mux
  assign SDA_B_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_SDA_B_s1 = cpu_0_data_master_qualified_request_SDA_B_s1;

  //cpu_0/data_master saved-grant SDA_B/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_SDA_B_s1 = cpu_0_data_master_requests_SDA_B_s1;

  //allow new arb cycle for SDA_B/s1, which is an e_assign
  assign SDA_B_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign SDA_B_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign SDA_B_s1_master_qreq_vector = 1;

  //SDA_B_s1_reset_n assignment, which is an e_assign
  assign SDA_B_s1_reset_n = reset_n;

  assign SDA_B_s1_chipselect = cpu_0_data_master_granted_SDA_B_s1;
  //SDA_B_s1_firsttransfer first transaction, which is an e_assign
  assign SDA_B_s1_firsttransfer = SDA_B_s1_begins_xfer ? SDA_B_s1_unreg_firsttransfer : SDA_B_s1_reg_firsttransfer;

  //SDA_B_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign SDA_B_s1_unreg_firsttransfer = ~(SDA_B_s1_slavearbiterlockenable & SDA_B_s1_any_continuerequest);

  //SDA_B_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SDA_B_s1_reg_firsttransfer <= 1'b1;
      else if (SDA_B_s1_begins_xfer)
          SDA_B_s1_reg_firsttransfer <= SDA_B_s1_unreg_firsttransfer;
    end


  //SDA_B_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign SDA_B_s1_beginbursttransfer_internal = SDA_B_s1_begins_xfer;

  //~SDA_B_s1_write_n assignment, which is an e_mux
  assign SDA_B_s1_write_n = ~(cpu_0_data_master_granted_SDA_B_s1 & cpu_0_data_master_write);

  assign shifted_address_to_SDA_B_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //SDA_B_s1_address mux, which is an e_mux
  assign SDA_B_s1_address = shifted_address_to_SDA_B_s1_from_cpu_0_data_master >> 2;

  //d1_SDA_B_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_SDA_B_s1_end_xfer <= 1;
      else 
        d1_SDA_B_s1_end_xfer <= SDA_B_s1_end_xfer;
    end


  //SDA_B_s1_waits_for_read in a cycle, which is an e_mux
  assign SDA_B_s1_waits_for_read = SDA_B_s1_in_a_read_cycle & SDA_B_s1_begins_xfer;

  //SDA_B_s1_in_a_read_cycle assignment, which is an e_assign
  assign SDA_B_s1_in_a_read_cycle = cpu_0_data_master_granted_SDA_B_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = SDA_B_s1_in_a_read_cycle;

  //SDA_B_s1_waits_for_write in a cycle, which is an e_mux
  assign SDA_B_s1_waits_for_write = SDA_B_s1_in_a_write_cycle & 0;

  //SDA_B_s1_in_a_write_cycle assignment, which is an e_assign
  assign SDA_B_s1_in_a_write_cycle = cpu_0_data_master_granted_SDA_B_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = SDA_B_s1_in_a_write_cycle;

  assign wait_for_SDA_B_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //SDA_B/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module board_in_s1_arbitrator (
                                // inputs:
                                 board_in_s1_readdata,
                                 clk,
                                 cpu_0_data_master_address_to_slave,
                                 cpu_0_data_master_read,
                                 cpu_0_data_master_write,
                                 reset_n,

                                // outputs:
                                 board_in_s1_address,
                                 board_in_s1_readdata_from_sa,
                                 board_in_s1_reset_n,
                                 cpu_0_data_master_granted_board_in_s1,
                                 cpu_0_data_master_qualified_request_board_in_s1,
                                 cpu_0_data_master_read_data_valid_board_in_s1,
                                 cpu_0_data_master_requests_board_in_s1,
                                 d1_board_in_s1_end_xfer
                              )
;

  output  [  1: 0] board_in_s1_address;
  output  [  7: 0] board_in_s1_readdata_from_sa;
  output           board_in_s1_reset_n;
  output           cpu_0_data_master_granted_board_in_s1;
  output           cpu_0_data_master_qualified_request_board_in_s1;
  output           cpu_0_data_master_read_data_valid_board_in_s1;
  output           cpu_0_data_master_requests_board_in_s1;
  output           d1_board_in_s1_end_xfer;
  input   [  7: 0] board_in_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;

  wire    [  1: 0] board_in_s1_address;
  wire             board_in_s1_allgrants;
  wire             board_in_s1_allow_new_arb_cycle;
  wire             board_in_s1_any_bursting_master_saved_grant;
  wire             board_in_s1_any_continuerequest;
  wire             board_in_s1_arb_counter_enable;
  reg     [  2: 0] board_in_s1_arb_share_counter;
  wire    [  2: 0] board_in_s1_arb_share_counter_next_value;
  wire    [  2: 0] board_in_s1_arb_share_set_values;
  wire             board_in_s1_beginbursttransfer_internal;
  wire             board_in_s1_begins_xfer;
  wire             board_in_s1_end_xfer;
  wire             board_in_s1_firsttransfer;
  wire             board_in_s1_grant_vector;
  wire             board_in_s1_in_a_read_cycle;
  wire             board_in_s1_in_a_write_cycle;
  wire             board_in_s1_master_qreq_vector;
  wire             board_in_s1_non_bursting_master_requests;
  wire    [  7: 0] board_in_s1_readdata_from_sa;
  reg              board_in_s1_reg_firsttransfer;
  wire             board_in_s1_reset_n;
  reg              board_in_s1_slavearbiterlockenable;
  wire             board_in_s1_slavearbiterlockenable2;
  wire             board_in_s1_unreg_firsttransfer;
  wire             board_in_s1_waits_for_read;
  wire             board_in_s1_waits_for_write;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_board_in_s1;
  wire             cpu_0_data_master_qualified_request_board_in_s1;
  wire             cpu_0_data_master_read_data_valid_board_in_s1;
  wire             cpu_0_data_master_requests_board_in_s1;
  wire             cpu_0_data_master_saved_grant_board_in_s1;
  reg              d1_board_in_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_board_in_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_board_in_s1_from_cpu_0_data_master;
  wire             wait_for_board_in_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~board_in_s1_end_xfer;
    end


  assign board_in_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_board_in_s1));
  //assign board_in_s1_readdata_from_sa = board_in_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign board_in_s1_readdata_from_sa = board_in_s1_readdata;

  assign cpu_0_data_master_requests_board_in_s1 = (({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h8013020) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //board_in_s1_arb_share_counter set values, which is an e_mux
  assign board_in_s1_arb_share_set_values = 1;

  //board_in_s1_non_bursting_master_requests mux, which is an e_mux
  assign board_in_s1_non_bursting_master_requests = cpu_0_data_master_requests_board_in_s1;

  //board_in_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign board_in_s1_any_bursting_master_saved_grant = 0;

  //board_in_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign board_in_s1_arb_share_counter_next_value = board_in_s1_firsttransfer ? (board_in_s1_arb_share_set_values - 1) : |board_in_s1_arb_share_counter ? (board_in_s1_arb_share_counter - 1) : 0;

  //board_in_s1_allgrants all slave grants, which is an e_mux
  assign board_in_s1_allgrants = |board_in_s1_grant_vector;

  //board_in_s1_end_xfer assignment, which is an e_assign
  assign board_in_s1_end_xfer = ~(board_in_s1_waits_for_read | board_in_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_board_in_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_board_in_s1 = board_in_s1_end_xfer & (~board_in_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //board_in_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign board_in_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_board_in_s1 & board_in_s1_allgrants) | (end_xfer_arb_share_counter_term_board_in_s1 & ~board_in_s1_non_bursting_master_requests);

  //board_in_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          board_in_s1_arb_share_counter <= 0;
      else if (board_in_s1_arb_counter_enable)
          board_in_s1_arb_share_counter <= board_in_s1_arb_share_counter_next_value;
    end


  //board_in_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          board_in_s1_slavearbiterlockenable <= 0;
      else if ((|board_in_s1_master_qreq_vector & end_xfer_arb_share_counter_term_board_in_s1) | (end_xfer_arb_share_counter_term_board_in_s1 & ~board_in_s1_non_bursting_master_requests))
          board_in_s1_slavearbiterlockenable <= |board_in_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master board_in/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = board_in_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //board_in_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign board_in_s1_slavearbiterlockenable2 = |board_in_s1_arb_share_counter_next_value;

  //cpu_0/data_master board_in/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = board_in_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //board_in_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign board_in_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_board_in_s1 = cpu_0_data_master_requests_board_in_s1;
  //master is always granted when requested
  assign cpu_0_data_master_granted_board_in_s1 = cpu_0_data_master_qualified_request_board_in_s1;

  //cpu_0/data_master saved-grant board_in/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_board_in_s1 = cpu_0_data_master_requests_board_in_s1;

  //allow new arb cycle for board_in/s1, which is an e_assign
  assign board_in_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign board_in_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign board_in_s1_master_qreq_vector = 1;

  //board_in_s1_reset_n assignment, which is an e_assign
  assign board_in_s1_reset_n = reset_n;

  //board_in_s1_firsttransfer first transaction, which is an e_assign
  assign board_in_s1_firsttransfer = board_in_s1_begins_xfer ? board_in_s1_unreg_firsttransfer : board_in_s1_reg_firsttransfer;

  //board_in_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign board_in_s1_unreg_firsttransfer = ~(board_in_s1_slavearbiterlockenable & board_in_s1_any_continuerequest);

  //board_in_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          board_in_s1_reg_firsttransfer <= 1'b1;
      else if (board_in_s1_begins_xfer)
          board_in_s1_reg_firsttransfer <= board_in_s1_unreg_firsttransfer;
    end


  //board_in_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign board_in_s1_beginbursttransfer_internal = board_in_s1_begins_xfer;

  assign shifted_address_to_board_in_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //board_in_s1_address mux, which is an e_mux
  assign board_in_s1_address = shifted_address_to_board_in_s1_from_cpu_0_data_master >> 2;

  //d1_board_in_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_board_in_s1_end_xfer <= 1;
      else 
        d1_board_in_s1_end_xfer <= board_in_s1_end_xfer;
    end


  //board_in_s1_waits_for_read in a cycle, which is an e_mux
  assign board_in_s1_waits_for_read = board_in_s1_in_a_read_cycle & board_in_s1_begins_xfer;

  //board_in_s1_in_a_read_cycle assignment, which is an e_assign
  assign board_in_s1_in_a_read_cycle = cpu_0_data_master_granted_board_in_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = board_in_s1_in_a_read_cycle;

  //board_in_s1_waits_for_write in a cycle, which is an e_mux
  assign board_in_s1_waits_for_write = board_in_s1_in_a_write_cycle & 0;

  //board_in_s1_in_a_write_cycle assignment, which is an e_assign
  assign board_in_s1_in_a_write_cycle = cpu_0_data_master_granted_board_in_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = board_in_s1_in_a_write_cycle;

  assign wait_for_board_in_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //board_in/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module board_out_s1_arbitrator (
                                 // inputs:
                                  board_out_s1_readdata,
                                  clk,
                                  cpu_0_data_master_address_to_slave,
                                  cpu_0_data_master_byteenable,
                                  cpu_0_data_master_read,
                                  cpu_0_data_master_waitrequest,
                                  cpu_0_data_master_write,
                                  cpu_0_data_master_writedata,
                                  reset_n,

                                 // outputs:
                                  board_out_s1_address,
                                  board_out_s1_chipselect,
                                  board_out_s1_readdata_from_sa,
                                  board_out_s1_reset_n,
                                  board_out_s1_write_n,
                                  board_out_s1_writedata,
                                  cpu_0_data_master_granted_board_out_s1,
                                  cpu_0_data_master_qualified_request_board_out_s1,
                                  cpu_0_data_master_read_data_valid_board_out_s1,
                                  cpu_0_data_master_requests_board_out_s1,
                                  d1_board_out_s1_end_xfer
                               )
;

  output  [  1: 0] board_out_s1_address;
  output           board_out_s1_chipselect;
  output  [  7: 0] board_out_s1_readdata_from_sa;
  output           board_out_s1_reset_n;
  output           board_out_s1_write_n;
  output  [  7: 0] board_out_s1_writedata;
  output           cpu_0_data_master_granted_board_out_s1;
  output           cpu_0_data_master_qualified_request_board_out_s1;
  output           cpu_0_data_master_read_data_valid_board_out_s1;
  output           cpu_0_data_master_requests_board_out_s1;
  output           d1_board_out_s1_end_xfer;
  input   [  7: 0] board_out_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] board_out_s1_address;
  wire             board_out_s1_allgrants;
  wire             board_out_s1_allow_new_arb_cycle;
  wire             board_out_s1_any_bursting_master_saved_grant;
  wire             board_out_s1_any_continuerequest;
  wire             board_out_s1_arb_counter_enable;
  reg     [  2: 0] board_out_s1_arb_share_counter;
  wire    [  2: 0] board_out_s1_arb_share_counter_next_value;
  wire    [  2: 0] board_out_s1_arb_share_set_values;
  wire             board_out_s1_beginbursttransfer_internal;
  wire             board_out_s1_begins_xfer;
  wire             board_out_s1_chipselect;
  wire             board_out_s1_end_xfer;
  wire             board_out_s1_firsttransfer;
  wire             board_out_s1_grant_vector;
  wire             board_out_s1_in_a_read_cycle;
  wire             board_out_s1_in_a_write_cycle;
  wire             board_out_s1_master_qreq_vector;
  wire             board_out_s1_non_bursting_master_requests;
  wire             board_out_s1_pretend_byte_enable;
  wire    [  7: 0] board_out_s1_readdata_from_sa;
  reg              board_out_s1_reg_firsttransfer;
  wire             board_out_s1_reset_n;
  reg              board_out_s1_slavearbiterlockenable;
  wire             board_out_s1_slavearbiterlockenable2;
  wire             board_out_s1_unreg_firsttransfer;
  wire             board_out_s1_waits_for_read;
  wire             board_out_s1_waits_for_write;
  wire             board_out_s1_write_n;
  wire    [  7: 0] board_out_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_board_out_s1;
  wire             cpu_0_data_master_qualified_request_board_out_s1;
  wire             cpu_0_data_master_read_data_valid_board_out_s1;
  wire             cpu_0_data_master_requests_board_out_s1;
  wire             cpu_0_data_master_saved_grant_board_out_s1;
  reg              d1_board_out_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_board_out_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_board_out_s1_from_cpu_0_data_master;
  wire             wait_for_board_out_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~board_out_s1_end_xfer;
    end


  assign board_out_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_board_out_s1));
  //assign board_out_s1_readdata_from_sa = board_out_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign board_out_s1_readdata_from_sa = board_out_s1_readdata;

  assign cpu_0_data_master_requests_board_out_s1 = ({cpu_0_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h8013030) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //board_out_s1_arb_share_counter set values, which is an e_mux
  assign board_out_s1_arb_share_set_values = 1;

  //board_out_s1_non_bursting_master_requests mux, which is an e_mux
  assign board_out_s1_non_bursting_master_requests = cpu_0_data_master_requests_board_out_s1;

  //board_out_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign board_out_s1_any_bursting_master_saved_grant = 0;

  //board_out_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign board_out_s1_arb_share_counter_next_value = board_out_s1_firsttransfer ? (board_out_s1_arb_share_set_values - 1) : |board_out_s1_arb_share_counter ? (board_out_s1_arb_share_counter - 1) : 0;

  //board_out_s1_allgrants all slave grants, which is an e_mux
  assign board_out_s1_allgrants = |board_out_s1_grant_vector;

  //board_out_s1_end_xfer assignment, which is an e_assign
  assign board_out_s1_end_xfer = ~(board_out_s1_waits_for_read | board_out_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_board_out_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_board_out_s1 = board_out_s1_end_xfer & (~board_out_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //board_out_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign board_out_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_board_out_s1 & board_out_s1_allgrants) | (end_xfer_arb_share_counter_term_board_out_s1 & ~board_out_s1_non_bursting_master_requests);

  //board_out_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          board_out_s1_arb_share_counter <= 0;
      else if (board_out_s1_arb_counter_enable)
          board_out_s1_arb_share_counter <= board_out_s1_arb_share_counter_next_value;
    end


  //board_out_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          board_out_s1_slavearbiterlockenable <= 0;
      else if ((|board_out_s1_master_qreq_vector & end_xfer_arb_share_counter_term_board_out_s1) | (end_xfer_arb_share_counter_term_board_out_s1 & ~board_out_s1_non_bursting_master_requests))
          board_out_s1_slavearbiterlockenable <= |board_out_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master board_out/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = board_out_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //board_out_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign board_out_s1_slavearbiterlockenable2 = |board_out_s1_arb_share_counter_next_value;

  //cpu_0/data_master board_out/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = board_out_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //board_out_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign board_out_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_board_out_s1 = cpu_0_data_master_requests_board_out_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //board_out_s1_writedata mux, which is an e_mux
  assign board_out_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_board_out_s1 = cpu_0_data_master_qualified_request_board_out_s1;

  //cpu_0/data_master saved-grant board_out/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_board_out_s1 = cpu_0_data_master_requests_board_out_s1;

  //allow new arb cycle for board_out/s1, which is an e_assign
  assign board_out_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign board_out_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign board_out_s1_master_qreq_vector = 1;

  //board_out_s1_reset_n assignment, which is an e_assign
  assign board_out_s1_reset_n = reset_n;

  assign board_out_s1_chipselect = cpu_0_data_master_granted_board_out_s1;
  //board_out_s1_firsttransfer first transaction, which is an e_assign
  assign board_out_s1_firsttransfer = board_out_s1_begins_xfer ? board_out_s1_unreg_firsttransfer : board_out_s1_reg_firsttransfer;

  //board_out_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign board_out_s1_unreg_firsttransfer = ~(board_out_s1_slavearbiterlockenable & board_out_s1_any_continuerequest);

  //board_out_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          board_out_s1_reg_firsttransfer <= 1'b1;
      else if (board_out_s1_begins_xfer)
          board_out_s1_reg_firsttransfer <= board_out_s1_unreg_firsttransfer;
    end


  //board_out_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign board_out_s1_beginbursttransfer_internal = board_out_s1_begins_xfer;

  //~board_out_s1_write_n assignment, which is an e_mux
  assign board_out_s1_write_n = ~(((cpu_0_data_master_granted_board_out_s1 & cpu_0_data_master_write)) & board_out_s1_pretend_byte_enable);

  assign shifted_address_to_board_out_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //board_out_s1_address mux, which is an e_mux
  assign board_out_s1_address = shifted_address_to_board_out_s1_from_cpu_0_data_master >> 2;

  //d1_board_out_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_board_out_s1_end_xfer <= 1;
      else 
        d1_board_out_s1_end_xfer <= board_out_s1_end_xfer;
    end


  //board_out_s1_waits_for_read in a cycle, which is an e_mux
  assign board_out_s1_waits_for_read = board_out_s1_in_a_read_cycle & board_out_s1_begins_xfer;

  //board_out_s1_in_a_read_cycle assignment, which is an e_assign
  assign board_out_s1_in_a_read_cycle = cpu_0_data_master_granted_board_out_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = board_out_s1_in_a_read_cycle;

  //board_out_s1_waits_for_write in a cycle, which is an e_mux
  assign board_out_s1_waits_for_write = board_out_s1_in_a_write_cycle & 0;

  //board_out_s1_in_a_write_cycle assignment, which is an e_assign
  assign board_out_s1_in_a_write_cycle = cpu_0_data_master_granted_board_out_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = board_out_s1_in_a_write_cycle;

  assign wait_for_board_out_s1_counter = 0;
  //board_out_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign board_out_s1_pretend_byte_enable = (cpu_0_data_master_granted_board_out_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //board_out/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_jtag_debug_module_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_byteenable,
                                             cpu_0_data_master_debugaccess,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_waitrequest,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             cpu_0_instruction_master_address_to_slave,
                                             cpu_0_instruction_master_latency_counter,
                                             cpu_0_instruction_master_read,
                                             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                             cpu_0_jtag_debug_module_readdata,
                                             cpu_0_jtag_debug_module_resetrequest,
                                             reset_n,

                                            // outputs:
                                             cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_jtag_debug_module_address,
                                             cpu_0_jtag_debug_module_begintransfer,
                                             cpu_0_jtag_debug_module_byteenable,
                                             cpu_0_jtag_debug_module_chipselect,
                                             cpu_0_jtag_debug_module_debugaccess,
                                             cpu_0_jtag_debug_module_readdata_from_sa,
                                             cpu_0_jtag_debug_module_reset,
                                             cpu_0_jtag_debug_module_reset_n,
                                             cpu_0_jtag_debug_module_resetrequest_from_sa,
                                             cpu_0_jtag_debug_module_write,
                                             cpu_0_jtag_debug_module_writedata,
                                             d1_cpu_0_jtag_debug_module_end_xfer
                                          )
;

  output           cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  output  [  8: 0] cpu_0_jtag_debug_module_address;
  output           cpu_0_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_0_jtag_debug_module_byteenable;
  output           cpu_0_jtag_debug_module_chipselect;
  output           cpu_0_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  output           cpu_0_jtag_debug_module_reset;
  output           cpu_0_jtag_debug_module_reset_n;
  output           cpu_0_jtag_debug_module_resetrequest_from_sa;
  output           cpu_0_jtag_debug_module_write;
  output  [ 31: 0] cpu_0_jtag_debug_module_writedata;
  output           d1_cpu_0_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_debugaccess;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 27: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata;
  input            cpu_0_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_allgrants;
  wire             cpu_0_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_0_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_0_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_addend;
  wire             cpu_0_jtag_debug_module_arb_counter_enable;
  reg     [  2: 0] cpu_0_jtag_debug_module_arb_share_counter;
  wire    [  2: 0] cpu_0_jtag_debug_module_arb_share_counter_next_value;
  wire    [  2: 0] cpu_0_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_winner;
  wire             cpu_0_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_0_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_0_jtag_debug_module_begins_xfer;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_0_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_0_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire             cpu_0_jtag_debug_module_end_xfer;
  wire             cpu_0_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_0_jtag_debug_module_grant_vector;
  wire             cpu_0_jtag_debug_module_in_a_read_cycle;
  wire             cpu_0_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_0_jtag_debug_module_master_qreq_vector;
  wire             cpu_0_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  reg              cpu_0_jtag_debug_module_reg_firsttransfer;
  wire             cpu_0_jtag_debug_module_reset;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_0_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_0_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_0_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_0_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_0_jtag_debug_module_waits_for_read;
  wire             cpu_0_jtag_debug_module_waits_for_write;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  reg              d1_cpu_0_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
  wire    [ 27: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master;
  wire    [ 27: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master;
  wire             wait_for_cpu_0_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_0_jtag_debug_module_end_xfer;
    end


  assign cpu_0_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  //assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata;

  assign cpu_0_data_master_requests_cpu_0_jtag_debug_module = ({cpu_0_data_master_address_to_slave[27 : 11] , 11'b0} == 28'h8011000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_0_jtag_debug_module_arb_share_set_values = 1;

  //cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_0_jtag_debug_module_non_bursting_master_requests = cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module |
    cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_0_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_share_counter_next_value = cpu_0_jtag_debug_module_firsttransfer ? (cpu_0_jtag_debug_module_arb_share_set_values - 1) : |cpu_0_jtag_debug_module_arb_share_counter ? (cpu_0_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_0_jtag_debug_module_allgrants = (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector);

  //cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_end_xfer = ~(cpu_0_jtag_debug_module_waits_for_read | cpu_0_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_end_xfer & (~cpu_0_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & cpu_0_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests);

  //cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_0_jtag_debug_module_arb_counter_enable)
          cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_0_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests))
          cpu_0_jtag_debug_module_slavearbiterlockenable <= |cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_0_jtag_debug_module_slavearbiterlockenable2 = |cpu_0_jtag_debug_module_arb_share_counter_next_value;

  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_0_jtag_debug_module_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_data_master_requests_cpu_0_jtag_debug_module & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_0_jtag_debug_module_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_cpu_0_jtag_debug_module = (({cpu_0_instruction_master_address_to_slave[27 : 11] , 11'b0} == 28'h8011000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  assign cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_instruction_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0) | (|cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))) | cpu_0_data_master_arbiterlock);
  //local readdatavalid cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[0];

  //cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[0] && cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[1] = cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[1];

  //cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[1] && cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_double_vector = {cpu_0_jtag_debug_module_master_qreq_vector, cpu_0_jtag_debug_module_master_qreq_vector} & ({~cpu_0_jtag_debug_module_master_qreq_vector, ~cpu_0_jtag_debug_module_master_qreq_vector} + cpu_0_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_0_jtag_debug_module_arb_winner = (cpu_0_jtag_debug_module_allow_new_arb_cycle & | cpu_0_jtag_debug_module_grant_vector) ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_0_jtag_debug_module_allow_new_arb_cycle)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= |cpu_0_jtag_debug_module_grant_vector ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_0_jtag_debug_module_grant_vector = {(cpu_0_jtag_debug_module_chosen_master_double_vector[1] | cpu_0_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_0_jtag_debug_module_chosen_master_double_vector[0] | cpu_0_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_rot_left = (cpu_0_jtag_debug_module_arb_winner << 1) ? (cpu_0_jtag_debug_module_arb_winner << 1) : 1;

  //cpu_0/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_0_jtag_debug_module_grant_vector)
          cpu_0_jtag_debug_module_arb_addend <= cpu_0_jtag_debug_module_end_xfer? cpu_0_jtag_debug_module_chosen_master_rot_left : cpu_0_jtag_debug_module_grant_vector;
    end


  assign cpu_0_jtag_debug_module_begintransfer = cpu_0_jtag_debug_module_begins_xfer;
  //assign lhs ~cpu_0_jtag_debug_module_reset of type reset_n to cpu_0_jtag_debug_module_reset_n, which is an e_assign
  assign cpu_0_jtag_debug_module_reset = ~cpu_0_jtag_debug_module_reset_n;

  //cpu_0_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_reset_n = reset_n;

  //assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest;

  assign cpu_0_jtag_debug_module_chipselect = cpu_0_data_master_granted_cpu_0_jtag_debug_module | cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  //cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_firsttransfer = cpu_0_jtag_debug_module_begins_xfer ? cpu_0_jtag_debug_module_unreg_firsttransfer : cpu_0_jtag_debug_module_reg_firsttransfer;

  //cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_unreg_firsttransfer = ~(cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_jtag_debug_module_any_continuerequest);

  //cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_0_jtag_debug_module_begins_xfer)
          cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_0_jtag_debug_module_beginbursttransfer_internal = cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_0_jtag_debug_module_arbitration_holdoff_internal = cpu_0_jtag_debug_module_begins_xfer & cpu_0_jtag_debug_module_firsttransfer;

  //cpu_0_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_0_jtag_debug_module_write = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpu_0_jtag_debug_module_address mux, which is an e_mux
  assign cpu_0_jtag_debug_module_address = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master >> 2) :
    (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_0_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end


  //cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_read = cpu_0_jtag_debug_module_in_a_read_cycle & cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_read_cycle = (cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_0_jtag_debug_module_in_a_read_cycle;

  //cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_write = cpu_0_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_write_cycle = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_0_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_0_jtag_debug_module_counter = 0;
  //cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_0_jtag_debug_module_byteenable = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_0_jtag_debug_module_debugaccess = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_cpu_0_jtag_debug_module + cpu_0_instruction_master_granted_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module + cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_data_master_arbitrator (
                                      // inputs:
                                       SCL_A_s1_readdata_from_sa,
                                       SCL_B_s1_readdata_from_sa,
                                       SDA_A_s1_readdata_from_sa,
                                       SDA_B_s1_readdata_from_sa,
                                       board_in_s1_readdata_from_sa,
                                       board_out_s1_readdata_from_sa,
                                       clk,
                                       cpu_0_data_master_address,
                                       cpu_0_data_master_byteenable_sdram_0_s1,
                                       cpu_0_data_master_byteenable_udpram_in_avs,
                                       cpu_0_data_master_granted_SCL_A_s1,
                                       cpu_0_data_master_granted_SCL_B_s1,
                                       cpu_0_data_master_granted_SDA_A_s1,
                                       cpu_0_data_master_granted_SDA_B_s1,
                                       cpu_0_data_master_granted_board_in_s1,
                                       cpu_0_data_master_granted_board_out_s1,
                                       cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port,
                                       cpu_0_data_master_granted_export_in_avs,
                                       cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_granted_load_para_in_avs,
                                       cpu_0_data_master_granted_sdram_0_s1,
                                       cpu_0_data_master_granted_sysid_control_slave,
                                       cpu_0_data_master_granted_udpram_in_avs,
                                       cpu_0_data_master_granted_watch_dog_s1,
                                       cpu_0_data_master_qualified_request_SCL_A_s1,
                                       cpu_0_data_master_qualified_request_SCL_B_s1,
                                       cpu_0_data_master_qualified_request_SDA_A_s1,
                                       cpu_0_data_master_qualified_request_SDA_B_s1,
                                       cpu_0_data_master_qualified_request_board_in_s1,
                                       cpu_0_data_master_qualified_request_board_out_s1,
                                       cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
                                       cpu_0_data_master_qualified_request_export_in_avs,
                                       cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_qualified_request_load_para_in_avs,
                                       cpu_0_data_master_qualified_request_sdram_0_s1,
                                       cpu_0_data_master_qualified_request_sysid_control_slave,
                                       cpu_0_data_master_qualified_request_udpram_in_avs,
                                       cpu_0_data_master_qualified_request_watch_dog_s1,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_read_data_valid_SCL_A_s1,
                                       cpu_0_data_master_read_data_valid_SCL_B_s1,
                                       cpu_0_data_master_read_data_valid_SDA_A_s1,
                                       cpu_0_data_master_read_data_valid_SDA_B_s1,
                                       cpu_0_data_master_read_data_valid_board_in_s1,
                                       cpu_0_data_master_read_data_valid_board_out_s1,
                                       cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
                                       cpu_0_data_master_read_data_valid_export_in_avs,
                                       cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_read_data_valid_load_para_in_avs,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                       cpu_0_data_master_read_data_valid_sysid_control_slave,
                                       cpu_0_data_master_read_data_valid_udpram_in_avs,
                                       cpu_0_data_master_read_data_valid_watch_dog_s1,
                                       cpu_0_data_master_requests_SCL_A_s1,
                                       cpu_0_data_master_requests_SCL_B_s1,
                                       cpu_0_data_master_requests_SDA_A_s1,
                                       cpu_0_data_master_requests_SDA_B_s1,
                                       cpu_0_data_master_requests_board_in_s1,
                                       cpu_0_data_master_requests_board_out_s1,
                                       cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port,
                                       cpu_0_data_master_requests_export_in_avs,
                                       cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_requests_load_para_in_avs,
                                       cpu_0_data_master_requests_sdram_0_s1,
                                       cpu_0_data_master_requests_sysid_control_slave,
                                       cpu_0_data_master_requests_udpram_in_avs,
                                       cpu_0_data_master_requests_watch_dog_s1,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       cpu_0_jtag_debug_module_readdata_from_sa,
                                       d1_SCL_A_s1_end_xfer,
                                       d1_SCL_B_s1_end_xfer,
                                       d1_SDA_A_s1_end_xfer,
                                       d1_SDA_B_s1_end_xfer,
                                       d1_board_in_s1_end_xfer,
                                       d1_board_out_s1_end_xfer,
                                       d1_cpu_0_jtag_debug_module_end_xfer,
                                       d1_epcs_flash_controller_0_epcs_control_port_end_xfer,
                                       d1_export_in_avs_end_xfer,
                                       d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                       d1_load_para_in_avs_end_xfer,
                                       d1_sdram_0_s1_end_xfer,
                                       d1_sysid_control_slave_end_xfer,
                                       d1_udpram_in_avs_end_xfer,
                                       d1_watch_dog_s1_end_xfer,
                                       epcs_flash_controller_0_epcs_control_port_irq_from_sa,
                                       epcs_flash_controller_0_epcs_control_port_readdata_from_sa,
                                       export_in_avs_readdata_from_sa,
                                       export_in_avs_wait_counter_eq_0,
                                       jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                       load_para_in_avs_readdata_from_sa,
                                       load_para_in_avs_wait_counter_eq_0,
                                       registered_cpu_0_data_master_read_data_valid_udpram_in_avs,
                                       reset_n,
                                       sdram_0_s1_readdata_from_sa,
                                       sdram_0_s1_waitrequest_from_sa,
                                       sysid_control_slave_readdata_from_sa,
                                       udpram_in_avs_readdata_from_sa,
                                       watch_dog_s1_irq_from_sa,
                                       watch_dog_s1_readdata_from_sa,

                                      // outputs:
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_dbs_address,
                                       cpu_0_data_master_dbs_write_16,
                                       cpu_0_data_master_dbs_write_8,
                                       cpu_0_data_master_irq,
                                       cpu_0_data_master_no_byte_enables_and_last_term,
                                       cpu_0_data_master_readdata,
                                       cpu_0_data_master_waitrequest
                                    )
;

  output  [ 27: 0] cpu_0_data_master_address_to_slave;
  output  [  1: 0] cpu_0_data_master_dbs_address;
  output  [ 15: 0] cpu_0_data_master_dbs_write_16;
  output  [  7: 0] cpu_0_data_master_dbs_write_8;
  output  [ 31: 0] cpu_0_data_master_irq;
  output           cpu_0_data_master_no_byte_enables_and_last_term;
  output  [ 31: 0] cpu_0_data_master_readdata;
  output           cpu_0_data_master_waitrequest;
  input            SCL_A_s1_readdata_from_sa;
  input            SCL_B_s1_readdata_from_sa;
  input            SDA_A_s1_readdata_from_sa;
  input            SDA_B_s1_readdata_from_sa;
  input   [  7: 0] board_in_s1_readdata_from_sa;
  input   [  7: 0] board_out_s1_readdata_from_sa;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address;
  input   [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  input            cpu_0_data_master_byteenable_udpram_in_avs;
  input            cpu_0_data_master_granted_SCL_A_s1;
  input            cpu_0_data_master_granted_SCL_B_s1;
  input            cpu_0_data_master_granted_SDA_A_s1;
  input            cpu_0_data_master_granted_SDA_B_s1;
  input            cpu_0_data_master_granted_board_in_s1;
  input            cpu_0_data_master_granted_board_out_s1;
  input            cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_data_master_granted_export_in_avs;
  input            cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_granted_load_para_in_avs;
  input            cpu_0_data_master_granted_sdram_0_s1;
  input            cpu_0_data_master_granted_sysid_control_slave;
  input            cpu_0_data_master_granted_udpram_in_avs;
  input            cpu_0_data_master_granted_watch_dog_s1;
  input            cpu_0_data_master_qualified_request_SCL_A_s1;
  input            cpu_0_data_master_qualified_request_SCL_B_s1;
  input            cpu_0_data_master_qualified_request_SDA_A_s1;
  input            cpu_0_data_master_qualified_request_SDA_B_s1;
  input            cpu_0_data_master_qualified_request_board_in_s1;
  input            cpu_0_data_master_qualified_request_board_out_s1;
  input            cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_data_master_qualified_request_export_in_avs;
  input            cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_qualified_request_load_para_in_avs;
  input            cpu_0_data_master_qualified_request_sdram_0_s1;
  input            cpu_0_data_master_qualified_request_sysid_control_slave;
  input            cpu_0_data_master_qualified_request_udpram_in_avs;
  input            cpu_0_data_master_qualified_request_watch_dog_s1;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_read_data_valid_SCL_A_s1;
  input            cpu_0_data_master_read_data_valid_SCL_B_s1;
  input            cpu_0_data_master_read_data_valid_SDA_A_s1;
  input            cpu_0_data_master_read_data_valid_SDA_B_s1;
  input            cpu_0_data_master_read_data_valid_board_in_s1;
  input            cpu_0_data_master_read_data_valid_board_out_s1;
  input            cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_data_master_read_data_valid_export_in_avs;
  input            cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_read_data_valid_load_para_in_avs;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_data_master_read_data_valid_sysid_control_slave;
  input            cpu_0_data_master_read_data_valid_udpram_in_avs;
  input            cpu_0_data_master_read_data_valid_watch_dog_s1;
  input            cpu_0_data_master_requests_SCL_A_s1;
  input            cpu_0_data_master_requests_SCL_B_s1;
  input            cpu_0_data_master_requests_SDA_A_s1;
  input            cpu_0_data_master_requests_SDA_B_s1;
  input            cpu_0_data_master_requests_board_in_s1;
  input            cpu_0_data_master_requests_board_out_s1;
  input            cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_data_master_requests_export_in_avs;
  input            cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_requests_load_para_in_avs;
  input            cpu_0_data_master_requests_sdram_0_s1;
  input            cpu_0_data_master_requests_sysid_control_slave;
  input            cpu_0_data_master_requests_udpram_in_avs;
  input            cpu_0_data_master_requests_watch_dog_s1;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_SCL_A_s1_end_xfer;
  input            d1_SCL_B_s1_end_xfer;
  input            d1_SDA_A_s1_end_xfer;
  input            d1_SDA_B_s1_end_xfer;
  input            d1_board_in_s1_end_xfer;
  input            d1_board_out_s1_end_xfer;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_epcs_flash_controller_0_epcs_control_port_end_xfer;
  input            d1_export_in_avs_end_xfer;
  input            d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  input            d1_load_para_in_avs_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            d1_udpram_in_avs_end_xfer;
  input            d1_watch_dog_s1_end_xfer;
  input            epcs_flash_controller_0_epcs_control_port_irq_from_sa;
  input   [ 31: 0] epcs_flash_controller_0_epcs_control_port_readdata_from_sa;
  input   [ 31: 0] export_in_avs_readdata_from_sa;
  input            export_in_avs_wait_counter_eq_0;
  input            jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  input   [ 31: 0] load_para_in_avs_readdata_from_sa;
  input            load_para_in_avs_wait_counter_eq_0;
  input            registered_cpu_0_data_master_read_data_valid_udpram_in_avs;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;
  input   [  7: 0] udpram_in_avs_readdata_from_sa;
  input            watch_dog_s1_irq_from_sa;
  input   [ 15: 0] watch_dog_s1_readdata_from_sa;

  wire    [ 27: 0] cpu_0_data_master_address_to_slave;
  reg     [  1: 0] cpu_0_data_master_dbs_address;
  wire    [  1: 0] cpu_0_data_master_dbs_increment;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire    [  7: 0] cpu_0_data_master_dbs_write_8;
  wire    [ 31: 0] cpu_0_data_master_irq;
  reg              cpu_0_data_master_no_byte_enables_and_last_term;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_run;
  reg              cpu_0_data_master_waitrequest;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  reg     [  7: 0] dbs_8_reg_segment_0;
  reg     [  7: 0] dbs_8_reg_segment_1;
  reg     [  7: 0] dbs_8_reg_segment_2;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             last_dbs_term_and_run;
  wire    [  1: 0] next_dbs_address;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire    [  7: 0] p1_dbs_8_reg_segment_0;
  wire    [  7: 0] p1_dbs_8_reg_segment_1;
  wire    [  7: 0] p1_dbs_8_reg_segment_2;
  wire    [ 31: 0] p1_registered_cpu_0_data_master_readdata;
  wire             pre_dbs_count_enable;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  reg     [ 31: 0] registered_cpu_0_data_master_readdata;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_data_master_qualified_request_SCL_A_s1 | ~cpu_0_data_master_requests_SCL_A_s1) & ((~cpu_0_data_master_qualified_request_SCL_A_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_SCL_A_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_SCL_B_s1 | ~cpu_0_data_master_requests_SCL_B_s1) & ((~cpu_0_data_master_qualified_request_SCL_B_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_SCL_B_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_SDA_A_s1 | ~cpu_0_data_master_requests_SDA_A_s1) & ((~cpu_0_data_master_qualified_request_SDA_A_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_SDA_A_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_SDA_B_s1 | ~cpu_0_data_master_requests_SDA_B_s1) & ((~cpu_0_data_master_qualified_request_SDA_B_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_SDA_B_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & ((~cpu_0_data_master_qualified_request_board_in_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_board_in_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1;

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_data_master_run = r_0 & r_1 & r_2;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = (cpu_0_data_master_qualified_request_board_out_s1 | ~cpu_0_data_master_requests_board_out_s1) & ((~cpu_0_data_master_qualified_request_board_out_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_board_out_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) & (cpu_0_data_master_granted_cpu_0_jtag_debug_module | ~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port | ~cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port) & (cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port | ~cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port) & ((~cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & 1 & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & 1 & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & ((~cpu_0_data_master_qualified_request_export_in_avs | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~d1_export_in_avs_end_xfer & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_export_in_avs | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~d1_export_in_avs_end_xfer & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write))));

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & ((~cpu_0_data_master_qualified_request_load_para_in_avs | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~d1_load_para_in_avs_end_xfer & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_load_para_in_avs | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~d1_load_para_in_avs_end_xfer & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_sdram_0_s1 | (cpu_0_data_master_read_data_valid_sdram_0_s1 & cpu_0_data_master_dbs_address[1]) | (cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1 & cpu_0_data_master_dbs_address[1]) | ~cpu_0_data_master_requests_sdram_0_s1) & (cpu_0_data_master_granted_sdram_0_s1 | ~cpu_0_data_master_qualified_request_sdram_0_s1) & ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~cpu_0_data_master_read | (cpu_0_data_master_read_data_valid_sdram_0_s1 & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~cpu_0_data_master_write | (1 & ~sdram_0_s1_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_write))) & 1 & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & ((cpu_0_data_master_qualified_request_udpram_in_avs | (registered_cpu_0_data_master_read_data_valid_udpram_in_avs & cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) | ((cpu_0_data_master_write & !cpu_0_data_master_byteenable_udpram_in_avs & cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0])) | ~cpu_0_data_master_requests_udpram_in_avs)) & ((~cpu_0_data_master_qualified_request_udpram_in_avs | ~cpu_0_data_master_read | (registered_cpu_0_data_master_read_data_valid_udpram_in_avs & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_udpram_in_avs | ~cpu_0_data_master_write | (1 & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_watch_dog_s1 | ~cpu_0_data_master_requests_watch_dog_s1) & ((~cpu_0_data_master_qualified_request_watch_dog_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_watch_dog_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_data_master_address_to_slave = cpu_0_data_master_address[27 : 0];

  //cpu_0/data_master readdata mux, which is an e_mux
  assign cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_SCL_A_s1}} | SCL_A_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_SCL_B_s1}} | SCL_B_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_SDA_A_s1}} | SDA_A_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_SDA_B_s1}} | SDA_B_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_board_in_s1}} | board_in_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_board_out_s1}} | board_out_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_cpu_0_jtag_debug_module}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port}} | epcs_flash_controller_0_epcs_control_port_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_export_in_avs}} | export_in_avs_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_load_para_in_avs}} | load_para_in_avs_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_sysid_control_slave}} | sysid_control_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_udpram_in_avs}} | {udpram_in_avs_readdata_from_sa[7 : 0],
    dbs_8_reg_segment_2,
    dbs_8_reg_segment_1,
    dbs_8_reg_segment_0}) &
    ({32 {~cpu_0_data_master_requests_watch_dog_s1}} | watch_dog_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_waitrequest <= ~0;
      else 
        cpu_0_data_master_waitrequest <= ~((~(cpu_0_data_master_read | cpu_0_data_master_write))? 0: (cpu_0_data_master_run & cpu_0_data_master_waitrequest));
    end


  //irq assign, which is an e_assign
  assign cpu_0_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    watch_dog_s1_irq_from_sa,
    epcs_flash_controller_0_epcs_control_port_irq_from_sa,
    jtag_uart_0_avalon_jtag_slave_irq_from_sa};

  //unpredictable registered wait state incoming data, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          registered_cpu_0_data_master_readdata <= 0;
      else 
        registered_cpu_0_data_master_readdata <= p1_registered_cpu_0_data_master_readdata;
    end


  //registered readdata mux, which is an e_mux
  assign p1_registered_cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | jtag_uart_0_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | {sdram_0_s1_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0});

  //no_byte_enables_and_last_term, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_no_byte_enables_and_last_term <= 0;
      else 
        cpu_0_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end


  //compute the last dbs term, which is an e_mux
  assign last_dbs_term_and_run = (cpu_0_data_master_requests_sdram_0_s1)? (((cpu_0_data_master_dbs_address == 2'b10) & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1)) :
    (((cpu_0_data_master_dbs_address == 2'b11) & cpu_0_data_master_write & !cpu_0_data_master_byteenable_udpram_in_avs));

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~cpu_0_data_master_no_byte_enables_and_last_term) & cpu_0_data_master_requests_sdram_0_s1 & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1)) |
    cpu_0_data_master_read_data_valid_sdram_0_s1 |
    (cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write & 1 & 1 & ~sdram_0_s1_waitrequest_from_sa) |
    (((~cpu_0_data_master_no_byte_enables_and_last_term) & cpu_0_data_master_requests_udpram_in_avs & cpu_0_data_master_write & !cpu_0_data_master_byteenable_udpram_in_avs)) |
    cpu_0_data_master_read_data_valid_udpram_in_avs |
    (cpu_0_data_master_granted_udpram_in_avs & cpu_0_data_master_write & 1 & 1);

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = sdram_0_s1_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_0_data_master_dbs_write_16 = (cpu_0_data_master_dbs_address[1])? cpu_0_data_master_writedata[31 : 16] :
    cpu_0_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_0_data_master_dbs_increment = (cpu_0_data_master_requests_sdram_0_s1)? 2 :
    (cpu_0_data_master_requests_udpram_in_avs)? 1 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_data_master_dbs_address + cpu_0_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable &
    (~(cpu_0_data_master_requests_sdram_0_s1 & ~cpu_0_data_master_waitrequest)) &
    (~(cpu_0_data_master_requests_udpram_in_avs & ~cpu_0_data_master_waitrequest & cpu_0_data_master_write));

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_data_master_dbs_address <= next_dbs_address;
    end


  //input to dbs-8 stored 0, which is an e_mux
  assign p1_dbs_8_reg_segment_0 = udpram_in_avs_readdata_from_sa;

  //dbs register for dbs-8 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 0))
          dbs_8_reg_segment_0 <= p1_dbs_8_reg_segment_0;
    end


  //input to dbs-8 stored 1, which is an e_mux
  assign p1_dbs_8_reg_segment_1 = udpram_in_avs_readdata_from_sa;

  //dbs register for dbs-8 segment 1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_1 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 1))
          dbs_8_reg_segment_1 <= p1_dbs_8_reg_segment_1;
    end


  //input to dbs-8 stored 2, which is an e_mux
  assign p1_dbs_8_reg_segment_2 = udpram_in_avs_readdata_from_sa;

  //dbs register for dbs-8 segment 2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_2 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 2))
          dbs_8_reg_segment_2 <= p1_dbs_8_reg_segment_2;
    end


  //mux write dbs 2, which is an e_mux
  assign cpu_0_data_master_dbs_write_8 = ((cpu_0_data_master_dbs_address[1 : 0] == 0))? cpu_0_data_master_writedata[7 : 0] :
    ((cpu_0_data_master_dbs_address[1 : 0] == 1))? cpu_0_data_master_writedata[15 : 8] :
    ((cpu_0_data_master_dbs_address[1 : 0] == 2))? cpu_0_data_master_writedata[23 : 16] :
    cpu_0_data_master_writedata[31 : 24];


endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_instruction_master_arbitrator (
                                             // inputs:
                                              clk,
                                              cpu_0_instruction_master_address,
                                              cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port,
                                              cpu_0_instruction_master_granted_sdram_0_s1,
                                              cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
                                              cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                              cpu_0_instruction_master_read,
                                              cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                              cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port,
                                              cpu_0_instruction_master_requests_sdram_0_s1,
                                              cpu_0_jtag_debug_module_readdata_from_sa,
                                              d1_cpu_0_jtag_debug_module_end_xfer,
                                              d1_epcs_flash_controller_0_epcs_control_port_end_xfer,
                                              d1_sdram_0_s1_end_xfer,
                                              epcs_flash_controller_0_epcs_control_port_readdata_from_sa,
                                              reset_n,
                                              sdram_0_s1_readdata_from_sa,
                                              sdram_0_s1_waitrequest_from_sa,

                                             // outputs:
                                              cpu_0_instruction_master_address_to_slave,
                                              cpu_0_instruction_master_dbs_address,
                                              cpu_0_instruction_master_latency_counter,
                                              cpu_0_instruction_master_readdata,
                                              cpu_0_instruction_master_readdatavalid,
                                              cpu_0_instruction_master_waitrequest
                                           )
;

  output  [ 27: 0] cpu_0_instruction_master_address_to_slave;
  output  [  1: 0] cpu_0_instruction_master_dbs_address;
  output           cpu_0_instruction_master_latency_counter;
  output  [ 31: 0] cpu_0_instruction_master_readdata;
  output           cpu_0_instruction_master_readdatavalid;
  output           cpu_0_instruction_master_waitrequest;
  input            clk;
  input   [ 27: 0] cpu_0_instruction_master_address;
  input            cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_instruction_master_granted_sdram_0_s1;
  input            cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_instruction_master_qualified_request_sdram_0_s1;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
  input            cpu_0_instruction_master_requests_sdram_0_s1;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_epcs_flash_controller_0_epcs_control_port_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input   [ 31: 0] epcs_flash_controller_0_epcs_control_port_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 27: 0] cpu_0_instruction_master_address_last_time;
  wire    [ 27: 0] cpu_0_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_0_instruction_master_dbs_address;
  wire    [  1: 0] cpu_0_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_0_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_0_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_0_instruction_master_is_granted_some_slave;
  reg              cpu_0_instruction_master_latency_counter;
  wire    [  1: 0] cpu_0_instruction_master_next_dbs_rdv_counter;
  reg              cpu_0_instruction_master_read_but_no_slave_selected;
  reg              cpu_0_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_run;
  wire             cpu_0_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_0_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_0_instruction_master_readdatavalid;
  wire             r_1;
  wire             r_2;
  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) & (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_instruction_master_read))) & 1 & (cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port | ~cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port) & (cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port | ~cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port) & ((~cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port | ~(cpu_0_instruction_master_read) | (1 & ~d1_epcs_flash_controller_0_epcs_control_port_end_xfer & (cpu_0_instruction_master_read))));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_instruction_master_run = r_1 & r_2;

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_0_instruction_master_qualified_request_sdram_0_s1 | ~cpu_0_instruction_master_requests_sdram_0_s1) & (cpu_0_instruction_master_granted_sdram_0_s1 | ~cpu_0_instruction_master_qualified_request_sdram_0_s1) & ((~cpu_0_instruction_master_qualified_request_sdram_0_s1 | ~cpu_0_instruction_master_read | (1 & ~sdram_0_s1_waitrequest_from_sa & (cpu_0_instruction_master_dbs_address[1]) & cpu_0_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_instruction_master_address_to_slave = cpu_0_instruction_master_address[27 : 0];

  //cpu_0_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_instruction_master_read_but_no_slave_selected <= cpu_0_instruction_master_read & cpu_0_instruction_master_run & ~cpu_0_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_instruction_master_is_granted_some_slave = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port |
    cpu_0_instruction_master_granted_sdram_0_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_data_valid_sdram_0_s1 & dbs_rdv_counter_overflow;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid |
    cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid |
    cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port |
    cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid;

  //cpu_0/instruction_master readdata mux, which is an e_mux
  assign cpu_0_instruction_master_readdata = ({32 {~(cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_instruction_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port & cpu_0_instruction_master_read)}} | epcs_flash_controller_0_epcs_control_port_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_read_data_valid_sdram_0_s1}} | {sdram_0_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_0_instruction_master_waitrequest = ~cpu_0_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_latency_counter <= 0;
      else 
        cpu_0_instruction_master_latency_counter <= p1_cpu_0_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_instruction_master_latency_counter = ((cpu_0_instruction_master_run & cpu_0_instruction_master_read))? latency_load_value :
    (cpu_0_instruction_master_latency_counter)? cpu_0_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = sdram_0_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_0_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_0_instruction_master_dbs_increment = (cpu_0_instruction_master_requests_sdram_0_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_instruction_master_dbs_address + cpu_0_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_0_instruction_master_next_dbs_rdv_counter = cpu_0_instruction_master_dbs_rdv_counter + cpu_0_instruction_master_dbs_rdv_counter_inc;

  //cpu_0_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_0_instruction_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_0_instruction_master_read_data_valid_sdram_0_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_0_instruction_master_dbs_rdv_counter <= cpu_0_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_0_instruction_master_dbs_rdv_counter[1] & ~cpu_0_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read & 1 & 1 & ~sdram_0_s1_waitrequest_from_sa;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_address_last_time <= 0;
      else 
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
    end


  //cpu_0/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_instruction_master_waitrequest & (cpu_0_instruction_master_read);
    end


  //cpu_0_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_address != cpu_0_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_last_time <= 0;
      else 
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
    end


  //cpu_0_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_read != cpu_0_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module epcs_flash_controller_0_epcs_control_port_arbitrator (
                                                              // inputs:
                                                               clk,
                                                               cpu_0_data_master_address_to_slave,
                                                               cpu_0_data_master_read,
                                                               cpu_0_data_master_write,
                                                               cpu_0_data_master_writedata,
                                                               cpu_0_instruction_master_address_to_slave,
                                                               cpu_0_instruction_master_latency_counter,
                                                               cpu_0_instruction_master_read,
                                                               cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                                               epcs_flash_controller_0_epcs_control_port_dataavailable,
                                                               epcs_flash_controller_0_epcs_control_port_endofpacket,
                                                               epcs_flash_controller_0_epcs_control_port_irq,
                                                               epcs_flash_controller_0_epcs_control_port_readdata,
                                                               epcs_flash_controller_0_epcs_control_port_readyfordata,
                                                               reset_n,

                                                              // outputs:
                                                               cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port,
                                                               cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
                                                               cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
                                                               cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port,
                                                               cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port,
                                                               cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port,
                                                               cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port,
                                                               cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port,
                                                               d1_epcs_flash_controller_0_epcs_control_port_end_xfer,
                                                               epcs_flash_controller_0_epcs_control_port_address,
                                                               epcs_flash_controller_0_epcs_control_port_chipselect,
                                                               epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa,
                                                               epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa,
                                                               epcs_flash_controller_0_epcs_control_port_irq_from_sa,
                                                               epcs_flash_controller_0_epcs_control_port_read_n,
                                                               epcs_flash_controller_0_epcs_control_port_readdata_from_sa,
                                                               epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa,
                                                               epcs_flash_controller_0_epcs_control_port_reset_n,
                                                               epcs_flash_controller_0_epcs_control_port_write_n,
                                                               epcs_flash_controller_0_epcs_control_port_writedata
                                                            )
;

  output           cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port;
  output           cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  output           cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  output           cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;
  output           cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port;
  output           cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  output           cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  output           cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
  output           d1_epcs_flash_controller_0_epcs_control_port_end_xfer;
  output  [  8: 0] epcs_flash_controller_0_epcs_control_port_address;
  output           epcs_flash_controller_0_epcs_control_port_chipselect;
  output           epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa;
  output           epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa;
  output           epcs_flash_controller_0_epcs_control_port_irq_from_sa;
  output           epcs_flash_controller_0_epcs_control_port_read_n;
  output  [ 31: 0] epcs_flash_controller_0_epcs_control_port_readdata_from_sa;
  output           epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa;
  output           epcs_flash_controller_0_epcs_control_port_reset_n;
  output           epcs_flash_controller_0_epcs_control_port_write_n;
  output  [ 31: 0] epcs_flash_controller_0_epcs_control_port_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 27: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  input            epcs_flash_controller_0_epcs_control_port_dataavailable;
  input            epcs_flash_controller_0_epcs_control_port_endofpacket;
  input            epcs_flash_controller_0_epcs_control_port_irq;
  input   [ 31: 0] epcs_flash_controller_0_epcs_control_port_readdata;
  input            epcs_flash_controller_0_epcs_control_port_readyfordata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port;
  reg              d1_epcs_flash_controller_0_epcs_control_port_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port;
  wire    [  8: 0] epcs_flash_controller_0_epcs_control_port_address;
  wire             epcs_flash_controller_0_epcs_control_port_allgrants;
  wire             epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle;
  wire             epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant;
  wire             epcs_flash_controller_0_epcs_control_port_any_continuerequest;
  reg     [  1: 0] epcs_flash_controller_0_epcs_control_port_arb_addend;
  wire             epcs_flash_controller_0_epcs_control_port_arb_counter_enable;
  reg     [  2: 0] epcs_flash_controller_0_epcs_control_port_arb_share_counter;
  wire    [  2: 0] epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value;
  wire    [  2: 0] epcs_flash_controller_0_epcs_control_port_arb_share_set_values;
  wire    [  1: 0] epcs_flash_controller_0_epcs_control_port_arb_winner;
  wire             epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal;
  wire             epcs_flash_controller_0_epcs_control_port_beginbursttransfer_internal;
  wire             epcs_flash_controller_0_epcs_control_port_begins_xfer;
  wire             epcs_flash_controller_0_epcs_control_port_chipselect;
  wire    [  3: 0] epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector;
  wire    [  1: 0] epcs_flash_controller_0_epcs_control_port_chosen_master_rot_left;
  wire             epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_end_xfer;
  wire             epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_firsttransfer;
  wire    [  1: 0] epcs_flash_controller_0_epcs_control_port_grant_vector;
  wire             epcs_flash_controller_0_epcs_control_port_in_a_read_cycle;
  wire             epcs_flash_controller_0_epcs_control_port_in_a_write_cycle;
  wire             epcs_flash_controller_0_epcs_control_port_irq_from_sa;
  wire    [  1: 0] epcs_flash_controller_0_epcs_control_port_master_qreq_vector;
  wire             epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests;
  wire             epcs_flash_controller_0_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_flash_controller_0_epcs_control_port_readdata_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa;
  reg              epcs_flash_controller_0_epcs_control_port_reg_firsttransfer;
  wire             epcs_flash_controller_0_epcs_control_port_reset_n;
  reg     [  1: 0] epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector;
  reg              epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable;
  wire             epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2;
  wire             epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer;
  wire             epcs_flash_controller_0_epcs_control_port_waits_for_read;
  wire             epcs_flash_controller_0_epcs_control_port_waits_for_write;
  wire             epcs_flash_controller_0_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_flash_controller_0_epcs_control_port_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port;
  wire    [ 27: 0] shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_data_master;
  wire    [ 27: 0] shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_instruction_master;
  wire             wait_for_epcs_flash_controller_0_epcs_control_port_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~epcs_flash_controller_0_epcs_control_port_end_xfer;
    end


  assign epcs_flash_controller_0_epcs_control_port_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port | cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port));
  //assign epcs_flash_controller_0_epcs_control_port_readdata_from_sa = epcs_flash_controller_0_epcs_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_readdata_from_sa = epcs_flash_controller_0_epcs_control_port_readdata;

  assign cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port = ({cpu_0_data_master_address_to_slave[27 : 11] , 11'b0} == 28'h8011800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa = epcs_flash_controller_0_epcs_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa = epcs_flash_controller_0_epcs_control_port_dataavailable;

  //assign epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa = epcs_flash_controller_0_epcs_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa = epcs_flash_controller_0_epcs_control_port_readyfordata;

  //epcs_flash_controller_0_epcs_control_port_arb_share_counter set values, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_arb_share_set_values = 1;

  //epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests mux, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests = cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port |
    cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port |
    cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port |
    cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;

  //epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant = 0;

  //epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value assignment, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value = epcs_flash_controller_0_epcs_control_port_firsttransfer ? (epcs_flash_controller_0_epcs_control_port_arb_share_set_values - 1) : |epcs_flash_controller_0_epcs_control_port_arb_share_counter ? (epcs_flash_controller_0_epcs_control_port_arb_share_counter - 1) : 0;

  //epcs_flash_controller_0_epcs_control_port_allgrants all slave grants, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_allgrants = (|epcs_flash_controller_0_epcs_control_port_grant_vector) |
    (|epcs_flash_controller_0_epcs_control_port_grant_vector) |
    (|epcs_flash_controller_0_epcs_control_port_grant_vector) |
    (|epcs_flash_controller_0_epcs_control_port_grant_vector);

  //epcs_flash_controller_0_epcs_control_port_end_xfer assignment, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_end_xfer = ~(epcs_flash_controller_0_epcs_control_port_waits_for_read | epcs_flash_controller_0_epcs_control_port_waits_for_write);

  //end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port = epcs_flash_controller_0_epcs_control_port_end_xfer & (~epcs_flash_controller_0_epcs_control_port_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //epcs_flash_controller_0_epcs_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_arb_counter_enable = (end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port & epcs_flash_controller_0_epcs_control_port_allgrants) | (end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port & ~epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests);

  //epcs_flash_controller_0_epcs_control_port_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_flash_controller_0_epcs_control_port_arb_share_counter <= 0;
      else if (epcs_flash_controller_0_epcs_control_port_arb_counter_enable)
          epcs_flash_controller_0_epcs_control_port_arb_share_counter <= epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value;
    end


  //epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable <= 0;
      else if ((|epcs_flash_controller_0_epcs_control_port_master_qreq_vector & end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port) | (end_xfer_arb_share_counter_term_epcs_flash_controller_0_epcs_control_port & ~epcs_flash_controller_0_epcs_control_port_non_bursting_master_requests))
          epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable <= |epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value;
    end


  //cpu_0/data_master epcs_flash_controller_0/epcs_control_port arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 = |epcs_flash_controller_0_epcs_control_port_arb_share_counter_next_value;

  //cpu_0/data_master epcs_flash_controller_0/epcs_control_port arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master epcs_flash_controller_0/epcs_control_port arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master epcs_flash_controller_0/epcs_control_port arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted epcs_flash_controller_0/epcs_control_port last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port ? 1 : (epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_epcs_flash_controller_0_epcs_control_port & cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;

  //epcs_flash_controller_0_epcs_control_port_any_continuerequest at least one master continues requesting, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port = cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port & ~(cpu_0_instruction_master_arbiterlock);
  //epcs_flash_controller_0_epcs_control_port_writedata mux, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_writedata = cpu_0_data_master_writedata;

  //assign epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa = epcs_flash_controller_0_epcs_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa = epcs_flash_controller_0_epcs_control_port_endofpacket;

  assign cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port = (({cpu_0_instruction_master_address_to_slave[27 : 11] , 11'b0} == 28'h8011800) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted epcs_flash_controller_0/epcs_control_port last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port <= cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port ? 1 : (epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal | ~cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port) ? 0 : last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_epcs_flash_controller_0_epcs_control_port & cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;

  assign cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port = cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0) | (|cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))) | cpu_0_data_master_arbiterlock);
  //local readdatavalid cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port = cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port & cpu_0_instruction_master_read & ~epcs_flash_controller_0_epcs_control_port_waits_for_read;

  //allow new arb cycle for epcs_flash_controller_0/epcs_control_port, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for epcs_flash_controller_0/epcs_control_port, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port;

  //cpu_0/instruction_master grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  assign cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port = epcs_flash_controller_0_epcs_control_port_grant_vector[0];

  //cpu_0/instruction_master saved-grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port = epcs_flash_controller_0_epcs_control_port_arb_winner[0] && cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;

  //cpu_0/data_master assignment into master qualified-requests vector for epcs_flash_controller_0/epcs_control_port, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_master_qreq_vector[1] = cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port;

  //cpu_0/data_master grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  assign cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port = epcs_flash_controller_0_epcs_control_port_grant_vector[1];

  //cpu_0/data_master saved-grant epcs_flash_controller_0/epcs_control_port, which is an e_assign
  assign cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port = epcs_flash_controller_0_epcs_control_port_arb_winner[1] && cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;

  //epcs_flash_controller_0/epcs_control_port chosen-master double-vector, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector = {epcs_flash_controller_0_epcs_control_port_master_qreq_vector, epcs_flash_controller_0_epcs_control_port_master_qreq_vector} & ({~epcs_flash_controller_0_epcs_control_port_master_qreq_vector, ~epcs_flash_controller_0_epcs_control_port_master_qreq_vector} + epcs_flash_controller_0_epcs_control_port_arb_addend);

  //stable onehot encoding of arb winner
  assign epcs_flash_controller_0_epcs_control_port_arb_winner = (epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle & | epcs_flash_controller_0_epcs_control_port_grant_vector) ? epcs_flash_controller_0_epcs_control_port_grant_vector : epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector;

  //saved epcs_flash_controller_0_epcs_control_port_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector <= 0;
      else if (epcs_flash_controller_0_epcs_control_port_allow_new_arb_cycle)
          epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector <= |epcs_flash_controller_0_epcs_control_port_grant_vector ? epcs_flash_controller_0_epcs_control_port_grant_vector : epcs_flash_controller_0_epcs_control_port_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign epcs_flash_controller_0_epcs_control_port_grant_vector = {(epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector[1] | epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector[3]),
    (epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector[0] | epcs_flash_controller_0_epcs_control_port_chosen_master_double_vector[2])};

  //epcs_flash_controller_0/epcs_control_port chosen master rotated left, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_chosen_master_rot_left = (epcs_flash_controller_0_epcs_control_port_arb_winner << 1) ? (epcs_flash_controller_0_epcs_control_port_arb_winner << 1) : 1;

  //epcs_flash_controller_0/epcs_control_port's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_flash_controller_0_epcs_control_port_arb_addend <= 1;
      else if (|epcs_flash_controller_0_epcs_control_port_grant_vector)
          epcs_flash_controller_0_epcs_control_port_arb_addend <= epcs_flash_controller_0_epcs_control_port_end_xfer? epcs_flash_controller_0_epcs_control_port_chosen_master_rot_left : epcs_flash_controller_0_epcs_control_port_grant_vector;
    end


  //epcs_flash_controller_0_epcs_control_port_reset_n assignment, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_reset_n = reset_n;

  assign epcs_flash_controller_0_epcs_control_port_chipselect = cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port | cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port;
  //epcs_flash_controller_0_epcs_control_port_firsttransfer first transaction, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_firsttransfer = epcs_flash_controller_0_epcs_control_port_begins_xfer ? epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer : epcs_flash_controller_0_epcs_control_port_reg_firsttransfer;

  //epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer first transaction, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer = ~(epcs_flash_controller_0_epcs_control_port_slavearbiterlockenable & epcs_flash_controller_0_epcs_control_port_any_continuerequest);

  //epcs_flash_controller_0_epcs_control_port_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_flash_controller_0_epcs_control_port_reg_firsttransfer <= 1'b1;
      else if (epcs_flash_controller_0_epcs_control_port_begins_xfer)
          epcs_flash_controller_0_epcs_control_port_reg_firsttransfer <= epcs_flash_controller_0_epcs_control_port_unreg_firsttransfer;
    end


  //epcs_flash_controller_0_epcs_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_beginbursttransfer_internal = epcs_flash_controller_0_epcs_control_port_begins_xfer;

  //epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_arbitration_holdoff_internal = epcs_flash_controller_0_epcs_control_port_begins_xfer & epcs_flash_controller_0_epcs_control_port_firsttransfer;

  //~epcs_flash_controller_0_epcs_control_port_read_n assignment, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_read_n = ~((cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port & cpu_0_instruction_master_read));

  //~epcs_flash_controller_0_epcs_control_port_write_n assignment, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_write_n = ~(cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port & cpu_0_data_master_write);

  assign shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //epcs_flash_controller_0_epcs_control_port_address mux, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_address = (cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port)? (shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_data_master >> 2) :
    (shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_epcs_flash_controller_0_epcs_control_port_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_epcs_flash_controller_0_epcs_control_port_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_epcs_flash_controller_0_epcs_control_port_end_xfer <= 1;
      else 
        d1_epcs_flash_controller_0_epcs_control_port_end_xfer <= epcs_flash_controller_0_epcs_control_port_end_xfer;
    end


  //epcs_flash_controller_0_epcs_control_port_waits_for_read in a cycle, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_waits_for_read = epcs_flash_controller_0_epcs_control_port_in_a_read_cycle & epcs_flash_controller_0_epcs_control_port_begins_xfer;

  //epcs_flash_controller_0_epcs_control_port_in_a_read_cycle assignment, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_in_a_read_cycle = (cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = epcs_flash_controller_0_epcs_control_port_in_a_read_cycle;

  //epcs_flash_controller_0_epcs_control_port_waits_for_write in a cycle, which is an e_mux
  assign epcs_flash_controller_0_epcs_control_port_waits_for_write = epcs_flash_controller_0_epcs_control_port_in_a_write_cycle & epcs_flash_controller_0_epcs_control_port_begins_xfer;

  //epcs_flash_controller_0_epcs_control_port_in_a_write_cycle assignment, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_in_a_write_cycle = cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = epcs_flash_controller_0_epcs_control_port_in_a_write_cycle;

  assign wait_for_epcs_flash_controller_0_epcs_control_port_counter = 0;
  //assign epcs_flash_controller_0_epcs_control_port_irq_from_sa = epcs_flash_controller_0_epcs_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_flash_controller_0_epcs_control_port_irq_from_sa = epcs_flash_controller_0_epcs_control_port_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //epcs_flash_controller_0/epcs_control_port enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port + cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_epcs_flash_controller_0_epcs_control_port + cpu_0_instruction_master_saved_grant_epcs_flash_controller_0_epcs_control_port > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module export_in_avs_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_0_data_master_address_to_slave,
                                   cpu_0_data_master_read,
                                   cpu_0_data_master_write,
                                   cpu_0_data_master_writedata,
                                   export_in_avs_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_0_data_master_granted_export_in_avs,
                                   cpu_0_data_master_qualified_request_export_in_avs,
                                   cpu_0_data_master_read_data_valid_export_in_avs,
                                   cpu_0_data_master_requests_export_in_avs,
                                   d1_export_in_avs_end_xfer,
                                   export_in_avs_address,
                                   export_in_avs_chipselect_n,
                                   export_in_avs_read_n,
                                   export_in_avs_readdata_from_sa,
                                   export_in_avs_wait_counter_eq_0,
                                   export_in_avs_write_n,
                                   export_in_avs_writedata
                                )
;

  output           cpu_0_data_master_granted_export_in_avs;
  output           cpu_0_data_master_qualified_request_export_in_avs;
  output           cpu_0_data_master_read_data_valid_export_in_avs;
  output           cpu_0_data_master_requests_export_in_avs;
  output           d1_export_in_avs_end_xfer;
  output  [  8: 0] export_in_avs_address;
  output           export_in_avs_chipselect_n;
  output           export_in_avs_read_n;
  output  [ 31: 0] export_in_avs_readdata_from_sa;
  output           export_in_avs_wait_counter_eq_0;
  output           export_in_avs_write_n;
  output  [ 31: 0] export_in_avs_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] export_in_avs_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_export_in_avs;
  wire             cpu_0_data_master_qualified_request_export_in_avs;
  wire             cpu_0_data_master_read_data_valid_export_in_avs;
  wire             cpu_0_data_master_requests_export_in_avs;
  wire             cpu_0_data_master_saved_grant_export_in_avs;
  reg              d1_export_in_avs_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_export_in_avs;
  wire    [  8: 0] export_in_avs_address;
  wire             export_in_avs_allgrants;
  wire             export_in_avs_allow_new_arb_cycle;
  wire             export_in_avs_any_bursting_master_saved_grant;
  wire             export_in_avs_any_continuerequest;
  wire             export_in_avs_arb_counter_enable;
  reg     [  2: 0] export_in_avs_arb_share_counter;
  wire    [  2: 0] export_in_avs_arb_share_counter_next_value;
  wire    [  2: 0] export_in_avs_arb_share_set_values;
  wire             export_in_avs_beginbursttransfer_internal;
  wire             export_in_avs_begins_xfer;
  wire             export_in_avs_chipselect_n;
  wire             export_in_avs_counter_load_value;
  wire             export_in_avs_end_xfer;
  wire             export_in_avs_firsttransfer;
  wire             export_in_avs_grant_vector;
  wire             export_in_avs_in_a_read_cycle;
  wire             export_in_avs_in_a_write_cycle;
  wire             export_in_avs_master_qreq_vector;
  wire             export_in_avs_non_bursting_master_requests;
  wire             export_in_avs_read_n;
  wire    [ 31: 0] export_in_avs_readdata_from_sa;
  reg              export_in_avs_reg_firsttransfer;
  reg              export_in_avs_slavearbiterlockenable;
  wire             export_in_avs_slavearbiterlockenable2;
  wire             export_in_avs_unreg_firsttransfer;
  reg              export_in_avs_wait_counter;
  wire             export_in_avs_wait_counter_eq_0;
  wire             export_in_avs_waits_for_read;
  wire             export_in_avs_waits_for_write;
  wire             export_in_avs_write_n;
  wire    [ 31: 0] export_in_avs_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_export_in_avs_from_cpu_0_data_master;
  wire             wait_for_export_in_avs_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~export_in_avs_end_xfer;
    end


  assign export_in_avs_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_export_in_avs));
  //assign export_in_avs_readdata_from_sa = export_in_avs_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign export_in_avs_readdata_from_sa = export_in_avs_readdata;

  assign cpu_0_data_master_requests_export_in_avs = ({cpu_0_data_master_address_to_slave[27 : 11] , 11'b0} == 28'h8012000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //export_in_avs_arb_share_counter set values, which is an e_mux
  assign export_in_avs_arb_share_set_values = 1;

  //export_in_avs_non_bursting_master_requests mux, which is an e_mux
  assign export_in_avs_non_bursting_master_requests = cpu_0_data_master_requests_export_in_avs;

  //export_in_avs_any_bursting_master_saved_grant mux, which is an e_mux
  assign export_in_avs_any_bursting_master_saved_grant = 0;

  //export_in_avs_arb_share_counter_next_value assignment, which is an e_assign
  assign export_in_avs_arb_share_counter_next_value = export_in_avs_firsttransfer ? (export_in_avs_arb_share_set_values - 1) : |export_in_avs_arb_share_counter ? (export_in_avs_arb_share_counter - 1) : 0;

  //export_in_avs_allgrants all slave grants, which is an e_mux
  assign export_in_avs_allgrants = |export_in_avs_grant_vector;

  //export_in_avs_end_xfer assignment, which is an e_assign
  assign export_in_avs_end_xfer = ~(export_in_avs_waits_for_read | export_in_avs_waits_for_write);

  //end_xfer_arb_share_counter_term_export_in_avs arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_export_in_avs = export_in_avs_end_xfer & (~export_in_avs_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //export_in_avs_arb_share_counter arbitration counter enable, which is an e_assign
  assign export_in_avs_arb_counter_enable = (end_xfer_arb_share_counter_term_export_in_avs & export_in_avs_allgrants) | (end_xfer_arb_share_counter_term_export_in_avs & ~export_in_avs_non_bursting_master_requests);

  //export_in_avs_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          export_in_avs_arb_share_counter <= 0;
      else if (export_in_avs_arb_counter_enable)
          export_in_avs_arb_share_counter <= export_in_avs_arb_share_counter_next_value;
    end


  //export_in_avs_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          export_in_avs_slavearbiterlockenable <= 0;
      else if ((|export_in_avs_master_qreq_vector & end_xfer_arb_share_counter_term_export_in_avs) | (end_xfer_arb_share_counter_term_export_in_avs & ~export_in_avs_non_bursting_master_requests))
          export_in_avs_slavearbiterlockenable <= |export_in_avs_arb_share_counter_next_value;
    end


  //cpu_0/data_master export/in_avs arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = export_in_avs_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //export_in_avs_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign export_in_avs_slavearbiterlockenable2 = |export_in_avs_arb_share_counter_next_value;

  //cpu_0/data_master export/in_avs arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = export_in_avs_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //export_in_avs_any_continuerequest at least one master continues requesting, which is an e_assign
  assign export_in_avs_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_export_in_avs = cpu_0_data_master_requests_export_in_avs;
  //export_in_avs_writedata mux, which is an e_mux
  assign export_in_avs_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_export_in_avs = cpu_0_data_master_qualified_request_export_in_avs;

  //cpu_0/data_master saved-grant export/in_avs, which is an e_assign
  assign cpu_0_data_master_saved_grant_export_in_avs = cpu_0_data_master_requests_export_in_avs;

  //allow new arb cycle for export/in_avs, which is an e_assign
  assign export_in_avs_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign export_in_avs_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign export_in_avs_master_qreq_vector = 1;

  assign export_in_avs_chipselect_n = ~cpu_0_data_master_granted_export_in_avs;
  //export_in_avs_firsttransfer first transaction, which is an e_assign
  assign export_in_avs_firsttransfer = export_in_avs_begins_xfer ? export_in_avs_unreg_firsttransfer : export_in_avs_reg_firsttransfer;

  //export_in_avs_unreg_firsttransfer first transaction, which is an e_assign
  assign export_in_avs_unreg_firsttransfer = ~(export_in_avs_slavearbiterlockenable & export_in_avs_any_continuerequest);

  //export_in_avs_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          export_in_avs_reg_firsttransfer <= 1'b1;
      else if (export_in_avs_begins_xfer)
          export_in_avs_reg_firsttransfer <= export_in_avs_unreg_firsttransfer;
    end


  //export_in_avs_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign export_in_avs_beginbursttransfer_internal = export_in_avs_begins_xfer;

  //~export_in_avs_read_n assignment, which is an e_mux
  assign export_in_avs_read_n = ~(((cpu_0_data_master_granted_export_in_avs & cpu_0_data_master_read))& ~export_in_avs_begins_xfer & (export_in_avs_wait_counter < 1));

  //~export_in_avs_write_n assignment, which is an e_mux
  assign export_in_avs_write_n = ~(((cpu_0_data_master_granted_export_in_avs & cpu_0_data_master_write))& ~export_in_avs_begins_xfer & (export_in_avs_wait_counter < 1));

  assign shifted_address_to_export_in_avs_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //export_in_avs_address mux, which is an e_mux
  assign export_in_avs_address = shifted_address_to_export_in_avs_from_cpu_0_data_master >> 2;

  //d1_export_in_avs_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_export_in_avs_end_xfer <= 1;
      else 
        d1_export_in_avs_end_xfer <= export_in_avs_end_xfer;
    end


  //export_in_avs_waits_for_read in a cycle, which is an e_mux
  assign export_in_avs_waits_for_read = export_in_avs_in_a_read_cycle & wait_for_export_in_avs_counter;

  //export_in_avs_in_a_read_cycle assignment, which is an e_assign
  assign export_in_avs_in_a_read_cycle = cpu_0_data_master_granted_export_in_avs & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = export_in_avs_in_a_read_cycle;

  //export_in_avs_waits_for_write in a cycle, which is an e_mux
  assign export_in_avs_waits_for_write = export_in_avs_in_a_write_cycle & wait_for_export_in_avs_counter;

  //export_in_avs_in_a_write_cycle assignment, which is an e_assign
  assign export_in_avs_in_a_write_cycle = cpu_0_data_master_granted_export_in_avs & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = export_in_avs_in_a_write_cycle;

  assign export_in_avs_wait_counter_eq_0 = export_in_avs_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          export_in_avs_wait_counter <= 0;
      else 
        export_in_avs_wait_counter <= export_in_avs_counter_load_value;
    end


  assign export_in_avs_counter_load_value = ((export_in_avs_in_a_write_cycle & export_in_avs_begins_xfer))? 1 :
    ((export_in_avs_in_a_read_cycle & export_in_avs_begins_xfer))? 1 :
    (~export_in_avs_wait_counter_eq_0)? export_in_avs_wait_counter - 1 :
    0;

  assign wait_for_export_in_avs_counter = export_in_avs_begins_xfer | ~export_in_avs_wait_counter_eq_0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //export/in_avs enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_0_avalon_jtag_slave_arbitrator (
                                                  // inputs:
                                                   clk,
                                                   cpu_0_data_master_address_to_slave,
                                                   cpu_0_data_master_read,
                                                   cpu_0_data_master_waitrequest,
                                                   cpu_0_data_master_write,
                                                   cpu_0_data_master_writedata,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable,
                                                   jtag_uart_0_avalon_jtag_slave_irq,
                                                   jtag_uart_0_avalon_jtag_slave_readdata,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest,
                                                   reset_n,

                                                  // outputs:
                                                   cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                                   d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                                   jtag_uart_0_avalon_jtag_slave_address,
                                                   jtag_uart_0_avalon_jtag_slave_chipselect,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_read_n,
                                                   jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_reset_n,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_write_n,
                                                   jtag_uart_0_avalon_jtag_slave_writedata
                                                )
;

  output           cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  output           d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  output           jtag_uart_0_avalon_jtag_slave_address;
  output           jtag_uart_0_avalon_jtag_slave_chipselect;
  output           jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_reset_n;
  output           jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            jtag_uart_0_avalon_jtag_slave_dataavailable;
  input            jtag_uart_0_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  input            jtag_uart_0_avalon_jtag_slave_readyfordata;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave;
  reg              d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_allgrants;
  wire             jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_0_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_0_avalon_jtag_slave_arb_counter_enable;
  reg     [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter;
  wire    [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_0_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  reg              jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [ 27: 0] shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master;
  wire             wait_for_jtag_uart_0_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_0_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave));
  //assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata;

  assign cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave = ({cpu_0_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h8013080) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_0_avalon_jtag_slave_firsttransfer ? (jtag_uart_0_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_0_avalon_jtag_slave_arb_share_counter ? (jtag_uart_0_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_allgrants = |jtag_uart_0_avalon_jtag_slave_grant_vector;

  //jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_end_xfer = ~(jtag_uart_0_avalon_jtag_slave_waits_for_read | jtag_uart_0_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave = jtag_uart_0_avalon_jtag_slave_end_xfer & (~jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & jtag_uart_0_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_0_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_0_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest)) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;

  //cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_0_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_0_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_0_avalon_jtag_slave_chipselect = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  //jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_firsttransfer = jtag_uart_0_avalon_jtag_slave_begins_xfer ? jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_0_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_0_avalon_jtag_slave_begins_xfer)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_0_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_read_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read);

  //~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_write_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write);

  assign shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_address = shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master >> 2;

  //d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_read = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_read_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_write = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_write_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_0_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module load_para_in_avs_arbitrator (
                                     // inputs:
                                      clk,
                                      cpu_0_data_master_address_to_slave,
                                      cpu_0_data_master_read,
                                      cpu_0_data_master_write,
                                      cpu_0_data_master_writedata,
                                      load_para_in_avs_readdata,
                                      reset_n,

                                     // outputs:
                                      cpu_0_data_master_granted_load_para_in_avs,
                                      cpu_0_data_master_qualified_request_load_para_in_avs,
                                      cpu_0_data_master_read_data_valid_load_para_in_avs,
                                      cpu_0_data_master_requests_load_para_in_avs,
                                      d1_load_para_in_avs_end_xfer,
                                      load_para_in_avs_address,
                                      load_para_in_avs_chipselect_n,
                                      load_para_in_avs_read_n,
                                      load_para_in_avs_readdata_from_sa,
                                      load_para_in_avs_wait_counter_eq_0,
                                      load_para_in_avs_write_n,
                                      load_para_in_avs_writedata
                                   )
;

  output           cpu_0_data_master_granted_load_para_in_avs;
  output           cpu_0_data_master_qualified_request_load_para_in_avs;
  output           cpu_0_data_master_read_data_valid_load_para_in_avs;
  output           cpu_0_data_master_requests_load_para_in_avs;
  output           d1_load_para_in_avs_end_xfer;
  output  [  8: 0] load_para_in_avs_address;
  output           load_para_in_avs_chipselect_n;
  output           load_para_in_avs_read_n;
  output  [ 31: 0] load_para_in_avs_readdata_from_sa;
  output           load_para_in_avs_wait_counter_eq_0;
  output           load_para_in_avs_write_n;
  output  [ 31: 0] load_para_in_avs_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] load_para_in_avs_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_load_para_in_avs;
  wire             cpu_0_data_master_qualified_request_load_para_in_avs;
  wire             cpu_0_data_master_read_data_valid_load_para_in_avs;
  wire             cpu_0_data_master_requests_load_para_in_avs;
  wire             cpu_0_data_master_saved_grant_load_para_in_avs;
  reg              d1_load_para_in_avs_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_load_para_in_avs;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  8: 0] load_para_in_avs_address;
  wire             load_para_in_avs_allgrants;
  wire             load_para_in_avs_allow_new_arb_cycle;
  wire             load_para_in_avs_any_bursting_master_saved_grant;
  wire             load_para_in_avs_any_continuerequest;
  wire             load_para_in_avs_arb_counter_enable;
  reg     [  2: 0] load_para_in_avs_arb_share_counter;
  wire    [  2: 0] load_para_in_avs_arb_share_counter_next_value;
  wire    [  2: 0] load_para_in_avs_arb_share_set_values;
  wire             load_para_in_avs_beginbursttransfer_internal;
  wire             load_para_in_avs_begins_xfer;
  wire             load_para_in_avs_chipselect_n;
  wire             load_para_in_avs_counter_load_value;
  wire             load_para_in_avs_end_xfer;
  wire             load_para_in_avs_firsttransfer;
  wire             load_para_in_avs_grant_vector;
  wire             load_para_in_avs_in_a_read_cycle;
  wire             load_para_in_avs_in_a_write_cycle;
  wire             load_para_in_avs_master_qreq_vector;
  wire             load_para_in_avs_non_bursting_master_requests;
  wire             load_para_in_avs_read_n;
  wire    [ 31: 0] load_para_in_avs_readdata_from_sa;
  reg              load_para_in_avs_reg_firsttransfer;
  reg              load_para_in_avs_slavearbiterlockenable;
  wire             load_para_in_avs_slavearbiterlockenable2;
  wire             load_para_in_avs_unreg_firsttransfer;
  reg              load_para_in_avs_wait_counter;
  wire             load_para_in_avs_wait_counter_eq_0;
  wire             load_para_in_avs_waits_for_read;
  wire             load_para_in_avs_waits_for_write;
  wire             load_para_in_avs_write_n;
  wire    [ 31: 0] load_para_in_avs_writedata;
  wire    [ 27: 0] shifted_address_to_load_para_in_avs_from_cpu_0_data_master;
  wire             wait_for_load_para_in_avs_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~load_para_in_avs_end_xfer;
    end


  assign load_para_in_avs_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_load_para_in_avs));
  //assign load_para_in_avs_readdata_from_sa = load_para_in_avs_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign load_para_in_avs_readdata_from_sa = load_para_in_avs_readdata;

  assign cpu_0_data_master_requests_load_para_in_avs = ({cpu_0_data_master_address_to_slave[27 : 11] , 11'b0} == 28'h8012800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //load_para_in_avs_arb_share_counter set values, which is an e_mux
  assign load_para_in_avs_arb_share_set_values = 1;

  //load_para_in_avs_non_bursting_master_requests mux, which is an e_mux
  assign load_para_in_avs_non_bursting_master_requests = cpu_0_data_master_requests_load_para_in_avs;

  //load_para_in_avs_any_bursting_master_saved_grant mux, which is an e_mux
  assign load_para_in_avs_any_bursting_master_saved_grant = 0;

  //load_para_in_avs_arb_share_counter_next_value assignment, which is an e_assign
  assign load_para_in_avs_arb_share_counter_next_value = load_para_in_avs_firsttransfer ? (load_para_in_avs_arb_share_set_values - 1) : |load_para_in_avs_arb_share_counter ? (load_para_in_avs_arb_share_counter - 1) : 0;

  //load_para_in_avs_allgrants all slave grants, which is an e_mux
  assign load_para_in_avs_allgrants = |load_para_in_avs_grant_vector;

  //load_para_in_avs_end_xfer assignment, which is an e_assign
  assign load_para_in_avs_end_xfer = ~(load_para_in_avs_waits_for_read | load_para_in_avs_waits_for_write);

  //end_xfer_arb_share_counter_term_load_para_in_avs arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_load_para_in_avs = load_para_in_avs_end_xfer & (~load_para_in_avs_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //load_para_in_avs_arb_share_counter arbitration counter enable, which is an e_assign
  assign load_para_in_avs_arb_counter_enable = (end_xfer_arb_share_counter_term_load_para_in_avs & load_para_in_avs_allgrants) | (end_xfer_arb_share_counter_term_load_para_in_avs & ~load_para_in_avs_non_bursting_master_requests);

  //load_para_in_avs_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          load_para_in_avs_arb_share_counter <= 0;
      else if (load_para_in_avs_arb_counter_enable)
          load_para_in_avs_arb_share_counter <= load_para_in_avs_arb_share_counter_next_value;
    end


  //load_para_in_avs_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          load_para_in_avs_slavearbiterlockenable <= 0;
      else if ((|load_para_in_avs_master_qreq_vector & end_xfer_arb_share_counter_term_load_para_in_avs) | (end_xfer_arb_share_counter_term_load_para_in_avs & ~load_para_in_avs_non_bursting_master_requests))
          load_para_in_avs_slavearbiterlockenable <= |load_para_in_avs_arb_share_counter_next_value;
    end


  //cpu_0/data_master load_para/in_avs arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = load_para_in_avs_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //load_para_in_avs_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign load_para_in_avs_slavearbiterlockenable2 = |load_para_in_avs_arb_share_counter_next_value;

  //cpu_0/data_master load_para/in_avs arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = load_para_in_avs_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //load_para_in_avs_any_continuerequest at least one master continues requesting, which is an e_assign
  assign load_para_in_avs_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_load_para_in_avs = cpu_0_data_master_requests_load_para_in_avs;
  //load_para_in_avs_writedata mux, which is an e_mux
  assign load_para_in_avs_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_load_para_in_avs = cpu_0_data_master_qualified_request_load_para_in_avs;

  //cpu_0/data_master saved-grant load_para/in_avs, which is an e_assign
  assign cpu_0_data_master_saved_grant_load_para_in_avs = cpu_0_data_master_requests_load_para_in_avs;

  //allow new arb cycle for load_para/in_avs, which is an e_assign
  assign load_para_in_avs_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign load_para_in_avs_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign load_para_in_avs_master_qreq_vector = 1;

  assign load_para_in_avs_chipselect_n = ~cpu_0_data_master_granted_load_para_in_avs;
  //load_para_in_avs_firsttransfer first transaction, which is an e_assign
  assign load_para_in_avs_firsttransfer = load_para_in_avs_begins_xfer ? load_para_in_avs_unreg_firsttransfer : load_para_in_avs_reg_firsttransfer;

  //load_para_in_avs_unreg_firsttransfer first transaction, which is an e_assign
  assign load_para_in_avs_unreg_firsttransfer = ~(load_para_in_avs_slavearbiterlockenable & load_para_in_avs_any_continuerequest);

  //load_para_in_avs_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          load_para_in_avs_reg_firsttransfer <= 1'b1;
      else if (load_para_in_avs_begins_xfer)
          load_para_in_avs_reg_firsttransfer <= load_para_in_avs_unreg_firsttransfer;
    end


  //load_para_in_avs_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign load_para_in_avs_beginbursttransfer_internal = load_para_in_avs_begins_xfer;

  //~load_para_in_avs_read_n assignment, which is an e_mux
  assign load_para_in_avs_read_n = ~(((cpu_0_data_master_granted_load_para_in_avs & cpu_0_data_master_read))& ~load_para_in_avs_begins_xfer & (load_para_in_avs_wait_counter < 1));

  //~load_para_in_avs_write_n assignment, which is an e_mux
  assign load_para_in_avs_write_n = ~(((cpu_0_data_master_granted_load_para_in_avs & cpu_0_data_master_write))& ~load_para_in_avs_begins_xfer & (load_para_in_avs_wait_counter < 1));

  assign shifted_address_to_load_para_in_avs_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //load_para_in_avs_address mux, which is an e_mux
  assign load_para_in_avs_address = shifted_address_to_load_para_in_avs_from_cpu_0_data_master >> 2;

  //d1_load_para_in_avs_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_load_para_in_avs_end_xfer <= 1;
      else 
        d1_load_para_in_avs_end_xfer <= load_para_in_avs_end_xfer;
    end


  //load_para_in_avs_waits_for_read in a cycle, which is an e_mux
  assign load_para_in_avs_waits_for_read = load_para_in_avs_in_a_read_cycle & wait_for_load_para_in_avs_counter;

  //load_para_in_avs_in_a_read_cycle assignment, which is an e_assign
  assign load_para_in_avs_in_a_read_cycle = cpu_0_data_master_granted_load_para_in_avs & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = load_para_in_avs_in_a_read_cycle;

  //load_para_in_avs_waits_for_write in a cycle, which is an e_mux
  assign load_para_in_avs_waits_for_write = load_para_in_avs_in_a_write_cycle & wait_for_load_para_in_avs_counter;

  //load_para_in_avs_in_a_write_cycle assignment, which is an e_assign
  assign load_para_in_avs_in_a_write_cycle = cpu_0_data_master_granted_load_para_in_avs & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = load_para_in_avs_in_a_write_cycle;

  assign load_para_in_avs_wait_counter_eq_0 = load_para_in_avs_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          load_para_in_avs_wait_counter <= 0;
      else 
        load_para_in_avs_wait_counter <= load_para_in_avs_counter_load_value;
    end


  assign load_para_in_avs_counter_load_value = ((load_para_in_avs_in_a_write_cycle & load_para_in_avs_begins_xfer))? 1 :
    ((load_para_in_avs_in_a_read_cycle & load_para_in_avs_begins_xfer))? 1 :
    (~load_para_in_avs_wait_counter_eq_0)? load_para_in_avs_wait_counter - 1 :
    0;

  assign wait_for_load_para_in_avs_counter = load_para_in_avs_begins_xfer | ~load_para_in_avs_wait_counter_eq_0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //load_para/in_avs enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module (
                                                             // inputs:
                                                              clear_fifo,
                                                              clk,
                                                              data_in,
                                                              read,
                                                              reset_n,
                                                              sync_reset,
                                                              write,

                                                             // outputs:
                                                              data_out,
                                                              empty,
                                                              fifo_contains_ones_n,
                                                              full
                                                           )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module (
                                                                    // inputs:
                                                                     clear_fifo,
                                                                     clk,
                                                                     data_in,
                                                                     read,
                                                                     reset_n,
                                                                     sync_reset,
                                                                     write,

                                                                    // outputs:
                                                                     data_out,
                                                                     empty,
                                                                     fifo_contains_ones_n,
                                                                     full
                                                                  )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_0_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_byteenable,
                                cpu_0_data_master_dbs_address,
                                cpu_0_data_master_dbs_write_16,
                                cpu_0_data_master_no_byte_enables_and_last_term,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_instruction_master_address_to_slave,
                                cpu_0_instruction_master_dbs_address,
                                cpu_0_instruction_master_latency_counter,
                                cpu_0_instruction_master_read,
                                reset_n,
                                sdram_0_s1_readdata,
                                sdram_0_s1_readdatavalid,
                                sdram_0_s1_waitrequest,

                               // outputs:
                                cpu_0_data_master_byteenable_sdram_0_s1,
                                cpu_0_data_master_granted_sdram_0_s1,
                                cpu_0_data_master_qualified_request_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_data_master_requests_sdram_0_s1,
                                cpu_0_instruction_master_granted_sdram_0_s1,
                                cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_instruction_master_requests_sdram_0_s1,
                                d1_sdram_0_s1_end_xfer,
                                sdram_0_s1_address,
                                sdram_0_s1_byteenable_n,
                                sdram_0_s1_chipselect,
                                sdram_0_s1_read_n,
                                sdram_0_s1_readdata_from_sa,
                                sdram_0_s1_reset_n,
                                sdram_0_s1_waitrequest_from_sa,
                                sdram_0_s1_write_n,
                                sdram_0_s1_writedata
                             )
;

  output  [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  output           cpu_0_data_master_granted_sdram_0_s1;
  output           cpu_0_data_master_qualified_request_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_data_master_requests_sdram_0_s1;
  output           cpu_0_instruction_master_granted_sdram_0_s1;
  output           cpu_0_instruction_master_qualified_request_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_instruction_master_requests_sdram_0_s1;
  output           d1_sdram_0_s1_end_xfer;
  output  [ 24: 0] sdram_0_s1_address;
  output  [  1: 0] sdram_0_s1_byteenable_n;
  output           sdram_0_s1_chipselect;
  output           sdram_0_s1_read_n;
  output  [ 15: 0] sdram_0_s1_readdata_from_sa;
  output           sdram_0_s1_reset_n;
  output           sdram_0_s1_waitrequest_from_sa;
  output           sdram_0_s1_write_n;
  output  [ 15: 0] sdram_0_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [ 15: 0] cpu_0_data_master_dbs_write_16;
  input            cpu_0_data_master_no_byte_enables_and_last_term;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 27: 0] cpu_0_instruction_master_address_to_slave;
  input   [  1: 0] cpu_0_instruction_master_dbs_address;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata;
  input            sdram_0_s1_readdatavalid;
  input            sdram_0_s1_waitrequest;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1_segment_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1_segment_1;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_saved_grant_sdram_0_s1;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_saved_grant_sdram_0_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
  wire    [ 24: 0] sdram_0_s1_address;
  wire             sdram_0_s1_allgrants;
  wire             sdram_0_s1_allow_new_arb_cycle;
  wire             sdram_0_s1_any_bursting_master_saved_grant;
  wire             sdram_0_s1_any_continuerequest;
  reg     [  1: 0] sdram_0_s1_arb_addend;
  wire             sdram_0_s1_arb_counter_enable;
  reg     [  2: 0] sdram_0_s1_arb_share_counter;
  wire    [  2: 0] sdram_0_s1_arb_share_counter_next_value;
  wire    [  2: 0] sdram_0_s1_arb_share_set_values;
  wire    [  1: 0] sdram_0_s1_arb_winner;
  wire             sdram_0_s1_arbitration_holdoff_internal;
  wire             sdram_0_s1_beginbursttransfer_internal;
  wire             sdram_0_s1_begins_xfer;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire    [  3: 0] sdram_0_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_0_s1_chosen_master_rot_left;
  wire             sdram_0_s1_end_xfer;
  wire             sdram_0_s1_firsttransfer;
  wire    [  1: 0] sdram_0_s1_grant_vector;
  wire             sdram_0_s1_in_a_read_cycle;
  wire             sdram_0_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_0_s1_master_qreq_vector;
  wire             sdram_0_s1_move_on_to_next_transaction;
  wire             sdram_0_s1_non_bursting_master_requests;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid_from_sa;
  reg              sdram_0_s1_reg_firsttransfer;
  wire             sdram_0_s1_reset_n;
  reg     [  1: 0] sdram_0_s1_saved_chosen_master_vector;
  reg              sdram_0_s1_slavearbiterlockenable;
  wire             sdram_0_s1_slavearbiterlockenable2;
  wire             sdram_0_s1_unreg_firsttransfer;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_waits_for_read;
  wire             sdram_0_s1_waits_for_write;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sdram_0_s1_from_cpu_0_data_master;
  wire    [ 27: 0] shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master;
  wire             wait_for_sdram_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_0_s1_end_xfer;
    end


  assign sdram_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sdram_0_s1 | cpu_0_instruction_master_qualified_request_sdram_0_s1));
  //assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid;

  //assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata;

  assign cpu_0_data_master_requests_sdram_0_s1 = ({cpu_0_data_master_address_to_slave[27 : 26] , 26'b0} == 28'h4000000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest;

  //sdram_0_s1_arb_share_counter set values, which is an e_mux
  assign sdram_0_s1_arb_share_set_values = (cpu_0_data_master_granted_sdram_0_s1)? 2 :
    (cpu_0_instruction_master_granted_sdram_0_s1)? 2 :
    (cpu_0_data_master_granted_sdram_0_s1)? 2 :
    (cpu_0_instruction_master_granted_sdram_0_s1)? 2 :
    1;

  //sdram_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1 |
    cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_0_s1_any_bursting_master_saved_grant = 0;

  //sdram_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_0_s1_arb_share_counter_next_value = sdram_0_s1_firsttransfer ? (sdram_0_s1_arb_share_set_values - 1) : |sdram_0_s1_arb_share_counter ? (sdram_0_s1_arb_share_counter - 1) : 0;

  //sdram_0_s1_allgrants all slave grants, which is an e_mux
  assign sdram_0_s1_allgrants = (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector);

  //sdram_0_s1_end_xfer assignment, which is an e_assign
  assign sdram_0_s1_end_xfer = ~(sdram_0_s1_waits_for_read | sdram_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_0_s1 = sdram_0_s1_end_xfer & (~sdram_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_0_s1 & sdram_0_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests);

  //sdram_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_share_counter <= 0;
      else if (sdram_0_s1_arb_counter_enable)
          sdram_0_s1_arb_share_counter <= sdram_0_s1_arb_share_counter_next_value;
    end


  //sdram_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_0_s1) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests))
          sdram_0_s1_slavearbiterlockenable <= |sdram_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sdram_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_0_s1_slavearbiterlockenable2 = |sdram_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= cpu_0_instruction_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 & cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_0_s1_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_sdram_0_s1 = cpu_0_data_master_requests_sdram_0_s1 & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest | (|cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))) | ((~cpu_0_data_master_waitrequest | cpu_0_data_master_no_byte_enables_and_last_term | !cpu_0_data_master_byteenable_sdram_0_s1) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //unique name for sdram_0_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_0_s1_move_on_to_next_transaction = sdram_0_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_data_master_granted_sdram_0_s1),
      .data_out             (cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_data_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_data_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;

  //sdram_0_s1_writedata mux, which is an e_mux
  assign sdram_0_s1_writedata = cpu_0_data_master_dbs_write_16;

  assign cpu_0_instruction_master_requests_sdram_0_s1 = (({cpu_0_instruction_master_address_to_slave[27 : 26] , 26'b0} == 28'h4000000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= cpu_0_data_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_data_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 & cpu_0_data_master_requests_sdram_0_s1;

  assign cpu_0_instruction_master_qualified_request_sdram_0_s1 = cpu_0_instruction_master_requests_sdram_0_s1 & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0) | (1 < cpu_0_instruction_master_latency_counter))) | cpu_0_data_master_arbiterlock);
  //rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_instruction_master_granted_sdram_0_s1),
      .data_out             (cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_instruction_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;

  //allow new arb cycle for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_sdram_0_s1;

  //cpu_0/instruction_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[0];

  //cpu_0/instruction_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[0] && cpu_0_instruction_master_requests_sdram_0_s1;

  //cpu_0/data_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[1] = cpu_0_data_master_qualified_request_sdram_0_s1;

  //cpu_0/data_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[1];

  //cpu_0/data_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[1] && cpu_0_data_master_requests_sdram_0_s1;

  //sdram_0/s1 chosen-master double-vector, which is an e_assign
  assign sdram_0_s1_chosen_master_double_vector = {sdram_0_s1_master_qreq_vector, sdram_0_s1_master_qreq_vector} & ({~sdram_0_s1_master_qreq_vector, ~sdram_0_s1_master_qreq_vector} + sdram_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_0_s1_arb_winner = (sdram_0_s1_allow_new_arb_cycle & | sdram_0_s1_grant_vector) ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;

  //saved sdram_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_saved_chosen_master_vector <= 0;
      else if (sdram_0_s1_allow_new_arb_cycle)
          sdram_0_s1_saved_chosen_master_vector <= |sdram_0_s1_grant_vector ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_0_s1_grant_vector = {(sdram_0_s1_chosen_master_double_vector[1] | sdram_0_s1_chosen_master_double_vector[3]),
    (sdram_0_s1_chosen_master_double_vector[0] | sdram_0_s1_chosen_master_double_vector[2])};

  //sdram_0/s1 chosen master rotated left, which is an e_assign
  assign sdram_0_s1_chosen_master_rot_left = (sdram_0_s1_arb_winner << 1) ? (sdram_0_s1_arb_winner << 1) : 1;

  //sdram_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_addend <= 1;
      else if (|sdram_0_s1_grant_vector)
          sdram_0_s1_arb_addend <= sdram_0_s1_end_xfer? sdram_0_s1_chosen_master_rot_left : sdram_0_s1_grant_vector;
    end


  //sdram_0_s1_reset_n assignment, which is an e_assign
  assign sdram_0_s1_reset_n = reset_n;

  assign sdram_0_s1_chipselect = cpu_0_data_master_granted_sdram_0_s1 | cpu_0_instruction_master_granted_sdram_0_s1;
  //sdram_0_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_firsttransfer = sdram_0_s1_begins_xfer ? sdram_0_s1_unreg_firsttransfer : sdram_0_s1_reg_firsttransfer;

  //sdram_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_unreg_firsttransfer = ~(sdram_0_s1_slavearbiterlockenable & sdram_0_s1_any_continuerequest);

  //sdram_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_0_s1_begins_xfer)
          sdram_0_s1_reg_firsttransfer <= sdram_0_s1_unreg_firsttransfer;
    end


  //sdram_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_0_s1_beginbursttransfer_internal = sdram_0_s1_begins_xfer;

  //sdram_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_0_s1_arbitration_holdoff_internal = sdram_0_s1_begins_xfer & sdram_0_s1_firsttransfer;

  //~sdram_0_s1_read_n assignment, which is an e_mux
  assign sdram_0_s1_read_n = ~((cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read));

  //~sdram_0_s1_write_n assignment, which is an e_mux
  assign sdram_0_s1_write_n = ~(cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_data_master = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_0_s1_address mux, which is an e_mux
  assign sdram_0_s1_address = (cpu_0_data_master_granted_sdram_0_s1)? (shifted_address_to_sdram_0_s1_from_cpu_0_data_master >> 1) :
    (shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master >> 1);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master = {cpu_0_instruction_master_address_to_slave >> 2,
    cpu_0_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_0_s1_end_xfer <= 1;
      else 
        d1_sdram_0_s1_end_xfer <= sdram_0_s1_end_xfer;
    end


  //sdram_0_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_read = sdram_0_s1_in_a_read_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_read_cycle = (cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_0_s1_in_a_read_cycle;

  //sdram_0_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_write = sdram_0_s1_in_a_write_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_write_cycle = cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_0_s1_in_a_write_cycle;

  assign wait_for_sdram_0_s1_counter = 0;
  //~sdram_0_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_0_s1_byteenable_n = ~((cpu_0_data_master_granted_sdram_0_s1)? cpu_0_data_master_byteenable_sdram_0_s1 :
    -1);

  assign {cpu_0_data_master_byteenable_sdram_0_s1_segment_1,
cpu_0_data_master_byteenable_sdram_0_s1_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_sdram_0_s1 = ((cpu_0_data_master_dbs_address[1] == 0))? cpu_0_data_master_byteenable_sdram_0_s1_segment_0 :
    cpu_0_data_master_byteenable_sdram_0_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_sdram_0_s1 + cpu_0_instruction_master_granted_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_sdram_0_s1 + cpu_0_instruction_master_saved_grant_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_0_data_master_granted_sysid_control_slave,
                                         cpu_0_data_master_qualified_request_sysid_control_slave,
                                         cpu_0_data_master_read_data_valid_sysid_control_slave,
                                         cpu_0_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa
                                      )
;

  output           cpu_0_data_master_granted_sysid_control_slave;
  output           cpu_0_data_master_qualified_request_sysid_control_slave;
  output           cpu_0_data_master_read_data_valid_sysid_control_slave;
  output           cpu_0_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_sysid_control_slave_from_cpu_0_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  2: 0] sysid_control_slave_arb_share_counter;
  wire    [  2: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  2: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_0_data_master_requests_sysid_control_slave = (({cpu_0_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h8013088) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;
  //master is always granted when requested
  assign cpu_0_data_master_granted_sysid_control_slave = cpu_0_data_master_qualified_request_sysid_control_slave;

  //cpu_0/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_0_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module udpram_in_avs_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_0_data_master_address_to_slave,
                                   cpu_0_data_master_byteenable,
                                   cpu_0_data_master_dbs_address,
                                   cpu_0_data_master_dbs_write_8,
                                   cpu_0_data_master_no_byte_enables_and_last_term,
                                   cpu_0_data_master_read,
                                   cpu_0_data_master_waitrequest,
                                   cpu_0_data_master_write,
                                   reset_n,
                                   udpram_in_avs_readdata,

                                  // outputs:
                                   cpu_0_data_master_byteenable_udpram_in_avs,
                                   cpu_0_data_master_granted_udpram_in_avs,
                                   cpu_0_data_master_qualified_request_udpram_in_avs,
                                   cpu_0_data_master_read_data_valid_udpram_in_avs,
                                   cpu_0_data_master_requests_udpram_in_avs,
                                   d1_udpram_in_avs_end_xfer,
                                   registered_cpu_0_data_master_read_data_valid_udpram_in_avs,
                                   udpram_in_avs_address,
                                   udpram_in_avs_chipselect_n,
                                   udpram_in_avs_read_n,
                                   udpram_in_avs_readdata_from_sa,
                                   udpram_in_avs_write_n,
                                   udpram_in_avs_writedata
                                )
;

  output           cpu_0_data_master_byteenable_udpram_in_avs;
  output           cpu_0_data_master_granted_udpram_in_avs;
  output           cpu_0_data_master_qualified_request_udpram_in_avs;
  output           cpu_0_data_master_read_data_valid_udpram_in_avs;
  output           cpu_0_data_master_requests_udpram_in_avs;
  output           d1_udpram_in_avs_end_xfer;
  output           registered_cpu_0_data_master_read_data_valid_udpram_in_avs;
  output  [ 15: 0] udpram_in_avs_address;
  output           udpram_in_avs_chipselect_n;
  output           udpram_in_avs_read_n;
  output  [  7: 0] udpram_in_avs_readdata_from_sa;
  output           udpram_in_avs_write_n;
  output  [  7: 0] udpram_in_avs_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [  7: 0] cpu_0_data_master_dbs_write_8;
  input            cpu_0_data_master_no_byte_enables_and_last_term;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input            reset_n;
  input   [  7: 0] udpram_in_avs_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_byteenable_udpram_in_avs;
  wire             cpu_0_data_master_byteenable_udpram_in_avs_segment_0;
  wire             cpu_0_data_master_byteenable_udpram_in_avs_segment_1;
  wire             cpu_0_data_master_byteenable_udpram_in_avs_segment_2;
  wire             cpu_0_data_master_byteenable_udpram_in_avs_segment_3;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_udpram_in_avs;
  wire             cpu_0_data_master_qualified_request_udpram_in_avs;
  wire             cpu_0_data_master_read_data_valid_udpram_in_avs;
  reg              cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register;
  wire             cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register_in;
  wire             cpu_0_data_master_requests_udpram_in_avs;
  wire             cpu_0_data_master_saved_grant_udpram_in_avs;
  reg              d1_reasons_to_wait;
  reg              d1_udpram_in_avs_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_udpram_in_avs;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             p1_cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register;
  wire             registered_cpu_0_data_master_read_data_valid_udpram_in_avs;
  wire    [ 15: 0] udpram_in_avs_address;
  wire             udpram_in_avs_allgrants;
  wire             udpram_in_avs_allow_new_arb_cycle;
  wire             udpram_in_avs_any_bursting_master_saved_grant;
  wire             udpram_in_avs_any_continuerequest;
  wire             udpram_in_avs_arb_counter_enable;
  reg     [  2: 0] udpram_in_avs_arb_share_counter;
  wire    [  2: 0] udpram_in_avs_arb_share_counter_next_value;
  wire    [  2: 0] udpram_in_avs_arb_share_set_values;
  wire             udpram_in_avs_beginbursttransfer_internal;
  wire             udpram_in_avs_begins_xfer;
  wire             udpram_in_avs_chipselect_n;
  wire             udpram_in_avs_end_xfer;
  wire             udpram_in_avs_firsttransfer;
  wire             udpram_in_avs_grant_vector;
  wire             udpram_in_avs_in_a_read_cycle;
  wire             udpram_in_avs_in_a_write_cycle;
  wire             udpram_in_avs_master_qreq_vector;
  wire             udpram_in_avs_non_bursting_master_requests;
  wire             udpram_in_avs_pretend_byte_enable;
  wire             udpram_in_avs_read_n;
  wire    [  7: 0] udpram_in_avs_readdata_from_sa;
  reg              udpram_in_avs_reg_firsttransfer;
  reg              udpram_in_avs_slavearbiterlockenable;
  wire             udpram_in_avs_slavearbiterlockenable2;
  wire             udpram_in_avs_unreg_firsttransfer;
  wire             udpram_in_avs_waits_for_read;
  wire             udpram_in_avs_waits_for_write;
  wire             udpram_in_avs_write_n;
  wire    [  7: 0] udpram_in_avs_writedata;
  wire             wait_for_udpram_in_avs_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~udpram_in_avs_end_xfer;
    end


  assign udpram_in_avs_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_udpram_in_avs));
  //assign udpram_in_avs_readdata_from_sa = udpram_in_avs_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign udpram_in_avs_readdata_from_sa = udpram_in_avs_readdata;

  assign cpu_0_data_master_requests_udpram_in_avs = ({cpu_0_data_master_address_to_slave[27 : 16] , 16'b0} == 28'h8000000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //registered rdv signal_name registered_cpu_0_data_master_read_data_valid_udpram_in_avs assignment, which is an e_assign
  assign registered_cpu_0_data_master_read_data_valid_udpram_in_avs = cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register_in;

  //udpram_in_avs_arb_share_counter set values, which is an e_mux
  assign udpram_in_avs_arb_share_set_values = (cpu_0_data_master_granted_udpram_in_avs)? 4 :
    1;

  //udpram_in_avs_non_bursting_master_requests mux, which is an e_mux
  assign udpram_in_avs_non_bursting_master_requests = cpu_0_data_master_requests_udpram_in_avs;

  //udpram_in_avs_any_bursting_master_saved_grant mux, which is an e_mux
  assign udpram_in_avs_any_bursting_master_saved_grant = 0;

  //udpram_in_avs_arb_share_counter_next_value assignment, which is an e_assign
  assign udpram_in_avs_arb_share_counter_next_value = udpram_in_avs_firsttransfer ? (udpram_in_avs_arb_share_set_values - 1) : |udpram_in_avs_arb_share_counter ? (udpram_in_avs_arb_share_counter - 1) : 0;

  //udpram_in_avs_allgrants all slave grants, which is an e_mux
  assign udpram_in_avs_allgrants = |udpram_in_avs_grant_vector;

  //udpram_in_avs_end_xfer assignment, which is an e_assign
  assign udpram_in_avs_end_xfer = ~(udpram_in_avs_waits_for_read | udpram_in_avs_waits_for_write);

  //end_xfer_arb_share_counter_term_udpram_in_avs arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_udpram_in_avs = udpram_in_avs_end_xfer & (~udpram_in_avs_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //udpram_in_avs_arb_share_counter arbitration counter enable, which is an e_assign
  assign udpram_in_avs_arb_counter_enable = (end_xfer_arb_share_counter_term_udpram_in_avs & udpram_in_avs_allgrants) | (end_xfer_arb_share_counter_term_udpram_in_avs & ~udpram_in_avs_non_bursting_master_requests);

  //udpram_in_avs_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          udpram_in_avs_arb_share_counter <= 0;
      else if (udpram_in_avs_arb_counter_enable)
          udpram_in_avs_arb_share_counter <= udpram_in_avs_arb_share_counter_next_value;
    end


  //udpram_in_avs_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          udpram_in_avs_slavearbiterlockenable <= 0;
      else if ((|udpram_in_avs_master_qreq_vector & end_xfer_arb_share_counter_term_udpram_in_avs) | (end_xfer_arb_share_counter_term_udpram_in_avs & ~udpram_in_avs_non_bursting_master_requests))
          udpram_in_avs_slavearbiterlockenable <= |udpram_in_avs_arb_share_counter_next_value;
    end


  //cpu_0/data_master udpram/in_avs arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = udpram_in_avs_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //udpram_in_avs_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign udpram_in_avs_slavearbiterlockenable2 = |udpram_in_avs_arb_share_counter_next_value;

  //cpu_0/data_master udpram/in_avs arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = udpram_in_avs_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //udpram_in_avs_any_continuerequest at least one master continues requesting, which is an e_assign
  assign udpram_in_avs_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_udpram_in_avs = cpu_0_data_master_requests_udpram_in_avs & ~((cpu_0_data_master_read & ((|cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register))) | ((~cpu_0_data_master_waitrequest | cpu_0_data_master_no_byte_enables_and_last_term | !cpu_0_data_master_byteenable_udpram_in_avs) & cpu_0_data_master_write));
  //cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register_in = cpu_0_data_master_granted_udpram_in_avs & cpu_0_data_master_read & ~udpram_in_avs_waits_for_read & ~(|cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register);

  //shift register p1 cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register = {cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register, cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register_in};

  //cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register <= 0;
      else 
        cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register <= p1_cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register;
    end


  //local readdatavalid cpu_0_data_master_read_data_valid_udpram_in_avs, which is an e_mux
  assign cpu_0_data_master_read_data_valid_udpram_in_avs = cpu_0_data_master_read_data_valid_udpram_in_avs_shift_register;

  //udpram_in_avs_writedata mux, which is an e_mux
  assign udpram_in_avs_writedata = cpu_0_data_master_dbs_write_8;

  //master is always granted when requested
  assign cpu_0_data_master_granted_udpram_in_avs = cpu_0_data_master_qualified_request_udpram_in_avs;

  //cpu_0/data_master saved-grant udpram/in_avs, which is an e_assign
  assign cpu_0_data_master_saved_grant_udpram_in_avs = cpu_0_data_master_requests_udpram_in_avs;

  //allow new arb cycle for udpram/in_avs, which is an e_assign
  assign udpram_in_avs_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign udpram_in_avs_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign udpram_in_avs_master_qreq_vector = 1;

  assign udpram_in_avs_chipselect_n = ~cpu_0_data_master_granted_udpram_in_avs;
  //udpram_in_avs_firsttransfer first transaction, which is an e_assign
  assign udpram_in_avs_firsttransfer = udpram_in_avs_begins_xfer ? udpram_in_avs_unreg_firsttransfer : udpram_in_avs_reg_firsttransfer;

  //udpram_in_avs_unreg_firsttransfer first transaction, which is an e_assign
  assign udpram_in_avs_unreg_firsttransfer = ~(udpram_in_avs_slavearbiterlockenable & udpram_in_avs_any_continuerequest);

  //udpram_in_avs_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          udpram_in_avs_reg_firsttransfer <= 1'b1;
      else if (udpram_in_avs_begins_xfer)
          udpram_in_avs_reg_firsttransfer <= udpram_in_avs_unreg_firsttransfer;
    end


  //udpram_in_avs_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign udpram_in_avs_beginbursttransfer_internal = udpram_in_avs_begins_xfer;

  //~udpram_in_avs_read_n assignment, which is an e_mux
  assign udpram_in_avs_read_n = ~(cpu_0_data_master_granted_udpram_in_avs & cpu_0_data_master_read);

  //~udpram_in_avs_write_n assignment, which is an e_mux
  assign udpram_in_avs_write_n = ~(((cpu_0_data_master_granted_udpram_in_avs & cpu_0_data_master_write)) & udpram_in_avs_pretend_byte_enable);

  //udpram_in_avs_address mux, which is an e_mux
  assign udpram_in_avs_address = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1 : 0]};

  //d1_udpram_in_avs_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_udpram_in_avs_end_xfer <= 1;
      else 
        d1_udpram_in_avs_end_xfer <= udpram_in_avs_end_xfer;
    end


  //udpram_in_avs_waits_for_read in a cycle, which is an e_mux
  assign udpram_in_avs_waits_for_read = udpram_in_avs_in_a_read_cycle & 0;

  //udpram_in_avs_in_a_read_cycle assignment, which is an e_assign
  assign udpram_in_avs_in_a_read_cycle = cpu_0_data_master_granted_udpram_in_avs & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = udpram_in_avs_in_a_read_cycle;

  //udpram_in_avs_waits_for_write in a cycle, which is an e_mux
  assign udpram_in_avs_waits_for_write = udpram_in_avs_in_a_write_cycle & 0;

  //udpram_in_avs_in_a_write_cycle assignment, which is an e_assign
  assign udpram_in_avs_in_a_write_cycle = cpu_0_data_master_granted_udpram_in_avs & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = udpram_in_avs_in_a_write_cycle;

  assign wait_for_udpram_in_avs_counter = 0;
  //udpram_in_avs_pretend_byte_enable byte enable port mux, which is an e_mux
  assign udpram_in_avs_pretend_byte_enable = (cpu_0_data_master_granted_udpram_in_avs)? cpu_0_data_master_byteenable_udpram_in_avs :
    -1;

  assign {cpu_0_data_master_byteenable_udpram_in_avs_segment_3,
cpu_0_data_master_byteenable_udpram_in_avs_segment_2,
cpu_0_data_master_byteenable_udpram_in_avs_segment_1,
cpu_0_data_master_byteenable_udpram_in_avs_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_udpram_in_avs = ((cpu_0_data_master_dbs_address[1 : 0] == 0))? cpu_0_data_master_byteenable_udpram_in_avs_segment_0 :
    ((cpu_0_data_master_dbs_address[1 : 0] == 1))? cpu_0_data_master_byteenable_udpram_in_avs_segment_1 :
    ((cpu_0_data_master_dbs_address[1 : 0] == 2))? cpu_0_data_master_byteenable_udpram_in_avs_segment_2 :
    cpu_0_data_master_byteenable_udpram_in_avs_segment_3;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //udpram/in_avs enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module watch_dog_s1_arbitrator (
                                 // inputs:
                                  clk,
                                  cpu_0_data_master_address_to_slave,
                                  cpu_0_data_master_read,
                                  cpu_0_data_master_waitrequest,
                                  cpu_0_data_master_write,
                                  cpu_0_data_master_writedata,
                                  reset_n,
                                  watch_dog_s1_irq,
                                  watch_dog_s1_readdata,
                                  watch_dog_s1_resetrequest,

                                 // outputs:
                                  cpu_0_data_master_granted_watch_dog_s1,
                                  cpu_0_data_master_qualified_request_watch_dog_s1,
                                  cpu_0_data_master_read_data_valid_watch_dog_s1,
                                  cpu_0_data_master_requests_watch_dog_s1,
                                  d1_watch_dog_s1_end_xfer,
                                  watch_dog_s1_address,
                                  watch_dog_s1_chipselect,
                                  watch_dog_s1_irq_from_sa,
                                  watch_dog_s1_readdata_from_sa,
                                  watch_dog_s1_reset_n,
                                  watch_dog_s1_resetrequest_from_sa,
                                  watch_dog_s1_write_n,
                                  watch_dog_s1_writedata
                               )
;

  output           cpu_0_data_master_granted_watch_dog_s1;
  output           cpu_0_data_master_qualified_request_watch_dog_s1;
  output           cpu_0_data_master_read_data_valid_watch_dog_s1;
  output           cpu_0_data_master_requests_watch_dog_s1;
  output           d1_watch_dog_s1_end_xfer;
  output  [  2: 0] watch_dog_s1_address;
  output           watch_dog_s1_chipselect;
  output           watch_dog_s1_irq_from_sa;
  output  [ 15: 0] watch_dog_s1_readdata_from_sa;
  output           watch_dog_s1_reset_n;
  output           watch_dog_s1_resetrequest_from_sa;
  output           watch_dog_s1_write_n;
  output  [ 15: 0] watch_dog_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input            watch_dog_s1_irq;
  input   [ 15: 0] watch_dog_s1_readdata;
  input            watch_dog_s1_resetrequest;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_watch_dog_s1;
  wire             cpu_0_data_master_qualified_request_watch_dog_s1;
  wire             cpu_0_data_master_read_data_valid_watch_dog_s1;
  wire             cpu_0_data_master_requests_watch_dog_s1;
  wire             cpu_0_data_master_saved_grant_watch_dog_s1;
  reg              d1_reasons_to_wait;
  reg              d1_watch_dog_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_watch_dog_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_watch_dog_s1_from_cpu_0_data_master;
  wire             wait_for_watch_dog_s1_counter;
  wire    [  2: 0] watch_dog_s1_address;
  wire             watch_dog_s1_allgrants;
  wire             watch_dog_s1_allow_new_arb_cycle;
  wire             watch_dog_s1_any_bursting_master_saved_grant;
  wire             watch_dog_s1_any_continuerequest;
  wire             watch_dog_s1_arb_counter_enable;
  reg     [  2: 0] watch_dog_s1_arb_share_counter;
  wire    [  2: 0] watch_dog_s1_arb_share_counter_next_value;
  wire    [  2: 0] watch_dog_s1_arb_share_set_values;
  wire             watch_dog_s1_beginbursttransfer_internal;
  wire             watch_dog_s1_begins_xfer;
  wire             watch_dog_s1_chipselect;
  wire             watch_dog_s1_end_xfer;
  wire             watch_dog_s1_firsttransfer;
  wire             watch_dog_s1_grant_vector;
  wire             watch_dog_s1_in_a_read_cycle;
  wire             watch_dog_s1_in_a_write_cycle;
  wire             watch_dog_s1_irq_from_sa;
  wire             watch_dog_s1_master_qreq_vector;
  wire             watch_dog_s1_non_bursting_master_requests;
  wire    [ 15: 0] watch_dog_s1_readdata_from_sa;
  reg              watch_dog_s1_reg_firsttransfer;
  wire             watch_dog_s1_reset_n;
  wire             watch_dog_s1_resetrequest_from_sa;
  reg              watch_dog_s1_slavearbiterlockenable;
  wire             watch_dog_s1_slavearbiterlockenable2;
  wire             watch_dog_s1_unreg_firsttransfer;
  wire             watch_dog_s1_waits_for_read;
  wire             watch_dog_s1_waits_for_write;
  wire             watch_dog_s1_write_n;
  wire    [ 15: 0] watch_dog_s1_writedata;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~watch_dog_s1_end_xfer;
    end


  assign watch_dog_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_watch_dog_s1));
  //assign watch_dog_s1_readdata_from_sa = watch_dog_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign watch_dog_s1_readdata_from_sa = watch_dog_s1_readdata;

  assign cpu_0_data_master_requests_watch_dog_s1 = ({cpu_0_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h8013000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //watch_dog_s1_arb_share_counter set values, which is an e_mux
  assign watch_dog_s1_arb_share_set_values = 1;

  //watch_dog_s1_non_bursting_master_requests mux, which is an e_mux
  assign watch_dog_s1_non_bursting_master_requests = cpu_0_data_master_requests_watch_dog_s1;

  //watch_dog_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign watch_dog_s1_any_bursting_master_saved_grant = 0;

  //watch_dog_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign watch_dog_s1_arb_share_counter_next_value = watch_dog_s1_firsttransfer ? (watch_dog_s1_arb_share_set_values - 1) : |watch_dog_s1_arb_share_counter ? (watch_dog_s1_arb_share_counter - 1) : 0;

  //watch_dog_s1_allgrants all slave grants, which is an e_mux
  assign watch_dog_s1_allgrants = |watch_dog_s1_grant_vector;

  //watch_dog_s1_end_xfer assignment, which is an e_assign
  assign watch_dog_s1_end_xfer = ~(watch_dog_s1_waits_for_read | watch_dog_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_watch_dog_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_watch_dog_s1 = watch_dog_s1_end_xfer & (~watch_dog_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //watch_dog_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign watch_dog_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_watch_dog_s1 & watch_dog_s1_allgrants) | (end_xfer_arb_share_counter_term_watch_dog_s1 & ~watch_dog_s1_non_bursting_master_requests);

  //watch_dog_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          watch_dog_s1_arb_share_counter <= 0;
      else if (watch_dog_s1_arb_counter_enable)
          watch_dog_s1_arb_share_counter <= watch_dog_s1_arb_share_counter_next_value;
    end


  //watch_dog_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          watch_dog_s1_slavearbiterlockenable <= 0;
      else if ((|watch_dog_s1_master_qreq_vector & end_xfer_arb_share_counter_term_watch_dog_s1) | (end_xfer_arb_share_counter_term_watch_dog_s1 & ~watch_dog_s1_non_bursting_master_requests))
          watch_dog_s1_slavearbiterlockenable <= |watch_dog_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master watch_dog/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = watch_dog_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //watch_dog_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign watch_dog_s1_slavearbiterlockenable2 = |watch_dog_s1_arb_share_counter_next_value;

  //cpu_0/data_master watch_dog/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = watch_dog_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //watch_dog_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign watch_dog_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_watch_dog_s1 = cpu_0_data_master_requests_watch_dog_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //watch_dog_s1_writedata mux, which is an e_mux
  assign watch_dog_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_watch_dog_s1 = cpu_0_data_master_qualified_request_watch_dog_s1;

  //cpu_0/data_master saved-grant watch_dog/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_watch_dog_s1 = cpu_0_data_master_requests_watch_dog_s1;

  //allow new arb cycle for watch_dog/s1, which is an e_assign
  assign watch_dog_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign watch_dog_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign watch_dog_s1_master_qreq_vector = 1;

  //watch_dog_s1_reset_n assignment, which is an e_assign
  assign watch_dog_s1_reset_n = reset_n;

  //assign watch_dog_s1_resetrequest_from_sa = watch_dog_s1_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign watch_dog_s1_resetrequest_from_sa = watch_dog_s1_resetrequest;

  assign watch_dog_s1_chipselect = cpu_0_data_master_granted_watch_dog_s1;
  //watch_dog_s1_firsttransfer first transaction, which is an e_assign
  assign watch_dog_s1_firsttransfer = watch_dog_s1_begins_xfer ? watch_dog_s1_unreg_firsttransfer : watch_dog_s1_reg_firsttransfer;

  //watch_dog_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign watch_dog_s1_unreg_firsttransfer = ~(watch_dog_s1_slavearbiterlockenable & watch_dog_s1_any_continuerequest);

  //watch_dog_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          watch_dog_s1_reg_firsttransfer <= 1'b1;
      else if (watch_dog_s1_begins_xfer)
          watch_dog_s1_reg_firsttransfer <= watch_dog_s1_unreg_firsttransfer;
    end


  //watch_dog_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign watch_dog_s1_beginbursttransfer_internal = watch_dog_s1_begins_xfer;

  //~watch_dog_s1_write_n assignment, which is an e_mux
  assign watch_dog_s1_write_n = ~(cpu_0_data_master_granted_watch_dog_s1 & cpu_0_data_master_write);

  assign shifted_address_to_watch_dog_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //watch_dog_s1_address mux, which is an e_mux
  assign watch_dog_s1_address = shifted_address_to_watch_dog_s1_from_cpu_0_data_master >> 2;

  //d1_watch_dog_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_watch_dog_s1_end_xfer <= 1;
      else 
        d1_watch_dog_s1_end_xfer <= watch_dog_s1_end_xfer;
    end


  //watch_dog_s1_waits_for_read in a cycle, which is an e_mux
  assign watch_dog_s1_waits_for_read = watch_dog_s1_in_a_read_cycle & watch_dog_s1_begins_xfer;

  //watch_dog_s1_in_a_read_cycle assignment, which is an e_assign
  assign watch_dog_s1_in_a_read_cycle = cpu_0_data_master_granted_watch_dog_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = watch_dog_s1_in_a_read_cycle;

  //watch_dog_s1_waits_for_write in a cycle, which is an e_mux
  assign watch_dog_s1_waits_for_write = watch_dog_s1_in_a_write_cycle & 0;

  //watch_dog_s1_in_a_write_cycle assignment, which is an e_assign
  assign watch_dog_s1_in_a_write_cycle = cpu_0_data_master_granted_watch_dog_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = watch_dog_s1_in_a_write_cycle;

  assign wait_for_watch_dog_s1_counter = 0;
  //assign watch_dog_s1_irq_from_sa = watch_dog_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign watch_dog_s1_irq_from_sa = watch_dog_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //watch_dog/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module gige_trans_cpu_reset_clk_0_domain_synch_module (
                                                        // inputs:
                                                         clk,
                                                         data_in,
                                                         reset_n,

                                                        // outputs:
                                                         data_out
                                                      )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module gige_trans_cpu (
                        // 1) global signals:
                         clk_0,
                         reset_n,

                        // the_SCL_A
                         out_port_from_the_SCL_A,

                        // the_SCL_B
                         out_port_from_the_SCL_B,

                        // the_SDA_A
                         bidir_port_to_and_from_the_SDA_A,

                        // the_SDA_B
                         bidir_port_to_and_from_the_SDA_B,

                        // the_board_in
                         in_port_to_the_board_in,

                        // the_board_out
                         out_port_from_the_board_out,

                        // the_export
                         addr_from_the_export,
                         rd_n_from_the_export,
                         rdata_to_the_export,
                         wdata_from_the_export,
                         wr_n_from_the_export,

                        // the_load_para
                         addr_from_the_load_para,
                         rd_n_from_the_load_para,
                         rdata_to_the_load_para,
                         wdata_from_the_load_para,
                         wr_n_from_the_load_para,

                        // the_sdram_0
                         zs_addr_from_the_sdram_0,
                         zs_ba_from_the_sdram_0,
                         zs_cas_n_from_the_sdram_0,
                         zs_cke_from_the_sdram_0,
                         zs_cs_n_from_the_sdram_0,
                         zs_dq_to_and_from_the_sdram_0,
                         zs_dqm_from_the_sdram_0,
                         zs_ras_n_from_the_sdram_0,
                         zs_we_n_from_the_sdram_0,

                        // the_udpram
                         addr_from_the_udpram,
                         rd_n_from_the_udpram,
                         rdata_to_the_udpram,
                         wdata_from_the_udpram,
                         wr_n_from_the_udpram
                      )
;

  output  [  8: 0] addr_from_the_export;
  output  [  8: 0] addr_from_the_load_para;
  output  [ 15: 0] addr_from_the_udpram;
  inout            bidir_port_to_and_from_the_SDA_A;
  inout            bidir_port_to_and_from_the_SDA_B;
  output           out_port_from_the_SCL_A;
  output           out_port_from_the_SCL_B;
  output  [  7: 0] out_port_from_the_board_out;
  output           rd_n_from_the_export;
  output           rd_n_from_the_load_para;
  output           rd_n_from_the_udpram;
  output  [ 31: 0] wdata_from_the_export;
  output  [ 31: 0] wdata_from_the_load_para;
  output  [  7: 0] wdata_from_the_udpram;
  output           wr_n_from_the_export;
  output           wr_n_from_the_load_para;
  output           wr_n_from_the_udpram;
  output  [ 12: 0] zs_addr_from_the_sdram_0;
  output  [  1: 0] zs_ba_from_the_sdram_0;
  output           zs_cas_n_from_the_sdram_0;
  output           zs_cke_from_the_sdram_0;
  output           zs_cs_n_from_the_sdram_0;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  output  [  1: 0] zs_dqm_from_the_sdram_0;
  output           zs_ras_n_from_the_sdram_0;
  output           zs_we_n_from_the_sdram_0;
  input            clk_0;
  input   [  7: 0] in_port_to_the_board_in;
  input   [ 31: 0] rdata_to_the_export;
  input   [ 31: 0] rdata_to_the_load_para;
  input   [  7: 0] rdata_to_the_udpram;
  input            reset_n;

  wire    [  1: 0] SCL_A_s1_address;
  wire             SCL_A_s1_chipselect;
  wire             SCL_A_s1_readdata;
  wire             SCL_A_s1_readdata_from_sa;
  wire             SCL_A_s1_reset_n;
  wire             SCL_A_s1_write_n;
  wire             SCL_A_s1_writedata;
  wire    [  1: 0] SCL_B_s1_address;
  wire             SCL_B_s1_chipselect;
  wire             SCL_B_s1_readdata;
  wire             SCL_B_s1_readdata_from_sa;
  wire             SCL_B_s1_reset_n;
  wire             SCL_B_s1_write_n;
  wire             SCL_B_s1_writedata;
  wire    [  1: 0] SDA_A_s1_address;
  wire             SDA_A_s1_chipselect;
  wire             SDA_A_s1_readdata;
  wire             SDA_A_s1_readdata_from_sa;
  wire             SDA_A_s1_reset_n;
  wire             SDA_A_s1_write_n;
  wire             SDA_A_s1_writedata;
  wire    [  1: 0] SDA_B_s1_address;
  wire             SDA_B_s1_chipselect;
  wire             SDA_B_s1_readdata;
  wire             SDA_B_s1_readdata_from_sa;
  wire             SDA_B_s1_reset_n;
  wire             SDA_B_s1_write_n;
  wire             SDA_B_s1_writedata;
  wire    [  8: 0] addr_from_the_export;
  wire    [  8: 0] addr_from_the_load_para;
  wire    [ 15: 0] addr_from_the_udpram;
  wire             bidir_port_to_and_from_the_SDA_A;
  wire             bidir_port_to_and_from_the_SDA_B;
  wire    [  1: 0] board_in_s1_address;
  wire    [  7: 0] board_in_s1_readdata;
  wire    [  7: 0] board_in_s1_readdata_from_sa;
  wire             board_in_s1_reset_n;
  wire    [  1: 0] board_out_s1_address;
  wire             board_out_s1_chipselect;
  wire    [  7: 0] board_out_s1_readdata;
  wire    [  7: 0] board_out_s1_readdata_from_sa;
  wire             board_out_s1_reset_n;
  wire             board_out_s1_write_n;
  wire    [  7: 0] board_out_s1_writedata;
  wire             clk_0_reset_n;
  wire    [ 27: 0] cpu_0_data_master_address;
  wire    [ 27: 0] cpu_0_data_master_address_to_slave;
  wire    [  3: 0] cpu_0_data_master_byteenable;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  wire             cpu_0_data_master_byteenable_udpram_in_avs;
  wire    [  1: 0] cpu_0_data_master_dbs_address;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire    [  7: 0] cpu_0_data_master_dbs_write_8;
  wire             cpu_0_data_master_debugaccess;
  wire             cpu_0_data_master_granted_SCL_A_s1;
  wire             cpu_0_data_master_granted_SCL_B_s1;
  wire             cpu_0_data_master_granted_SDA_A_s1;
  wire             cpu_0_data_master_granted_SDA_B_s1;
  wire             cpu_0_data_master_granted_board_in_s1;
  wire             cpu_0_data_master_granted_board_out_s1;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_granted_export_in_avs;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_granted_load_para_in_avs;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_granted_udpram_in_avs;
  wire             cpu_0_data_master_granted_watch_dog_s1;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_no_byte_enables_and_last_term;
  wire             cpu_0_data_master_qualified_request_SCL_A_s1;
  wire             cpu_0_data_master_qualified_request_SCL_B_s1;
  wire             cpu_0_data_master_qualified_request_SDA_A_s1;
  wire             cpu_0_data_master_qualified_request_SDA_B_s1;
  wire             cpu_0_data_master_qualified_request_board_in_s1;
  wire             cpu_0_data_master_qualified_request_board_out_s1;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_qualified_request_export_in_avs;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_load_para_in_avs;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_udpram_in_avs;
  wire             cpu_0_data_master_qualified_request_watch_dog_s1;
  wire             cpu_0_data_master_read;
  wire             cpu_0_data_master_read_data_valid_SCL_A_s1;
  wire             cpu_0_data_master_read_data_valid_SCL_B_s1;
  wire             cpu_0_data_master_read_data_valid_SDA_A_s1;
  wire             cpu_0_data_master_read_data_valid_SDA_B_s1;
  wire             cpu_0_data_master_read_data_valid_board_in_s1;
  wire             cpu_0_data_master_read_data_valid_board_out_s1;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_read_data_valid_export_in_avs;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_load_para_in_avs;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_udpram_in_avs;
  wire             cpu_0_data_master_read_data_valid_watch_dog_s1;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_requests_SCL_A_s1;
  wire             cpu_0_data_master_requests_SCL_B_s1;
  wire             cpu_0_data_master_requests_SDA_A_s1;
  wire             cpu_0_data_master_requests_SDA_B_s1;
  wire             cpu_0_data_master_requests_board_in_s1;
  wire             cpu_0_data_master_requests_board_out_s1;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_data_master_requests_export_in_avs;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_load_para_in_avs;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_requests_udpram_in_avs;
  wire             cpu_0_data_master_requests_watch_dog_s1;
  wire             cpu_0_data_master_waitrequest;
  wire             cpu_0_data_master_write;
  wire    [ 31: 0] cpu_0_data_master_writedata;
  wire    [ 27: 0] cpu_0_instruction_master_address;
  wire    [ 27: 0] cpu_0_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_0_instruction_master_dbs_address;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_latency_counter;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_read;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_waitrequest;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  wire             cpu_0_jtag_debug_module_reset;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  wire             d1_SCL_A_s1_end_xfer;
  wire             d1_SCL_B_s1_end_xfer;
  wire             d1_SDA_A_s1_end_xfer;
  wire             d1_SDA_B_s1_end_xfer;
  wire             d1_board_in_s1_end_xfer;
  wire             d1_board_out_s1_end_xfer;
  wire             d1_cpu_0_jtag_debug_module_end_xfer;
  wire             d1_epcs_flash_controller_0_epcs_control_port_end_xfer;
  wire             d1_export_in_avs_end_xfer;
  wire             d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             d1_load_para_in_avs_end_xfer;
  wire             d1_sdram_0_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_udpram_in_avs_end_xfer;
  wire             d1_watch_dog_s1_end_xfer;
  wire    [  8: 0] epcs_flash_controller_0_epcs_control_port_address;
  wire             epcs_flash_controller_0_epcs_control_port_chipselect;
  wire             epcs_flash_controller_0_epcs_control_port_dataavailable;
  wire             epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_endofpacket;
  wire             epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_irq;
  wire             epcs_flash_controller_0_epcs_control_port_irq_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_flash_controller_0_epcs_control_port_readdata;
  wire    [ 31: 0] epcs_flash_controller_0_epcs_control_port_readdata_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_readyfordata;
  wire             epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_reset_n;
  wire             epcs_flash_controller_0_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_flash_controller_0_epcs_control_port_writedata;
  wire    [  8: 0] export_in_avs_address;
  wire             export_in_avs_chipselect_n;
  wire             export_in_avs_read_n;
  wire    [ 31: 0] export_in_avs_readdata;
  wire    [ 31: 0] export_in_avs_readdata_from_sa;
  wire             export_in_avs_wait_counter_eq_0;
  wire             export_in_avs_write_n;
  wire    [ 31: 0] export_in_avs_writedata;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_irq;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [  8: 0] load_para_in_avs_address;
  wire             load_para_in_avs_chipselect_n;
  wire             load_para_in_avs_read_n;
  wire    [ 31: 0] load_para_in_avs_readdata;
  wire    [ 31: 0] load_para_in_avs_readdata_from_sa;
  wire             load_para_in_avs_wait_counter_eq_0;
  wire             load_para_in_avs_write_n;
  wire    [ 31: 0] load_para_in_avs_writedata;
  wire             out_port_from_the_SCL_A;
  wire             out_port_from_the_SCL_B;
  wire    [  7: 0] out_port_from_the_board_out;
  wire             rd_n_from_the_export;
  wire             rd_n_from_the_load_para;
  wire             rd_n_from_the_udpram;
  wire             registered_cpu_0_data_master_read_data_valid_udpram_in_avs;
  wire             reset_n_sources;
  wire    [ 24: 0] sdram_0_s1_address;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid;
  wire             sdram_0_s1_reset_n;
  wire             sdram_0_s1_waitrequest;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire             sysid_control_slave_address;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire    [ 15: 0] udpram_in_avs_address;
  wire             udpram_in_avs_chipselect_n;
  wire             udpram_in_avs_read_n;
  wire    [  7: 0] udpram_in_avs_readdata;
  wire    [  7: 0] udpram_in_avs_readdata_from_sa;
  wire             udpram_in_avs_write_n;
  wire    [  7: 0] udpram_in_avs_writedata;
  wire    [  2: 0] watch_dog_s1_address;
  wire             watch_dog_s1_chipselect;
  wire             watch_dog_s1_irq;
  wire             watch_dog_s1_irq_from_sa;
  wire    [ 15: 0] watch_dog_s1_readdata;
  wire    [ 15: 0] watch_dog_s1_readdata_from_sa;
  wire             watch_dog_s1_reset_n;
  wire             watch_dog_s1_resetrequest;
  wire             watch_dog_s1_resetrequest_from_sa;
  wire             watch_dog_s1_write_n;
  wire    [ 15: 0] watch_dog_s1_writedata;
  wire    [ 31: 0] wdata_from_the_export;
  wire    [ 31: 0] wdata_from_the_load_para;
  wire    [  7: 0] wdata_from_the_udpram;
  wire             wr_n_from_the_export;
  wire             wr_n_from_the_load_para;
  wire             wr_n_from_the_udpram;
  wire    [ 12: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;
  SCL_A_s1_arbitrator the_SCL_A_s1
    (
      .SCL_A_s1_address                             (SCL_A_s1_address),
      .SCL_A_s1_chipselect                          (SCL_A_s1_chipselect),
      .SCL_A_s1_readdata                            (SCL_A_s1_readdata),
      .SCL_A_s1_readdata_from_sa                    (SCL_A_s1_readdata_from_sa),
      .SCL_A_s1_reset_n                             (SCL_A_s1_reset_n),
      .SCL_A_s1_write_n                             (SCL_A_s1_write_n),
      .SCL_A_s1_writedata                           (SCL_A_s1_writedata),
      .clk                                          (clk_0),
      .cpu_0_data_master_address_to_slave           (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_SCL_A_s1           (cpu_0_data_master_granted_SCL_A_s1),
      .cpu_0_data_master_qualified_request_SCL_A_s1 (cpu_0_data_master_qualified_request_SCL_A_s1),
      .cpu_0_data_master_read                       (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_SCL_A_s1   (cpu_0_data_master_read_data_valid_SCL_A_s1),
      .cpu_0_data_master_requests_SCL_A_s1          (cpu_0_data_master_requests_SCL_A_s1),
      .cpu_0_data_master_waitrequest                (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                      (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                  (cpu_0_data_master_writedata),
      .d1_SCL_A_s1_end_xfer                         (d1_SCL_A_s1_end_xfer),
      .reset_n                                      (clk_0_reset_n)
    );

  SCL_A the_SCL_A
    (
      .address    (SCL_A_s1_address),
      .chipselect (SCL_A_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_SCL_A),
      .readdata   (SCL_A_s1_readdata),
      .reset_n    (SCL_A_s1_reset_n),
      .write_n    (SCL_A_s1_write_n),
      .writedata  (SCL_A_s1_writedata)
    );

  SCL_B_s1_arbitrator the_SCL_B_s1
    (
      .SCL_B_s1_address                             (SCL_B_s1_address),
      .SCL_B_s1_chipselect                          (SCL_B_s1_chipselect),
      .SCL_B_s1_readdata                            (SCL_B_s1_readdata),
      .SCL_B_s1_readdata_from_sa                    (SCL_B_s1_readdata_from_sa),
      .SCL_B_s1_reset_n                             (SCL_B_s1_reset_n),
      .SCL_B_s1_write_n                             (SCL_B_s1_write_n),
      .SCL_B_s1_writedata                           (SCL_B_s1_writedata),
      .clk                                          (clk_0),
      .cpu_0_data_master_address_to_slave           (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_SCL_B_s1           (cpu_0_data_master_granted_SCL_B_s1),
      .cpu_0_data_master_qualified_request_SCL_B_s1 (cpu_0_data_master_qualified_request_SCL_B_s1),
      .cpu_0_data_master_read                       (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_SCL_B_s1   (cpu_0_data_master_read_data_valid_SCL_B_s1),
      .cpu_0_data_master_requests_SCL_B_s1          (cpu_0_data_master_requests_SCL_B_s1),
      .cpu_0_data_master_waitrequest                (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                      (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                  (cpu_0_data_master_writedata),
      .d1_SCL_B_s1_end_xfer                         (d1_SCL_B_s1_end_xfer),
      .reset_n                                      (clk_0_reset_n)
    );

  SCL_B the_SCL_B
    (
      .address    (SCL_B_s1_address),
      .chipselect (SCL_B_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_SCL_B),
      .readdata   (SCL_B_s1_readdata),
      .reset_n    (SCL_B_s1_reset_n),
      .write_n    (SCL_B_s1_write_n),
      .writedata  (SCL_B_s1_writedata)
    );

  SDA_A_s1_arbitrator the_SDA_A_s1
    (
      .SDA_A_s1_address                             (SDA_A_s1_address),
      .SDA_A_s1_chipselect                          (SDA_A_s1_chipselect),
      .SDA_A_s1_readdata                            (SDA_A_s1_readdata),
      .SDA_A_s1_readdata_from_sa                    (SDA_A_s1_readdata_from_sa),
      .SDA_A_s1_reset_n                             (SDA_A_s1_reset_n),
      .SDA_A_s1_write_n                             (SDA_A_s1_write_n),
      .SDA_A_s1_writedata                           (SDA_A_s1_writedata),
      .clk                                          (clk_0),
      .cpu_0_data_master_address_to_slave           (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_SDA_A_s1           (cpu_0_data_master_granted_SDA_A_s1),
      .cpu_0_data_master_qualified_request_SDA_A_s1 (cpu_0_data_master_qualified_request_SDA_A_s1),
      .cpu_0_data_master_read                       (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_SDA_A_s1   (cpu_0_data_master_read_data_valid_SDA_A_s1),
      .cpu_0_data_master_requests_SDA_A_s1          (cpu_0_data_master_requests_SDA_A_s1),
      .cpu_0_data_master_waitrequest                (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                      (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                  (cpu_0_data_master_writedata),
      .d1_SDA_A_s1_end_xfer                         (d1_SDA_A_s1_end_xfer),
      .reset_n                                      (clk_0_reset_n)
    );

  SDA_A the_SDA_A
    (
      .address    (SDA_A_s1_address),
      .bidir_port (bidir_port_to_and_from_the_SDA_A),
      .chipselect (SDA_A_s1_chipselect),
      .clk        (clk_0),
      .readdata   (SDA_A_s1_readdata),
      .reset_n    (SDA_A_s1_reset_n),
      .write_n    (SDA_A_s1_write_n),
      .writedata  (SDA_A_s1_writedata)
    );

  SDA_B_s1_arbitrator the_SDA_B_s1
    (
      .SDA_B_s1_address                             (SDA_B_s1_address),
      .SDA_B_s1_chipselect                          (SDA_B_s1_chipselect),
      .SDA_B_s1_readdata                            (SDA_B_s1_readdata),
      .SDA_B_s1_readdata_from_sa                    (SDA_B_s1_readdata_from_sa),
      .SDA_B_s1_reset_n                             (SDA_B_s1_reset_n),
      .SDA_B_s1_write_n                             (SDA_B_s1_write_n),
      .SDA_B_s1_writedata                           (SDA_B_s1_writedata),
      .clk                                          (clk_0),
      .cpu_0_data_master_address_to_slave           (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_SDA_B_s1           (cpu_0_data_master_granted_SDA_B_s1),
      .cpu_0_data_master_qualified_request_SDA_B_s1 (cpu_0_data_master_qualified_request_SDA_B_s1),
      .cpu_0_data_master_read                       (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_SDA_B_s1   (cpu_0_data_master_read_data_valid_SDA_B_s1),
      .cpu_0_data_master_requests_SDA_B_s1          (cpu_0_data_master_requests_SDA_B_s1),
      .cpu_0_data_master_waitrequest                (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                      (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                  (cpu_0_data_master_writedata),
      .d1_SDA_B_s1_end_xfer                         (d1_SDA_B_s1_end_xfer),
      .reset_n                                      (clk_0_reset_n)
    );

  SDA_B the_SDA_B
    (
      .address    (SDA_B_s1_address),
      .bidir_port (bidir_port_to_and_from_the_SDA_B),
      .chipselect (SDA_B_s1_chipselect),
      .clk        (clk_0),
      .readdata   (SDA_B_s1_readdata),
      .reset_n    (SDA_B_s1_reset_n),
      .write_n    (SDA_B_s1_write_n),
      .writedata  (SDA_B_s1_writedata)
    );

  board_in_s1_arbitrator the_board_in_s1
    (
      .board_in_s1_address                             (board_in_s1_address),
      .board_in_s1_readdata                            (board_in_s1_readdata),
      .board_in_s1_readdata_from_sa                    (board_in_s1_readdata_from_sa),
      .board_in_s1_reset_n                             (board_in_s1_reset_n),
      .clk                                             (clk_0),
      .cpu_0_data_master_address_to_slave              (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_board_in_s1           (cpu_0_data_master_granted_board_in_s1),
      .cpu_0_data_master_qualified_request_board_in_s1 (cpu_0_data_master_qualified_request_board_in_s1),
      .cpu_0_data_master_read                          (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_board_in_s1   (cpu_0_data_master_read_data_valid_board_in_s1),
      .cpu_0_data_master_requests_board_in_s1          (cpu_0_data_master_requests_board_in_s1),
      .cpu_0_data_master_write                         (cpu_0_data_master_write),
      .d1_board_in_s1_end_xfer                         (d1_board_in_s1_end_xfer),
      .reset_n                                         (clk_0_reset_n)
    );

  board_in the_board_in
    (
      .address  (board_in_s1_address),
      .clk      (clk_0),
      .in_port  (in_port_to_the_board_in),
      .readdata (board_in_s1_readdata),
      .reset_n  (board_in_s1_reset_n)
    );

  board_out_s1_arbitrator the_board_out_s1
    (
      .board_out_s1_address                             (board_out_s1_address),
      .board_out_s1_chipselect                          (board_out_s1_chipselect),
      .board_out_s1_readdata                            (board_out_s1_readdata),
      .board_out_s1_readdata_from_sa                    (board_out_s1_readdata_from_sa),
      .board_out_s1_reset_n                             (board_out_s1_reset_n),
      .board_out_s1_write_n                             (board_out_s1_write_n),
      .board_out_s1_writedata                           (board_out_s1_writedata),
      .clk                                              (clk_0),
      .cpu_0_data_master_address_to_slave               (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                     (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_board_out_s1           (cpu_0_data_master_granted_board_out_s1),
      .cpu_0_data_master_qualified_request_board_out_s1 (cpu_0_data_master_qualified_request_board_out_s1),
      .cpu_0_data_master_read                           (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_board_out_s1   (cpu_0_data_master_read_data_valid_board_out_s1),
      .cpu_0_data_master_requests_board_out_s1          (cpu_0_data_master_requests_board_out_s1),
      .cpu_0_data_master_waitrequest                    (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                          (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                      (cpu_0_data_master_writedata),
      .d1_board_out_s1_end_xfer                         (d1_board_out_s1_end_xfer),
      .reset_n                                          (clk_0_reset_n)
    );

  board_out the_board_out
    (
      .address    (board_out_s1_address),
      .chipselect (board_out_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_board_out),
      .readdata   (board_out_s1_readdata),
      .reset_n    (board_out_s1_reset_n),
      .write_n    (board_out_s1_write_n),
      .writedata  (board_out_s1_writedata)
    );

  cpu_0_jtag_debug_module_arbitrator the_cpu_0_jtag_debug_module
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_debugaccess                                      (cpu_0_data_master_debugaccess),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                  (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module        (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module          (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                 (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_jtag_debug_module_address                                    (cpu_0_jtag_debug_module_address),
      .cpu_0_jtag_debug_module_begintransfer                              (cpu_0_jtag_debug_module_begintransfer),
      .cpu_0_jtag_debug_module_byteenable                                 (cpu_0_jtag_debug_module_byteenable),
      .cpu_0_jtag_debug_module_chipselect                                 (cpu_0_jtag_debug_module_chipselect),
      .cpu_0_jtag_debug_module_debugaccess                                (cpu_0_jtag_debug_module_debugaccess),
      .cpu_0_jtag_debug_module_readdata                                   (cpu_0_jtag_debug_module_readdata),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpu_0_jtag_debug_module_reset                                      (cpu_0_jtag_debug_module_reset),
      .cpu_0_jtag_debug_module_reset_n                                    (cpu_0_jtag_debug_module_reset_n),
      .cpu_0_jtag_debug_module_resetrequest                               (cpu_0_jtag_debug_module_resetrequest),
      .cpu_0_jtag_debug_module_resetrequest_from_sa                       (cpu_0_jtag_debug_module_resetrequest_from_sa),
      .cpu_0_jtag_debug_module_write                                      (cpu_0_jtag_debug_module_write),
      .cpu_0_jtag_debug_module_writedata                                  (cpu_0_jtag_debug_module_writedata),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .reset_n                                                            (clk_0_reset_n)
    );

  cpu_0_data_master_arbitrator the_cpu_0_data_master
    (
      .SCL_A_s1_readdata_from_sa                                                     (SCL_A_s1_readdata_from_sa),
      .SCL_B_s1_readdata_from_sa                                                     (SCL_B_s1_readdata_from_sa),
      .SDA_A_s1_readdata_from_sa                                                     (SDA_A_s1_readdata_from_sa),
      .SDA_B_s1_readdata_from_sa                                                     (SDA_B_s1_readdata_from_sa),
      .board_in_s1_readdata_from_sa                                                  (board_in_s1_readdata_from_sa),
      .board_out_s1_readdata_from_sa                                                 (board_out_s1_readdata_from_sa),
      .clk                                                                           (clk_0),
      .cpu_0_data_master_address                                                     (cpu_0_data_master_address),
      .cpu_0_data_master_address_to_slave                                            (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable_sdram_0_s1                                       (cpu_0_data_master_byteenable_sdram_0_s1),
      .cpu_0_data_master_byteenable_udpram_in_avs                                    (cpu_0_data_master_byteenable_udpram_in_avs),
      .cpu_0_data_master_dbs_address                                                 (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                                (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_dbs_write_8                                                 (cpu_0_data_master_dbs_write_8),
      .cpu_0_data_master_granted_SCL_A_s1                                            (cpu_0_data_master_granted_SCL_A_s1),
      .cpu_0_data_master_granted_SCL_B_s1                                            (cpu_0_data_master_granted_SCL_B_s1),
      .cpu_0_data_master_granted_SDA_A_s1                                            (cpu_0_data_master_granted_SDA_A_s1),
      .cpu_0_data_master_granted_SDA_B_s1                                            (cpu_0_data_master_granted_SDA_B_s1),
      .cpu_0_data_master_granted_board_in_s1                                         (cpu_0_data_master_granted_board_in_s1),
      .cpu_0_data_master_granted_board_out_s1                                        (cpu_0_data_master_granted_board_out_s1),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                             (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port           (cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_granted_export_in_avs                                       (cpu_0_data_master_granted_export_in_avs),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave                       (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_granted_load_para_in_avs                                    (cpu_0_data_master_granted_load_para_in_avs),
      .cpu_0_data_master_granted_sdram_0_s1                                          (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_granted_sysid_control_slave                                 (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_granted_udpram_in_avs                                       (cpu_0_data_master_granted_udpram_in_avs),
      .cpu_0_data_master_granted_watch_dog_s1                                        (cpu_0_data_master_granted_watch_dog_s1),
      .cpu_0_data_master_irq                                                         (cpu_0_data_master_irq),
      .cpu_0_data_master_no_byte_enables_and_last_term                               (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_SCL_A_s1                                  (cpu_0_data_master_qualified_request_SCL_A_s1),
      .cpu_0_data_master_qualified_request_SCL_B_s1                                  (cpu_0_data_master_qualified_request_SCL_B_s1),
      .cpu_0_data_master_qualified_request_SDA_A_s1                                  (cpu_0_data_master_qualified_request_SDA_A_s1),
      .cpu_0_data_master_qualified_request_SDA_B_s1                                  (cpu_0_data_master_qualified_request_SDA_B_s1),
      .cpu_0_data_master_qualified_request_board_in_s1                               (cpu_0_data_master_qualified_request_board_in_s1),
      .cpu_0_data_master_qualified_request_board_out_s1                              (cpu_0_data_master_qualified_request_board_out_s1),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module                   (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port (cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_qualified_request_export_in_avs                             (cpu_0_data_master_qualified_request_export_in_avs),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave             (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_load_para_in_avs                          (cpu_0_data_master_qualified_request_load_para_in_avs),
      .cpu_0_data_master_qualified_request_sdram_0_s1                                (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_qualified_request_sysid_control_slave                       (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_qualified_request_udpram_in_avs                             (cpu_0_data_master_qualified_request_udpram_in_avs),
      .cpu_0_data_master_qualified_request_watch_dog_s1                              (cpu_0_data_master_qualified_request_watch_dog_s1),
      .cpu_0_data_master_read                                                        (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_SCL_A_s1                                    (cpu_0_data_master_read_data_valid_SCL_A_s1),
      .cpu_0_data_master_read_data_valid_SCL_B_s1                                    (cpu_0_data_master_read_data_valid_SCL_B_s1),
      .cpu_0_data_master_read_data_valid_SDA_A_s1                                    (cpu_0_data_master_read_data_valid_SDA_A_s1),
      .cpu_0_data_master_read_data_valid_SDA_B_s1                                    (cpu_0_data_master_read_data_valid_SDA_B_s1),
      .cpu_0_data_master_read_data_valid_board_in_s1                                 (cpu_0_data_master_read_data_valid_board_in_s1),
      .cpu_0_data_master_read_data_valid_board_out_s1                                (cpu_0_data_master_read_data_valid_board_out_s1),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module                     (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port   (cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_read_data_valid_export_in_avs                               (cpu_0_data_master_read_data_valid_export_in_avs),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave               (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read_data_valid_load_para_in_avs                            (cpu_0_data_master_read_data_valid_load_para_in_avs),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                                  (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register                   (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_read_data_valid_sysid_control_slave                         (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_read_data_valid_udpram_in_avs                               (cpu_0_data_master_read_data_valid_udpram_in_avs),
      .cpu_0_data_master_read_data_valid_watch_dog_s1                                (cpu_0_data_master_read_data_valid_watch_dog_s1),
      .cpu_0_data_master_readdata                                                    (cpu_0_data_master_readdata),
      .cpu_0_data_master_requests_SCL_A_s1                                           (cpu_0_data_master_requests_SCL_A_s1),
      .cpu_0_data_master_requests_SCL_B_s1                                           (cpu_0_data_master_requests_SCL_B_s1),
      .cpu_0_data_master_requests_SDA_A_s1                                           (cpu_0_data_master_requests_SDA_A_s1),
      .cpu_0_data_master_requests_SDA_B_s1                                           (cpu_0_data_master_requests_SDA_B_s1),
      .cpu_0_data_master_requests_board_in_s1                                        (cpu_0_data_master_requests_board_in_s1),
      .cpu_0_data_master_requests_board_out_s1                                       (cpu_0_data_master_requests_board_out_s1),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                            (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port          (cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_requests_export_in_avs                                      (cpu_0_data_master_requests_export_in_avs),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave                      (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_load_para_in_avs                                   (cpu_0_data_master_requests_load_para_in_avs),
      .cpu_0_data_master_requests_sdram_0_s1                                         (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_requests_sysid_control_slave                                (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_requests_udpram_in_avs                                      (cpu_0_data_master_requests_udpram_in_avs),
      .cpu_0_data_master_requests_watch_dog_s1                                       (cpu_0_data_master_requests_watch_dog_s1),
      .cpu_0_data_master_waitrequest                                                 (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                                       (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                                   (cpu_0_data_master_writedata),
      .cpu_0_jtag_debug_module_readdata_from_sa                                      (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_SCL_A_s1_end_xfer                                                          (d1_SCL_A_s1_end_xfer),
      .d1_SCL_B_s1_end_xfer                                                          (d1_SCL_B_s1_end_xfer),
      .d1_SDA_A_s1_end_xfer                                                          (d1_SDA_A_s1_end_xfer),
      .d1_SDA_B_s1_end_xfer                                                          (d1_SDA_B_s1_end_xfer),
      .d1_board_in_s1_end_xfer                                                       (d1_board_in_s1_end_xfer),
      .d1_board_out_s1_end_xfer                                                      (d1_board_out_s1_end_xfer),
      .d1_cpu_0_jtag_debug_module_end_xfer                                           (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_epcs_flash_controller_0_epcs_control_port_end_xfer                         (d1_epcs_flash_controller_0_epcs_control_port_end_xfer),
      .d1_export_in_avs_end_xfer                                                     (d1_export_in_avs_end_xfer),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                                     (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .d1_load_para_in_avs_end_xfer                                                  (d1_load_para_in_avs_end_xfer),
      .d1_sdram_0_s1_end_xfer                                                        (d1_sdram_0_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                                               (d1_sysid_control_slave_end_xfer),
      .d1_udpram_in_avs_end_xfer                                                     (d1_udpram_in_avs_end_xfer),
      .d1_watch_dog_s1_end_xfer                                                      (d1_watch_dog_s1_end_xfer),
      .epcs_flash_controller_0_epcs_control_port_irq_from_sa                         (epcs_flash_controller_0_epcs_control_port_irq_from_sa),
      .epcs_flash_controller_0_epcs_control_port_readdata_from_sa                    (epcs_flash_controller_0_epcs_control_port_readdata_from_sa),
      .export_in_avs_readdata_from_sa                                                (export_in_avs_readdata_from_sa),
      .export_in_avs_wait_counter_eq_0                                               (export_in_avs_wait_counter_eq_0),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                                     (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                                (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                             (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .load_para_in_avs_readdata_from_sa                                             (load_para_in_avs_readdata_from_sa),
      .load_para_in_avs_wait_counter_eq_0                                            (load_para_in_avs_wait_counter_eq_0),
      .registered_cpu_0_data_master_read_data_valid_udpram_in_avs                    (registered_cpu_0_data_master_read_data_valid_udpram_in_avs),
      .reset_n                                                                       (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                                   (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                                (sdram_0_s1_waitrequest_from_sa),
      .sysid_control_slave_readdata_from_sa                                          (sysid_control_slave_readdata_from_sa),
      .udpram_in_avs_readdata_from_sa                                                (udpram_in_avs_readdata_from_sa),
      .watch_dog_s1_irq_from_sa                                                      (watch_dog_s1_irq_from_sa),
      .watch_dog_s1_readdata_from_sa                                                 (watch_dog_s1_readdata_from_sa)
    );

  cpu_0_instruction_master_arbitrator the_cpu_0_instruction_master
    (
      .clk                                                                                  (clk_0),
      .cpu_0_instruction_master_address                                                     (cpu_0_instruction_master_address),
      .cpu_0_instruction_master_address_to_slave                                            (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                                                 (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module                             (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port           (cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_instruction_master_granted_sdram_0_s1                                          (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_latency_counter                                             (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module                   (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port (cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1                                (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_read                                                        (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module                     (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port   (cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                                  (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register                   (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_readdata                                                    (cpu_0_instruction_master_readdata),
      .cpu_0_instruction_master_readdatavalid                                               (cpu_0_instruction_master_readdatavalid),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module                            (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port          (cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_instruction_master_requests_sdram_0_s1                                         (cpu_0_instruction_master_requests_sdram_0_s1),
      .cpu_0_instruction_master_waitrequest                                                 (cpu_0_instruction_master_waitrequest),
      .cpu_0_jtag_debug_module_readdata_from_sa                                             (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                                  (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_epcs_flash_controller_0_epcs_control_port_end_xfer                                (d1_epcs_flash_controller_0_epcs_control_port_end_xfer),
      .d1_sdram_0_s1_end_xfer                                                               (d1_sdram_0_s1_end_xfer),
      .epcs_flash_controller_0_epcs_control_port_readdata_from_sa                           (epcs_flash_controller_0_epcs_control_port_readdata_from_sa),
      .reset_n                                                                              (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                                          (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                                       (sdram_0_s1_waitrequest_from_sa)
    );

  cpu_0 the_cpu_0
    (
      .clk                                   (clk_0),
      .d_address                             (cpu_0_data_master_address),
      .d_byteenable                          (cpu_0_data_master_byteenable),
      .d_irq                                 (cpu_0_data_master_irq),
      .d_read                                (cpu_0_data_master_read),
      .d_readdata                            (cpu_0_data_master_readdata),
      .d_waitrequest                         (cpu_0_data_master_waitrequest),
      .d_write                               (cpu_0_data_master_write),
      .d_writedata                           (cpu_0_data_master_writedata),
      .i_address                             (cpu_0_instruction_master_address),
      .i_read                                (cpu_0_instruction_master_read),
      .i_readdata                            (cpu_0_instruction_master_readdata),
      .i_readdatavalid                       (cpu_0_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_0_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_0_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_0_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_0_jtag_debug_module_byteenable),
      .jtag_debug_module_clk                 (clk_0),
      .jtag_debug_module_debugaccess         (cpu_0_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_0_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_0_jtag_debug_module_readdata),
      .jtag_debug_module_reset               (cpu_0_jtag_debug_module_reset),
      .jtag_debug_module_resetrequest        (cpu_0_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_0_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_0_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_0_jtag_debug_module_writedata),
      .reset_n                               (cpu_0_jtag_debug_module_reset_n)
    );

  epcs_flash_controller_0_epcs_control_port_arbitrator the_epcs_flash_controller_0_epcs_control_port
    (
      .clk                                                                                  (clk_0),
      .cpu_0_data_master_address_to_slave                                                   (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port                  (cpu_0_data_master_granted_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port        (cpu_0_data_master_qualified_request_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_read                                                               (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port          (cpu_0_data_master_read_data_valid_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port                 (cpu_0_data_master_requests_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_data_master_write                                                              (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                                          (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                                            (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port           (cpu_0_instruction_master_granted_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_instruction_master_latency_counter                                             (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port (cpu_0_instruction_master_qualified_request_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_instruction_master_read                                                        (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port   (cpu_0_instruction_master_read_data_valid_epcs_flash_controller_0_epcs_control_port),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register                   (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port          (cpu_0_instruction_master_requests_epcs_flash_controller_0_epcs_control_port),
      .d1_epcs_flash_controller_0_epcs_control_port_end_xfer                                (d1_epcs_flash_controller_0_epcs_control_port_end_xfer),
      .epcs_flash_controller_0_epcs_control_port_address                                    (epcs_flash_controller_0_epcs_control_port_address),
      .epcs_flash_controller_0_epcs_control_port_chipselect                                 (epcs_flash_controller_0_epcs_control_port_chipselect),
      .epcs_flash_controller_0_epcs_control_port_dataavailable                              (epcs_flash_controller_0_epcs_control_port_dataavailable),
      .epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa                      (epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa),
      .epcs_flash_controller_0_epcs_control_port_endofpacket                                (epcs_flash_controller_0_epcs_control_port_endofpacket),
      .epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa                        (epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa),
      .epcs_flash_controller_0_epcs_control_port_irq                                        (epcs_flash_controller_0_epcs_control_port_irq),
      .epcs_flash_controller_0_epcs_control_port_irq_from_sa                                (epcs_flash_controller_0_epcs_control_port_irq_from_sa),
      .epcs_flash_controller_0_epcs_control_port_read_n                                     (epcs_flash_controller_0_epcs_control_port_read_n),
      .epcs_flash_controller_0_epcs_control_port_readdata                                   (epcs_flash_controller_0_epcs_control_port_readdata),
      .epcs_flash_controller_0_epcs_control_port_readdata_from_sa                           (epcs_flash_controller_0_epcs_control_port_readdata_from_sa),
      .epcs_flash_controller_0_epcs_control_port_readyfordata                               (epcs_flash_controller_0_epcs_control_port_readyfordata),
      .epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa                       (epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa),
      .epcs_flash_controller_0_epcs_control_port_reset_n                                    (epcs_flash_controller_0_epcs_control_port_reset_n),
      .epcs_flash_controller_0_epcs_control_port_write_n                                    (epcs_flash_controller_0_epcs_control_port_write_n),
      .epcs_flash_controller_0_epcs_control_port_writedata                                  (epcs_flash_controller_0_epcs_control_port_writedata),
      .reset_n                                                                              (clk_0_reset_n)
    );

  epcs_flash_controller_0 the_epcs_flash_controller_0
    (
      .address       (epcs_flash_controller_0_epcs_control_port_address),
      .chipselect    (epcs_flash_controller_0_epcs_control_port_chipselect),
      .clk           (clk_0),
      .dataavailable (epcs_flash_controller_0_epcs_control_port_dataavailable),
      .endofpacket   (epcs_flash_controller_0_epcs_control_port_endofpacket),
      .irq           (epcs_flash_controller_0_epcs_control_port_irq),
      .read_n        (epcs_flash_controller_0_epcs_control_port_read_n),
      .readdata      (epcs_flash_controller_0_epcs_control_port_readdata),
      .readyfordata  (epcs_flash_controller_0_epcs_control_port_readyfordata),
      .reset_n       (epcs_flash_controller_0_epcs_control_port_reset_n),
      .write_n       (epcs_flash_controller_0_epcs_control_port_write_n),
      .writedata     (epcs_flash_controller_0_epcs_control_port_writedata)
    );

  export_in_avs_arbitrator the_export_in_avs
    (
      .clk                                               (clk_0),
      .cpu_0_data_master_address_to_slave                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_export_in_avs           (cpu_0_data_master_granted_export_in_avs),
      .cpu_0_data_master_qualified_request_export_in_avs (cpu_0_data_master_qualified_request_export_in_avs),
      .cpu_0_data_master_read                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_export_in_avs   (cpu_0_data_master_read_data_valid_export_in_avs),
      .cpu_0_data_master_requests_export_in_avs          (cpu_0_data_master_requests_export_in_avs),
      .cpu_0_data_master_write                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                       (cpu_0_data_master_writedata),
      .d1_export_in_avs_end_xfer                         (d1_export_in_avs_end_xfer),
      .export_in_avs_address                             (export_in_avs_address),
      .export_in_avs_chipselect_n                        (export_in_avs_chipselect_n),
      .export_in_avs_read_n                              (export_in_avs_read_n),
      .export_in_avs_readdata                            (export_in_avs_readdata),
      .export_in_avs_readdata_from_sa                    (export_in_avs_readdata_from_sa),
      .export_in_avs_wait_counter_eq_0                   (export_in_avs_wait_counter_eq_0),
      .export_in_avs_write_n                             (export_in_avs_write_n),
      .export_in_avs_writedata                           (export_in_avs_writedata),
      .reset_n                                           (clk_0_reset_n)
    );

  export the_export
    (
      .addr                (addr_from_the_export),
      .clk                 (clk_0),
      .in_avs_address      (export_in_avs_address),
      .in_avs_chipselect_n (export_in_avs_chipselect_n),
      .in_avs_read_n       (export_in_avs_read_n),
      .in_avs_readdata     (export_in_avs_readdata),
      .in_avs_write_n      (export_in_avs_write_n),
      .in_avs_writedata    (export_in_avs_writedata),
      .rd_n                (rd_n_from_the_export),
      .rdata               (rdata_to_the_export),
      .wdata               (wdata_from_the_export),
      .wr_n                (wr_n_from_the_export)
    );

  jtag_uart_0_avalon_jtag_slave_arbitrator the_jtag_uart_0_avalon_jtag_slave
    (
      .clk                                                               (clk_0),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_waitrequest                                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_address                             (jtag_uart_0_avalon_jtag_slave_address),
      .jtag_uart_0_avalon_jtag_slave_chipselect                          (jtag_uart_0_avalon_jtag_slave_chipselect),
      .jtag_uart_0_avalon_jtag_slave_dataavailable                       (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa               (jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq                                 (jtag_uart_0_avalon_jtag_slave_irq),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_read_n                              (jtag_uart_0_avalon_jtag_slave_read_n),
      .jtag_uart_0_avalon_jtag_slave_readdata                            (jtag_uart_0_avalon_jtag_slave_readdata),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readyfordata                        (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa                (jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_reset_n                             (jtag_uart_0_avalon_jtag_slave_reset_n),
      .jtag_uart_0_avalon_jtag_slave_waitrequest                         (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_0_avalon_jtag_slave_write_n                             (jtag_uart_0_avalon_jtag_slave_write_n),
      .jtag_uart_0_avalon_jtag_slave_writedata                           (jtag_uart_0_avalon_jtag_slave_writedata),
      .reset_n                                                           (clk_0_reset_n)
    );

  jtag_uart_0 the_jtag_uart_0
    (
      .av_address     (jtag_uart_0_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_0_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_0_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_0_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_0_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_0_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_0_avalon_jtag_slave_writedata),
      .clk            (clk_0),
      .dataavailable  (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_0_avalon_jtag_slave_reset_n)
    );

  load_para_in_avs_arbitrator the_load_para_in_avs
    (
      .clk                                                  (clk_0),
      .cpu_0_data_master_address_to_slave                   (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_load_para_in_avs           (cpu_0_data_master_granted_load_para_in_avs),
      .cpu_0_data_master_qualified_request_load_para_in_avs (cpu_0_data_master_qualified_request_load_para_in_avs),
      .cpu_0_data_master_read                               (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_load_para_in_avs   (cpu_0_data_master_read_data_valid_load_para_in_avs),
      .cpu_0_data_master_requests_load_para_in_avs          (cpu_0_data_master_requests_load_para_in_avs),
      .cpu_0_data_master_write                              (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                          (cpu_0_data_master_writedata),
      .d1_load_para_in_avs_end_xfer                         (d1_load_para_in_avs_end_xfer),
      .load_para_in_avs_address                             (load_para_in_avs_address),
      .load_para_in_avs_chipselect_n                        (load_para_in_avs_chipselect_n),
      .load_para_in_avs_read_n                              (load_para_in_avs_read_n),
      .load_para_in_avs_readdata                            (load_para_in_avs_readdata),
      .load_para_in_avs_readdata_from_sa                    (load_para_in_avs_readdata_from_sa),
      .load_para_in_avs_wait_counter_eq_0                   (load_para_in_avs_wait_counter_eq_0),
      .load_para_in_avs_write_n                             (load_para_in_avs_write_n),
      .load_para_in_avs_writedata                           (load_para_in_avs_writedata),
      .reset_n                                              (clk_0_reset_n)
    );

  load_para the_load_para
    (
      .addr                (addr_from_the_load_para),
      .clk                 (clk_0),
      .in_avs_address      (load_para_in_avs_address),
      .in_avs_chipselect_n (load_para_in_avs_chipselect_n),
      .in_avs_read_n       (load_para_in_avs_read_n),
      .in_avs_readdata     (load_para_in_avs_readdata),
      .in_avs_write_n      (load_para_in_avs_write_n),
      .in_avs_writedata    (load_para_in_avs_writedata),
      .rd_n                (rd_n_from_the_load_para),
      .rdata               (rdata_to_the_load_para),
      .wdata               (wdata_from_the_load_para),
      .wr_n                (wr_n_from_the_load_para)
    );

  sdram_0_s1_arbitrator the_sdram_0_s1
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_sdram_0_s1                            (cpu_0_data_master_byteenable_sdram_0_s1),
      .cpu_0_data_master_dbs_address                                      (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                     (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_sdram_0_s1                               (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_no_byte_enables_and_last_term                    (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_sdram_0_s1                     (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                       (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register        (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_requests_sdram_0_s1                              (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                               (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_sdram_0_s1                        (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1              (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_requests_sdram_0_s1                       (cpu_0_instruction_master_requests_sdram_0_s1),
      .d1_sdram_0_s1_end_xfer                                             (d1_sdram_0_s1_end_xfer),
      .reset_n                                                            (clk_0_reset_n),
      .sdram_0_s1_address                                                 (sdram_0_s1_address),
      .sdram_0_s1_byteenable_n                                            (sdram_0_s1_byteenable_n),
      .sdram_0_s1_chipselect                                              (sdram_0_s1_chipselect),
      .sdram_0_s1_read_n                                                  (sdram_0_s1_read_n),
      .sdram_0_s1_readdata                                                (sdram_0_s1_readdata),
      .sdram_0_s1_readdata_from_sa                                        (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_readdatavalid                                           (sdram_0_s1_readdatavalid),
      .sdram_0_s1_reset_n                                                 (sdram_0_s1_reset_n),
      .sdram_0_s1_waitrequest                                             (sdram_0_s1_waitrequest),
      .sdram_0_s1_waitrequest_from_sa                                     (sdram_0_s1_waitrequest_from_sa),
      .sdram_0_s1_write_n                                                 (sdram_0_s1_write_n),
      .sdram_0_s1_writedata                                               (sdram_0_s1_writedata)
    );

  sdram_0 the_sdram_0
    (
      .az_addr        (sdram_0_s1_address),
      .az_be_n        (sdram_0_s1_byteenable_n),
      .az_cs          (sdram_0_s1_chipselect),
      .az_data        (sdram_0_s1_writedata),
      .az_rd_n        (sdram_0_s1_read_n),
      .az_wr_n        (sdram_0_s1_write_n),
      .clk            (clk_0),
      .reset_n        (sdram_0_s1_reset_n),
      .za_data        (sdram_0_s1_readdata),
      .za_valid       (sdram_0_s1_readdatavalid),
      .za_waitrequest (sdram_0_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_0),
      .zs_ba          (zs_ba_from_the_sdram_0),
      .zs_cas_n       (zs_cas_n_from_the_sdram_0),
      .zs_cke         (zs_cke_from_the_sdram_0),
      .zs_cs_n        (zs_cs_n_from_the_sdram_0),
      .zs_dq          (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm         (zs_dqm_from_the_sdram_0),
      .zs_ras_n       (zs_ras_n_from_the_sdram_0),
      .zs_we_n        (zs_we_n_from_the_sdram_0)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                     (clk_0),
      .cpu_0_data_master_address_to_slave                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_sysid_control_slave           (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_qualified_request_sysid_control_slave (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_read                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sysid_control_slave   (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_requests_sysid_control_slave          (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_write                                 (cpu_0_data_master_write),
      .d1_sysid_control_slave_end_xfer                         (d1_sysid_control_slave_end_xfer),
      .reset_n                                                 (clk_0_reset_n),
      .sysid_control_slave_address                             (sysid_control_slave_address),
      .sysid_control_slave_readdata                            (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                    (sysid_control_slave_readdata_from_sa)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .readdata (sysid_control_slave_readdata)
    );

  udpram_in_avs_arbitrator the_udpram_in_avs
    (
      .clk                                                        (clk_0),
      .cpu_0_data_master_address_to_slave                         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                               (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_udpram_in_avs                 (cpu_0_data_master_byteenable_udpram_in_avs),
      .cpu_0_data_master_dbs_address                              (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_8                              (cpu_0_data_master_dbs_write_8),
      .cpu_0_data_master_granted_udpram_in_avs                    (cpu_0_data_master_granted_udpram_in_avs),
      .cpu_0_data_master_no_byte_enables_and_last_term            (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_udpram_in_avs          (cpu_0_data_master_qualified_request_udpram_in_avs),
      .cpu_0_data_master_read                                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_udpram_in_avs            (cpu_0_data_master_read_data_valid_udpram_in_avs),
      .cpu_0_data_master_requests_udpram_in_avs                   (cpu_0_data_master_requests_udpram_in_avs),
      .cpu_0_data_master_waitrequest                              (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                    (cpu_0_data_master_write),
      .d1_udpram_in_avs_end_xfer                                  (d1_udpram_in_avs_end_xfer),
      .registered_cpu_0_data_master_read_data_valid_udpram_in_avs (registered_cpu_0_data_master_read_data_valid_udpram_in_avs),
      .reset_n                                                    (clk_0_reset_n),
      .udpram_in_avs_address                                      (udpram_in_avs_address),
      .udpram_in_avs_chipselect_n                                 (udpram_in_avs_chipselect_n),
      .udpram_in_avs_read_n                                       (udpram_in_avs_read_n),
      .udpram_in_avs_readdata                                     (udpram_in_avs_readdata),
      .udpram_in_avs_readdata_from_sa                             (udpram_in_avs_readdata_from_sa),
      .udpram_in_avs_write_n                                      (udpram_in_avs_write_n),
      .udpram_in_avs_writedata                                    (udpram_in_avs_writedata)
    );

  udpram the_udpram
    (
      .addr                (addr_from_the_udpram),
      .clk                 (clk_0),
      .in_avs_address      (udpram_in_avs_address),
      .in_avs_chipselect_n (udpram_in_avs_chipselect_n),
      .in_avs_read_n       (udpram_in_avs_read_n),
      .in_avs_readdata     (udpram_in_avs_readdata),
      .in_avs_write_n      (udpram_in_avs_write_n),
      .in_avs_writedata    (udpram_in_avs_writedata),
      .rd_n                (rd_n_from_the_udpram),
      .rdata               (rdata_to_the_udpram),
      .wdata               (wdata_from_the_udpram),
      .wr_n                (wr_n_from_the_udpram)
    );

  watch_dog_s1_arbitrator the_watch_dog_s1
    (
      .clk                                              (clk_0),
      .cpu_0_data_master_address_to_slave               (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_watch_dog_s1           (cpu_0_data_master_granted_watch_dog_s1),
      .cpu_0_data_master_qualified_request_watch_dog_s1 (cpu_0_data_master_qualified_request_watch_dog_s1),
      .cpu_0_data_master_read                           (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_watch_dog_s1   (cpu_0_data_master_read_data_valid_watch_dog_s1),
      .cpu_0_data_master_requests_watch_dog_s1          (cpu_0_data_master_requests_watch_dog_s1),
      .cpu_0_data_master_waitrequest                    (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                          (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                      (cpu_0_data_master_writedata),
      .d1_watch_dog_s1_end_xfer                         (d1_watch_dog_s1_end_xfer),
      .reset_n                                          (clk_0_reset_n),
      .watch_dog_s1_address                             (watch_dog_s1_address),
      .watch_dog_s1_chipselect                          (watch_dog_s1_chipselect),
      .watch_dog_s1_irq                                 (watch_dog_s1_irq),
      .watch_dog_s1_irq_from_sa                         (watch_dog_s1_irq_from_sa),
      .watch_dog_s1_readdata                            (watch_dog_s1_readdata),
      .watch_dog_s1_readdata_from_sa                    (watch_dog_s1_readdata_from_sa),
      .watch_dog_s1_reset_n                             (watch_dog_s1_reset_n),
      .watch_dog_s1_resetrequest                        (watch_dog_s1_resetrequest),
      .watch_dog_s1_resetrequest_from_sa                (watch_dog_s1_resetrequest_from_sa),
      .watch_dog_s1_write_n                             (watch_dog_s1_write_n),
      .watch_dog_s1_writedata                           (watch_dog_s1_writedata)
    );

  watch_dog the_watch_dog
    (
      .address      (watch_dog_s1_address),
      .chipselect   (watch_dog_s1_chipselect),
      .clk          (clk_0),
      .irq          (watch_dog_s1_irq),
      .readdata     (watch_dog_s1_readdata),
      .reset_n      (watch_dog_s1_reset_n),
      .resetrequest (watch_dog_s1_resetrequest),
      .write_n      (watch_dog_s1_write_n),
      .writedata    (watch_dog_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  gige_trans_cpu_reset_clk_0_domain_synch_module gige_trans_cpu_reset_clk_0_domain_synch
    (
      .clk      (clk_0),
      .data_in  (1'b1),
      .data_out (clk_0_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    watch_dog_s1_resetrequest_from_sa |
    watch_dog_s1_resetrequest_from_sa);


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/90/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/90/quartus/eda/sim_lib/220model.v"
`include "c:/altera/90/quartus/eda/sim_lib/sgate.v"
`include "avalon_slave_exram_8bit.v"
`include "udpram.v"
`include "avalon_slave_export_v2.v"
`include "load_para.v"
`include "export.v"
`include "sdram_0.v"
`include "sdram_0_test_component.v"
`include "SCL_A.v"
`include "board_out.v"
`include "sysid.v"
`include "cpu_0_test_bench.v"
`include "cpu_0_mult_cell.v"
`include "cpu_0_oci_test_bench.v"
`include "cpu_0_jtag_debug_module_tck.v"
`include "cpu_0_jtag_debug_module_sysclk.v"
`include "cpu_0_jtag_debug_module_wrapper.v"
`include "cpu_0.v"
`include "epcs_flash_controller_0.v"
`include "board_in.v"
`include "SDA_A.v"
`include "SDA_B.v"
`include "SCL_B.v"
`include "jtag_uart_0.v"
`include "watch_dog.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire    [  8: 0] addr_from_the_export;
  wire    [  8: 0] addr_from_the_load_para;
  wire    [ 15: 0] addr_from_the_udpram;
  wire             bidir_port_to_and_from_the_SDA_A;
  wire             bidir_port_to_and_from_the_SDA_B;
  wire             clk;
  reg              clk_0;
  wire             epcs_flash_controller_0_epcs_control_port_dataavailable_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_endofpacket_from_sa;
  wire             epcs_flash_controller_0_epcs_control_port_readyfordata_from_sa;
  wire    [  7: 0] in_port_to_the_board_in;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             out_port_from_the_SCL_A;
  wire             out_port_from_the_SCL_B;
  wire    [  7: 0] out_port_from_the_board_out;
  wire             rd_n_from_the_export;
  wire             rd_n_from_the_load_para;
  wire             rd_n_from_the_udpram;
  wire    [ 31: 0] rdata_to_the_export;
  wire    [ 31: 0] rdata_to_the_load_para;
  wire    [  7: 0] rdata_to_the_udpram;
  reg              reset_n;
  wire    [ 31: 0] wdata_from_the_export;
  wire    [ 31: 0] wdata_from_the_load_para;
  wire    [  7: 0] wdata_from_the_udpram;
  wire             wr_n_from_the_export;
  wire             wr_n_from_the_load_para;
  wire             wr_n_from_the_udpram;
  wire    [ 12: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  gige_trans_cpu DUT
    (
      .addr_from_the_export             (addr_from_the_export),
      .addr_from_the_load_para          (addr_from_the_load_para),
      .addr_from_the_udpram             (addr_from_the_udpram),
      .bidir_port_to_and_from_the_SDA_A (bidir_port_to_and_from_the_SDA_A),
      .bidir_port_to_and_from_the_SDA_B (bidir_port_to_and_from_the_SDA_B),
      .clk_0                            (clk_0),
      .in_port_to_the_board_in          (in_port_to_the_board_in),
      .out_port_from_the_SCL_A          (out_port_from_the_SCL_A),
      .out_port_from_the_SCL_B          (out_port_from_the_SCL_B),
      .out_port_from_the_board_out      (out_port_from_the_board_out),
      .rd_n_from_the_export             (rd_n_from_the_export),
      .rd_n_from_the_load_para          (rd_n_from_the_load_para),
      .rd_n_from_the_udpram             (rd_n_from_the_udpram),
      .rdata_to_the_export              (rdata_to_the_export),
      .rdata_to_the_load_para           (rdata_to_the_load_para),
      .rdata_to_the_udpram              (rdata_to_the_udpram),
      .reset_n                          (reset_n),
      .wdata_from_the_export            (wdata_from_the_export),
      .wdata_from_the_load_para         (wdata_from_the_load_para),
      .wdata_from_the_udpram            (wdata_from_the_udpram),
      .wr_n_from_the_export             (wr_n_from_the_export),
      .wr_n_from_the_load_para          (wr_n_from_the_load_para),
      .wr_n_from_the_udpram             (wr_n_from_the_udpram),
      .zs_addr_from_the_sdram_0         (zs_addr_from_the_sdram_0),
      .zs_ba_from_the_sdram_0           (zs_ba_from_the_sdram_0),
      .zs_cas_n_from_the_sdram_0        (zs_cas_n_from_the_sdram_0),
      .zs_cke_from_the_sdram_0          (zs_cke_from_the_sdram_0),
      .zs_cs_n_from_the_sdram_0         (zs_cs_n_from_the_sdram_0),
      .zs_dq_to_and_from_the_sdram_0    (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm_from_the_sdram_0          (zs_dqm_from_the_sdram_0),
      .zs_ras_n_from_the_sdram_0        (zs_ras_n_from_the_sdram_0),
      .zs_we_n_from_the_sdram_0         (zs_we_n_from_the_sdram_0)
    );

  sdram_0_test_component the_sdram_0_test_component
    (
      .clk      (clk_0),
      .zs_addr  (zs_addr_from_the_sdram_0),
      .zs_ba    (zs_ba_from_the_sdram_0),
      .zs_cas_n (zs_cas_n_from_the_sdram_0),
      .zs_cke   (zs_cke_from_the_sdram_0),
      .zs_cs_n  (zs_cs_n_from_the_sdram_0),
      .zs_dq    (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm   (zs_dqm_from_the_sdram_0),
      .zs_ras_n (zs_ras_n_from_the_sdram_0),
      .zs_we_n  (zs_we_n_from_the_sdram_0)
    );

  initial
    clk_0 = 1'b0;
  always
    #4 clk_0 <= ~clk_0;
  
  initial 
    begin
      reset_n <= 0;
      #80 reset_n <= 1;
    end

endmodule


//synthesis translate_on