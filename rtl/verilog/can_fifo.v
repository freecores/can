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
// Revision 1.2  2003/01/09 14:46:58  mohor
// Temporary files (backup).
//
// Revision 1.1  2003/01/08 02:10:55  mohor
// Acceptance filter added.
//
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

  data_in,
  addr,
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
input   [7:0] data_in;
input   [7:0] addr;
input         reset_mode;
input         release_buffer;
input         extended_mode;

output  [7:0] data_out;


reg     [7:0] fifo [0:63];
reg     [5:0] rd_pointer;
reg     [5:0] wr_pointer;
reg     [5:0] read_address;
reg     [3:0] length_info[0:31];
reg     [4:0] wr_info_pointer;
reg     [4:0] rd_info_pointer;
reg           overrun_info[0:31];
reg           wr_q;
reg     [3:0] len_cnt;

wire          write_length_info;


assign write_length_info = (~wr) & wr_q;

// Delayed write signal
always @ (posedge clk or posedge rst)
begin
  if (rst)
    wr_q <= 0;
  else if (reset_mode)
    wr_q <=#Tp 0;
  else
    wr_q <=#Tp wr;
end


// length counter
always @ (posedge clk or posedge rst)
begin
  if (rst)
    len_cnt <= 0;
  else if (reset_mode | write_length_info)
    len_cnt <=#Tp 1'b0;
  else if (wr)
    len_cnt <=#Tp len_cnt + 1'b1;
end


// wr_info_pointer
always @ (posedge clk or posedge rst)
begin
  if (rst)
    wr_info_pointer <= 0;
  else if (reset_mode)
    wr_info_pointer <=#Tp 0;
  else if (write_length_info)
    wr_info_pointer <=#Tp wr_info_pointer + 1'b1;
end


// length_info
always @ (posedge clk)
begin
  if (write_length_info)
    length_info[wr_info_pointer] <=#Tp len_cnt;
end


// rd_info_pointer
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rd_info_pointer <= 0;
  else if (reset_mode)
    rd_info_pointer <=#Tp 0;
  else if (release_buffer)
    rd_info_pointer <=#Tp rd_info_pointer + 1'b1;
end





// rd_pointer
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rd_pointer <= 0;
  else if (release_buffer)
    rd_pointer <=#Tp rd_pointer + length_info[rd_info_pointer];
  else if (reset_mode)
    rd_pointer <=#Tp 0;
end


// wr_pointer
always @ (posedge clk or posedge rst)
begin
  if (rst)
    wr_pointer <= 0;
  else if (wr)
    wr_pointer <=#Tp wr_pointer + 1'b1;
  else if (reset_mode)
    wr_pointer <=#Tp 0;
end


// writing data to fifo
always @ (posedge clk or posedge rst)
begin
  if (wr)
    fifo[wr_pointer] <=#Tp data_in;
end



// Selecting which address will be used for reading data from rx fifo
always @ (extended_mode or rd_pointer or addr)
begin
  if (extended_mode)      // extended mode
    begin
      read_address <= rd_pointer + (addr - 8'h16);
    end
  else                    // normal mode
    begin
      read_address <= rd_pointer + (addr - 8'h20);
    end
end



assign data_out = fifo[read_address];




endmodule
