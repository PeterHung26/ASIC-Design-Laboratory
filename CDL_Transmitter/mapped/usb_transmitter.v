/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Apr 28 12:42:59 2023
/////////////////////////////////////////////////////////////


module packet_selecter ( sync_start, pid_start, tx_packet_data, tx_packet, 
        crc_start, d_par );
  input [7:0] tx_packet_data;
  input [3:0] tx_packet;
  output [7:0] d_par;
  input sync_start, pid_start, crc_start;
  wire   N47, N48, N49, N50, N51, N52, N53, N54, N55, n1, n2, n3, n4, n5, n6,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33;

  LATCH \d_par_reg[7]  ( .CLK(N47), .D(N55), .Q(d_par[7]) );
  LATCH \d_par_reg[6]  ( .CLK(N47), .D(N54), .Q(d_par[6]) );
  LATCH \d_par_reg[5]  ( .CLK(N47), .D(N53), .Q(d_par[5]) );
  LATCH \d_par_reg[4]  ( .CLK(N47), .D(N52), .Q(d_par[4]) );
  LATCH \d_par_reg[3]  ( .CLK(N47), .D(N51), .Q(d_par[3]) );
  LATCH \d_par_reg[2]  ( .CLK(N47), .D(N50), .Q(d_par[2]) );
  LATCH \d_par_reg[1]  ( .CLK(N47), .D(N49), .Q(d_par[1]) );
  LATCH \d_par_reg[0]  ( .CLK(N47), .D(N48), .Q(d_par[0]) );
  OAI21X1 U3 ( .A(pid_start), .B(n1), .C(n2), .Y(N55) );
  AOI21X1 U4 ( .A(n3), .B(n4), .C(n5), .Y(n2) );
  AOI21X1 U5 ( .A(tx_packet_data[7]), .B(n6), .C(sync_start), .Y(n1) );
  OAI21X1 U6 ( .A(n7), .B(n8), .C(n9), .Y(N54) );
  AOI21X1 U7 ( .A(n4), .B(n10), .C(n5), .Y(n9) );
  AND2X1 U8 ( .A(pid_start), .B(n11), .Y(n4) );
  XNOR2X1 U9 ( .A(n12), .B(tx_packet[0]), .Y(n11) );
  INVX1 U10 ( .A(tx_packet_data[6]), .Y(n8) );
  OAI21X1 U11 ( .A(n7), .B(n13), .C(n14), .Y(N53) );
  INVX1 U12 ( .A(tx_packet_data[5]), .Y(n13) );
  OAI21X1 U13 ( .A(n7), .B(n15), .C(n16), .Y(N52) );
  INVX1 U14 ( .A(tx_packet_data[4]), .Y(n15) );
  OAI21X1 U15 ( .A(n17), .B(n18), .C(n19), .Y(N51) );
  AOI22X1 U16 ( .A(n20), .B(tx_packet[3]), .C(tx_packet_data[3]), .D(n21), .Y(
        n19) );
  OAI21X1 U17 ( .A(n10), .B(n22), .C(n23), .Y(N50) );
  NAND2X1 U18 ( .A(tx_packet_data[2]), .B(n21), .Y(n23) );
  OR2X1 U19 ( .A(n18), .B(n17), .Y(n22) );
  NAND3X1 U20 ( .A(n16), .B(n24), .C(n25), .Y(N49) );
  NAND2X1 U21 ( .A(tx_packet_data[1]), .B(n21), .Y(n25) );
  NAND3X1 U22 ( .A(n14), .B(n24), .C(n26), .Y(N48) );
  NAND2X1 U23 ( .A(tx_packet_data[0]), .B(n21), .Y(n26) );
  INVX1 U24 ( .A(n7), .Y(n21) );
  NAND3X1 U25 ( .A(n17), .B(n27), .C(n6), .Y(n7) );
  INVX1 U26 ( .A(crc_start), .Y(n6) );
  INVX1 U27 ( .A(sync_start), .Y(n27) );
  INVX1 U28 ( .A(n5), .Y(n24) );
  NOR2X1 U29 ( .A(n17), .B(n28), .Y(n5) );
  INVX1 U30 ( .A(n20), .Y(n14) );
  NOR2X1 U31 ( .A(n29), .B(n17), .Y(n20) );
  INVX1 U32 ( .A(pid_start), .Y(n17) );
  NAND3X1 U33 ( .A(n28), .B(n29), .C(n30), .Y(N47) );
  AND2X1 U34 ( .A(n16), .B(pid_start), .Y(n30) );
  NAND2X1 U35 ( .A(pid_start), .B(n31), .Y(n16) );
  OAI21X1 U36 ( .A(n12), .B(n32), .C(n18), .Y(n31) );
  NAND3X1 U37 ( .A(tx_packet[1]), .B(n33), .C(tx_packet[3]), .Y(n18) );
  NAND2X1 U38 ( .A(n33), .B(n10), .Y(n32) );
  INVX1 U39 ( .A(tx_packet[0]), .Y(n33) );
  NAND3X1 U40 ( .A(n12), .B(n10), .C(tx_packet[0]), .Y(n29) );
  INVX1 U41 ( .A(tx_packet[2]), .Y(n10) );
  INVX1 U42 ( .A(tx_packet[1]), .Y(n12) );
  NAND3X1 U43 ( .A(tx_packet[1]), .B(tx_packet[0]), .C(n3), .Y(n28) );
  NOR2X1 U44 ( .A(tx_packet[3]), .B(tx_packet[2]), .Y(n3) );
endmodule


module flex_pts_sr_NUM_BITS8_SHIFT_MSB0 ( clk, n_rst, shift_enable, 
        load_enable, parallel_in, serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n28, n29, n30, n31, n32, n33, n34, n35, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n36;
  wire   [7:0] parallel_out;

  DFFSR \parallel_out_reg[7]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n30), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n31), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n32), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n33), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n34), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n35), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n28), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  NAND2X1 U11 ( .A(n_rst), .B(n9), .Y(serial_out) );
  INVX1 U12 ( .A(parallel_out[0]), .Y(n9) );
  OAI21X1 U13 ( .A(n10), .B(n11), .C(n12), .Y(n35) );
  AOI22X1 U14 ( .A(parallel_out[2]), .B(n13), .C(parallel_out[1]), .D(n14), 
        .Y(n12) );
  INVX1 U15 ( .A(parallel_in[1]), .Y(n11) );
  OAI21X1 U16 ( .A(n10), .B(n15), .C(n16), .Y(n34) );
  AOI22X1 U17 ( .A(parallel_out[3]), .B(n13), .C(n14), .D(parallel_out[2]), 
        .Y(n16) );
  INVX1 U18 ( .A(parallel_in[2]), .Y(n15) );
  OAI21X1 U19 ( .A(n10), .B(n17), .C(n18), .Y(n33) );
  AOI22X1 U20 ( .A(parallel_out[4]), .B(n13), .C(parallel_out[3]), .D(n14), 
        .Y(n18) );
  INVX1 U21 ( .A(parallel_in[3]), .Y(n17) );
  OAI21X1 U22 ( .A(n10), .B(n19), .C(n20), .Y(n32) );
  AOI22X1 U23 ( .A(parallel_out[5]), .B(n13), .C(parallel_out[4]), .D(n14), 
        .Y(n20) );
  INVX1 U24 ( .A(parallel_in[4]), .Y(n19) );
  OAI21X1 U25 ( .A(n10), .B(n21), .C(n22), .Y(n31) );
  AOI22X1 U26 ( .A(parallel_out[6]), .B(n13), .C(parallel_out[5]), .D(n14), 
        .Y(n22) );
  INVX1 U27 ( .A(parallel_in[5]), .Y(n21) );
  OAI21X1 U28 ( .A(n10), .B(n23), .C(n24), .Y(n30) );
  AOI22X1 U29 ( .A(parallel_out[7]), .B(n13), .C(parallel_out[6]), .D(n14), 
        .Y(n24) );
  INVX1 U30 ( .A(parallel_in[6]), .Y(n23) );
  NAND2X1 U31 ( .A(n25), .B(n26), .Y(n29) );
  INVX1 U32 ( .A(n13), .Y(n26) );
  MUX2X1 U33 ( .B(parallel_in[7]), .A(parallel_out[7]), .S(n14), .Y(n25) );
  OAI21X1 U34 ( .A(n10), .B(n27), .C(n36), .Y(n28) );
  AOI22X1 U35 ( .A(parallel_out[1]), .B(n13), .C(parallel_out[0]), .D(n14), 
        .Y(n36) );
  NOR2X1 U36 ( .A(n14), .B(load_enable), .Y(n13) );
  NOR2X1 U37 ( .A(shift_enable), .B(load_enable), .Y(n14) );
  INVX1 U38 ( .A(parallel_in[0]), .Y(n27) );
  INVX1 U39 ( .A(load_enable), .Y(n10) );
endmodule


module pts_sr_8_lsb ( clk, n_rst, strobe, strobe_middle, d_par, 
        pts_load_enable, pts_shift_enable, d_orig );
  input [7:0] d_par;
  input clk, n_rst, strobe, strobe_middle, pts_load_enable, pts_shift_enable;
  output d_orig;


  flex_pts_sr_NUM_BITS8_SHIFT_MSB0 CORE ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(strobe), .load_enable(pts_load_enable), .parallel_in(
        d_par), .serial_out(d_orig) );
endmodule


module encoder ( clk, strobe_middle, strobe, n_rst, d_orig, d_encoded );
  input clk, strobe_middle, strobe, n_rst, d_orig;
  output d_encoded;
  wire   n4, n2, n3;

  DFFSR d_encoded_reg ( .D(n4), .CLK(clk), .R(1'b1), .S(n_rst), .Q(d_encoded)
         );
  XOR2X1 U3 ( .A(d_encoded), .B(n2), .Y(n4) );
  NOR2X1 U4 ( .A(d_orig), .B(n3), .Y(n2) );
  INVX1 U5 ( .A(strobe_middle), .Y(n3) );
endmodule


module d_plus_selecter ( d_encoded, eop, idle, d_plus_out );
  input d_encoded, eop, idle;
  output d_plus_out;
  wire   n1;

  NOR2X1 U3 ( .A(eop), .B(n1), .Y(d_plus_out) );
  NOR2X1 U4 ( .A(d_encoded), .B(idle), .Y(n1) );
endmodule


module d_minus_selecter ( d_encoded, eop, idle, d_minus_out );
  input d_encoded, eop, idle;
  output d_minus_out;
  wire   n1;

  NOR2X1 U2 ( .A(d_encoded), .B(n1), .Y(d_minus_out) );
  OR2X1 U3 ( .A(idle), .B(eop), .Y(n1) );
endmodule


module flex_counter_NUM_CNT_BITS4_2 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   rollover_flag_next, n1, n2, n3, n4, n5, n6, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37;
  wire   [3:0] count_next;

  DFFSR \count_out_reg[0]  ( .D(count_next[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(count_next[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(count_next[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(count_next[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[3]) );
  DFFSR rollover_flag_reg ( .D(rollover_flag_next), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(rollover_flag) );
  NOR2X1 U8 ( .A(n1), .B(n2), .Y(rollover_flag_next) );
  NAND2X1 U9 ( .A(n3), .B(n4), .Y(n2) );
  XNOR2X1 U10 ( .A(rollover_val[1]), .B(count_next[1]), .Y(n4) );
  XNOR2X1 U11 ( .A(rollover_val[2]), .B(count_next[2]), .Y(n3) );
  NAND3X1 U12 ( .A(n5), .B(n6), .C(n12), .Y(n1) );
  XNOR2X1 U13 ( .A(rollover_val[0]), .B(count_next[0]), .Y(n12) );
  XNOR2X1 U14 ( .A(rollover_val[3]), .B(count_next[3]), .Y(n5) );
  OAI21X1 U15 ( .A(n13), .B(n14), .C(n15), .Y(count_next[3]) );
  NAND3X1 U16 ( .A(n6), .B(n16), .C(count_out[3]), .Y(n15) );
  XOR2X1 U17 ( .A(n17), .B(n18), .Y(n13) );
  AND2X1 U18 ( .A(n19), .B(count_out[3]), .Y(n18) );
  NAND2X1 U19 ( .A(n20), .B(count_out[2]), .Y(n17) );
  OAI21X1 U20 ( .A(n21), .B(n22), .C(n23), .Y(count_next[2]) );
  NAND3X1 U21 ( .A(n20), .B(n21), .C(n24), .Y(n23) );
  NAND2X1 U22 ( .A(n25), .B(n6), .Y(n22) );
  OAI21X1 U23 ( .A(n20), .B(n26), .C(count_enable), .Y(n25) );
  AND2X1 U24 ( .A(n27), .B(count_out[1]), .Y(n20) );
  OAI21X1 U25 ( .A(n28), .B(n29), .C(n30), .Y(count_next[1]) );
  NAND3X1 U26 ( .A(n27), .B(n28), .C(n24), .Y(n30) );
  INVX1 U27 ( .A(n14), .Y(n24) );
  NAND2X1 U28 ( .A(n31), .B(n6), .Y(n29) );
  OAI21X1 U29 ( .A(n27), .B(n26), .C(count_enable), .Y(n31) );
  INVX1 U30 ( .A(n19), .Y(n26) );
  INVX1 U31 ( .A(count_out[1]), .Y(n28) );
  OAI21X1 U32 ( .A(n27), .B(n14), .C(n32), .Y(count_next[0]) );
  NAND3X1 U33 ( .A(n6), .B(n16), .C(count_out[0]), .Y(n32) );
  INVX1 U34 ( .A(count_enable), .Y(n16) );
  NAND2X1 U35 ( .A(count_enable), .B(n6), .Y(n14) );
  INVX1 U36 ( .A(clear), .Y(n6) );
  AND2X1 U37 ( .A(count_out[0]), .B(n19), .Y(n27) );
  NAND3X1 U38 ( .A(n33), .B(n34), .C(n35), .Y(n19) );
  NOR2X1 U39 ( .A(n36), .B(n37), .Y(n35) );
  XOR2X1 U40 ( .A(rollover_val[1]), .B(count_out[1]), .Y(n37) );
  XOR2X1 U41 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n36) );
  XOR2X1 U42 ( .A(rollover_val[2]), .B(n21), .Y(n34) );
  INVX1 U43 ( .A(count_out[2]), .Y(n21) );
  XNOR2X1 U44 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n33) );
endmodule


module flex_counter_NUM_CNT_BITS4_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   rollover_flag_next, n1, n2, n3, n4, n5, n6, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37;
  wire   [3:0] count_next;

  DFFSR \count_out_reg[0]  ( .D(count_next[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(count_next[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(count_next[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(count_next[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[3]) );
  DFFSR rollover_flag_reg ( .D(rollover_flag_next), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(rollover_flag) );
  NOR2X1 U8 ( .A(n1), .B(n2), .Y(rollover_flag_next) );
  NAND2X1 U9 ( .A(n3), .B(n4), .Y(n2) );
  XNOR2X1 U10 ( .A(rollover_val[1]), .B(count_next[1]), .Y(n4) );
  XNOR2X1 U11 ( .A(rollover_val[2]), .B(count_next[2]), .Y(n3) );
  NAND3X1 U12 ( .A(n5), .B(n6), .C(n12), .Y(n1) );
  XNOR2X1 U13 ( .A(rollover_val[0]), .B(count_next[0]), .Y(n12) );
  XNOR2X1 U14 ( .A(rollover_val[3]), .B(count_next[3]), .Y(n5) );
  OAI21X1 U15 ( .A(n13), .B(n14), .C(n15), .Y(count_next[3]) );
  NAND3X1 U16 ( .A(n6), .B(n16), .C(count_out[3]), .Y(n15) );
  XOR2X1 U17 ( .A(n17), .B(n18), .Y(n13) );
  AND2X1 U18 ( .A(n19), .B(count_out[3]), .Y(n18) );
  NAND2X1 U19 ( .A(n20), .B(count_out[2]), .Y(n17) );
  OAI21X1 U20 ( .A(n21), .B(n22), .C(n23), .Y(count_next[2]) );
  NAND3X1 U21 ( .A(n20), .B(n21), .C(n24), .Y(n23) );
  NAND2X1 U22 ( .A(n25), .B(n6), .Y(n22) );
  OAI21X1 U23 ( .A(n20), .B(n26), .C(count_enable), .Y(n25) );
  AND2X1 U24 ( .A(n27), .B(count_out[1]), .Y(n20) );
  OAI21X1 U25 ( .A(n28), .B(n29), .C(n30), .Y(count_next[1]) );
  NAND3X1 U26 ( .A(n27), .B(n28), .C(n24), .Y(n30) );
  INVX1 U27 ( .A(n14), .Y(n24) );
  NAND2X1 U28 ( .A(n31), .B(n6), .Y(n29) );
  OAI21X1 U29 ( .A(n27), .B(n26), .C(count_enable), .Y(n31) );
  INVX1 U30 ( .A(n19), .Y(n26) );
  INVX1 U31 ( .A(count_out[1]), .Y(n28) );
  OAI21X1 U32 ( .A(n27), .B(n14), .C(n32), .Y(count_next[0]) );
  NAND3X1 U33 ( .A(n6), .B(n16), .C(count_out[0]), .Y(n32) );
  INVX1 U34 ( .A(count_enable), .Y(n16) );
  NAND2X1 U35 ( .A(count_enable), .B(n6), .Y(n14) );
  INVX1 U36 ( .A(clear), .Y(n6) );
  AND2X1 U37 ( .A(count_out[0]), .B(n19), .Y(n27) );
  NAND3X1 U38 ( .A(n33), .B(n34), .C(n35), .Y(n19) );
  NOR2X1 U39 ( .A(n36), .B(n37), .Y(n35) );
  XOR2X1 U40 ( .A(rollover_val[1]), .B(count_out[1]), .Y(n37) );
  XOR2X1 U41 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n36) );
  XOR2X1 U42 ( .A(rollover_val[2]), .B(n21), .Y(n34) );
  INVX1 U43 ( .A(count_out[2]), .Y(n21) );
  XNOR2X1 U44 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n33) );
endmodule


module flex_counter_NUM_CNT_BITS4_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   rollover_flag_next, n1, n2, n3, n4, n5, n6, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37;
  wire   [3:0] count_next;

  DFFSR \count_out_reg[0]  ( .D(count_next[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(count_next[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(count_next[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(count_next[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[3]) );
  DFFSR rollover_flag_reg ( .D(rollover_flag_next), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(rollover_flag) );
  NOR2X1 U8 ( .A(n1), .B(n2), .Y(rollover_flag_next) );
  NAND2X1 U9 ( .A(n3), .B(n4), .Y(n2) );
  XNOR2X1 U10 ( .A(rollover_val[1]), .B(count_next[1]), .Y(n4) );
  XNOR2X1 U11 ( .A(rollover_val[2]), .B(count_next[2]), .Y(n3) );
  NAND3X1 U12 ( .A(n5), .B(n6), .C(n12), .Y(n1) );
  XNOR2X1 U13 ( .A(rollover_val[0]), .B(count_next[0]), .Y(n12) );
  XNOR2X1 U14 ( .A(rollover_val[3]), .B(count_next[3]), .Y(n5) );
  OAI21X1 U15 ( .A(n13), .B(n14), .C(n15), .Y(count_next[3]) );
  NAND3X1 U16 ( .A(n6), .B(n16), .C(count_out[3]), .Y(n15) );
  XOR2X1 U17 ( .A(n17), .B(n18), .Y(n13) );
  AND2X1 U18 ( .A(n19), .B(count_out[3]), .Y(n18) );
  NAND2X1 U19 ( .A(n20), .B(count_out[2]), .Y(n17) );
  OAI21X1 U20 ( .A(n21), .B(n22), .C(n23), .Y(count_next[2]) );
  NAND3X1 U21 ( .A(n20), .B(n21), .C(n24), .Y(n23) );
  NAND2X1 U22 ( .A(n25), .B(n6), .Y(n22) );
  OAI21X1 U23 ( .A(n20), .B(n26), .C(count_enable), .Y(n25) );
  AND2X1 U24 ( .A(n27), .B(count_out[1]), .Y(n20) );
  OAI21X1 U25 ( .A(n28), .B(n29), .C(n30), .Y(count_next[1]) );
  NAND3X1 U26 ( .A(n27), .B(n28), .C(n24), .Y(n30) );
  INVX1 U27 ( .A(n14), .Y(n24) );
  NAND2X1 U28 ( .A(n31), .B(n6), .Y(n29) );
  OAI21X1 U29 ( .A(n27), .B(n26), .C(count_enable), .Y(n31) );
  INVX1 U30 ( .A(n19), .Y(n26) );
  INVX1 U31 ( .A(count_out[1]), .Y(n28) );
  OAI21X1 U32 ( .A(n27), .B(n14), .C(n32), .Y(count_next[0]) );
  NAND3X1 U33 ( .A(n6), .B(n16), .C(count_out[0]), .Y(n32) );
  INVX1 U34 ( .A(count_enable), .Y(n16) );
  NAND2X1 U35 ( .A(count_enable), .B(n6), .Y(n14) );
  INVX1 U36 ( .A(clear), .Y(n6) );
  AND2X1 U37 ( .A(count_out[0]), .B(n19), .Y(n27) );
  NAND3X1 U38 ( .A(n33), .B(n34), .C(n35), .Y(n19) );
  NOR2X1 U39 ( .A(n36), .B(n37), .Y(n35) );
  XOR2X1 U40 ( .A(rollover_val[1]), .B(count_out[1]), .Y(n37) );
  XOR2X1 U41 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n36) );
  XOR2X1 U42 ( .A(rollover_val[2]), .B(n21), .Y(n34) );
  INVX1 U43 ( .A(count_out[2]), .Y(n21) );
  XNOR2X1 U44 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n33) );
endmodule


module timer_transmit ( clk, n_rst, timer_enable, timer_clear, 
        tx_transfer_active, byte_transmitted, strobe, strobe_middle );
  input clk, n_rst, timer_enable, timer_clear, tx_transfer_active;
  output byte_transmitted, strobe, strobe_middle;
  wire   rollover_flag_8, rollover_flag_9, _0_net_, _3_net_, _5_net_, _6_net_,
         n38, n39, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27;
  wire   [3:0] state;
  wire   [3:0] count_out_bit;

  DFFSR \state_reg[0]  ( .D(n27), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n39), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(n38), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  flex_counter_NUM_CNT_BITS4_2 bit_counter_bit ( .clk(clk), .n_rst(n_rst), 
        .clear(timer_clear), .count_enable(_0_net_), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .count_out(count_out_bit), .rollover_flag(strobe) );
  flex_counter_NUM_CNT_BITS4_1 bit_counter_byte_8 ( .clk(clk), .n_rst(n_rst), 
        .clear(_5_net_), .count_enable(_3_net_), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .rollover_flag(rollover_flag_8) );
  flex_counter_NUM_CNT_BITS4_0 bit_counter_byte_9 ( .clk(clk), .n_rst(n_rst), 
        .clear(_5_net_), .count_enable(_6_net_), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b1}), .rollover_flag(rollover_flag_9) );
  OR2X1 U6 ( .A(n4), .B(n5), .Y(n27) );
  OAI21X1 U7 ( .A(rollover_flag_9), .B(n6), .C(state[0]), .Y(n5) );
  OAI21X1 U8 ( .A(state[2]), .B(rollover_flag_8), .C(n7), .Y(n4) );
  INVX1 U9 ( .A(n8), .Y(strobe_middle) );
  NAND3X1 U10 ( .A(tx_transfer_active), .B(count_out_bit[2]), .C(n9), .Y(n8)
         );
  NOR2X1 U11 ( .A(count_out_bit[0]), .B(n10), .Y(n9) );
  OR2X1 U12 ( .A(count_out_bit[3]), .B(count_out_bit[1]), .Y(n10) );
  OAI21X1 U13 ( .A(n6), .B(n11), .C(n12), .Y(n39) );
  MUX2X1 U14 ( .B(n13), .A(n14), .S(n15), .Y(n12) );
  NOR2X1 U15 ( .A(n16), .B(n17), .Y(n14) );
  OAI21X1 U16 ( .A(state[2]), .B(state[0]), .C(n18), .Y(n13) );
  AOI21X1 U17 ( .A(n19), .B(n17), .C(n20), .Y(n18) );
  OAI21X1 U18 ( .A(n17), .B(n21), .C(n22), .Y(n38) );
  OAI21X1 U19 ( .A(n20), .B(n15), .C(state[2]), .Y(n22) );
  INVX1 U20 ( .A(n7), .Y(n20) );
  NAND3X1 U21 ( .A(state[0]), .B(n6), .C(state[2]), .Y(n7) );
  INVX1 U22 ( .A(n19), .Y(n21) );
  NOR2X1 U23 ( .A(n15), .B(n16), .Y(n19) );
  NAND2X1 U24 ( .A(n11), .B(n17), .Y(byte_transmitted) );
  INVX1 U25 ( .A(rollover_flag_8), .Y(n17) );
  INVX1 U26 ( .A(rollover_flag_9), .Y(n11) );
  NOR2X1 U27 ( .A(n6), .B(n23), .Y(_6_net_) );
  OAI21X1 U28 ( .A(state[0]), .B(n24), .C(n25), .Y(_5_net_) );
  INVX1 U29 ( .A(timer_clear), .Y(n25) );
  NOR2X1 U30 ( .A(state[1]), .B(state[2]), .Y(n24) );
  NOR2X1 U31 ( .A(n16), .B(n23), .Y(_3_net_) );
  INVX1 U32 ( .A(strobe), .Y(n23) );
  NAND2X1 U33 ( .A(n6), .B(n16), .Y(_0_net_) );
  NAND2X1 U34 ( .A(state[0]), .B(n26), .Y(n16) );
  INVX1 U35 ( .A(state[2]), .Y(n26) );
  NAND3X1 U36 ( .A(state[0]), .B(n15), .C(state[2]), .Y(n6) );
  INVX1 U37 ( .A(state[1]), .Y(n15) );
endmodule


module tmu ( clk, n_rst, strobe, byte_transmitted, buffer_occupancy, tx_packet, 
        get_tx_packet_data, tx_transfer_active, tx_error, timer_enable, 
        pid_start, sync_start, idle, pts_load_enable, pts_shift_enable, 
        timer_clear, eop, crc_start );
  input [6:0] buffer_occupancy;
  input [3:0] tx_packet;
  input clk, n_rst, strobe, byte_transmitted;
  output get_tx_packet_data, tx_transfer_active, tx_error, timer_enable,
         pid_start, sync_start, idle, pts_load_enable, pts_shift_enable,
         timer_clear, eop, crc_start;
  wire   timer_enable, n90, n91, n92, n93, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, idle;
  wire   [3:0] state;
  assign pts_shift_enable = timer_enable;
  assign timer_clear = idle;

  DFFSR \state_reg[0]  ( .D(n93), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[3]  ( .D(n92), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[3])
         );
  DFFSR \state_reg[2]  ( .D(n90), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n91), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  OAI21X1 U7 ( .A(n5), .B(n6), .C(n7), .Y(pts_load_enable) );
  NOR2X1 U8 ( .A(crc_start), .B(tx_error), .Y(n7) );
  OR2X1 U9 ( .A(n8), .B(state[3]), .Y(n6) );
  INVX1 U10 ( .A(n9), .Y(pid_start) );
  INVX1 U11 ( .A(n10), .Y(crc_start) );
  INVX1 U12 ( .A(n11), .Y(idle) );
  OAI21X1 U13 ( .A(n12), .B(n5), .C(n13), .Y(n93) );
  OAI21X1 U14 ( .A(n14), .B(n15), .C(n16), .Y(n13) );
  OAI21X1 U15 ( .A(n11), .B(n17), .C(n18), .Y(n15) );
  INVX1 U16 ( .A(n19), .Y(n18) );
  OAI21X1 U17 ( .A(n20), .B(n21), .C(n22), .Y(n17) );
  OR2X1 U18 ( .A(tx_packet[0]), .B(tx_packet[1]), .Y(n21) );
  NAND2X1 U19 ( .A(n23), .B(n24), .Y(n20) );
  NAND2X1 U20 ( .A(n25), .B(n10), .Y(n14) );
  NAND3X1 U21 ( .A(n5), .B(n26), .C(state[3]), .Y(n10) );
  OAI21X1 U22 ( .A(n12), .B(n27), .C(n28), .Y(n92) );
  OAI21X1 U23 ( .A(n29), .B(n30), .C(n16), .Y(n28) );
  OAI21X1 U24 ( .A(state[0]), .B(n31), .C(n32), .Y(n30) );
  AOI22X1 U25 ( .A(n33), .B(get_tx_packet_data), .C(n34), .D(n35), .Y(n32) );
  NAND3X1 U26 ( .A(n36), .B(n37), .C(n38), .Y(n29) );
  OAI21X1 U27 ( .A(n12), .B(n39), .C(n40), .Y(n91) );
  OAI21X1 U28 ( .A(n41), .B(n42), .C(n16), .Y(n40) );
  NAND2X1 U29 ( .A(n43), .B(n44), .Y(n42) );
  NAND2X1 U30 ( .A(n38), .B(n45), .Y(n41) );
  OAI21X1 U31 ( .A(n12), .B(n26), .C(n46), .Y(n90) );
  OAI21X1 U32 ( .A(n47), .B(n48), .C(n16), .Y(n46) );
  OR2X1 U33 ( .A(n19), .B(n49), .Y(n48) );
  OAI21X1 U34 ( .A(n50), .B(n51), .C(n44), .Y(n49) );
  NAND2X1 U35 ( .A(n52), .B(n53), .Y(n19) );
  AOI22X1 U36 ( .A(n54), .B(n8), .C(get_tx_packet_data), .D(n55), .Y(n53) );
  INVX1 U37 ( .A(n56), .Y(get_tx_packet_data) );
  AOI22X1 U38 ( .A(n34), .B(n57), .C(eop), .D(n5), .Y(n52) );
  INVX1 U39 ( .A(n31), .Y(eop) );
  INVX1 U40 ( .A(n51), .Y(n34) );
  NAND3X1 U41 ( .A(n36), .B(n9), .C(n38), .Y(n47) );
  OR2X1 U42 ( .A(n22), .B(n11), .Y(n38) );
  NAND3X1 U43 ( .A(n39), .B(n26), .C(n54), .Y(n11) );
  NAND3X1 U44 ( .A(n57), .B(n24), .C(n33), .Y(n22) );
  INVX1 U45 ( .A(n55), .Y(n33) );
  NAND3X1 U46 ( .A(n58), .B(n59), .C(n60), .Y(n55) );
  NOR2X1 U47 ( .A(buffer_occupancy[0]), .B(n61), .Y(n60) );
  OR2X1 U48 ( .A(buffer_occupancy[2]), .B(buffer_occupancy[1]), .Y(n61) );
  NOR2X1 U49 ( .A(buffer_occupancy[6]), .B(buffer_occupancy[5]), .Y(n59) );
  NOR2X1 U50 ( .A(buffer_occupancy[4]), .B(buffer_occupancy[3]), .Y(n58) );
  INVX1 U51 ( .A(tx_packet[3]), .Y(n24) );
  INVX1 U52 ( .A(n35), .Y(n57) );
  NAND2X1 U53 ( .A(tx_packet[1]), .B(n50), .Y(n35) );
  AND2X1 U54 ( .A(tx_packet[0]), .B(n23), .Y(n50) );
  INVX1 U55 ( .A(tx_packet[2]), .Y(n23) );
  INVX1 U56 ( .A(n62), .Y(n12) );
  OAI21X1 U57 ( .A(n63), .B(n64), .C(n16), .Y(n62) );
  INVX1 U58 ( .A(n65), .Y(n16) );
  OAI22X1 U59 ( .A(strobe), .B(n31), .C(byte_transmitted), .D(n66), .Y(n65) );
  NAND2X1 U60 ( .A(n44), .B(n9), .Y(n64) );
  NAND3X1 U61 ( .A(state[1]), .B(n27), .C(n67), .Y(n9) );
  NAND3X1 U62 ( .A(n68), .B(n27), .C(state[0]), .Y(n44) );
  OR2X1 U63 ( .A(sync_start), .B(tx_transfer_active), .Y(n63) );
  NAND3X1 U64 ( .A(n56), .B(n31), .C(n66), .Y(tx_transfer_active) );
  NOR2X1 U65 ( .A(tx_error), .B(timer_enable), .Y(n66) );
  NAND3X1 U66 ( .A(n51), .B(n36), .C(n43), .Y(timer_enable) );
  AND2X1 U67 ( .A(n25), .B(n37), .Y(n43) );
  NAND3X1 U68 ( .A(state[3]), .B(n39), .C(n67), .Y(n37) );
  NAND2X1 U69 ( .A(n54), .B(state[1]), .Y(n25) );
  NAND3X1 U70 ( .A(state[1]), .B(state[3]), .C(n67), .Y(n36) );
  NAND2X1 U71 ( .A(n54), .B(n68), .Y(n51) );
  NOR2X1 U72 ( .A(state[3]), .B(state[0]), .Y(n54) );
  INVX1 U73 ( .A(n69), .Y(tx_error) );
  NAND3X1 U74 ( .A(state[3]), .B(n5), .C(n8), .Y(n69) );
  NAND2X1 U75 ( .A(state[3]), .B(n68), .Y(n31) );
  NOR2X1 U76 ( .A(n26), .B(state[1]), .Y(n68) );
  NAND3X1 U77 ( .A(n8), .B(n27), .C(state[0]), .Y(n56) );
  NOR2X1 U78 ( .A(n39), .B(n26), .Y(n8) );
  INVX1 U79 ( .A(state[2]), .Y(n26) );
  INVX1 U80 ( .A(n45), .Y(sync_start) );
  NAND3X1 U81 ( .A(n39), .B(n27), .C(n67), .Y(n45) );
  NOR2X1 U82 ( .A(n5), .B(state[2]), .Y(n67) );
  INVX1 U83 ( .A(state[0]), .Y(n5) );
  INVX1 U84 ( .A(state[3]), .Y(n27) );
  INVX1 U85 ( .A(state[1]), .Y(n39) );
endmodule


module usb_transmitter ( clk, n_rst, buffer_occupancy, tx_packet, 
        tx_packet_data, get_tx_packet_data, tx_transfer_active, tx_error, 
        d_plus_out, d_minus_out );
  input [6:0] buffer_occupancy;
  input [3:0] tx_packet;
  input [7:0] tx_packet_data;
  input clk, n_rst;
  output get_tx_packet_data, tx_transfer_active, tx_error, d_plus_out,
         d_minus_out;
  wire   sync_start, pid_start, crc_start, strobe, strobe_middle,
         pts_load_enable, pts_shift_enable, d_orig, d_encoded, eop, idle,
         timer_enable, timer_clear, byte_transmitted;
  wire   [7:0] d_par;

  packet_selecter packet_selecter ( .sync_start(sync_start), .pid_start(
        pid_start), .tx_packet_data(tx_packet_data), .tx_packet(tx_packet), 
        .crc_start(crc_start), .d_par(d_par) );
  pts_sr_8_lsb pts_sr_8_lsb ( .clk(clk), .n_rst(n_rst), .strobe(strobe), 
        .strobe_middle(strobe_middle), .d_par(d_par), .pts_load_enable(
        pts_load_enable), .pts_shift_enable(pts_shift_enable), .d_orig(d_orig)
         );
  encoder encoder ( .clk(clk), .strobe_middle(strobe_middle), .strobe(strobe), 
        .n_rst(n_rst), .d_orig(d_orig), .d_encoded(d_encoded) );
  d_plus_selecter d_plus_selecter ( .d_encoded(d_encoded), .eop(eop), .idle(
        idle), .d_plus_out(d_plus_out) );
  d_minus_selecter d_minus_selecter ( .d_encoded(d_encoded), .eop(eop), .idle(
        idle), .d_minus_out(d_minus_out) );
  timer_transmit timer ( .clk(clk), .n_rst(n_rst), .timer_enable(timer_enable), 
        .timer_clear(timer_clear), .tx_transfer_active(tx_transfer_active), 
        .byte_transmitted(byte_transmitted), .strobe(strobe), .strobe_middle(
        strobe_middle) );
  tmu tmu ( .clk(clk), .n_rst(n_rst), .strobe(strobe), .byte_transmitted(
        byte_transmitted), .buffer_occupancy(buffer_occupancy), .tx_packet(
        tx_packet), .get_tx_packet_data(get_tx_packet_data), 
        .tx_transfer_active(tx_transfer_active), .tx_error(tx_error), 
        .timer_enable(timer_enable), .pid_start(pid_start), .sync_start(
        sync_start), .idle(idle), .pts_load_enable(pts_load_enable), 
        .pts_shift_enable(pts_shift_enable), .timer_clear(timer_clear), .eop(
        eop), .crc_start(crc_start) );
endmodule

