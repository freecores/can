// Signalscan Version 6.7p1


define noactivityindicator
define analog waveform lines
define add variable default overlay off
define waveform window analogheight 1
define terminal automatic
define buttons control \
  1 opensimmulationfile \
  2 executedofile \
  3 designbrowser \
  4 waveform \
  5 source \
  6 breakpoints \
  7 definesourcessearchpath \
  8 exit \
  9 createbreakpoint \
  10 creategroup \
  11 createmarker \
  12 closesimmulationfile \
  13 renamesimmulationfile \
  14 replacesimulationfiledata \
  15 listopensimmulationfiles \
  16 savedofile
define buttons waveform \
  1 undo \
  2 cut \
  3 copy \
  4 paste \
  5 delete \
  6 zoomin \
  7 zoomout \
  8 zoomoutfull \
  9 expand \
  10 createmarker \
  11 designbrowser:1 \
  12 variableradixbinary \
  13 variableradixoctal \
  14 variableradixdecimal \
  15 variableradixhexadecimal \
  16 variableradixascii
define buttons designbrowser \
  1 undo \
  2 cut \
  3 copy \
  4 paste \
  5 delete \
  6 cdupscope \
  7 getallvariables \
  8 getdeepallvariables \
  9 addvariables \
  10 addvarsandclosewindow \
  11 closewindow \
  12 scopefiltermodule \
  13 scopefiltertask \
  14 scopefilterfunction \
  15 scopefilterblock \
  16 scopefilterprimitive
define buttons event \
  1 undo \
  2 cut \
  3 copy \
  4 paste \
  5 delete \
  6 move \
  7 closewindow \
  8 duplicate \
  9 defineasrisingedge \
  10 defineasfallingedge \
  11 defineasanyedge \
  12 variableradixbinary \
  13 variableradixoctal \
  14 variableradixdecimal \
  15 variableradixhexadecimal \
  16 variableradixascii
define buttons source \
  1 undo \
  2 cut \
  3 copy \
  4 paste \
  5 delete \
  6 createbreakpoint \
  7 creategroup \
  8 createmarker \
  9 createevent \
  10 createregisterpage \
  11 closewindow \
  12 opensimmulationfile \
  13 closesimmulationfile \
  14 renamesimmulationfile \
  15 replacesimulationfiledata \
  16 listopensimmulationfiles
define buttons register \
  1 undo \
  2 cut \
  3 copy \
  4 paste \
  5 delete \
  6 createregisterpage \
  7 closewindow \
  8 continuefor \
  9 continueuntil \
  10 continueforever \
  11 stop \
  12 previous \
  13 next \
  14 variableradixbinary \
  15 variableradixhexadecimal \
  16 variableradixascii
define show related transactions  
define exit prompt
define event search direction forward
define variable nofullhierarchy
define variable nofilenames
define variable nofullpathfilenames
include bookmark with filenames
include scope history without filenames
define waveform window listpane 5.97
define waveform window namepane 13.98
define multivalueindication
define pattern curpos dot
define pattern cursor1 dot
define pattern cursor2 dot
define pattern marker dot
define print designer "Igor Mohor"
define print border
define print color blackonwhite
define print command "/usr/ucb/lpr -P%P"
define print printer  lp
define print range visible
define print variable visible
define rise fall time low threshold percentage 10
define rise fall time high threshold percentage 90
define rise fall time low value 0
define rise fall time high value 3.3
define sendmail command "/usr/lib/sendmail"
define sequence time width 30.00
define snap

define source noprompt
define time units default
define userdefinedbussymbol
define user guide directory "/usr/local/designacc/signalscan-6.7p1/doc/html"
define waveform window grid off
define waveform window waveheight 14
define waveform window wavespace 6
define web browser command netscape
define zoom outfull on initial add off
add group \
    can_top \
      can_testbench.i_can_top.acceptance_filter_mode \
      can_testbench.i_can_top.addr[7:0]'h \
      can_testbench.i_can_top.baud_r_presc[5:0]'h \
      can_testbench.i_can_top.clk \
      can_testbench.i_can_top.clk_en \
      can_testbench.i_can_top.cs \
      can_testbench.i_can_top.data_in[7:0]'h \
      can_testbench.i_can_top.data_out[7:0]'h \
      can_testbench.i_can_top.listen_only_mode \
      can_testbench.i_can_top.reset_mode \
      can_testbench.i_can_top.rst \
      can_testbench.i_can_top.rw \
      can_testbench.i_can_top.rx \
      can_testbench.i_can_top.sleep_mode \
      can_testbench.i_can_top.sync_jump_width[1:0]'h \
      can_testbench.i_can_top.time_segment1[3:0]'h \
      can_testbench.i_can_top.time_segment2[2:0]'h \
      can_testbench.i_can_top.triple_sampling \

add group \
    can_btl \
      can_testbench.i_can_top.i_can_btl.hard_sync \
      can_testbench.i_can_top.i_can_btl.resync \
      can_testbench.i_can_top.i_can_btl.rx \
      can_testbench.i_can_top.i_can_btl.sample_point \
      can_testbench.i_can_top.i_can_btl.sampled_bit \

add group \
    can_acf \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_code_0[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_code_1[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_code_2[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_code_3[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_filter_mode \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_mask_0[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_mask_1[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_mask_2[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.acceptance_mask_3[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.clk \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.data0[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.data1[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.extended_mode \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.go_rx_crc_lim \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.go_rx_idle \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.id[28:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.id_ok \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.ide \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.match \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.match_df_ext \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.match_df_std \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.match_sf_ext \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.match_sf_std \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.no_data \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.reset_mode \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.rst \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.rtr1 \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.rtr2 \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.sample_point \

add group \
    testbench \
      can_testbench.send_frame.cnt's \
      can_testbench.send_frame.crc[14:0]'h \
      can_testbench.send_frame.data[117:0]'h \
      { \
        id_xx[56:46] descendingorder \
          can_testbench.send_frame.data[56] \
          can_testbench.send_frame.data[55] \
          can_testbench.send_frame.data[54] \
          can_testbench.send_frame.data[53] \
          can_testbench.send_frame.data[52] \
          can_testbench.send_frame.data[51] \
          can_testbench.send_frame.data[50] \
          can_testbench.send_frame.data[49] \
          can_testbench.send_frame.data[48] \
          can_testbench.send_frame.data[47] \
          can_testbench.send_frame.data[46] \
      }'h \
      { \
        rtr_ide_r0[45:43] descendingorder \
          can_testbench.send_frame.data[45] \
          can_testbench.send_frame.data[44] \
          can_testbench.send_frame.data[43] \
      }'h \
      { \
        dlc_xx[42:39] descendingorder \
          can_testbench.send_frame.data[42] \
          can_testbench.send_frame.data[41] \
          can_testbench.send_frame.data[40] \
          can_testbench.send_frame.data[39] \
      }'h \
      { \
        byte1[38:31] descendingorder \
          can_testbench.send_frame.data[38] \
          can_testbench.send_frame.data[37] \
          can_testbench.send_frame.data[36] \
          can_testbench.send_frame.data[35] \
          can_testbench.send_frame.data[34] \
          can_testbench.send_frame.data[33] \
          can_testbench.send_frame.data[32] \
          can_testbench.send_frame.data[31] \
      }'h \
      { \
        byte2[30:23] descendingorder \
          can_testbench.send_frame.data[30] \
          can_testbench.send_frame.data[29] \
          can_testbench.send_frame.data[28] \
          can_testbench.send_frame.data[27] \
          can_testbench.send_frame.data[26] \
          can_testbench.send_frame.data[25] \
          can_testbench.send_frame.data[24] \
          can_testbench.send_frame.data[23] \
      }'h \
      { \
        byte_3[22:15] descendingorder \
          can_testbench.send_frame.data[22] \
          can_testbench.send_frame.data[21] \
          can_testbench.send_frame.data[20] \
          can_testbench.send_frame.data[19] \
          can_testbench.send_frame.data[18] \
          can_testbench.send_frame.data[17] \
          can_testbench.send_frame.data[16] \
          can_testbench.send_frame.data[15] \
      }'h \
      { \
        crc_xx[14:0] descendingorder \
          can_testbench.send_frame.data[14] \
          can_testbench.send_frame.data[13] \
          can_testbench.send_frame.data[12] \
          can_testbench.send_frame.data[11] \
          can_testbench.send_frame.data[10] \
          can_testbench.send_frame.data[9] \
          can_testbench.send_frame.data[8] \
          can_testbench.send_frame.data[7] \
          can_testbench.send_frame.data[6] \
          can_testbench.send_frame.data[5] \
          can_testbench.send_frame.data[4] \
          can_testbench.send_frame.data[3] \
          can_testbench.send_frame.data[2] \
          can_testbench.send_frame.data[1] \
          can_testbench.send_frame.data[0] \
      }'h \
      can_testbench.send_frame.id[28:0]'h \
      can_testbench.send_frame.length[3:0]'h \
      can_testbench.send_frame.mode \
      can_testbench.send_frame.pointer's \
      can_testbench.send_frame.previous_bit \
      can_testbench.send_frame.remote_trans_req \
      can_testbench.send_frame.stuff_cnt's \
      can_testbench.send_frame.total_bits's \
      can_testbench.send_frame.stuff \
      can_testbench.send_frame.xxx \

add group \
    can_bsp \
      can_testbench.i_can_top.i_can_bsp.acceptance_code_0[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.acceptance_code_1[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.acceptance_code_2[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.acceptance_code_3[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.acceptance_filter_mode \
      can_testbench.i_can_top.i_can_bsp.acceptance_mask_0[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.acceptance_mask_1[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.acceptance_mask_2[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.acceptance_mask_3[7:0]'h \
      can_testbench.i_can_top.i_can_btl.rx \
      can_testbench.i_can_top.i_can_btl.sample_point \
      can_testbench.i_can_top.i_can_btl.sampled_bit \
      can_testbench.i_can_top.i_can_bsp.sampled_bit_q \
      can_testbench.i_can_top.i_can_bsp.bit_cnt[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_reset \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_set \
      can_testbench.i_can_top.i_can_bsp.bit_stuff_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.bit_stuff_cnt_en \
      can_testbench.i_can_top.i_can_bsp.byte_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.calculated_crc[14:0]'h \
      can_testbench.i_can_top.i_can_bsp.clk \
      can_testbench.i_can_top.i_can_bsp.crc_enable \
      can_testbench.i_can_top.i_can_bsp.crc_error \
      can_testbench.i_can_top.i_can_bsp.crc_in[14:0]'h \
      can_testbench.i_can_top.i_can_bsp.data_for_fifo[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.id[28:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.id_ok \
      can_testbench.i_can_top.i_can_bsp.data_len[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.eof_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.extended_mode \
      can_testbench.i_can_top.i_can_bsp.rst_crc_enable \
      can_testbench.i_can_top.i_can_bsp.rtr1 \
      can_testbench.i_can_top.i_can_bsp.rtr2 \
      can_testbench.i_can_top.i_can_bsp.rx_ack \
      can_testbench.i_can_top.i_can_bsp.rx_ack_lim \
      can_testbench.i_can_top.i_can_bsp.rx_crc \
      can_testbench.i_can_top.i_can_bsp.rx_crc_lim \
      can_testbench.i_can_top.i_can_bsp.rx_data \
      can_testbench.i_can_top.i_can_bsp.rx_dlc \
      can_testbench.i_can_top.i_can_bsp.rx_eof \
      can_testbench.i_can_top.i_can_bsp.rx_id1 \
      can_testbench.i_can_top.i_can_bsp.rx_id2 \
      can_testbench.i_can_top.i_can_bsp.rx_ide \
      can_testbench.i_can_top.i_can_bsp.rx_idle \
      can_testbench.i_can_top.i_can_bsp.rx_r0 \
      can_testbench.i_can_top.i_can_bsp.rx_r1 \
      can_testbench.i_can_top.i_can_bsp.rx_rtr1 \
      can_testbench.i_can_top.i_can_bsp.rx_rtr2 \
      can_testbench.i_can_top.i_can_bsp.go_crc_enable \
      can_testbench.i_can_top.i_can_bsp.go_rx_ack \
      can_testbench.i_can_top.i_can_bsp.go_rx_ack_lim \
      can_testbench.i_can_top.i_can_bsp.go_rx_crc \
      can_testbench.i_can_top.i_can_bsp.go_rx_crc_lim \
      can_testbench.i_can_top.i_can_bsp.go_rx_data \
      can_testbench.i_can_top.i_can_bsp.go_rx_dlc \
      can_testbench.i_can_top.i_can_bsp.go_rx_eof \
      can_testbench.i_can_top.i_can_bsp.go_rx_id1 \
      can_testbench.i_can_top.i_can_bsp.go_rx_id2 \
      can_testbench.i_can_top.i_can_bsp.go_rx_ide \
      can_testbench.i_can_top.i_can_bsp.go_rx_idle \
      can_testbench.i_can_top.i_can_bsp.go_rx_r0 \
      can_testbench.i_can_top.i_can_bsp.go_rx_r1 \
      can_testbench.i_can_top.i_can_bsp.go_rx_rtr1 \
      can_testbench.i_can_top.i_can_bsp.go_rx_rtr2 \
      can_testbench.i_can_top.i_can_bsp.hard_sync \
      can_testbench.i_can_top.i_can_bsp.id[28:0]'h \
      can_testbench.i_can_top.i_can_bsp.id_ok \
      can_testbench.i_can_top.i_can_bsp.ide \
      can_testbench.i_can_top.i_can_bsp.no_data \
      can_testbench.i_can_top.i_can_bsp.reset_mode \
      can_testbench.i_can_top.i_can_bsp.reset_mode_q \
      can_testbench.i_can_top.i_can_bsp.reset_wr_fifo_normal_mode \
      can_testbench.i_can_top.i_can_bsp.resync \
      can_testbench.i_can_top.i_can_bsp.rst \
      can_testbench.i_can_top.i_can_bsp.sample_point \
      can_testbench.i_can_top.i_can_bsp.sampled_bit \
      can_testbench.i_can_top.i_can_bsp.sampled_bit_q \
      can_testbench.i_can_top.i_can_bsp.stuff_error \
      can_testbench.i_can_top.i_can_bsp.tmp_data[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.go_rx_ack_lim \
      can_testbench.i_can_top.i_can_bsp.id_ok \
      can_testbench.i_can_top.i_can_bsp.crc_error \
      can_testbench.i_can_top.i_can_bsp.extended_mode \
      can_testbench.i_can_top.i_can_bsp.header_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.data_cnt[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.data_for_fifo[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.wr_fifo \
      can_testbench.i_can_top.i_can_bsp.storing_header \
      can_testbench.i_can_top.i_can_bsp.header_len[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.write_data_to_tmp_fifo \

add group \
    can_fifo \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.clk \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.data_in[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.data_out[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.len_cnt[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.rd \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.rd_pointer[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.release_buffer \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.reset_mode \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.rst \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.wr \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.wr_pointer[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.wr_q \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.write_length_info \

add group \
    can_registers \
      can_testbench.i_can_top.i_can_registers.acceptance_code_0[7:0]'h \
      can_testbench.i_can_top.i_can_registers.acceptance_code_1[7:0]'h \
      can_testbench.i_can_top.i_can_registers.acceptance_code_2[7:0]'h \
      can_testbench.i_can_top.i_can_registers.acceptance_code_3[7:0]'h \
      can_testbench.i_can_top.i_can_registers.acceptance_filter_mode \
      can_testbench.i_can_top.i_can_registers.acceptance_mask_0[7:0]'h \
      can_testbench.i_can_top.i_can_registers.acceptance_mask_1[7:0]'h \
      can_testbench.i_can_top.i_can_registers.acceptance_mask_2[7:0]'h \
      can_testbench.i_can_top.i_can_registers.acceptance_mask_3[7:0]'h \
      can_testbench.i_can_top.i_can_registers.addr[7:0]'h \
      can_testbench.i_can_top.i_can_registers.baud_r_presc[5:0]'h \
      can_testbench.i_can_top.i_can_registers.bus_timing_0[7:0]'h \
      can_testbench.i_can_top.i_can_registers.bus_timing_1[7:0]'h \
      can_testbench.i_can_top.i_can_registers.cd[2:0]'h \
      can_testbench.i_can_top.i_can_registers.clk \
      can_testbench.i_can_top.i_can_registers.clock_divider[7:0]'h \
      can_testbench.i_can_top.i_can_registers.clock_off \
      can_testbench.i_can_top.i_can_registers.cs \
      can_testbench.i_can_top.i_can_registers.data_in[7:0]'h \
      can_testbench.i_can_top.i_can_registers.data_out[7:0]'h \
      can_testbench.i_can_top.i_can_registers.extended_mode \
      can_testbench.i_can_top.i_can_registers.fix_me[7:0]'h \
      can_testbench.i_can_top.i_can_registers.listen_only_mode \
      can_testbench.i_can_top.i_can_registers.mode[7:0]'h \
      can_testbench.i_can_top.i_can_registers.read \
      can_testbench.i_can_top.i_can_registers.reset_mode \
      can_testbench.i_can_top.i_can_registers.rst \
      can_testbench.i_can_top.i_can_registers.rw \
      can_testbench.i_can_top.i_can_registers.rx_int_enable \
      can_testbench.i_can_top.i_can_registers.sleep_mode \
      can_testbench.i_can_top.i_can_registers.sync_jump_width[1:0]'h \
      can_testbench.i_can_top.i_can_registers.time_segment1[3:0]'h \
      can_testbench.i_can_top.i_can_registers.time_segment2[2:0]'h \
      can_testbench.i_can_top.i_can_registers.triple_sampling \
      can_testbench.i_can_top.i_can_registers.we_acceptance_code_0 \
      can_testbench.i_can_top.i_can_registers.we_acceptance_code_1 \
      can_testbench.i_can_top.i_can_registers.we_acceptance_code_2 \
      can_testbench.i_can_top.i_can_registers.we_acceptance_code_3 \
      can_testbench.i_can_top.i_can_registers.we_acceptance_mask_0 \
      can_testbench.i_can_top.i_can_registers.we_acceptance_mask_1 \
      can_testbench.i_can_top.i_can_registers.we_acceptance_mask_2 \
      can_testbench.i_can_top.i_can_registers.we_acceptance_mask_3 \
      can_testbench.i_can_top.i_can_registers.we_bus_timing_0 \
      can_testbench.i_can_top.i_can_registers.we_bus_timing_1 \
      can_testbench.i_can_top.i_can_registers.we_clock_divider_hi \
      can_testbench.i_can_top.i_can_registers.we_clock_divider_low \
      can_testbench.i_can_top.i_can_registers.we_mode \


deselect all
open window waveform 1 geometry 10 59 1592 1140
zoom at 109181(0)ns 0.00016079 0.00000000
