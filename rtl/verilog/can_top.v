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
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
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
  clk,
  rst,
  data_in,
  data_out,
  cs, rw, addr,
  rx,
  idle    /* REMOVE and use correct "idle state" signal instead */
);

parameter Tp = 1;

input        clk;
input        rst;
input  [7:0] data_in;
output [7:0] data_out;
input        cs, rw;
input  [7:0] addr;
input        rx;
input        idle;   /* REMOVE and use correct "idle state" signal instead */


/* Mode register */
wire         reset_mode;
wire         listen_only_mode;
wire         acceptance_filter_mode;
wire         sleep_mode;

/* Bus Timing 0 register */
wire    [5:0] baud_r_presc;
wire    [1:0] sync_jump_width;

/* Bus Timing 1 register */
wire    [3:0] time_segment1;
wire    [2:0] time_segment2;
wire          triple_sampling;

/* Clock Divider register */
wire          extended_mode;
wire          rx_int_enable;
wire          clock_off;
wire    [2:0] cd;




/* Connecting can_registers module */
can_registers i_can_registers
( 
  .clk(clk),
  .rst(rst),
  .cs(cs),
  .rw(rw),
  .addr(addr),
  .data_in(data_in),
  .data_out(data_out),

  /* Mode register */
  .reset_mode(reset_mode),
  .listen_only_mode(listen_only_mode),
  .acceptance_filter_mode(acceptance_filter_mode),
  .sleep_mode(sleep_mode),

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
  .cd(cd)


);


/* Output signals from can_btl module */
wire        take_sample;
wire        clk_en;




/* Connecting can_btl module */
can_btl i_can_btl
( 
  .clk(clk),
  .rst(rst),
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
  .take_sample(take_sample),
  .clk_en(clk_en),
  
  /* States */
  .idle(idle)
  


);



can_bsp i_can_bsp
(
  .clk(clk),
  .rst(rst)

);




endmodule
