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
define waveform window listpane 10.99
define waveform window namepane 11.94
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
      can_testbench.i_can_top.idle \
      can_testbench.i_can_top.listen_only_mode \
      can_testbench.i_can_top.reset_mode \
      can_testbench.i_can_top.rst \
      can_testbench.i_can_top.rw \
      can_testbench.i_can_top.rx \
      can_testbench.i_can_top.sleep_mode \
      can_testbench.i_can_top.sync_jump_width[1:0]'h \
      can_testbench.i_can_top.take_sample \
      can_testbench.i_can_top.time_segment1[3:0]'h \
      can_testbench.i_can_top.time_segment2[2:0]'h \
      can_testbench.i_can_top.triple_sampling \

add group \
    can_btl \
      can_testbench.i_can_top.i_can_btl.go_seg1 \
      can_testbench.i_can_top.i_can_btl.go_seg2 \
      can_testbench.i_can_top.i_can_btl.go_sync \
      can_testbench.i_can_top.i_can_btl.clk_cnt[8:0]'h \
      can_testbench.i_can_top.i_can_btl.clk_en \
      can_testbench.i_can_top.i_can_btl.quant_cnt[7:0]'h \
      can_testbench.i_can_top.i_can_btl.rx \
      can_testbench.i_can_top.i_can_btl.hard_sync \
      can_testbench.i_can_top.i_can_btl.resync \
      can_testbench.i_can_top.i_can_btl.resync_latched \
      can_testbench.i_can_top.i_can_btl.sync_blocked \
      can_testbench.i_can_top.i_can_btl.dodatek[3:0]'h \
      can_testbench.i_can_top.i_can_btl.sync \
      can_testbench.i_can_top.i_can_btl.seg1 \
      can_testbench.i_can_top.i_can_btl.seg2 \
      can_testbench.i_can_top.i_can_btl.sample_pulse \
      can_testbench.i_can_top.i_can_btl.sampled_bit \

add group \
    can_registers \
      can_testbench.i_can_top.i_can_registers.acceptance_filter_mode \
      can_testbench.i_can_top.i_can_registers.addr[7:0]'h \
      can_testbench.i_can_top.i_can_registers.baud_r_presc[5:0]'h \
      can_testbench.i_can_top.i_can_registers.bus_timing_0[7:0]'h \
      can_testbench.i_can_top.i_can_registers.bus_timing_1[7:0]'h \
      can_testbench.i_can_top.i_can_registers.clk \
      can_testbench.i_can_top.i_can_registers.cs \
      can_testbench.i_can_top.i_can_registers.data_in[7:0]'h \
      can_testbench.i_can_top.i_can_registers.data_out[7:0]'h \
      can_testbench.i_can_top.i_can_registers.listen_only_mode \
      can_testbench.i_can_top.i_can_registers.mode[7:0]'h \
      can_testbench.i_can_top.i_can_registers.read \
      can_testbench.i_can_top.i_can_registers.reset_mode \
      can_testbench.i_can_top.i_can_registers.rst \
      can_testbench.i_can_top.i_can_registers.rw \
      can_testbench.i_can_top.i_can_registers.sleep_mode \
      can_testbench.i_can_top.i_can_registers.sync_jump_width[1:0]'h \
      can_testbench.i_can_top.i_can_registers.time_segment1[3:0]'h \
      can_testbench.i_can_top.i_can_registers.time_segment2[2:0]'h \
      can_testbench.i_can_top.i_can_registers.triple_sampling \
      can_testbench.i_can_top.i_can_registers.we_bus_timing_0 \
      can_testbench.i_can_top.i_can_registers.we_bus_timing_1 \
      can_testbench.i_can_top.i_can_registers.we_mode \


deselect all
open window waveform 1 geometry 10 59 1592 1140
zoom at 49009.23(0)ns 0.00333533 0.00000000
