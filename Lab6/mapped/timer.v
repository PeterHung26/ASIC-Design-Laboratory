/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Feb 18 16:06:48 2023
/////////////////////////////////////////////////////////////


module flex_counter_1 ( clk, n_rst, clear, count_enable, rollover_val, 
        count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n48, n49, n50, n51, n52, n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42;

  DFFSR \count_out_reg[0]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[3]  ( .D(n49), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[1]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n50), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR rollover_flag_reg ( .D(n48), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  MUX2X1 U7 ( .B(n1), .A(n2), .S(n3), .Y(n52) );
  OAI21X1 U9 ( .A(n4), .B(n2), .C(n5), .Y(n1) );
  INVX1 U10 ( .A(n6), .Y(n4) );
  MUX2X1 U11 ( .B(n7), .A(n8), .S(count_out[1]), .Y(n51) );
  NAND2X1 U12 ( .A(n9), .B(count_out[0]), .Y(n7) );
  INVX1 U13 ( .A(n15), .Y(n50) );
  MUX2X1 U14 ( .B(n16), .A(n17), .S(count_out[2]), .Y(n15) );
  MUX2X1 U15 ( .B(n18), .A(n19), .S(count_out[3]), .Y(n49) );
  AOI21X1 U16 ( .A(n9), .B(n20), .C(n17), .Y(n19) );
  OAI21X1 U17 ( .A(count_out[1]), .B(n21), .C(n8), .Y(n17) );
  AOI21X1 U18 ( .A(n2), .B(n9), .C(n3), .Y(n8) );
  INVX1 U19 ( .A(count_out[0]), .Y(n2) );
  NAND2X1 U20 ( .A(n16), .B(count_out[2]), .Y(n18) );
  INVX1 U21 ( .A(n22), .Y(n16) );
  NAND3X1 U22 ( .A(count_out[1]), .B(count_out[0]), .C(n9), .Y(n22) );
  OAI21X1 U23 ( .A(n23), .B(n24), .C(n25), .Y(n48) );
  NAND2X1 U24 ( .A(rollover_flag), .B(n3), .Y(n25) );
  NAND3X1 U25 ( .A(n26), .B(n9), .C(n27), .Y(n24) );
  MUX2X1 U26 ( .B(n28), .A(n29), .S(n30), .Y(n27) );
  NOR2X1 U27 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n29) );
  OAI21X1 U28 ( .A(rollover_val[0]), .B(n31), .C(n32), .Y(n28) );
  INVX1 U29 ( .A(n21), .Y(n9) );
  NAND3X1 U30 ( .A(n33), .B(n5), .C(n6), .Y(n21) );
  NAND3X1 U31 ( .A(n34), .B(n32), .C(n35), .Y(n6) );
  AOI21X1 U32 ( .A(rollover_val[1]), .B(n31), .C(n36), .Y(n35) );
  INVX1 U33 ( .A(n37), .Y(n32) );
  OAI21X1 U34 ( .A(rollover_val[1]), .B(n31), .C(n38), .Y(n37) );
  XNOR2X1 U35 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n34) );
  INVX1 U36 ( .A(clear), .Y(n5) );
  INVX1 U37 ( .A(n3), .Y(n33) );
  NOR2X1 U38 ( .A(count_enable), .B(clear), .Y(n3) );
  XOR2X1 U39 ( .A(n39), .B(count_out[3]), .Y(n26) );
  OAI21X1 U40 ( .A(rollover_val[2]), .B(n40), .C(rollover_val[3]), .Y(n39) );
  INVX1 U41 ( .A(n30), .Y(n40) );
  NAND3X1 U42 ( .A(n36), .B(n41), .C(n42), .Y(n23) );
  OAI21X1 U43 ( .A(n38), .B(n31), .C(n30), .Y(n42) );
  NOR2X1 U44 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n30) );
  XOR2X1 U45 ( .A(n20), .B(rollover_val[2]), .Y(n38) );
  INVX1 U46 ( .A(count_out[2]), .Y(n20) );
  NAND3X1 U47 ( .A(rollover_val[1]), .B(n31), .C(rollover_val[0]), .Y(n41) );
  INVX1 U48 ( .A(count_out[1]), .Y(n31) );
  XOR2X1 U49 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n36) );
endmodule


module flex_counter_0 ( clk, n_rst, clear, count_enable, rollover_val, 
        count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47;

  DFFSR \count_out_reg[0]  ( .D(n43), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[3]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[1]  ( .D(n44), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n45), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR rollover_flag_reg ( .D(n47), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  MUX2X1 U7 ( .B(n1), .A(n2), .S(n3), .Y(n43) );
  OAI21X1 U9 ( .A(n4), .B(n2), .C(n5), .Y(n1) );
  INVX1 U10 ( .A(n6), .Y(n4) );
  MUX2X1 U11 ( .B(n7), .A(n8), .S(count_out[1]), .Y(n44) );
  NAND2X1 U12 ( .A(n9), .B(count_out[0]), .Y(n7) );
  INVX1 U13 ( .A(n15), .Y(n45) );
  MUX2X1 U14 ( .B(n16), .A(n17), .S(count_out[2]), .Y(n15) );
  MUX2X1 U15 ( .B(n18), .A(n19), .S(count_out[3]), .Y(n46) );
  AOI21X1 U16 ( .A(n9), .B(n20), .C(n17), .Y(n19) );
  OAI21X1 U17 ( .A(count_out[1]), .B(n21), .C(n8), .Y(n17) );
  AOI21X1 U18 ( .A(n2), .B(n9), .C(n3), .Y(n8) );
  INVX1 U19 ( .A(count_out[0]), .Y(n2) );
  NAND2X1 U20 ( .A(n16), .B(count_out[2]), .Y(n18) );
  INVX1 U21 ( .A(n22), .Y(n16) );
  NAND3X1 U22 ( .A(count_out[1]), .B(count_out[0]), .C(n9), .Y(n22) );
  OAI21X1 U23 ( .A(n23), .B(n24), .C(n25), .Y(n47) );
  NAND2X1 U24 ( .A(rollover_flag), .B(n3), .Y(n25) );
  NAND3X1 U25 ( .A(n26), .B(n9), .C(n27), .Y(n24) );
  MUX2X1 U26 ( .B(n28), .A(n29), .S(n30), .Y(n27) );
  NOR2X1 U27 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n29) );
  OAI21X1 U28 ( .A(rollover_val[0]), .B(n31), .C(n32), .Y(n28) );
  INVX1 U29 ( .A(n21), .Y(n9) );
  NAND3X1 U30 ( .A(n33), .B(n5), .C(n6), .Y(n21) );
  NAND3X1 U31 ( .A(n34), .B(n32), .C(n35), .Y(n6) );
  AOI21X1 U32 ( .A(rollover_val[1]), .B(n31), .C(n36), .Y(n35) );
  INVX1 U33 ( .A(n37), .Y(n32) );
  OAI21X1 U34 ( .A(rollover_val[1]), .B(n31), .C(n38), .Y(n37) );
  XNOR2X1 U35 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n34) );
  INVX1 U36 ( .A(clear), .Y(n5) );
  INVX1 U37 ( .A(n3), .Y(n33) );
  NOR2X1 U38 ( .A(count_enable), .B(clear), .Y(n3) );
  XOR2X1 U39 ( .A(n39), .B(count_out[3]), .Y(n26) );
  OAI21X1 U40 ( .A(rollover_val[2]), .B(n40), .C(rollover_val[3]), .Y(n39) );
  INVX1 U41 ( .A(n30), .Y(n40) );
  NAND3X1 U42 ( .A(n36), .B(n41), .C(n42), .Y(n23) );
  OAI21X1 U43 ( .A(n38), .B(n31), .C(n30), .Y(n42) );
  NOR2X1 U44 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n30) );
  XOR2X1 U45 ( .A(n20), .B(rollover_val[2]), .Y(n38) );
  INVX1 U46 ( .A(count_out[2]), .Y(n20) );
  NAND3X1 U47 ( .A(rollover_val[1]), .B(n31), .C(rollover_val[0]), .Y(n41) );
  INVX1 U48 ( .A(count_out[1]), .Y(n31) );
  XOR2X1 U49 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n36) );
endmodule


module timer ( clk, n_rst, enable_timer, shift_strobe, packet_done );
  input clk, n_rst, enable_timer;
  output shift_strobe, packet_done;
  wire   N22, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26;
  wire   [3:0] clk_count;
  wire   [3:0] bit_count;
  wire   [1:0] state;
  assign packet_done = N22;

  DFFSR \state_reg[0]  ( .D(n14), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n13), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  flex_counter_1 CLK_COUNT ( .clk(clk), .n_rst(n_rst), .clear(n16), 
        .count_enable(n15), .rollover_val({1'b1, 1'b0, 1'b1, 1'b0}), 
        .count_out(clk_count), .rollover_flag(shift_strobe) );
  flex_counter_0 BIT_COUNT ( .clk(clk), .n_rst(n_rst), .clear(n16), 
        .count_enable(shift_strobe), .rollover_val({1'b1, 1'b0, 1'b1, 1'b0}), 
        .count_out(bit_count) );
  NOR2X1 U20 ( .A(state[0]), .B(n17), .Y(n14) );
  MUX2X1 U21 ( .B(n18), .A(enable_timer), .S(n19), .Y(n17) );
  NOR2X1 U22 ( .A(n20), .B(n21), .Y(n18) );
  NAND3X1 U23 ( .A(clk_count[3]), .B(bit_count[3]), .C(n22), .Y(n21) );
  NOR2X1 U24 ( .A(bit_count[1]), .B(n23), .Y(n22) );
  INVX1 U25 ( .A(bit_count[0]), .Y(n23) );
  NAND2X1 U26 ( .A(n24), .B(n25), .Y(n20) );
  NOR2X1 U27 ( .A(clk_count[2]), .B(clk_count[1]), .Y(n25) );
  NOR2X1 U28 ( .A(clk_count[0]), .B(bit_count[2]), .Y(n24) );
  OR2X1 U29 ( .A(n16), .B(n15), .Y(n13) );
  NOR2X1 U30 ( .A(n19), .B(state[0]), .Y(n15) );
  NOR2X1 U31 ( .A(n26), .B(state[1]), .Y(n16) );
  NOR2X1 U32 ( .A(n26), .B(n19), .Y(N22) );
  INVX1 U33 ( .A(state[1]), .Y(n19) );
  INVX1 U34 ( .A(state[0]), .Y(n26) );
endmodule

