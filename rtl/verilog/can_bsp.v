//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_bsp.v                                                   ////
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
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.2  2002/12/27 00:12:52  mohor
// Header changed, testbench improved to send a frame (crc still missing).
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

module can_bsp
( 
  clk,
  rst,

  sample_point,
  sampled_bit,
  sampled_bit_q,
  reset_mode,
  
  rx_idle

  
);

parameter Tp = 1;

input         clk;
input         rst;
input         sample_point;
input         sampled_bit;
input         sampled_bit_q;
input         reset_mode;

output        rx_idle;

reg           reset_mode_q;
reg     [5:0] bit_cnt;

reg     [3:0] data_len;
reg    [28:0] id;
reg     [2:0] bit_stuff_cnt;
reg           stuff_error;

wire          bit_de_stuff;


/* Rx state machine */
wire          go_rx_idle;
wire          go_rx_id1;
wire          go_rx_rtr1;
wire          go_rx_ide;
wire          go_rx_id2;
wire          go_rx_rtr2;
wire          go_rx_r1;
wire          go_rx_r0;
wire          go_rx_dlc;
wire          go_rx_data;
wire          go_rx_crc;
wire          go_rx_ack;
wire          go_rx_eof;

reg           rx_idle;
reg           rx_id1;
reg           rx_rtr1;
reg           rx_ide;
reg           rx_id2;
reg           rx_rtr2;
reg           rx_r1;
reg           rx_r0;
reg           rx_dlc;
reg           rx_data;
reg           rx_crc;
reg           rx_ack;
reg           rx_eof;

reg     [2:0] eof_cnt;


assign go_rx_idle     = sample_point &  rx_eof  & (eof_cnt == 6);
assign go_rx_id1      = sample_point &  rx_idle & (~sampled_bit);
assign go_rx_rtr1     = sample_point &  rx_id1  & (bit_cnt == 10);
assign go_rx_ide      = sample_point &  rx_rtr1;
assign go_rx_id2      = sample_point &  rx_ide  &   sampled_bit;
assign go_rx_rtr2     = sample_point &  rx_id2  & (bit_cnt == 17);
assign go_rx_r1       = sample_point &  rx_rtr2;
assign go_rx_r0       = sample_point & (rx_ide  & (~sampled_bit) | rx_r1);
assign go_rx_dlc      = sample_point &  rx_r0;
assign go_rx_data     = sample_point &  rx_dlc  & (bit_cnt == 3) & (sampled_bit | (|data_len[2:0]));
assign go_rx_crc      = sample_point & (rx_dlc  & (bit_cnt == 3) & (~sampled_bit) & (~(|data_len[2:0]))
                                     |  rx_data & (bit_cnt == ((data_len<<3) - 1'b1)));
assign go_rx_ack      = sample_point &  rx_crc  & (bit_cnt == 15);
assign go_rx_eof      = sample_point &  rx_ack  & (bit_cnt == 1) | (~reset_mode) & reset_mode_q;

// Rx idle state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_idle <= 1'b1;
  else if (reset_mode | go_rx_id1)
    rx_idle <=#Tp 1'b0;
  else if (go_rx_idle)
    rx_idle <=#Tp 1'b1;
end


// Rx id1 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_id1 <= 1'b0;
  else if (reset_mode | go_rx_rtr1)
    rx_id1 <=#Tp 1'b0;
  else if (go_rx_id1)
    rx_id1 <=#Tp 1'b1;
end


// Rx rtr1 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_rtr1 <= 1'b0;
  else if (reset_mode | go_rx_ide)
    rx_rtr1 <=#Tp 1'b0;
  else if (go_rx_rtr1)
    rx_rtr1 <=#Tp 1'b1;
end


// Rx ide state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_ide <= 1'b0;
  else if (reset_mode | go_rx_r0 | go_rx_id2)
    rx_ide <=#Tp 1'b0;
  else if (go_rx_ide)
    rx_ide <=#Tp 1'b1;
end


// Rx id2 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_id2 <= 1'b0;
  else if (reset_mode | go_rx_rtr2)
    rx_id2 <=#Tp 1'b0;
  else if (go_rx_id2)
    rx_id2 <=#Tp 1'b1;
end


// Rx rtr2 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_rtr2 <= 1'b0;
  else if (reset_mode | go_rx_r1)
    rx_rtr2 <=#Tp 1'b0;
  else if (go_rx_rtr2)
    rx_rtr2 <=#Tp 1'b1;
end


// Rx r0 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_r1 <= 1'b0;
  else if (reset_mode | go_rx_r0)
    rx_r1 <=#Tp 1'b0;
  else if (go_rx_r1)
    rx_r1 <=#Tp 1'b1;
end


// Rx r0 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_r0 <= 1'b0;
  else if (reset_mode | go_rx_dlc)
    rx_r0 <=#Tp 1'b0;
  else if (go_rx_r0)
    rx_r0 <=#Tp 1'b1;
end


// Rx dlc state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_dlc <= 1'b0;
  else if (reset_mode | go_rx_data | go_rx_crc)
    rx_dlc <=#Tp 1'b0;
  else if (go_rx_dlc)
    rx_dlc <=#Tp 1'b1;
end


// Rx data state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_data <= 1'b0;
  else if (reset_mode | go_rx_crc)
    rx_data <=#Tp 1'b0;
  else if (go_rx_data)
    rx_data <=#Tp 1'b1;
end


// Rx crc state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_crc <= 1'b0;
  else if (reset_mode | go_rx_ack)
    rx_crc <=#Tp 1'b0;
  else if (go_rx_crc)
    rx_crc <=#Tp 1'b1;
end


// Rx ack state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_ack <= 1'b0;
  else if (reset_mode | go_rx_eof)
    rx_ack <=#Tp 1'b0;
  else if (go_rx_ack)
    rx_ack <=#Tp 1'b1;
end


// Rx eof state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_eof <= 1'b0;
  else if (go_rx_idle)
    rx_eof <=#Tp 1'b0;
  else if (go_rx_eof)
    rx_eof <=#Tp 1'b1;
end








// ID register
always @ (posedge clk or posedge rst)
begin
  if (rst)
    id <= 0;
  else if (sample_point & rx_id1 & (~bit_de_stuff))
    id <=#Tp {id[27:0], sampled_bit};
end

// Data length
always @ (posedge clk or posedge rst)
begin
  if (rst)
    data_len <= 0;
  else if (sample_point & rx_dlc & (~bit_de_stuff))
    data_len <=#Tp {data_len[2:0], sampled_bit};
end


// bit_cnt
always @ (posedge clk or posedge rst)
begin
  if (rst)
    bit_cnt <= 0;
  else if (go_rx_id1 | go_rx_id2 | go_rx_dlc | go_rx_data | go_rx_crc | go_rx_ack | go_rx_eof)
    bit_cnt <=#Tp 0;
  else if (sample_point)
    bit_cnt <=#Tp bit_cnt + 1'b1;
end


// eof_cnt
always @ (posedge clk or posedge rst)
begin
  if (rst)
    eof_cnt <= 0;
  else if (sample_point)
    begin
      if (rx_eof & sampled_bit)
        eof_cnt <=#Tp eof_cnt + 1'b1;
      else
        eof_cnt <=#Tp 0;
    end
end





// bit_stuff_cnt
always @ (posedge clk or posedge rst)
begin
  if (rst)
    bit_stuff_cnt <= 1;
  else if (sample_point & (rx_id1 | rx_id2 | rx_dlc | rx_data | rx_crc))    // Is this OK? Check again
    begin
      if (bit_stuff_cnt == 5)
        bit_stuff_cnt <=#Tp 1;
      else if (sampled_bit == sampled_bit_q)
        bit_stuff_cnt <=#Tp bit_stuff_cnt + 1'b1;
      else
        bit_stuff_cnt <=#Tp 1;
    end
end


assign bit_de_stuff = bit_stuff_cnt == 5;


// stuff_error
always @ (posedge clk or posedge rst)
begin
  if (rst)
    stuff_error <= 0;
  else if (sample_point & (rx_id1) & bit_de_stuff & (sampled_bit == sampled_bit_q))   // Add other stages (data, control, etc.) !!!
    stuff_error <=#Tp 1'b1;
//  else if (reset condition)       // Add reset condition
//    stuff_error <=#Tp 0;
end


// Generating delayed reset_mode signal
always @ (posedge clk)
begin
  reset_mode_q <=#Tp reset_mode;
end


endmodule
