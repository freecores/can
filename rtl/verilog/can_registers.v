//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_registers.v                                             ////
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
// Revision 1.4  2003/01/08 02:10:55  mohor
// Acceptance filter added.
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
  triple_sampling,
  
  /* Clock Divider register */
  extended_mode,
  rx_int_enable,
  clock_off,
  cd,
  
  
  /* This section is for BASIC and EXTENDED mode */
  /* Acceptance code register */
  acceptance_code_0,

  /* Acceptance mask register */
  acceptance_mask_0,
  /* End: This section is for BASIC and EXTENDED mode */
  
  /* This section is for EXTENDED mode */
  /* Acceptance code register */
  acceptance_code_1,
  acceptance_code_2,
  acceptance_code_3,

  /* Acceptance mask register */
  acceptance_mask_1,
  acceptance_mask_2,
  acceptance_mask_3
  /* End: This section is for EXTENDED mode */
  
  
  


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

/* Clock Divider register */
output        extended_mode;
output        rx_int_enable;
output        clock_off;
output  [2:0] cd;


/* This section is for BASIC and EXTENDED mode */
/* Acceptance code register */
output  [7:0] acceptance_code_0;

/* Acceptance mask register */
output  [7:0] acceptance_mask_0;

/* End: This section is for BASIC and EXTENDED mode */


/* This section is for EXTENDED mode */
/* Acceptance code register */
output  [7:0] acceptance_code_1;
output  [7:0] acceptance_code_2;
output  [7:0] acceptance_code_3;

/* Acceptance mask register */
output  [7:0] acceptance_mask_1;
output  [7:0] acceptance_mask_2;
output  [7:0] acceptance_mask_3;

/* End: This section is for EXTENDED mode */





wire we_mode                  = cs & (~rw) & (addr == 8'h0);
wire we_bus_timing_0          = cs & (~rw) & (addr == 8'h6) & reset_mode;
wire we_bus_timing_1          = cs & (~rw) & (addr == 8'h7) & reset_mode;
wire we_clock_divider_hi      = cs & (~rw) & (addr == 8'h31) & reset_mode;
wire we_clock_divider_low     = cs & (~rw) & (addr == 8'h31);
wire read = cs & rw;


/* This section is for BASIC and EXTENDED mode */
wire we_acceptance_code_0       = cs & (~rw) & reset_mode & ((~extended_mode) & (addr == 8'h4) | extended_mode & (addr == 8'h16));
wire we_acceptance_mask_0       = cs & (~rw) & reset_mode & ((~extended_mode) & (addr == 8'h5) | extended_mode & (addr == 8'h20));
/* End: This section is for BASIC and EXTENDED mode */


/* This section is for EXTENDED mode */
wire we_acceptance_code_1     = cs & (~rw) & (addr == 8'h17) & reset_mode & extended_mode;
wire we_acceptance_code_2     = cs & (~rw) & (addr == 8'h18) & reset_mode & extended_mode;
wire we_acceptance_code_3     = cs & (~rw) & (addr == 8'h19) & reset_mode & extended_mode;
wire we_acceptance_mask_1     = cs & (~rw) & (addr == 8'h21) & reset_mode & extended_mode;
wire we_acceptance_mask_2     = cs & (~rw) & (addr == 8'h22) & reset_mode & extended_mode;
wire we_acceptance_mask_3     = cs & (~rw) & (addr == 8'h23) & reset_mode & extended_mode;
/* End: This section is for EXTENDED mode */






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


/* Clock Divider register */
wire   [7:0] clock_divider;
can_register #(5) CLOCK_DIVIDER_REG_HI
( .data_in(data_in[7:3]),
  .data_out(clock_divider[7:3]),
  .we(we_clock_divider_hi),
  .clk(clk)
);

can_register #(3) CLOCK_DIVIDER_REG_LOW
( .data_in(data_in[2:0]),
  .data_out(clock_divider[2:0]),
  .we(we_clock_divider_low),
  .clk(clk)
);

assign extended_mode = clock_divider[7];
assign rx_int_enable = clock_divider[5];
assign clock_off = clock_divider[3];
assign cd[2:0] = clock_divider[2:0];

/* End Clock Divider register */




/* This section is for BASIC and EXTENDED mode */

/* Acceptance code register */
can_register #(8) ACCEPTANCE_CODE_REG0
( .data_in(data_in),
  .data_out(acceptance_code_0),
  .we(we_acceptance_code_0),
  .clk(clk)
);
/* End: Acceptance code register */


/* Acceptance mask register */
can_register #(8) ACCEPTANCE_MASK_REG0
( .data_in(data_in),
  .data_out(acceptance_mask_0),
  .we(we_acceptance_mask_0),
  .clk(clk)
);
/* End: Acceptance code register */

/* End: This section is for BASIC and EXTENDED mode */



/* This section is for EXTENDED mode */

/* Acceptance code register 1 */
wire [7:0] acceptance_code_1;
can_register #(8) ACCEPTANCE_CODE_REG1
( .data_in(data_in),
  .data_out(acceptance_code_1),
  .we(we_acceptance_code_1),
  .clk(clk)
);
/* End: Acceptance code register */


/* Acceptance code register 2 */
wire [7:0] acceptance_code_2;
can_register #(8) ACCEPTANCE_CODE_REG2
( .data_in(data_in),
  .data_out(acceptance_code_2),
  .we(we_acceptance_code_2),
  .clk(clk)
);
/* End: Acceptance code register */


/* Acceptance code register 3 */
wire [7:0] acceptance_code_3;
can_register #(8) ACCEPTANCE_CODE_REG3
( .data_in(data_in),
  .data_out(acceptance_code_3),
  .we(we_acceptance_code_3),
  .clk(clk)
);
/* End: Acceptance code register */


/* Acceptance mask register 1 */
wire [7:0] acceptance_mask_1;
can_register #(8) ACCEPTANCE_MASK_REG1
( .data_in(data_in),
  .data_out(acceptance_mask_1),
  .we(we_acceptance_mask_1),
  .clk(clk)
);
/* End: Acceptance code register */


/* Acceptance mask register 2 */
wire [7:0] acceptance_mask_2;
can_register #(8) ACCEPTANCE_MASK_REG2
( .data_in(data_in),
  .data_out(acceptance_mask_2),
  .we(we_acceptance_mask_2),
  .clk(clk)
);
/* End: Acceptance code register */


/* Acceptance mask register 3 */
wire [7:0] acceptance_mask_3;
can_register #(8) ACCEPTANCE_MASK_REG3
( .data_in(data_in),
  .data_out(acceptance_mask_3),
  .we(we_acceptance_mask_3),
  .clk(clk)
);
/* End: Acceptance code register */


/* End: This section is for EXTENDED mode */



wire [7:0] fix_me = 8'h0;     // This wire is used in many exuations that are not final, yet. Fix them !!!



// Reading data from registers
always @ ( addr or read or extended_mode or mode or bus_timing_0 or bus_timing_1 or clock_divider
         )
begin
  if(read)  // read
    begin
      if (extended_mode)    // EXTENDED mode (Different register map depends on mode)
        begin
          case(addr)
            8'h0  :  data_out <= mode;
            8'h6  :  data_out <= bus_timing_0;
            8'h7  :  data_out <= bus_timing_1;
            8'h16 :  data_out <= reset_mode? acceptance_code_0 : fix_me;    // + fix TX identifiers
            8'h17 :  data_out <= reset_mode? acceptance_code_1 : fix_me;
            8'h18 :  data_out <= reset_mode? acceptance_code_2 : fix_me;
            8'h19 :  data_out <= reset_mode? acceptance_code_3 : fix_me;
            8'h20 :  data_out <= reset_mode? acceptance_mask_0 : fix_me;
            8'h21 :  data_out <= reset_mode? acceptance_mask_1 : fix_me;
            8'h22 :  data_out <= reset_mode? acceptance_mask_2 : fix_me;
            8'h23 :  data_out <= reset_mode? acceptance_mask_3 : fix_me;
    
            8'h31 :  data_out <= {clock_divider[7:5], 1'b0, clock_divider[3:0]};
    
            default: data_out <= 8'h0;
          endcase
        end
      else                  // BASIC mode
        begin
          case(addr)
            8'h0  :  data_out <= mode;
            8'h4  :  data_out <= reset_mode? acceptance_code_0 : 8'hff;
            8'h5  :  data_out <= reset_mode? acceptance_mask_0 : 8'hff;
            8'h6  :  data_out <= reset_mode? bus_timing_0 : 8'hff;
            8'h7  :  data_out <= reset_mode? bus_timing_1 : 8'hff;
    
            8'h31 :  data_out <= {clock_divider[7:5], 1'b0, clock_divider[3:0]};
    
            default: data_out <= 8'h0;
          endcase
        end
    end
  else
    data_out <= 8'h0;
end






endmodule
