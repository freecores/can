//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_fifo.v                                                  ////
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
//
//
//

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on
`include "can_defines.v"

module can_fifo
( 
  clk,
  rst,

  rd,
  wr,
  wr_length_info,

  data_in,
  data_out,

  reset_mode,
  release_buffer,
  extended_mode
  
);

parameter Tp = 1;

input         clk;
input         rst;
input         rd;
input         wr;
input         wr_length_info;
input   [7:0] data_in;
input         reset_mode;
input         release_buffer;
input         extended_mode;

output  [7:0] data_in;


reg     [7:0] fifo [0:63];
reg     [5:0] rd_pointer;
reg     [5:0] wr_pointer;
reg     [3:0] length_info[0:6];
reg           overrun_info[0:6];



// length_info
always @ (posedge clk or posedge rst)
begin
  if (rst)
    length_info <= 0;
  else if (wr_length_info)
    length_info <=#Tp data_in;
  else if (reset_mode)
    length_info <=#Tp 0;
end


// rd_pointer
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rd_pointer <= 0;
  else if (rd)
    rd_pointer <=#Tp rd_pointer + length_info;
  else if (reset_mode)
    rd_pointer <=#Tp 0;
end


// wr_pointer
always @ (posedge clk or posedge rst)
begin
  if (rst)
    wr_pointer <= 0;
  else if (wr)
    wr_pointer <=#Tp wd_pointer + 1'b1;
  else if (reset_mode)
    wr_pointer <=#Tp 0;
end


// writing data to fifo
always @ (posedge clk or posedge rst)
begin
  if (wr)
    fifo[wr_pointer] <=#Tp data_in;
end






endmodule
