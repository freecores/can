//////////////////////////////////////////////////////////////////////
////                                                              ////
////  can_bsp.v                                                   ////
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
// Revision 1.7  2003/01/09 21:54:45  mohor
// rx fifo added. Not 100 % verified, yet.
//
// Revision 1.6  2003/01/09 14:46:58  mohor
// Temporary files (backup).
//
// Revision 1.5  2003/01/08 13:30:31  mohor
// Temp version.
//
// Revision 1.4  2003/01/08 02:10:53  mohor
// Acceptance filter added.
//
// Revision 1.3  2002/12/28 04:13:23  mohor
// Backup version.
//
// Revision 1.2  2002/12/27 00:12:52  mohor
// Header changed, testbench improved to send a frame (crc still missing).
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

module can_bsp
( 
  clk,
  rst,

  sample_point,
  sampled_bit,
  sampled_bit_q,
  hard_sync,
  resync,

  addr,
  data_out,


  /* Mode register */
  reset_mode,
  acceptance_filter_mode,

  /* Command register */
  release_buffer,

  /* Clock Divider register */
  extended_mode,

  rx_idle,

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
input         sample_point;
input         sampled_bit;
input         sampled_bit_q;
input         hard_sync;
input         resync;
input   [7:0] addr;
output  [7:0] data_out;


input         reset_mode;
input         acceptance_filter_mode;
input         extended_mode;

/* Command register */
input         release_buffer;

output        rx_idle;

/* This section is for BASIC and EXTENDED mode */
/* Acceptance code register */
input   [7:0] acceptance_code_0;

/* Acceptance mask register */
input   [7:0] acceptance_mask_0;

/* End: This section is for BASIC and EXTENDED mode */


/* This section is for EXTENDED mode */
/* Acceptance code register */
input   [7:0] acceptance_code_1;
input   [7:0] acceptance_code_2;
input   [7:0] acceptance_code_3;

/* Acceptance mask register */
input   [7:0] acceptance_mask_1;
input   [7:0] acceptance_mask_2;
input   [7:0] acceptance_mask_3;

/* End: This section is for EXTENDED mode */



reg           reset_mode_q;
reg     [5:0] bit_cnt;

reg     [3:0] data_len;
reg    [28:0] id;
reg     [2:0] bit_stuff_cnt;
reg           stuff_error;

wire          bit_de_stuff;


/* Rx state machine */
wire          go_rx_idle;
wire          go_rx_id1;
wire          go_rx_rtr1;
wire          go_rx_ide;
wire          go_rx_id2;
wire          go_rx_rtr2;
wire          go_rx_r1;
wire          go_rx_r0;
wire          go_rx_dlc;
wire          go_rx_data;
wire          go_rx_crc;
wire          go_rx_crc_lim;
wire          go_rx_ack;
wire          go_rx_ack_lim;
wire          go_rx_eof;

wire          go_crc_enable;
wire          rst_crc_enable;

wire          bit_de_stuff_set;
wire          bit_de_stuff_reset;

reg           rx_idle;
reg           rx_id1;
reg           rx_rtr1;
reg           rx_ide;
reg           rx_id2;
reg           rx_rtr2;
reg           rx_r1;
reg           rx_r0;
reg           rx_dlc;
reg           rx_data;
reg           rx_crc;
reg           rx_crc_lim;
reg           rx_ack;
reg           rx_ack_lim;
reg           rx_eof;

reg           crc_enable;

reg     [2:0] eof_cnt;
wire   [14:0] calculated_crc;

assign go_rx_idle     =                   sample_point &  rx_eof  & (eof_cnt == 6);
assign go_rx_id1      =                   sample_point &  rx_idle & (~sampled_bit);
assign go_rx_rtr1     = (~bit_de_stuff) & sample_point &  rx_id1  & (bit_cnt == 10);
assign go_rx_ide      = (~bit_de_stuff) & sample_point &  rx_rtr1;
assign go_rx_id2      = (~bit_de_stuff) & sample_point &  rx_ide  &   sampled_bit;
assign go_rx_rtr2     = (~bit_de_stuff) & sample_point &  rx_id2  & (bit_cnt == 17);
assign go_rx_r1       = (~bit_de_stuff) & sample_point &  rx_rtr2;
assign go_rx_r0       = (~bit_de_stuff) & sample_point & (rx_ide  & (~sampled_bit) | rx_r1);
assign go_rx_dlc      = (~bit_de_stuff) & sample_point &  rx_r0;
assign go_rx_data     = (~bit_de_stuff) & sample_point &  rx_dlc  & (bit_cnt == 3) & (sampled_bit | (|data_len[2:0]));
assign go_rx_crc      = (~bit_de_stuff) & sample_point & (rx_dlc  & (bit_cnt == 3) & (~sampled_bit) & (~(|data_len[2:0])) |
                                                          rx_data & (bit_cnt == ((data_len<<3) - 1'b1)));
assign go_rx_crc_lim  =                   sample_point &  rx_crc  & (bit_cnt == 14);
assign go_rx_ack      =                   sample_point &  rx_crc_lim;
assign go_rx_ack_lim  =                   sample_point &  rx_ack;
assign go_rx_eof      =                   sample_point &  rx_ack_lim  | (~reset_mode) & reset_mode_q;

assign go_crc_enable  = hard_sync;
assign rst_crc_enable = go_rx_crc;

assign bit_de_stuff_set   = go_rx_id1;
assign bit_de_stuff_reset = go_rx_crc_lim;


// Rx idle state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_idle <= 1'b1;
  else if (reset_mode | go_rx_id1)
    rx_idle <=#Tp 1'b0;
  else if (go_rx_idle)
    rx_idle <=#Tp 1'b1;
end


// Rx id1 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_id1 <= 1'b0;
  else if (reset_mode | go_rx_rtr1)
    rx_id1 <=#Tp 1'b0;
  else if (go_rx_id1)
    rx_id1 <=#Tp 1'b1;
end


// Rx rtr1 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_rtr1 <= 1'b0;
  else if (reset_mode | go_rx_ide)
    rx_rtr1 <=#Tp 1'b0;
  else if (go_rx_rtr1)
    rx_rtr1 <=#Tp 1'b1;
end


// Rx ide state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_ide <= 1'b0;
  else if (reset_mode | go_rx_r0 | go_rx_id2)
    rx_ide <=#Tp 1'b0;
  else if (go_rx_ide)
    rx_ide <=#Tp 1'b1;
end


// Rx id2 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_id2 <= 1'b0;
  else if (reset_mode | go_rx_rtr2)
    rx_id2 <=#Tp 1'b0;
  else if (go_rx_id2)
    rx_id2 <=#Tp 1'b1;
end


// Rx rtr2 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_rtr2 <= 1'b0;
  else if (reset_mode | go_rx_r1)
    rx_rtr2 <=#Tp 1'b0;
  else if (go_rx_rtr2)
    rx_rtr2 <=#Tp 1'b1;
end


// Rx r0 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_r1 <= 1'b0;
  else if (reset_mode | go_rx_r0)
    rx_r1 <=#Tp 1'b0;
  else if (go_rx_r1)
    rx_r1 <=#Tp 1'b1;
end


// Rx r0 state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_r0 <= 1'b0;
  else if (reset_mode | go_rx_dlc)
    rx_r0 <=#Tp 1'b0;
  else if (go_rx_r0)
    rx_r0 <=#Tp 1'b1;
end


// Rx dlc state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_dlc <= 1'b0;
  else if (reset_mode | go_rx_data | go_rx_crc)
    rx_dlc <=#Tp 1'b0;
  else if (go_rx_dlc)
    rx_dlc <=#Tp 1'b1;
end


// Rx data state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_data <= 1'b0;
  else if (reset_mode | go_rx_crc)
    rx_data <=#Tp 1'b0;
  else if (go_rx_data)
    rx_data <=#Tp 1'b1;
end


// Rx crc state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_crc <= 1'b0;
  else if (reset_mode | go_rx_crc_lim)
    rx_crc <=#Tp 1'b0;
  else if (go_rx_crc)
    rx_crc <=#Tp 1'b1;
end


// Rx crc delimiter state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_crc_lim <= 1'b0;
  else if (reset_mode | go_rx_ack)
    rx_crc_lim <=#Tp 1'b0;
  else if (go_rx_crc_lim)
    rx_crc_lim <=#Tp 1'b1;
end


// Rx ack state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_ack <= 1'b0;
  else if (reset_mode | go_rx_ack_lim)
    rx_ack <=#Tp 1'b0;
  else if (go_rx_ack)
    rx_ack <=#Tp 1'b1;
end


// Rx ack delimiter state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_ack_lim <= 1'b0;
  else if (reset_mode | go_rx_eof)
    rx_ack_lim <=#Tp 1'b0;
  else if (go_rx_ack_lim)
    rx_ack_lim <=#Tp 1'b1;
end


// Rx eof state
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rx_eof <= 1'b0;
  else if (go_rx_idle)
    rx_eof <=#Tp 1'b0;
  else if (go_rx_eof)
    rx_eof <=#Tp 1'b1;
end




reg rtr1;
reg ide;
reg rtr2;
reg [14:0] crc_in;

// ID register
always @ (posedge clk or posedge rst)
begin
  if (rst)
    id <= 0;
  else if (sample_point & (rx_id1 | rx_id2) & (~bit_de_stuff))
    id <=#Tp {id[27:0], sampled_bit};
end


// rtr1 bit
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rtr1 <= 0;
  else if (sample_point & rx_rtr1 & (~bit_de_stuff))
    rtr1 <=#Tp sampled_bit;
end


// rtr2 bit
always @ (posedge clk or posedge rst)
begin
  if (rst)
    rtr2 <= 0;
  else if (sample_point & rx_rtr2 & (~bit_de_stuff))
    rtr2 <=#Tp sampled_bit;
end


// ide bit
always @ (posedge clk or posedge rst)
begin
  if (rst)
    ide <= 0;
  else if (sample_point & rx_ide & (~bit_de_stuff))
    ide <=#Tp sampled_bit;
end


// Data length
always @ (posedge clk or posedge rst)
begin
  if (rst)
    data_len <= 0;
  else if (sample_point & rx_dlc & (~bit_de_stuff))
    data_len <=#Tp {data_len[2:0], sampled_bit};
end


// Data
reg [7:0] tmp_data;
reg [7:0] tmp_fifo [0:7];
always @ (posedge clk or posedge rst)
begin
  if (rst)
    tmp_data <= 0;
  else if (sample_point & rx_data & (~bit_de_stuff))
    tmp_data <=#Tp {tmp_data[6:0], sampled_bit};
end


reg write_data_to_tmp_fifo;
always @ (posedge clk or posedge rst)
begin
  if (rst)
    write_data_to_tmp_fifo <= 0;
  else if (sample_point & rx_data & (~bit_de_stuff) & (&bit_cnt[2:0]))
    write_data_to_tmp_fifo <=#Tp 1'b1;
  else
    write_data_to_tmp_fifo <=#Tp 0;
end


reg [2:0] byte_cnt;
always @ (posedge clk or posedge rst)
begin
  if (rst)
    byte_cnt <= 0;
  else if (write_data_to_tmp_fifo)
    byte_cnt <=#Tp byte_cnt + 1;
  else if (sample_point & go_rx_crc_lim)
    byte_cnt <=#Tp 0;
end


always @ (posedge clk or posedge rst)
begin
  if (write_data_to_tmp_fifo)
    tmp_fifo[byte_cnt] <=#Tp tmp_data;
end



// CRC
always @ (posedge clk or posedge rst)
begin
  if (rst)
    crc_in <= 0;
  else if (sample_point & rx_crc & (~bit_de_stuff))
    crc_in <=#Tp {crc_in[13:0], sampled_bit};
end


// bit_cnt
always @ (posedge clk or posedge rst)
begin
  if (rst)
    bit_cnt <= 0;
  else if (go_rx_id1 | go_rx_id2 | go_rx_dlc | go_rx_data | go_rx_crc | go_rx_ack | go_rx_eof)
    bit_cnt <=#Tp 0;
  else if (sample_point & (~bit_de_stuff))
    bit_cnt <=#Tp bit_cnt + 1'b1;
end


// eof_cnt
always @ (posedge clk or posedge rst)
begin
  if (rst)
    eof_cnt <= 0;
  else if (sample_point)
    begin
      if (rx_eof & sampled_bit)
        eof_cnt <=#Tp eof_cnt + 1'b1;
      else
        eof_cnt <=#Tp 0;
    end
end


// Enabling bit de-stuffing
reg bit_stuff_cnt_en;
always @ (posedge clk or posedge rst)
begin
  if (rst)
    bit_stuff_cnt_en <= 1'b0;
  else if (bit_de_stuff_set)
    bit_stuff_cnt_en <=#Tp 1'b1;
  else if (bit_de_stuff_reset)
    bit_stuff_cnt_en <=#Tp 1'b0;
end

// bit_stuff_cnt
always @ (posedge clk or posedge rst)
begin
  if (rst)
    bit_stuff_cnt <= 1;
  else if (bit_de_stuff_reset)
    bit_stuff_cnt <=#Tp 1;
  else if (sample_point & bit_stuff_cnt_en)
    begin
      if (bit_stuff_cnt == 5)
        bit_stuff_cnt <=#Tp 1;
      else if (sampled_bit == sampled_bit_q)
        bit_stuff_cnt <=#Tp bit_stuff_cnt + 1'b1;
      else
        bit_stuff_cnt <=#Tp 1;
    end
end


assign bit_de_stuff = bit_stuff_cnt == 5;


// stuff_error
always @ (posedge clk or posedge rst)
begin
  if (rst)
    stuff_error <= 0;
  else if (sample_point & (rx_id1) & bit_de_stuff & (sampled_bit == sampled_bit_q))   // Add other stages (data, control, etc.) !!!
    stuff_error <=#Tp 1'b1;
//  else if (reset condition)       // Add reset condition
//    stuff_error <=#Tp 0;
end


// Generating delayed reset_mode signal
always @ (posedge clk)
begin
  reset_mode_q <=#Tp reset_mode;
end



always @ (posedge clk or posedge rst)
begin
  if (rst)
    crc_enable <= 1'b0;
  else if (go_crc_enable)
    crc_enable <=#Tp 1'b1;
  else if (reset_mode | rst_crc_enable)
    crc_enable <=#Tp 1'b0;
end


reg crc_error;
// CRC error generation
always @ (posedge clk or posedge rst)
begin
  if (rst)
    crc_error <= 0;
  else if (go_rx_ack)
    crc_error <=#Tp crc_in != calculated_crc;
  else if (reset_mode | rx_eof)
    crc_error <=#Tp 0;
end



// Instantiation of the RX CRC module
can_crc i_can_crc_rx 
(
  .clk(clk),
//  .data(sampled_bit & (~rx_crc)),     // Zeros are shifted in for calculation when we are in crc stage
  .data(sampled_bit ),     // Zeros are shifted in for calculation when we are in crc stage
  .enable(crc_enable & sample_point & (~bit_de_stuff)),
  .initialize(rx_eof),
  .crc(calculated_crc)
);



wire          id_ok;        // If received ID matches ID set in registers
wire          no_data;      // There is no data (RTR bit set to 1 or DLC field equal to 0)

assign no_data = rtr1 | (~(|data_len));

can_acf i_can_acf
(
  .clk(clk),
  .rst(rst),
  
  .id(id),

  /* Mode register */
  .reset_mode(reset_mode),
  .acceptance_filter_mode(acceptance_filter_mode),

  // Clock Divider register
  .extended_mode(extended_mode),
  
  /* This section is for BASIC and EXTENDED mode */
  /* Acceptance code register */
  .acceptance_code_0(acceptance_code_0),

  /* Acceptance mask register */
  .acceptance_mask_0(acceptance_mask_0),
  /* End: This section is for BASIC and EXTENDED mode */
  
  /* This section is for EXTENDED mode */
  /* Acceptance code register */
  .acceptance_code_1(acceptance_code_1),
  .acceptance_code_2(acceptance_code_2),
  .acceptance_code_3(acceptance_code_3),

  /* Acceptance mask register */
  .acceptance_mask_1(acceptance_mask_1),
  .acceptance_mask_2(acceptance_mask_2),
  .acceptance_mask_3(acceptance_mask_3),
  /* End: This section is for EXTENDED mode */

  .sample_point(sample_point),
  .go_rx_crc_lim(go_rx_crc_lim),
  .go_rx_idle(go_rx_idle),
  
  .data0(tmp_fifo[0]),
  .data1(tmp_fifo[1]),
  .rtr1(rtr1),
  .rtr2(rtr2),
  .ide(ide),
  .no_data(no_data),

  .id_ok(id_ok)

);



reg [3:0]   data_cnt;       // Counting the data bytes that are written to FIFO
reg [2:0]   header_cnt;     // Counting header length
reg         wr_fifo;        // Write data and header to 64-byte fifo
reg [7:0]   data_for_fifo;  // Multiplexed data that is stored to 64-byte fifo


wire [2:0]  header_len;
wire        storing_header;
wire        data_cnt_en;
wire [3:0]  limited_data_len;
wire        reset_wr_fifo_normal_mode;

assign header_len[2:0] = extended_mode ? (ide? (3'h5) : (3'h3)) : 3'h2;    // + 1 because data_cnt need to start with 0
assign storing_header = header_cnt < header_len;
assign data_cnt_en = header_cnt == header_len;
assign limited_data_len[3:0] = (data_len < 8)? (data_len -1'b1) : 4'h7;   // - 1 because counter counts from 0
assign reset_wr_fifo_normal_mode = data_cnt == limited_data_len;


// Write enable signal for 64-byte rx fifo
always @ (posedge clk or posedge rst)
begin
  if (rst)
    wr_fifo <= 1'b0;
  if (go_rx_ack_lim & (~extended_mode) & id_ok & (~crc_error))
    wr_fifo <=#Tp 1'b1;
  else if (reset_wr_fifo_normal_mode)
    wr_fifo <=#Tp 1'b0;
end


// Header counter. Header length depends on the mode of operation and frame format.
always @ (posedge clk or posedge rst)
begin
  if (rst)
    header_cnt <= 0;
  if (wr_fifo)
    header_cnt <=#Tp header_cnt + 1;
  else if (reset_wr_fifo_normal_mode)
    header_cnt <=#Tp 0;
end


// Data counter. Length of the data is limited to 8 bytes.
always @ (posedge clk or posedge rst)
begin
  if (rst)
    data_cnt <= 0;
  if (data_cnt_en)
    data_cnt <=#Tp data_cnt + 1;
  else if (reset_wr_fifo_normal_mode)
    data_cnt <=#Tp 0;
end


// Multiplexing data that is stored to 64-byte fifo depends on the mode of operation and frame format
always @ (extended_mode or ide or data_cnt or header_cnt or storing_header or id or rtr1 or rtr2 or data_len or
          tmp_fifo[0] or tmp_fifo[2] or tmp_fifo[4] or tmp_fifo[6] or 
          tmp_fifo[1] or tmp_fifo[3] or tmp_fifo[5] or tmp_fifo[7])
begin
  if (storing_header)
    begin
      if (extended_mode)      // extended mode
        begin
          if (ide)              // extended format
            begin
              case (header_cnt)            // synopsys parallel_case synopsys full_case
                4'h0  : data_for_fifo <= {1'b1, rtr2, 2'h0, data_len};
                4'h1  : data_for_fifo <= id[28:21];
                4'h2  : data_for_fifo <= id[20:13];
                4'h3  : data_for_fifo <= id[12:5];
                4'h4  : data_for_fifo <= {id[4:0], 3'h0};
              endcase
            end
          else                  // standard format
            begin
              case (header_cnt)            // synopsys parallel_case synopsys full_case
                4'h0  : data_for_fifo <= {1'b0, rtr1, 2'h0, data_len};
                4'h1  : data_for_fifo <= id[10:3];
                4'h2  : data_for_fifo <= {id[2:0], 5'h0};
              endcase
            end
        end
      else                    // normal mode
        begin
          case (header_cnt)            // synopsys parallel_case synopsys full_case
            4'h0  : data_for_fifo <= id[10:3];
            4'h1  : data_for_fifo <= {id[2:0], rtr1, data_len};
          endcase
        end
    end
  else
    data_for_fifo <= tmp_fifo[data_cnt];
end




// Instantiation of the RX fifo module
can_fifo i_can_fifo
( 
  .clk(clk),
  .rst(rst),

  .rd(1'b0),                // FIX ME
  .wr(wr_fifo),

  .data_in(data_for_fifo),
  .addr(addr),
  .data_out(data_out),

  .reset_mode(reset_mode),
  .release_buffer(release_buffer),
  .extended_mode(extended_mode)

  
);








endmodule
