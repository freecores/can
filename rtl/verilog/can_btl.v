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


reg           hard_sync_blocked;
reg           resync_blocked;
reg           monitored_bit;


/* Needed for edge detection */
always @ (posedge clk or posedge rst)
begin
  if (rst) 
    monitored_bit <= 1'b0;
  else if(clk_en)
    monitored_bit <=#Tp rx;
end


reg           sampled_bit;
reg     [7:0] quant_cnt;


/* Generating general enable signal that defines baud rate. 
   Hard synchronization is done here.                       */
wire [8:0]    preset_cnt = (baud_r_presc + 1'b1)<<1;        // (BRP+1)*2
wire          hard_sync =   idle  & (~monitored_bit) & sampled_bit & (~hard_sync_blocked);
wire          resync    = (~idle) & (~monitored_bit) & sampled_bit & (~resync_blocked);



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


/* Hard Synchronization */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      quant_cnt <=#Tp 0;
      hard_sync_blocked <=#Tp 1'b0;
    end
  else if (clk_en)
    begin
      if (hard_sync || (quant_cnt == (time_segment1 + time_segment2 + 2)))  // Hard synchronization
        begin
          quant_cnt <=#Tp 0;
          hard_sync_blocked <=#Tp hard_sync;
        end
      else
        begin
          quant_cnt <=#Tp quant_cnt + 1;
        end
    end
end


/* Resynchronization */
always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      resync_blocked <=#Tp 1'b0;
    end
  else if (clk_en)
    begin
      if (resync)
        begin
          if (quant_cnt == (time_segment1 + time_segment2 + 2))     // Right on time
            dodatek = 0;
          else if (sample_point_passed)                             // Too late
            dodatek = quant_cnt;  // Take smaller (SJW : quant_cnt)
          else                                                      // Too early
            reseti clock to 0 so we start with new bit sooner
      
      
      

/* sample_point_passed is needed for phase error detection. Signal is set only when resynchronization is possible (high to low transition) */
reg sample_point_passed;
always @ (posedge clk)
begin
  if (clk_en & (quant_cnt == (time_segment1 + time_segment2 + 2)))
    begin
      if(rx)
        sample_point_passed <=#Tp 1'b0;
      else
        sample_point_passed <=#Tp 1'b1;
    end
end


/* Sampling data */
wire sample_time = 

always @ (posedge clk or posedge rst)
begin
  if (rst)
    begin
      sampled_bit <= 1;
    end
  else if (clk_en & (quant_cnt == time_segment1))
    begin
      sampled_bit <=#Tp rx;
    end
end



Detect phase error and change the above flip-flop




endmodule
