//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_btl.v                                                   ////
////                                                              ////
////                                                              ////
////  This file is part of the CAN Protocal Controller            ////
////  http://www.opencores.org/projects/can/                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////       Igor Mohor                                             ////
////       igorm@opencores.org                                    ////
////                                                              ////
////                                                              ////
////  All additional information is avaliable in the README.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002 Authors                                   ////
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
// Revision 1.2  2002/12/25 14:17:00  mohor
// Synchronization working.
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

module can_btl
( 
  clk,
  rst,
  rx,

  /* Mode register */
  reset_mode,           // Not used !!!

  /* Bus Timing 0 register */
  baud_r_presc,
  sync_jump_width,

  /* Bus Timing 1 register */
  time_segment1,
  time_segment2,
  triple_sampling,

  /* Output signals from this module */
  take_sample,
  clk_en,
  
  /* States */
  idle,
  
  /* bit stream processor (can_bsp.v) */
  sync_mode


);

parameter Tp = 1;

input         clk;
input         rst;
input         rx;

/* Mode register */
input         reset_mode;

/* Bus Timing 0 register */
input   [5:0] baud_r_presc;
input   [1:0] sync_jump_width;

/* Bus Timing 1 register */
input   [3:0] time_segment1;
input   [2:0] time_segment2;
input         triple_sampling;

/* Output signals from this module */
output        take_sample;
output        clk_en;

input         idle;

/* bit stream processor (can_bsp.v) */
input         sync_mode;        // NOT USED, YET


reg     [8:0] clk_cnt;
reg           clk_en;
reg           sync_blocked;
reg           sampled_bit;
reg     [7:0] quant_cnt;
reg     [3:0] delay;
reg           sync;
reg           seg1;
reg           seg2;
reg           resync_latched;
reg           sample_pulse;

wire          go_sync;
wire          go_seg1;
wire          go_seg2;
wire [8:0]    preset_cnt;
wire          hard_sync;
wire          resync;
wire          sync_window;



assign preset_cnt = (baud_r_presc + 1'b1)<<1;        // (BRP+1)*2
assign hard_sync  =   idle  & (~rx) & sampled_bit & (~sync_blocked);  // Hard synchronization
assign resync     = (~idle) & (~rx) & sampled_bit & (~sync_blocked);  // Re-synchronization


/* Generating general enable signal that defines baud rate. */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      clk_cnt <= 0;
      clk_en  <= 1'b0;
    end
  else if (clk_cnt == (preset_cnt-1))
    begin
      clk_cnt <=#Tp 0;
      clk_en  <=#Tp 1'b1;
    end
  else
    begin
      clk_cnt <=#Tp clk_cnt + 1;
      clk_en  <=#Tp 1'b0;
    end
end



/* Changing states */
assign go_sync = clk_en & (seg2 & (~resync) & ((quant_cnt == time_segment2)));
assign go_seg1 = clk_en & (sync | hard_sync | (resync & seg2 & sync_window) | (resync_latched & sync_window));
assign go_seg2 = clk_en & (seg1 & (quant_cnt == (time_segment1 + delay)));


/* When early edge is detected outside of the SJW field, synchronization request is latched and performed when
   SJW is reached */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    resync_latched <= 1'b0;
  else if (resync & seg2 & (~sync_window))
    resync_latched <=#Tp 1'b1;
  else if (go_seg1)
    resync_latched <= 1'b0;
end



/* Synchronization stage/segment */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    sync <= 1;
  else if (go_sync)
    sync <=#Tp 1'b1;
  else if (go_seg1)
    sync <=#Tp 1'b0;
end


/* Seg1 stage/segment (together with propagation segment which is 1 quant long) */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    seg1 <= 0;
  else if (go_seg1)
    seg1 <=#Tp 1'b1;
  else if (go_seg2)
    seg1 <=#Tp 1'b0;
end


/* Seg2 stage/segment */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    seg2 <= 0;
  else if (go_seg2)
    seg2 <=#Tp 1'b1;
  else if (go_sync | go_seg1)
    seg2 <=#Tp 1'b0;
end


/* Quant counter */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    quant_cnt <= 0;
  else if (go_sync || go_seg1 || go_seg2)
    quant_cnt <=#Tp 0;
  else if (clk_en)
    quant_cnt <=#Tp quant_cnt + 1'b1;
end


/* When late edge is detected (in seg1 stage), stage seg1 is prolonged. */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    delay <= 0;
  else if (clk_en & resync & seg1)
    delay <=#Tp (quant_cnt > sync_jump_width)? (sync_jump_width + 1) : (quant_cnt + 1);
  else if (go_sync | go_seg1)
    delay <=#Tp 0;
end


// If early edge appears within this window (in seg2 stage), phase error is fully compensated
assign sync_window = ((time_segment2 - quant_cnt) < ( sync_jump_width + 1));


// Sampling data 
always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      sampled_bit <= 1;
      sample_pulse <= 0;
    end
  else if (go_seg2)
    begin
      sampled_bit <=#Tp rx;
      sample_pulse <=#Tp 1;
    end
  else
    sample_pulse <=#Tp 0;       // Sample pulse is for development purposes only. REMOVE ME.
end



/* Blocking synchronization (can occur only once in a bit time) */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    sync_blocked <=#Tp 1'b0;
  else if (clk_en)
    begin
      if (hard_sync || resync)
        sync_blocked <=#Tp 1'b1;
      else if (seg2 & quant_cnt == time_segment2)
        sync_blocked <=#Tp 1'b0;
    end
end





endmodule
