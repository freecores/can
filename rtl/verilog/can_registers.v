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
//// The CAN protocol is developed by Robert Bosch GmbH and       ////
//// protected by patents. Anybody who wants to implement this    ////
//// CAN IP core on silicon has to obtain a CAN protocol license  ////
//// from Bosch.                                                  ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.12  2003/02/11 00:56:06  mohor
// Wishbone interface added.
//
// Revision 1.11  2003/02/09 02:24:33  mohor
// Bosch license warning added. Error counters finished. Overload frames
// still need to be fixed.
//
// Revision 1.10  2003/01/31 01:13:38  mohor
// backup.
//
// Revision 1.9  2003/01/15 13:16:48  mohor
// When a frame with "remote request" is received, no data is stored
// to fifo, just the frame information (identifier, ...). Data length
// that is stored is the received data length and not the actual data
// length that is stored to fifo.
//
// Revision 1.8  2003/01/14 17:25:09  mohor
// Addresses corrected to decimal values (previously hex).
//
// Revision 1.7  2003/01/14 12:19:35  mohor
// rx_fifo is now working.
//
// Revision 1.6  2003/01/10 17:51:34  mohor
// Temporary version (backup).
//
// Revision 1.5  2003/01/09 14:46:58  mohor
// Temporary files (backup).
//
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
  we,
  addr,
  data_in,
  data_out,

  sample_point,
  transmitting,

  /* Mode register */
  reset_mode,
  listen_only_mode,
  acceptance_filter_mode,
  sleep_mode,


  /* Command register */
  clear_data_overrun,
  release_buffer,
  abort_tx,
  tx_request,
  self_rx_request,

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
  acceptance_mask_3,
  /* End: This section is for EXTENDED mode */
  
  /* Tx data registers. Holding identifier (basic mode), tx frame information (extended mode) and data */
  tx_data_0,
  tx_data_1,
  tx_data_2,
  tx_data_3,
  tx_data_4,
  tx_data_5,
  tx_data_6,
  tx_data_7,
  tx_data_8,
  tx_data_9,
  tx_data_10,
  tx_data_11,
  tx_data_12
  /* End: Tx data registers */
  
  


);

parameter Tp = 1;

input         clk;
input         rst;
input         cs;
input         we;
input   [7:0] addr;
input   [7:0] data_in;

output  [7:0] data_out;
reg     [7:0] data_out;

input         sample_point;
input         transmitting;

/* Mode register */
output        reset_mode;
output        listen_only_mode;
output        acceptance_filter_mode;
output        sleep_mode;

/* Command register */
output        clear_data_overrun;
output        release_buffer;
output        abort_tx;
output        tx_request;
output        self_rx_request;

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

  /* Tx data registers. Holding identifier (basic mode), tx frame information (extended mode) and data */
output  [7:0] tx_data_0;
output  [7:0] tx_data_1;
output  [7:0] tx_data_2;
output  [7:0] tx_data_3;
output  [7:0] tx_data_4;
output  [7:0] tx_data_5;
output  [7:0] tx_data_6;
output  [7:0] tx_data_7;
output  [7:0] tx_data_8;
output  [7:0] tx_data_9;
output  [7:0] tx_data_10;
output  [7:0] tx_data_11;
output  [7:0] tx_data_12;
  /* End: Tx data registers */




wire we_mode                  = cs & we & (addr == 8'd0);
wire we_command               = cs & we & (addr == 8'd1);
wire we_bus_timing_0          = cs & we & (addr == 8'd6) & reset_mode;
wire we_bus_timing_1          = cs & we & (addr == 8'd7) & reset_mode;
wire we_clock_divider_low     = cs & we & (addr == 8'd31);
wire we_clock_divider_hi      = we_clock_divider_low & reset_mode;

wire read = cs & (~we);


/* This section is for BASIC and EXTENDED mode */
wire we_acceptance_code_0       = cs & we &   reset_mode  & ((~extended_mode) & (addr == 8'd4)  | extended_mode & (addr == 8'd16));
wire we_acceptance_mask_0       = cs & we &   reset_mode  & ((~extended_mode) & (addr == 8'd5)  | extended_mode & (addr == 8'd20));
wire we_tx_data_0               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd10) | extended_mode & (addr == 8'd16));
wire we_tx_data_1               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd11) | extended_mode & (addr == 8'd17));
wire we_tx_data_2               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd12) | extended_mode & (addr == 8'd18));
wire we_tx_data_3               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd13) | extended_mode & (addr == 8'd19));
wire we_tx_data_4               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd14) | extended_mode & (addr == 8'd20));
wire we_tx_data_5               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd15) | extended_mode & (addr == 8'd21));
wire we_tx_data_6               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd16) | extended_mode & (addr == 8'd22));
wire we_tx_data_7               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd17) | extended_mode & (addr == 8'd23));
wire we_tx_data_8               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd18) | extended_mode & (addr == 8'd24));
wire we_tx_data_9               = cs & we & (~reset_mode) & ((~extended_mode) & (addr == 8'd19) | extended_mode & (addr == 8'd25));
wire we_tx_data_10              = cs & we & (~reset_mode) & (                                     extended_mode & (addr == 8'd26));
wire we_tx_data_11              = cs & we & (~reset_mode) & (                                     extended_mode & (addr == 8'd27));
wire we_tx_data_12              = cs & we & (~reset_mode) & (                                     extended_mode & (addr == 8'd28));
/* End: This section is for BASIC and EXTENDED mode */


/* This section is for EXTENDED mode */
wire we_acceptance_code_1     = cs & we & (addr == 8'd17) & reset_mode & extended_mode;
wire we_acceptance_code_2     = cs & we & (addr == 8'd18) & reset_mode & extended_mode;
wire we_acceptance_code_3     = cs & we & (addr == 8'd19) & reset_mode & extended_mode;
wire we_acceptance_mask_1     = cs & we & (addr == 8'd21) & reset_mode & extended_mode;
wire we_acceptance_mask_2     = cs & we & (addr == 8'd22) & reset_mode & extended_mode;
wire we_acceptance_mask_3     = cs & we & (addr == 8'd23) & reset_mode & extended_mode;
/* End: This section is for EXTENDED mode */






/* Mode register */
wire   [7:0] mode;
wire         receive_irq_en_basic;
wire         transmit_irq_en_basic;
wire         error_irq_en_basic;
wire         overrun_irq_en_basic;

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

assign receive_irq_en_basic = mode[1];
assign transmit_irq_en_basic = mode[2];
assign error_irq_en_basic = mode[3];
assign overrun_irq_en_basic = mode[4];
/* End Mode register */


/* Command register */
wire   [4:0] command;
can_register_asyn_syn #(1, 1'h0) COMMAND_REG0
( .data_in(data_in[0]),
  .data_out(command[0]),
  .we(we_command),
  .clk(clk),
  .rst(rst),
  .rst_sync(tx_request & sample_point)
);

can_register_asyn_syn #(1, 1'h0) COMMAND_REG1
( .data_in(data_in[1]),
  .data_out(command[1]),
  .we(we_command),
  .clk(clk),
  .rst(rst),
  .rst_sync(abort_tx & ~transmitting)
);

can_register_asyn_syn #(3, 3'h0) COMMAND_REG
( .data_in(data_in[4:2]),
  .data_out(command[4:2]),
  .we(we_command),
  .clk(clk),
  .rst(rst),
  .rst_sync(|command[4:2])
);

assign self_rx_request = command[4];
assign clear_data_overrun = command[3];
assign release_buffer = command[2];
assign abort_tx = command[1];
assign tx_request = command[0];
/* End Command register */


/* Status register */
/*
wire   [7:0] status;
can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn_syn #(1, 0) BUS_STATUS_REG_0
( .data_in(),
  .data_out(status[0]),
  .we(),
  .clk(clk)
  .rst(rst),
  .rst_sync()
);

can_register_asyn #(1, 0) BUS_STATUS_REG_7
( .data_in(),
  .data_out(status[7]),
  .we(),
  .clk(clk)
  .rst(rst)
);
*/
/* End Status register */


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
/* End: Acceptance mask register */
/* End: This section is for BASIC and EXTENDED mode */


/* Tx data 0 register. */
can_register #(8) TX_DATA_REG0
( .data_in(data_in),
  .data_out(tx_data_0),
  .we(we_tx_data_0),
  .clk(clk)
);
/* End: Tx data 0 register. */


/* Tx data 1 register. */
can_register #(8) TX_DATA_REG1
( .data_in(data_in),
  .data_out(tx_data_1),
  .we(we_tx_data_1),
  .clk(clk)
);
/* End: Tx data 1 register. */


/* Tx data 2 register. */
can_register #(8) TX_DATA_REG2
( .data_in(data_in),
  .data_out(tx_data_2),
  .we(we_tx_data_2),
  .clk(clk)
);
/* End: Tx data 2 register. */


/* Tx data 3 register. */
can_register #(8) TX_DATA_REG3
( .data_in(data_in),
  .data_out(tx_data_3),
  .we(we_tx_data_3),
  .clk(clk)
);
/* End: Tx data 3 register. */


/* Tx data 4 register. */
can_register #(8) TX_DATA_REG4
( .data_in(data_in),
  .data_out(tx_data_4),
  .we(we_tx_data_4),
  .clk(clk)
);
/* End: Tx data 4 register. */


/* Tx data 5 register. */
can_register #(8) TX_DATA_REG5
( .data_in(data_in),
  .data_out(tx_data_5),
  .we(we_tx_data_5),
  .clk(clk)
);
/* End: Tx data 5 register. */


/* Tx data 6 register. */
can_register #(8) TX_DATA_REG6
( .data_in(data_in),
  .data_out(tx_data_6),
  .we(we_tx_data_6),
  .clk(clk)
);
/* End: Tx data 6 register. */


/* Tx data 7 register. */
can_register #(8) TX_DATA_REG7
( .data_in(data_in),
  .data_out(tx_data_7),
  .we(we_tx_data_7),
  .clk(clk)
);
/* End: Tx data 7 register. */


/* Tx data 8 register. */
can_register #(8) TX_DATA_REG8
( .data_in(data_in),
  .data_out(tx_data_8),
  .we(we_tx_data_8),
  .clk(clk)
);
/* End: Tx data 8 register. */


/* Tx data 9 register. */
can_register #(8) TX_DATA_REG9
( .data_in(data_in),
  .data_out(tx_data_9),
  .we(we_tx_data_9),
  .clk(clk)
);
/* End: Tx data 9 register. */


/* Tx data 10 register. */
can_register #(8) TX_DATA_REG10
( .data_in(data_in),
  .data_out(tx_data_10),
  .we(we_tx_data_10),
  .clk(clk)
);
/* End: Tx data 10 register. */


/* Tx data 11 register. */
can_register #(8) TX_DATA_REG11
( .data_in(data_in),
  .data_out(tx_data_11),
  .we(we_tx_data_11),
  .clk(clk)
);
/* End: Tx data 11 register. */


/* Tx data 12 register. */
can_register #(8) TX_DATA_REG12
( .data_in(data_in),
  .data_out(tx_data_12),
  .we(we_tx_data_12),
  .clk(clk)
);
/* End: Tx data 12 register. */





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




// Reading data from registers
always @ ( addr or read or extended_mode or mode or bus_timing_0 or bus_timing_1 or clock_divider or
           acceptance_code_0 or acceptance_code_1 or acceptance_code_2 or acceptance_code_3 or
           acceptance_mask_0 or acceptance_mask_1 or acceptance_mask_2 or acceptance_mask_3 or
           reset_mode or tx_data_0 or tx_data_1 or tx_data_2 or tx_data_3 or tx_data_4 or 
           tx_data_5 or tx_data_6 or tx_data_7 or tx_data_8 or tx_data_9
         )
begin
  if(read)  // read
    begin
      if (extended_mode)    // EXTENDED mode (Different register map depends on mode)
        begin
          case(addr)
            8'd0  :  data_out <= mode;
            8'd1  :  data_out <= 8'h0;
            8'd6  :  data_out <= bus_timing_0;
            8'd7  :  data_out <= bus_timing_1;
            8'd16 :  data_out <= acceptance_code_0;
            8'd17 :  data_out <= acceptance_code_1;
            8'd18 :  data_out <= acceptance_code_2;
            8'd19 :  data_out <= acceptance_code_3;
            8'd20 :  data_out <= acceptance_mask_0;
            8'd21 :  data_out <= acceptance_mask_1;
            8'd22 :  data_out <= acceptance_mask_2;
            8'd23 :  data_out <= acceptance_mask_3;
            8'd24 :  data_out <= 8'h0;
            8'd25 :  data_out <= 8'h0;
            8'd26 :  data_out <= 8'h0;
            8'd27 :  data_out <= 8'h0;
            8'd28 :  data_out <= 8'h0;
    
            8'd31 :  data_out <= {clock_divider[7:5], 1'b0, clock_divider[3:0]};
    
            default: data_out <= 8'h0;
          endcase
        end
      else                  // BASIC mode
        begin
          case(addr)
            8'd0  :  data_out <= mode;
            8'd1  :  data_out <= 8'hff;
            8'd4  :  data_out <= reset_mode? acceptance_code_0 : 8'hff;
            8'd5  :  data_out <= reset_mode? acceptance_mask_0 : 8'hff;
            8'd6  :  data_out <= reset_mode? bus_timing_0 : 8'hff;
            8'd7  :  data_out <= reset_mode? bus_timing_1 : 8'hff;
            8'd10 :  data_out <= reset_mode? 8'hff : tx_data_0;
            8'd11 :  data_out <= reset_mode? 8'hff : tx_data_1;
            8'd12 :  data_out <= reset_mode? 8'hff : tx_data_2;
            8'd13 :  data_out <= reset_mode? 8'hff : tx_data_3;
            8'd14 :  data_out <= reset_mode? 8'hff : tx_data_4;
            8'd15 :  data_out <= reset_mode? 8'hff : tx_data_5;
            8'd16 :  data_out <= reset_mode? 8'hff : tx_data_6;
            8'd17 :  data_out <= reset_mode? 8'hff : tx_data_7;
            8'd18 :  data_out <= reset_mode? 8'hff : tx_data_8;
            8'd19 :  data_out <= reset_mode? 8'hff : tx_data_9;
            8'd31 :  data_out <= {clock_divider[7:5], 1'b0, clock_divider[3:0]};
    
            default: data_out <= 8'h0;
          endcase
        end
    end
  else
    data_out <= 8'h0;
end












endmodule
