//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_testbench.v                                             ////
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
// Revision 1.6  2002/12/27 00:12:48  mohor
// Header changed, testbench improved to send a frame (crc still missing).
//
// Revision 1.5  2002/12/26 16:00:29  mohor
// Testbench define file added. Clock divider register added.
//
// Revision 1.4  2002/12/26 01:33:01  mohor
// Tripple sampling supported.
//
// Revision 1.3  2002/12/25 23:44:12  mohor
// Commented lines removed.
//
// Revision 1.2  2002/12/25 14:16:54  mohor
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
`include "can_testbench_defines.v"

module can_testbench();



parameter Tp = 1;
parameter BRP = 2*(`CAN_TIMING0_BRP + 1);



reg         clk;
reg         rst;
reg   [7:0] data_in;
wire  [7:0] data_out;
reg         cs, rw;
reg   [7:0] addr;
reg         rx;
integer     start_tb;

/* Instantiate can_top module */
can_top i_can_top
( 
  .clk(clk),
  .rst(rst),
  .data_in(data_in),
  .data_out(data_out),
  .cs(cs),
  .rw(rw),
  .addr(addr),
  .rx(rx)
);


// Generate clock signal 24 MHz
initial
begin
  clk=0;
  forever #20 clk = ~clk;
end

initial
begin
  start_tb = 0;
  data_in = 'hz;
  cs = 0;
  rw = 'hz;
  addr = 'hz;
  rx = 1;
  rst = 1;
  #200 rst = 0;
  #200 start_tb = 1;
end


// Main testbench
initial
begin
  wait(start_tb);

  /* Set bus timing register 0 */
  write_register(8'h6, {`CAN_TIMING0_SJW, `CAN_TIMING0_BRP});

  /* Set bus timing register 1 */
  write_register(8'h7, {`CAN_TIMING1_SAM, `CAN_TIMING1_TSEG2, `CAN_TIMING1_TSEG1});
  
  #10;
  repeat (1000) @ (posedge clk);
  
  /* Switch-off reset mode */
  write_register(8'h0, {7'h0, ~(`CAN_MODE_RESET)});

  repeat (BRP) @ (posedge clk);   // At least BRP clocks needed before bus goes to dominant level. Otherwise 1 quant difference is possible
                                  // This difference is resynchronized later.

//  test_synchronization;

  repeat (7) send_bit(1);         // Sending EOF


  send_frame(1, 29'h00075678, 1); // mode, id, length
  

  repeat (50000) @ (posedge clk);
  $display("CAN Testbench finished.");
  $stop;
end




task write_register;
  input [7:0] reg_addr;
  input [7:0] reg_data;

  begin
    @ (posedge clk);
    #1; 
    addr = reg_addr;
    data_in = reg_data;
    cs = 1;
    rw = 0;
    @ (posedge clk);
    #1; 
    addr = 'hz;
    data_in = 'hz;
    cs = 0;
    rw = 'hz;
  end
endtask


task test_synchronization;
  begin
    // Hard synchronization
    #1 rx=0;
    repeat (2*BRP) @ (posedge clk);
//    #1 idle = 0;
    repeat (8*BRP) @ (posedge clk);
    #1 rx=1;
    repeat (10*BRP) @ (posedge clk);
  
    // Resynchronization on time
    #1 rx=0;
    repeat (10*BRP) @ (posedge clk);
    #1 rx=1;
//    idle = 0;
    repeat (10*BRP) @ (posedge clk);
  
    // Resynchronization late
    repeat (BRP) @ (posedge clk);
    repeat (BRP) @ (posedge clk);
    #1 rx=0;
    repeat (10*BRP) @ (posedge clk);
    #1 rx=1;
//    idle = 0;
  
    // Resynchronization early
    repeat (8*BRP) @ (posedge clk);   // two frames too early
    #1 rx=0;
    repeat (10*BRP) @ (posedge clk);
    #1 rx=1;
//    idle = 0;
    repeat (10*BRP) @ (posedge clk);
  end
endtask


task send_bit;
  input bit;
  integer cnt;
  begin
    #1 rx=bit;
    repeat ((`CAN_TIMING1_TSEG1 + `CAN_TIMING1_TSEG2 + 3)*BRP) @ (posedge clk);
//    idle=0;
  end
endtask


task send_frame;
  input mode;
  input [28:0] id;
  input  [3:0] length;
  integer cnt;

  reg [28:0] data;
  reg  [3:0] len;
  begin

    data = id;
    len  = length;

    send_bit(0);                        // SOF

    if(mode)      // Extended format
      begin
        for (cnt=0; cnt<11; cnt=cnt+1)  // 11 bit ID
          begin
            send_bit(data[28]);
            data=data<<1;
          end
        send_bit(1);                    // SRR
        send_bit(1);                    // IDE

        for (cnt=11; cnt<29; cnt=cnt+1)  // 18 bit ID
          begin
            send_bit(data[28]);
            data=data<<1;
          end

        send_bit(0);                    // RTR
        send_bit(0);                    // r1 (reserved 1)
        send_bit(0);                    // r0 (reserved 0)

        for (cnt=0; cnt<4; cnt=cnt+1)   // DLC (length)
          begin
            send_bit(len[3]);
            len=len<<1;
          end
      end
    else                  // Standard format
      begin
        for (cnt=0; cnt<11; cnt=cnt+1)  // 11 bit ID
          begin
            send_bit(data[10]);
            data=data<<1;
          end
        send_bit(0);                    // RTR
        send_bit(0);                    // IDE
        send_bit(0);                    // r0 (reserved 0)

        for (cnt=0; cnt<4; cnt=cnt+1)   // DLC (length)
          begin
            send_bit(len[3]);
            len=len<<1;
          end
      end                 // End header


      for (cnt=0; cnt<(8*length); cnt=cnt+4)  // data
        begin
          send_bit(cnt[3]);
          send_bit(cnt[2]);
          send_bit(cnt[1]);
          send_bit(cnt[0]);
        end


      // Nothing send after the data (just recessive bit)
      send_bit(1);



  end
endtask


/* State machine monitor (btl) */
always @ (posedge clk)
begin
  if(can_testbench.i_can_top.i_can_btl.go_sync & can_testbench.i_can_top.i_can_btl.go_seg1 | can_testbench.i_can_top.i_can_btl.go_sync & can_testbench.i_can_top.i_can_btl.go_seg2 | 
     can_testbench.i_can_top.i_can_btl.go_seg1 & can_testbench.i_can_top.i_can_btl.go_seg2)
    begin
      $display("(%0t) ERROR multiple go_sync, go_seg1 or go_seg2 occurance\n\n", $time);
      #1000;
      $stop;
    end

  if(can_testbench.i_can_top.i_can_btl.sync & can_testbench.i_can_top.i_can_btl.seg1 | can_testbench.i_can_top.i_can_btl.sync & can_testbench.i_can_top.i_can_btl.seg2 | 
     can_testbench.i_can_top.i_can_btl.seg1 & can_testbench.i_can_top.i_can_btl.seg2)
    begin
      $display("(%0t) ERROR multiple sync, seg1 or seg2 occurance\n\n", $time);
      #1000;
      $stop;
    end
end

/* stuff_error monitor (bsp)
always @ (posedge clk)
begin
  if(can_testbench.i_can_top.i_can_bsp.stuff_error)
    begin
      $display("\n\n(%0t) Stuff error occured in can_bsp.v file\n\n", $time);
      $stop;                                      After everything is finished add another condition (something like & (~idle)) and enable stop
    end
end
*/


endmodule
