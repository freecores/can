//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_top.v                                                   ////
////                                                              ////
////                                                              ////
////  This file is part of the CAN Protocol Controller            ////
////  http://www.opencores.org/projects/can/                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////       Igor Mohor                                             ////
////       igorm@opencores.org                                    ////
////                                                              ////
////                                                              ////
////  All additional information is available in the README.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002, 2003 Authors                             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//// The CAN protocol is developed by Robert Bosch GmbH and       ////
//// protected by patents. Anybody who wants to implement this    ////
//// CAN IP core on silicon has to obtain a CAN protocol license  ////
//// from Bosch.                                                  ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.14  2003/02/11 00:56:06  mohor
// Wishbone interface added.
//
// Revision 1.13  2003/02/09 18:40:29  mohor
// Overload fixed. Hard synchronization also enabled at the last bit of
// interframe.
//
// Revision 1.12  2003/02/09 02:24:33  mohor
// Bosch license warning added. Error counters finished. Overload frames
// still need to be fixed.
//
// Revision 1.11  2003/02/04 14:34:52  mohor
// *** empty log message ***
//
// Revision 1.10  2003/01/31 01:13:38  mohor
// backup.
//
// Revision 1.9  2003/01/15 13:16:48  mohor
// When a frame with "remote request" is received, no data is stored to
// fifo, just the frame information (identifier, ...). Data length that
// is stored is the received data length and not the actual data length
// that is stored to fifo.
//
// Revision 1.8  2003/01/14 17:25:09  mohor
// Addresses corrected to decimal values (previously hex).
//
// Revision 1.7  2003/01/10 17:51:34  mohor
// Temporary version (backup).
//
// Revision 1.6  2003/01/09 21:54:45  mohor
// rx fifo added. Not 100 % verified, yet.
//
// Revision 1.5  2003/01/08 02:10:56  mohor
// Acceptance filter added.
//
// Revision 1.4  2002/12/28 04:13:23  mohor
// Backup version.
//
// Revision 1.3  2002/12/27 00:12:52  mohor
// Header changed, testbench improved to send a frame (crc still missing).
//
// Revision 1.2  2002/12/26 16:00:34  mohor
// Testbench define file added. Clock divider register added.
//
// Revision 1.1.1.1  2002/12/20 16:39:21  mohor
// Initial
//
//
//

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on
`include "can_defines.v"

module can_top
( 
  wb_clk_i,
  wb_rst_i,
  wb_dat_i,
  wb_dat_o,
  wb_cyc_i,
  wb_stb_i,
  wb_we_i,
  wb_adr_i,
  wb_ack_o,
  clk,
  rx,
  tx,
  tx_oen
);

parameter Tp = 1;

input        wb_clk_i;
input        wb_rst_i;
input  [7:0] wb_dat_i;
output [7:0] wb_dat_o;
input        wb_cyc_i;
input        wb_stb_i;
input        wb_we_i;
input  [7:0] wb_adr_i;
output       wb_ack_o;
input        clk;
input        rx;
output       tx;
output       tx_oen;

reg          wb_ack_o;
reg          data_out_fifo_selected;

reg          cs_sync1;
reg          cs_sync2;
reg          cs_sync3;

reg          cs_rst1;
reg          cs_rst2;
reg          cs_rst3;

wire   [7:0] data_out_fifo;
wire   [7:0] data_out_regs;


/* Mode register */
wire         reset_mode;
wire         listen_only_mode;
wire         acceptance_filter_mode;
wire         sleep_mode;

/* Command register */
wire         release_buffer;
wire         tx_request;
wire         abort_tx;

/* Bus Timing 0 register */
wire   [5:0] baud_r_presc;
wire   [1:0] sync_jump_width;

/* Bus Timing 1 register */
wire   [3:0] time_segment1;
wire   [2:0] time_segment2;
wire         triple_sampling;

/* Clock Divider register */
wire         extended_mode;
wire         rx_int_enable;
wire         clock_off;
wire   [2:0] cd;

/* This section is for BASIC and EXTENDED mode */
/* Acceptance code register */
wire   [7:0] acceptance_code_0;

/* Acceptance mask register */
wire   [7:0] acceptance_mask_0;
/* End: This section is for BASIC and EXTENDED mode */


/* This section is for EXTENDED mode */
/* Acceptance code register */
wire   [7:0] acceptance_code_1;
wire   [7:0] acceptance_code_2;
wire   [7:0] acceptance_code_3;

/* Acceptance mask register */
wire   [7:0] acceptance_mask_1;
wire   [7:0] acceptance_mask_2;
wire   [7:0] acceptance_mask_3;
/* End: This section is for EXTENDED mode */

/* Tx data registers. Holding identifier (basic mode), tx frame information (extended mode) and data */
wire   [7:0] tx_data_0;
wire   [7:0] tx_data_1;
wire   [7:0] tx_data_2;
wire   [7:0] tx_data_3;
wire   [7:0] tx_data_4;
wire   [7:0] tx_data_5;
wire   [7:0] tx_data_6;
wire   [7:0] tx_data_7;
wire   [7:0] tx_data_8;
wire   [7:0] tx_data_9;
wire   [7:0] tx_data_10;
wire   [7:0] tx_data_11;
wire   [7:0] tx_data_12;
/* End: Tx data registers */

wire         cs;

/* Output signals from can_btl module */
wire        clk_en;
wire        sample_point;
wire        sampled_bit;
wire        sampled_bit_q;
wire        tx_point;
wire        hard_sync;
wire        resync;


/* output from can_bsp module */
wire        rx_idle;
wire        transmitting;
wire        last_bit_of_inter;


/* Connecting can_registers module */
can_registers i_can_registers
( 
  .clk(clk),
  .rst(wb_rst_i),
  .cs(cs),
  .we(wb_we_i),
  .addr(wb_adr_i),
  .data_in(wb_dat_i),
  .data_out(data_out_regs),

  .sample_point(sample_point),
  .transmitting(transmitting),

  /* Mode register */
  .reset_mode(reset_mode),
  .listen_only_mode(listen_only_mode),
  .acceptance_filter_mode(acceptance_filter_mode),
  .sleep_mode(sleep_mode),

  /* Command register */
  .clear_data_overrun(),
  .release_buffer(release_buffer),
  .abort_tx(abort_tx),
  .tx_request(tx_request),
  .self_rx_request(),

  /* Bus Timing 0 register */
  .baud_r_presc(baud_r_presc),
  .sync_jump_width(sync_jump_width),

  /* Bus Timing 1 register */
  .time_segment1(time_segment1),
  .time_segment2(time_segment2),
  .triple_sampling(triple_sampling),

  /* Clock Divider register */
  .extended_mode(extended_mode),
  .rx_int_enable(rx_int_enable),
  .clock_off(clock_off),
  .cd(cd),
  
  /* This section is for BASIC and EXTENDED mode */
  /* Acceptance code register */
  .acceptance_code_0(acceptance_code_0),

  /* Acceptance mask register */
  .acceptance_mask_0(acceptance_mask_0),
  /* End: This section is for BASIC and EXTENDED mode */
  
  /* This section is for EXTENDED mode */
  /* Acceptance code register */
  .acceptance_code_1(acceptance_code_1),
  .acceptance_code_2(acceptance_code_2),
  .acceptance_code_3(acceptance_code_3),

  /* Acceptance mask register */
  .acceptance_mask_1(acceptance_mask_1),
  .acceptance_mask_2(acceptance_mask_2),
  .acceptance_mask_3(acceptance_mask_3),
  /* End: This section is for EXTENDED mode */

  /* Tx data registers. Holding identifier (basic mode), tx frame information (extended mode) and data */
  .tx_data_0(tx_data_0),
  .tx_data_1(tx_data_1),
  .tx_data_2(tx_data_2),
  .tx_data_3(tx_data_3),
  .tx_data_4(tx_data_4),
  .tx_data_5(tx_data_5),
  .tx_data_6(tx_data_6),
  .tx_data_7(tx_data_7),
  .tx_data_8(tx_data_8),
  .tx_data_9(tx_data_9),
  .tx_data_10(tx_data_10),
  .tx_data_11(tx_data_11),
  .tx_data_12(tx_data_12)
  /* End: Tx data registers */






);





/* Connecting can_btl module */
can_btl i_can_btl
( 
  .clk(clk),
  .rst(wb_rst_i),
  .rx(rx),

  /* Mode register */
  .reset_mode(reset_mode),

  /* Bus Timing 0 register */
  .baud_r_presc(baud_r_presc),
  .sync_jump_width(sync_jump_width),

  /* Bus Timing 1 register */
  .time_segment1(time_segment1),
  .time_segment2(time_segment2),
  .triple_sampling(triple_sampling),

  /* Output signals from this module */
  .clk_en(clk_en),
  .sample_point(sample_point),
  .sampled_bit(sampled_bit),
  .sampled_bit_q(sampled_bit_q),
  .tx_point(tx_point),
  .hard_sync(hard_sync),
  .resync(resync),

  
  /* output from can_bsp module */
  .rx_idle(rx_idle),
  .transmitting(transmitting),
  .last_bit_of_inter(last_bit_of_inter)
  


);



can_bsp i_can_bsp
(
  .clk(clk),
  .rst(wb_rst_i),
  
  /* From btl module */
  .sample_point(sample_point),
  .sampled_bit(sampled_bit),
  .sampled_bit_q(sampled_bit_q),
  .tx_point(tx_point),
  .hard_sync(hard_sync),

  .addr(wb_adr_i),
  .data_out(data_out_fifo),

  /* Mode register */
  .reset_mode(reset_mode),
  .acceptance_filter_mode(acceptance_filter_mode),
  
  /* Command register */
  .release_buffer(release_buffer),
  .tx_request(tx_request),
  .abort_tx(abort_tx),

  /* Clock Divider register */
  .extended_mode(extended_mode),

  /* output from can_bsp module */
  .rx_idle(rx_idle),
  .transmitting(transmitting),
  .last_bit_of_inter(last_bit_of_inter),
  
  /* This section is for BASIC and EXTENDED mode */
  /* Acceptance code register */
  .acceptance_code_0(acceptance_code_0),

  /* Acceptance mask register */
  .acceptance_mask_0(acceptance_mask_0),
  /* End: This section is for BASIC and EXTENDED mode */
  
  /* This section is for EXTENDED mode */
  /* Acceptance code register */
  .acceptance_code_1(acceptance_code_1),
  .acceptance_code_2(acceptance_code_2),
  .acceptance_code_3(acceptance_code_3),

  /* Acceptance mask register */
  .acceptance_mask_1(acceptance_mask_1),
  .acceptance_mask_2(acceptance_mask_2),
  .acceptance_mask_3(acceptance_mask_3),
  /* End: This section is for EXTENDED mode */

  /* Tx data registers. Holding identifier (basic mode), tx frame information (extended mode) and data */
  .tx_data_0(tx_data_0),
  .tx_data_1(tx_data_1),
  .tx_data_2(tx_data_2),
  .tx_data_3(tx_data_3),
  .tx_data_4(tx_data_4),
  .tx_data_5(tx_data_5),
  .tx_data_6(tx_data_6),
  .tx_data_7(tx_data_7),
  .tx_data_8(tx_data_8),
  .tx_data_9(tx_data_9),
  .tx_data_10(tx_data_10),
  .tx_data_11(tx_data_11),
  .tx_data_12(tx_data_12),
  /* End: Tx data registers */
  
  /* Tx signal */
  .tx(tx),
  .tx_oen(tx_oen)
);


// Multiplexing wb_dat_o from registers and rx fifo
always @ (extended_mode or wb_adr_i or reset_mode)
begin
  if (extended_mode & (~reset_mode) & ((wb_adr_i >= 8'd16) && (wb_adr_i <= 8'd28)) | (~extended_mode) & ((wb_adr_i >= 8'd20) && (wb_adr_i <= 8'd29)))
    data_out_fifo_selected <= 1'b1;
  else
    data_out_fifo_selected <= 1'b0;
end


assign wb_dat_o = data_out_fifo_selected ? data_out_fifo : data_out_regs;



// Combining wb_cyc_i and wb_stb_i signals to cs signal. Than synchronizing to clk clock domain. 
always @ (posedge clk)
begin
  if (cs_rst2)
    begin
      cs_sync1 <=#Tp 1'b0;
      cs_sync2 <=#Tp 1'b0;
      cs_sync3 <=#Tp 1'b0;
    end
  else
    begin
      cs_sync1 <=#Tp (wb_cyc_i & wb_stb_i);
      cs_sync2 <=#Tp cs_sync1;
      cs_sync3 <=#Tp cs_sync2;
    end
end


assign cs = cs_sync2 & (~cs_sync3);


always @ (posedge wb_clk_i)
begin
  if (wb_ack_o)
    begin
      cs_rst1 <=#Tp 1'b0;
      cs_rst2 <=#Tp 1'b0;
      cs_rst3 <=#Tp 1'b0;
    end
  else
    begin
      cs_rst1 <=#Tp cs_sync2;
      cs_rst2 <=#Tp cs_rst1;
      cs_rst3 <=#Tp cs_rst2;
    end
end



// Generating acknowledge signal
always @ (posedge wb_clk_i)
begin
  wb_ack_o <=#Tp (cs_rst2 & (~cs_rst3));
end




endmodule
