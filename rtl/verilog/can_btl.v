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
reg           monitored_bit;


/* Needed for edge detection */
always @ (posedge clk or posedge rst)
begin
  if (rst) 
    monitored_bit <= 1'b1;
  else if(clk_en)
    monitored_bit <=#Tp rx;
end


reg           sampled_bit;
reg     [7:0] quant_cnt;
reg     [3:0] dodatek;
wire          odstevek;

wire    [7:0] difference;


reg           rx_early;



/* Generating general enable signal that defines baud rate. 
   Hard synchronization is done here.                       */
wire [8:0]    preset_cnt = (baud_r_presc + 1'b1)<<1;        // (BRP+1)*2
wire          hard_sync =   idle  & (~rx) & sampled_bit & (~sync_blocked);
wire          resync    = (~idle) & (~rx) & sampled_bit & (~sync_blocked);



/* Generating enable signal (can clock) */
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



assign difference = time_segment1 + time_segment2 + 3 - quant_cnt;



/* Synchronization */
/*
always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      quant_cnt <=#Tp 0;
      sync_blocked <=#Tp 1'b0;
      dodatek <=#Tp 0;
      odstevek <=#Tp 0;
    end
  else if (clk_en)
    begin
      if (hard_sync)        // Hard synchronization
        begin
          quant_cnt <=#Tp 1;
          sync_blocked <=#Tp 1'b1;
        end
      else if (resync)      // resynchronization
        begin
          sync_blocked <=#Tp 1'b1;
          if (quant_cnt == 0)     // Right on time
            quant_cnt <=#Tp quant_cnt + 1;
          else if (rx_early)                             // Too early
            begin
                quant_cnt <=#Tp 1;
              odstevek <=#Tp (difference > (sync_jump_width + 1))? (sync_jump_width + 1) : difference;
            end
          else                                                // Too late         // Take smaller (SJW : quant_cnt)
            begin
              dodatek <=#Tp (quant_cnt > (sync_jump_width + 1))? (sync_jump_width + 1) : quant_cnt;
              quant_cnt <=#Tp quant_cnt + 1;
            end
        end
      else if (quant_cnt == (time_segment1 + time_segment2 + 2 + dodatek))
//      else if (quant_cnt == (time_segment1 + time_segment2 + 2 + dodatek - odstevek))
        begin
          quant_cnt <=#Tp 0;
          sync_blocked <=#Tp 1'b0;
          dodatek <=#Tp 0;
          odstevek <=#Tp 0;
        end
      else
        quant_cnt <=#Tp quant_cnt + 1;
    end
end





reg sample_pulse;
// Sampling data 
always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      sampled_bit <= 1;
      sample_pulse <= 0;
    end
  else if (clk_en & (quant_cnt == (time_segment1 + 1 + dodatek)) & (~idle))   // (~idle) blocks sampling so hard sync works in all cases
    begin
      sampled_bit <=#Tp rx;
      sample_pulse <=#Tp 1;
    end
  else
    sample_pulse <=#Tp 0;
end



always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      rx_early <= 1'b0;
    end
  else if (clk_en & rx & (quant_cnt == (time_segment1 + 1)))
    begin
      rx_early <=#Tp 1'b1;
    end
  else if (clk_en & (quant_cnt == 0))
    rx_early <=#Tp 1'b0;
end


*/


reg sync;
reg seg1;
reg seg2;
reg resync_latched;


wire go_sync = clk_en & (seg2 & (~resync) & ((quant_cnt == time_segment2)));
wire go_seg1 = clk_en & (sync | hard_sync | (resync & seg2 & odstevek) | (resync_latched & odstevek));
wire go_seg2 = clk_en & (seg1 & (quant_cnt == (time_segment1 + dodatek)));


always @ (posedge clk or posedge rst)
begin
  if (rst)
    resync_latched <= 1'b0;
  else if (resync & seg2 & (~odstevek))
    resync_latched <=#Tp 1'b1;
  else if (go_seg1)
    resync_latched <= 1'b0;
end




always @ (posedge clk or posedge rst)
begin
  if (rst)
    sync <= 1;
  else if (go_sync)
    sync <=#Tp 1'b1;
  else if (go_seg1)
    sync <=#Tp 1'b0;
end


always @ (posedge clk or posedge rst)
begin
  if (rst)
    seg1 <= 0;
  else if (go_seg1)
    seg1 <=#Tp 1'b1;
  else if (go_seg2)
    seg1 <=#Tp 1'b0;
end


always @ (posedge clk or posedge rst)
begin
  if (rst)
    seg2 <= 0;
  else if (go_seg2)
    seg2 <=#Tp 1'b1;
  else if (go_sync | go_seg1)
    seg2 <=#Tp 1'b0;
end


always @ (posedge clk or posedge rst)
begin
  if (rst)
    quant_cnt <= 0;
  else if (go_sync || go_seg1 || go_seg2)
    quant_cnt <=#Tp 0;
  else if (clk_en)
    quant_cnt <=#Tp quant_cnt + 1'b1;
end


always @ (posedge clk or posedge rst)
begin
  if (rst)
    dodatek <= 0;
  else if (clk_en & resync & seg1)
    dodatek <=#Tp (quant_cnt > sync_jump_width)? (sync_jump_width + 1) : (quant_cnt + 1);
  else if (go_sync | go_seg1)
    dodatek <=#Tp 0;
end

/*
always @ (posedge clk or posedge rst)
begin
  if (rst)
    odstevek <= 0;
  else if (clk_en & resync & seg2)
    odstevek <=#Tp ((time_segment2 + 1 - quant_cnt) > sync_jump_width)? (sync_jump_width + 1) : (time_segment2 + 1 - quant_cnt);
  else if (go_sync | go_seg1)
    odstevek <=#Tp 0;
end
*/

assign odstevek = ((time_segment2 - quant_cnt) < ( sync_jump_width + 1));



reg sample_pulse;
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
    sample_pulse <=#Tp 0;
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
