//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_registers.v                                             ////
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

module can_registers
( 
  clk,
  rst,
  cs,
  rw,
  addr,
  data_in,
  data_out,

  /* Mode register */
  reset_mode,
  listen_only_mode,
  acceptance_filter_mode,
  sleep_mode,

  /* Bus Timing 0 register */
  baud_r_presc,
  sync_jump_width,

  /* Bus Timing 1 register */
  time_segment1,
  time_segment2,
  triple_sampling

);

parameter Tp = 1;

input         clk;
input         rst;
input         cs;
input         rw;
input   [7:0] addr;
input   [7:0] data_in;

output  [7:0] data_out;
reg     [7:0] data_out;

/* Mode register */
output        reset_mode;
output        listen_only_mode;
output        acceptance_filter_mode;
output        sleep_mode;

/* Bus Timing 0 register */
output  [5:0] baud_r_presc;
output  [1:0] sync_jump_width;


/* Bus Timing 1 register */
output  [3:0] time_segment1;
output  [2:0] time_segment2;
output        triple_sampling;


wire we_mode          = cs & (~rw) & (addr == 8'h0);
wire we_bus_timing_0  = cs & (~rw) & (addr == 8'h6) & reset_mode;
wire we_bus_timing_1  = cs & (~rw) & (addr == 8'h7) & reset_mode;

wire read = cs & rw;

/* Mode register */
wire   [7:0] mode;
can_register_asyn #(8, 8'h1) MODE_REG
( .data_in(data_in),
  .data_out(mode),
  .we(we_mode),
  .clk(clk),
  .rst(rst)
);

assign reset_mode = mode[0];
assign listen_only_mode = mode[1];
assign acceptance_filter_mode = mode[3];
assign sleep_mode = mode[4];
/* End Mode register */


/* Bus Timing 0 register */
wire   [7:0] bus_timing_0;
can_register #(8) BUS_TIMING_0_REG
( .data_in(data_in),
  .data_out(bus_timing_0),
  .we(we_bus_timing_0),
  .clk(clk)
);

assign baud_r_presc = bus_timing_0[5:0];
assign sync_jump_width = bus_timing_0[7:6];
/* End Bus Timing 0 register */


/* Bus Timing 1 register */
wire   [7:0] bus_timing_1;
can_register #(8) BUS_TIMING_1_REG
( .data_in(data_in),
  .data_out(bus_timing_1),
  .we(we_bus_timing_1),
  .clk(clk)
);

assign time_segment1 = bus_timing_1[3:0];
assign time_segment2 = bus_timing_1[6:4];
assign triple_sampling = bus_timing_1[7];
/* End Bus Timing 1 register */













// Reading data from registers
always @ ( addr or read or mode or bus_timing_0 or bus_timing_1
         )
begin
  if(read)  // read
    begin
      case(addr)
        8'h0  :  data_out <= mode;
        8'h6  :  data_out <= bus_timing_0;
        8'h7  :  data_out <= bus_timing_1;

        default: data_out <= 8'h0;
      endcase
    end
  else
    data_out <= 8'h0;
end





/*
module can_register
( data_in,
  data_out,
  we,
  clk,
  rst,
  rst_sync
);

parameter WIDTH = 8; // default parameter of the register width
parameter RESET_VALUE = 0;
*/

endmodule
