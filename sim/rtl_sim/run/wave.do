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
define waveform window listpane 8.96
define waveform window namepane 14.36
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
      can_testbench.i_can_top.tx \
      can_testbench.i_can_top.rx \

add group \
    can_btl \
      can_testbench.i_can_top.i_can_btl.rx \
      can_testbench.i_can_top.i_can_btl.baud_r_presc[5:0]'h \
      can_testbench.i_can_top.i_can_btl.clk \
      can_testbench.i_can_top.i_can_btl.clk_cnt[8:0]'h \
      can_testbench.i_can_top.i_can_btl.clk_en \
      can_testbench.i_can_top.i_can_btl.delay[3:0]'h \
      can_testbench.i_can_top.i_can_btl.go_seg1 \
      can_testbench.i_can_top.i_can_btl.go_seg2 \
      can_testbench.i_can_top.i_can_btl.go_sync \
      can_testbench.i_can_top.i_can_btl.hard_sync \
      can_testbench.i_can_top.i_can_btl.preset_cnt[8:0]'h \
      can_testbench.i_can_top.i_can_btl.quant_cnt[7:0]'h \
      can_testbench.i_can_top.i_can_btl.reset_mode \
      can_testbench.i_can_top.i_can_btl.resync \
      can_testbench.i_can_top.i_can_btl.resync_latched \
      can_testbench.i_can_top.i_can_btl.rst \
      can_testbench.i_can_top.i_can_btl.rx_idle \
      can_testbench.i_can_top.i_can_btl.sample[1:0]'h \
      can_testbench.i_can_top.i_can_btl.sample_point \
      can_testbench.i_can_top.i_can_btl.sampled_bit \
      can_testbench.i_can_top.i_can_btl.sampled_bit_q \
      can_testbench.i_can_top.i_can_btl.seg1 \
      can_testbench.i_can_top.i_can_btl.seg2 \
      can_testbench.i_can_top.i_can_btl.sync \
      can_testbench.i_can_top.i_can_btl.sync_blocked \
      can_testbench.i_can_top.i_can_btl.sync_jump_width[1:0]'h \
      can_testbench.i_can_top.i_can_btl.sync_window \
      can_testbench.i_can_top.i_can_btl.time_segment1[3:0]'h \
      can_testbench.i_can_top.i_can_btl.time_segment2[2:0]'h \
      can_testbench.i_can_top.i_can_btl.transmitting \
      can_testbench.i_can_top.i_can_btl.triple_sampling \
      can_testbench.i_can_top.i_can_btl.tx_point \

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
      can_testbench.i_can_top.i_can_bsp.i_can_acf.reset_mode \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.rst \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.rtr1 \
      can_testbench.i_can_top.i_can_bsp.i_can_acf.rtr2 \

add group \
    testbench \
      can_testbench.receive_frame.arbitration_lost \
      can_testbench.receive_frame.tmp \
      can_testbench.receive_frame.cnt's \
      can_testbench.receive_frame.mode \
      can_testbench.receive_frame.pointer's \
      can_testbench.receive_frame.total_bits's \
      can_testbench.rx \

add group \
    can_bsp \
      can_testbench.i_can_top.i_can_bsp.ack_err_latched \
      can_testbench.i_can_top.i_can_bsp.bit_err_latched \
      can_testbench.i_can_top.i_can_bsp.form_err_latched \
      can_testbench.i_can_top.i_can_bsp.stuff_err_latched \
      can_testbench.i_can_top.i_can_bsp.crc_err \
      can_testbench.i_can_top.i_can_bsp.ack_err \
      can_testbench.i_can_top.i_can_bsp.bit_err \
      can_testbench.i_can_top.i_can_bsp.form_err \
      can_testbench.i_can_top.i_can_bsp.stuff_err \
      can_testbench.i_can_top.i_can_bsp.err \
      can_testbench.i_can_top.i_can_bsp.bit_err_exc1 \
      can_testbench.i_can_top.i_can_bsp.bit_err_exc2 \
      can_testbench.i_can_top.i_can_bsp.bit_err_exc3 \
      can_testbench.i_can_top.i_can_bsp.set_form_error \
      can_testbench.i_can_top.i_can_btl.hard_sync \
      can_testbench.i_can_top.i_can_btl.resync \
      can_testbench.i_can_top.sampled_bit \
      can_testbench.i_can_top.sampled_bit_q \
      can_testbench.i_can_top.i_can_bsp.transmitting \
      can_testbench.rx \
      can_testbench.i_can_top.rx \
      can_testbench.i_can_top.tx \
      can_testbench.i_can_top.i_can_bsp.sample_point \
      can_testbench.i_can_top.i_can_bsp.tx_point \
      can_testbench.i_can_top.i_can_bsp.tx_point_q \
      can_testbench.i_can_top.i_can_bsp.bit_stuff_cnt_tx[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_tx \
      can_testbench.i_can_top.i_can_bsp.tx_pointer[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.basic_chain[18:0]'h \
      can_testbench.i_can_top.i_can_bsp.basic_chain_data[63:0]'h \
      can_testbench.i_can_top.i_can_bsp.extended_chain_std[18:0]'h \
      can_testbench.i_can_top.i_can_bsp.extended_chain_ext[38:0]'h \
      can_testbench.i_can_top.i_can_bsp.extended_chain_data[63:0]'h \
      can_testbench.i_can_top.i_can_bsp.extended_mode \
      can_testbench.i_can_top.i_can_bsp.rst_tx_pointer \
      can_testbench.i_can_top.i_can_bsp.addr[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.bit_cnt[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_reset \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_set \
      can_testbench.i_can_top.i_can_bsp.bit_stuff_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.bit_stuff_cnt_en \
      can_testbench.i_can_top.i_can_bsp.byte_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.calculated_crc[14:0]'h \
      can_testbench.i_can_top.i_can_bsp.r_calculated_crc[15:0]'h \
      can_testbench.i_can_top.i_can_bsp.crc_in[14:0]'h \
      can_testbench.i_can_top.i_can_bsp.clk \
      can_testbench.i_can_top.i_can_bsp.crc_enable \
      can_testbench.i_can_top.i_can_bsp.data_cnt[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.data_for_fifo[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.data_len[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.data_out[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.overload_frame_ended \
      can_testbench.i_can_top.i_can_bsp.transmitter \
      can_testbench.i_can_top.i_can_bsp.arbitration_field \
      can_testbench.i_can_top.i_can_bsp.sampled_bit \
      can_testbench.i_can_top.i_can_bsp.priority_lost \
      can_testbench.i_can_top.i_can_bsp.error_flag_over \
      can_testbench.i_can_top.i_can_bsp.rx_err_cnt_blocked \
      can_testbench.i_can_top.i_can_bsp.rule5 \
      can_testbench.i_can_top.i_can_bsp.rule3_exc1_1 \
      can_testbench.i_can_top.i_can_bsp.rule3_exc1_2 \
      can_testbench.i_can_top.i_can_bsp.rule3_exc2 \
      can_testbench.i_can_top.i_can_bsp.go_error_frame \
      can_testbench.i_can_top.i_can_bsp.error_frame \
      can_testbench.i_can_top.i_can_bsp.overload_frame \
      can_testbench.i_can_top.i_can_bsp.enable_error_cnt2 \
      can_testbench.i_can_top.i_can_bsp.passive_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.eof_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.wr_fifo \
      can_testbench.i_can_top.i_can_bsp.error_cnt1[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.error_cnt2[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.error_frame \
      can_testbench.i_can_top.i_can_bsp.error_frame_ended \
      can_testbench.i_can_top.i_can_bsp.rx_inter \
      can_testbench.i_can_top.i_can_bsp.node_error_passive \
      can_testbench.i_can_top.i_can_bsp.rx_err_cnt[9:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_err_cnt[9:0]'h \
      can_testbench.i_can_top.i_can_bsp.rtr1 \
      can_testbench.i_can_top.i_can_bsp.rtr2 \
      can_testbench.i_can_top.i_can_bsp.priority_lost \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_tx \
      can_testbench.i_can_top.i_can_bsp.bit_stuff_cnt_tx[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.bit_stuff_cnt_en \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_set \
      can_testbench.i_can_top.i_can_bsp.bit_de_stuff_reset \
      can_testbench.i_can_top.i_can_btl.hard_sync \
      can_testbench.i_can_top.i_can_btl.resync \
      can_testbench.i_can_top.rx \
      can_testbench.i_can_top.i_can_bsp.tx_pointer[5:0]'h \
      can_testbench.i_can_top.tx \
      can_testbench.rx \
      can_testbench.i_can_top.rx \
      can_testbench.i_can_top.i_can_bsp.sample_point \
      can_testbench.i_can_top.i_can_bsp.tx_point \
      can_testbench.i_can_top.i_can_bsp.rx_ack \
      can_testbench.i_can_top.i_can_bsp.rx_ack_lim \
      can_testbench.i_can_top.i_can_bsp.rx_crc \
      can_testbench.i_can_top.i_can_bsp.rx_crc_lim \
      can_testbench.i_can_top.i_can_bsp.rx_data \
      can_testbench.i_can_top.i_can_bsp.rx_dlc \
      can_testbench.i_can_top.i_can_bsp.finish_msg \
      can_testbench.i_can_top.i_can_bsp.tx_state \
      can_testbench.i_can_top.i_can_bsp.rx_eof \
      can_testbench.i_can_top.i_can_bsp.rx_id1 \
      can_testbench.i_can_top.i_can_bsp.rx_id2 \
      can_testbench.i_can_top.i_can_bsp.rx_ide \
      can_testbench.i_can_top.i_can_bsp.rx_idle \
      can_testbench.i_can_top.i_can_bsp.rx_inter \
      can_testbench.i_can_top.i_can_bsp.suspend \
      can_testbench.i_can_top.i_can_bsp.susp_cnt_en \
      can_testbench.i_can_top.i_can_bsp.susp_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.rx_r0 \
      can_testbench.i_can_top.i_can_bsp.rx_r1 \
      can_testbench.i_can_top.i_can_bsp.rx_rtr1 \
      can_testbench.i_can_top.i_can_bsp.rx_rtr2 \
      can_testbench.i_can_top.i_can_bsp.extended_mode \
      can_testbench.i_can_top.i_can_bsp.go_early_tx \
      can_testbench.i_can_top.i_can_bsp.go_tx \
      can_testbench.i_can_top.i_can_bsp.need_to_tx \
      can_testbench.i_can_top.i_can_bsp.tx_request \
      can_testbench.i_can_top.i_can_bsp.clk \
      can_testbench.i_can_top.i_can_bsp.tx_state \
      can_testbench.i_can_top.i_can_bsp.transmitting \
      can_testbench.i_can_top.i_can_bsp.priority_lost \
      can_testbench.i_can_top.i_can_bsp.go_crc_enable \
      can_testbench.i_can_top.i_can_bsp.go_error_frame \
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
      can_testbench.i_can_top.i_can_bsp.go_rx_inter \
      can_testbench.i_can_top.i_can_bsp.go_overload_frame \
      can_testbench.i_can_top.i_can_bsp.go_rx_r0 \
      can_testbench.i_can_top.i_can_bsp.go_rx_r1 \
      can_testbench.i_can_top.i_can_bsp.go_rx_rtr1 \
      can_testbench.i_can_top.i_can_bsp.go_rx_rtr2 \
      can_testbench.i_can_top.i_can_bsp.hard_sync \
      can_testbench.i_can_top.i_can_bsp.header_cnt[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.header_len[2:0]'h \
      can_testbench.i_can_top.i_can_bsp.id[28:0]'h \
      can_testbench.i_can_top.i_can_bsp.id_ok \
      can_testbench.i_can_top.i_can_bsp.ide \
      can_testbench.i_can_top.i_can_bsp.limited_data_len[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.limited_data_len_minus1[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.no_byte0 \
      can_testbench.i_can_top.i_can_bsp.no_byte1 \
      can_testbench.i_can_top.i_can_bsp.release_buffer \
      can_testbench.i_can_top.i_can_bsp.remote_rq \
      can_testbench.i_can_top.i_can_bsp.reset_mode \
      can_testbench.i_can_top.i_can_bsp.reset_mode_q \
      can_testbench.i_can_top.i_can_bsp.reset_wr_fifo \
      can_testbench.i_can_top.i_can_bsp.rst \
      can_testbench.i_can_top.i_can_bsp.rst_crc_enable \
      can_testbench.i_can_top.i_can_bsp.sample_point \
      can_testbench.i_can_top.i_can_bsp.sampled_bit_q \
      can_testbench.i_can_top.i_can_bsp.set_form_error \
      can_testbench.i_can_top.i_can_bsp.storing_header \
      can_testbench.i_can_top.i_can_bsp.tmp_data[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.write_data_to_tmp_fifo \
      can_testbench.i_can_top.i_can_bsp.wr_fifo \
      can_testbench.i_can_top.i_can_bsp.reset_wr_fifo \
      can_testbench.i_can_top.i_can_bsp.transmitting \
      can_testbench.i_can_top.i_can_bsp.tx \
      can_testbench.i_can_top.i_can_bsp.tx_data_0[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_1[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_2[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_3[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_4[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_5[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_6[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_7[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_8[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_9[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_10[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_11[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_data_12[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.tx_point \
      can_testbench.i_can_top.i_can_bsp.wr_fifo \

add group \
    can_fifo \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.addr[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.clk \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.data_in[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.data_out[7:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.extended_mode \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.fifo_cnt[6:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.fifo_empty \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.fifo_full \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.latch_overrun \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.len_cnt[3:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.rd_pointer[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.read_address[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.reset_mode \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.rst \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.wr_pointer[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.wr_q \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.write_length_info \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.info_cnt[6:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.wr_info_pointer[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.info_empty \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.info_full \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.rd_info_pointer[5:0]'h \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.wr \
      can_testbench.i_can_top.i_can_bsp.i_can_fifo.release_buffer \

add group \
    can_registers \
      can_testbench.i_can_top.i_can_registers.abort_tx \
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
      can_testbench.i_can_top.i_can_registers.clear_data_overrun \
      can_testbench.i_can_top.i_can_registers.clk \
      can_testbench.i_can_top.i_can_registers.clock_divider[7:0]'h \
      can_testbench.i_can_top.i_can_registers.clock_off \
      can_testbench.i_can_top.i_can_registers.command[4:0]'h \
      can_testbench.i_can_top.i_can_registers.command_dummy[2:0]'h \
      can_testbench.i_can_top.i_can_registers.cs \
      can_testbench.i_can_top.i_can_registers.data_in[7:0]'h \
      can_testbench.i_can_top.i_can_registers.data_out[7:0]'h \
      can_testbench.i_can_top.i_can_registers.extended_mode \
      can_testbench.i_can_top.i_can_registers.listen_only_mode \
      can_testbench.i_can_top.i_can_registers.mode[7:0]'h \
      can_testbench.i_can_top.i_can_registers.read \
      can_testbench.i_can_top.i_can_registers.release_buffer \
      can_testbench.i_can_top.i_can_registers.reset_mode \
      can_testbench.i_can_top.i_can_registers.rst \
      can_testbench.i_can_top.i_can_registers.rw \
      can_testbench.i_can_top.i_can_registers.rx_int_enable \
      can_testbench.i_can_top.i_can_registers.self_rx_request \
      can_testbench.i_can_top.i_can_registers.sleep_mode \
      can_testbench.i_can_top.i_can_registers.sync_jump_width[1:0]'h \
      can_testbench.i_can_top.i_can_registers.time_segment1[3:0]'h \
      can_testbench.i_can_top.i_can_registers.time_segment2[2:0]'h \
      can_testbench.i_can_top.i_can_registers.triple_sampling \
      can_testbench.i_can_top.i_can_registers.tx_data_0[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_1[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_2[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_3[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_4[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_5[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_6[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_7[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_8[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_9[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_10[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_11[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_data_12[7:0]'h \
      can_testbench.i_can_top.i_can_registers.tx_request \
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
      can_testbench.i_can_top.i_can_registers.we_command \
      can_testbench.i_can_top.i_can_registers.we_mode \
      can_testbench.i_can_top.i_can_registers.we_tx_data_0 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_1 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_2 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_3 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_4 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_5 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_6 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_7 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_8 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_9 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_10 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_11 \
      can_testbench.i_can_top.i_can_registers.we_tx_data_12 \


deselect all
add register  Default \
    fontsize 12 \


open window waveform 1 geometry 10 59 1592 1140
zoom at 0(0)ns 0.00003462 0.00000000
