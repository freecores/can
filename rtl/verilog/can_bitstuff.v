//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_bitstuff.v                                              ////
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

module can_bitstuff
( clk,
  rst,
  enable,
  data_in,
  data_out
);

parameter Tp = 1;

input  clk;
input  rst;
input  enable;
input  [30:0]arbitration;

output data_out;


reg [2:0] bit_cnt;
reg       data_in_q;

always @ (posedge clk or posedge rst)
begin
  if(rst)
    data_in_q <= 0;
  else if (enable)
    data_in_q <= data_in;
  else
    data_in_q <= ~data_in;
end


always @ (posedge clk or posedge rst)
begin
  if(rst)
    bit_cnt <= 0;
  else if (enable)
    begin
      if(data_in ^ data_in_q)
        bit_cnt <= 0;
      else
        bit_cnt <= bit_cnt + 1'b1;
    end
  else
    bit_cnt <= 0;
end


always @ (posedge clk or posedge rst)
begin
  if(rst)
    data_out <= 0;
  else if (enable)
    data_in_q <= data_in;
  else
    data_in_q <= ~data_in;
end



wire go_idle;


always @ (posedge clk or posedge rst)
begin
  if(rst)
    cnt <= 0;
  else if(data_in)
    cnt <= cnt + 1'b1;
end


always @ (posedge clk or posedge rst)
begin
  if(rst)
    idle <= 1'b0;
  else if(go_idle)
    idle <= 1'b1;
end


endmodule
