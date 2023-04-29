/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Apr 28 12:52:48 2023
/////////////////////////////////////////////////////////////


module sync_high ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   meta;

  DFFSR meta_reg ( .D(async_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(meta) );
  DFFSR sync_out_reg ( .D(meta), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sync_out)
         );
endmodule


module sync_low ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   meta;

  DFFSR meta_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(meta) );
  DFFSR sync_out_reg ( .D(meta), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out)
         );
endmodule


module eop_detect ( clk, n_rst, d_plus_sync, d_minus_sync, shift_enable, eop
 );
  input clk, n_rst, d_plus_sync, d_minus_sync, shift_enable;
  output eop;
  wire   n5, n1, n2;

  DFFSR eop_reg ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(eop) );
  INVX1 U2 ( .A(n1), .Y(n5) );
  MUX2X1 U3 ( .B(eop), .A(n2), .S(shift_enable), .Y(n1) );
  NOR2X1 U4 ( .A(d_plus_sync), .B(d_minus_sync), .Y(n2) );
endmodule


module decoder ( clk, n_rst, d_plus_sync, shift_enable, d_orig );
  input clk, n_rst, d_plus_sync, shift_enable;
  output d_orig;
  wire   old_data, new_data, n6, n8, n1, n2;

  DFFSR new_data_reg ( .D(n8), .CLK(clk), .R(1'b1), .S(n_rst), .Q(new_data) );
  DFFSR old_data_reg ( .D(n6), .CLK(clk), .R(1'b1), .S(n_rst), .Q(old_data) );
  INVX1 U2 ( .A(n1), .Y(n8) );
  MUX2X1 U3 ( .B(new_data), .A(d_plus_sync), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n6) );
  MUX2X1 U5 ( .B(old_data), .A(new_data), .S(shift_enable), .Y(n2) );
  XNOR2X1 U6 ( .A(new_data), .B(old_data), .Y(d_orig) );
endmodule


module edge_detector ( clk, n_rst, d_plus_sync, d_edge );
  input clk, n_rst, d_plus_sync;
  output d_edge;
  wire   old_d_plus;

  DFFSR old_d_plus_reg ( .D(d_plus_sync), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        old_d_plus) );
  XOR2X1 U4 ( .A(old_d_plus), .B(d_plus_sync), .Y(d_edge) );
endmodule


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


module timer ( clk, n_rst, d_edge, disable_timer, shift_enable, byte_received
 );
  input clk, n_rst, d_edge, disable_timer;
  output shift_enable, byte_received;
  wire   strobe_clear, strobe_enable, strobe_rollovervalue_0, shift_enable1,
         byte_clear, \byte_rollovervalue[3] , byte_enable, n26, n28, n30, n35,
         n36, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n33, n34, n37, n39;
  wire   [1:0] state1;
  wire   [2:0] state2;

  DFFSR \state1_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state1[0]) );
  DFFSR \state1_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state1[1]) );
  DFFSR \state2_reg[0]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state2[0]) );
  DFFSR \state2_reg[2]  ( .D(n28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state2[2]) );
  DFFSR \state2_reg[1]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state2[1]) );
  flex_counter_1 CORE1 ( .clk(clk), .n_rst(n_rst), .clear(strobe_clear), 
        .count_enable(strobe_enable), .rollover_val({n39, 1'b0, 1'b0, 
        strobe_rollovervalue_0}), .rollover_flag(shift_enable1) );
  flex_counter_0 CORE2 ( .clk(clk), .n_rst(n_rst), .clear(byte_clear), 
        .count_enable(byte_enable), .rollover_val({\byte_rollovervalue[3] , 
        1'b0, 1'b0, 1'b0}), .rollover_flag(byte_received) );
  INVX2 U3 ( .A(n7), .Y(shift_enable) );
  NAND2X1 U4 ( .A(n1), .B(n2), .Y(strobe_enable) );
  OAI21X1 U5 ( .A(state1[1]), .B(state1[0]), .C(n3), .Y(strobe_clear) );
  INVX1 U6 ( .A(n2), .Y(n39) );
  NAND2X1 U7 ( .A(state1[1]), .B(n4), .Y(n2) );
  MUX2X1 U8 ( .B(n4), .A(n5), .S(n6), .Y(n36) );
  NOR2X1 U9 ( .A(n4), .B(n7), .Y(n5) );
  OAI21X1 U10 ( .A(n7), .B(n1), .C(n6), .Y(n35) );
  OAI21X1 U11 ( .A(state1[0]), .B(n3), .C(state1[1]), .Y(n6) );
  INVX1 U12 ( .A(strobe_rollovervalue_0), .Y(n1) );
  NOR2X1 U13 ( .A(n4), .B(state1[1]), .Y(strobe_rollovervalue_0) );
  INVX1 U14 ( .A(state1[0]), .Y(n4) );
  NAND2X1 U15 ( .A(n8), .B(n9), .Y(n30) );
  MUX2X1 U16 ( .B(n10), .A(n11), .S(n12), .Y(n9) );
  OAI21X1 U17 ( .A(state2[0]), .B(n3), .C(n13), .Y(n11) );
  AND2X1 U18 ( .A(shift_enable), .B(n14), .Y(n10) );
  INVX1 U19 ( .A(n15), .Y(n8) );
  OAI21X1 U20 ( .A(n16), .B(n17), .C(n18), .Y(n15) );
  OAI21X1 U21 ( .A(n19), .B(n12), .C(n18), .Y(n28) );
  AOI21X1 U22 ( .A(n20), .B(byte_received), .C(state2[2]), .Y(n19) );
  NOR2X1 U23 ( .A(disable_timer), .B(n17), .Y(n20) );
  INVX1 U24 ( .A(state2[0]), .Y(n17) );
  OR2X1 U25 ( .A(n21), .B(n22), .Y(n26) );
  OAI21X1 U26 ( .A(state2[0]), .B(n12), .C(n16), .Y(n22) );
  NAND3X1 U27 ( .A(n23), .B(n24), .C(state2[1]), .Y(n16) );
  INVX1 U28 ( .A(disable_timer), .Y(n24) );
  INVX1 U29 ( .A(byte_received), .Y(n23) );
  XNOR2X1 U30 ( .A(state2[2]), .B(n33), .Y(n21) );
  NAND2X1 U31 ( .A(state2[0]), .B(n12), .Y(n33) );
  NOR2X1 U32 ( .A(n12), .B(n34), .Y(\byte_rollovervalue[3] ) );
  NAND2X1 U33 ( .A(state2[0]), .B(n13), .Y(n34) );
  INVX1 U34 ( .A(state2[2]), .Y(n13) );
  NOR2X1 U35 ( .A(n14), .B(n7), .Y(byte_enable) );
  NAND2X1 U36 ( .A(shift_enable1), .B(n3), .Y(n7) );
  INVX1 U37 ( .A(d_edge), .Y(n3) );
  NOR2X1 U38 ( .A(n14), .B(n37), .Y(byte_clear) );
  NAND2X1 U39 ( .A(n18), .B(n12), .Y(n37) );
  INVX1 U45 ( .A(state2[1]), .Y(n12) );
  NAND2X1 U46 ( .A(state2[2]), .B(state2[0]), .Y(n18) );
  NOR2X1 U47 ( .A(state2[2]), .B(state2[0]), .Y(n14) );
endmodule


module rcu ( clk, n_rst, d_edge, shift_enable, byte_received, p_out, 
        old_2_byte, new_2_byte, eop, done_2, done_64, disable_timer, rcving, 
        flush, r_error, store_pid, load_buf, w_enable, ready );
  input [7:0] p_out;
  input [7:0] old_2_byte;
  input [7:0] new_2_byte;
  input clk, n_rst, d_edge, shift_enable, byte_received, eop, done_2, done_64;
  output disable_timer, rcving, flush, r_error, store_pid, load_buf, w_enable,
         ready;
  wire   N157, N162, N167, N175, N176, n75, n83, n84, n85, n86, n87, n163, n6,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n76, n77,
         n78, n79, n80, n81, n82, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158, w_enable, n161, n162;
  wire   [4:0] nxt_state;
  wire   [4:0] state;
  assign N167 = byte_received;
  assign ready = w_enable;

  DFFSR \state_reg[0]  ( .D(n87), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[3]  ( .D(n83), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[3])
         );
  DFFSR \state_reg[2]  ( .D(n84), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n85), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[4]  ( .D(n86), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[4])
         );
  AND2X2 U4 ( .A(n96), .B(n75), .Y(n6) );
  AND2X2 U9 ( .A(n42), .B(n41), .Y(n7) );
  AND2X2 U10 ( .A(n65), .B(n64), .Y(n8) );
  INVX2 U11 ( .A(state[2]), .Y(n161) );
  INVX2 U12 ( .A(state[1]), .Y(n162) );
  NOR2X1 U13 ( .A(n77), .B(state[3]), .Y(n35) );
  NOR2X1 U14 ( .A(n161), .B(n92), .Y(n30) );
  OAI21X1 U15 ( .A(n35), .B(N167), .C(n70), .Y(n9) );
  NAND2X1 U16 ( .A(state[0]), .B(n9), .Y(n54) );
  NOR2X1 U17 ( .A(n92), .B(n77), .Y(n63) );
  NOR2X1 U18 ( .A(n154), .B(n80), .Y(n11) );
  OAI21X1 U19 ( .A(state[3]), .B(n6), .C(n79), .Y(n10) );
  AOI22X1 U20 ( .A(n11), .B(n79), .C(n10), .D(n89), .Y(n12) );
  OAI21X1 U21 ( .A(n158), .B(n69), .C(n12), .Y(n14) );
  NOR2X1 U22 ( .A(n70), .B(n88), .Y(n50) );
  AOI21X1 U23 ( .A(n30), .B(N162), .C(n50), .Y(n13) );
  OAI21X1 U24 ( .A(n14), .B(n73), .C(n103), .Y(n15) );
  OAI21X1 U25 ( .A(n67), .B(n103), .C(n15), .Y(n18) );
  AOI22X1 U26 ( .A(n158), .B(n30), .C(n82), .D(state[4]), .Y(n16) );
  NOR2X1 U27 ( .A(n103), .B(n35), .Y(n55) );
  AOI21X1 U28 ( .A(n16), .B(n66), .C(n72), .Y(n17) );
  AOI21X1 U29 ( .A(n18), .B(n72), .C(n17), .Y(n19) );
  OAI21X1 U30 ( .A(n54), .B(n162), .C(n19), .Y(nxt_state[0]) );
  NAND2X1 U31 ( .A(n67), .B(n70), .Y(n24) );
  NAND2X1 U32 ( .A(state[0]), .B(n153), .Y(n23) );
  OAI22X1 U33 ( .A(n79), .B(done_2), .C(state[3]), .D(n163), .Y(n21) );
  NAND2X1 U34 ( .A(n67), .B(n72), .Y(n20) );
  OAI21X1 U35 ( .A(n21), .B(n20), .C(n162), .Y(n22) );
  OAI21X1 U36 ( .A(n24), .B(n23), .C(n22), .Y(n28) );
  AOI22X1 U37 ( .A(N175), .B(n161), .C(N157), .D(n78), .Y(n26) );
  NOR2X1 U38 ( .A(state[4]), .B(n35), .Y(n25) );
  NAND3X1 U39 ( .A(n26), .B(n70), .C(n25), .Y(n27) );
  NOR2X1 U40 ( .A(n162), .B(state[0]), .Y(n57) );
  AOI22X1 U41 ( .A(n28), .B(n103), .C(n27), .D(n57), .Y(n29) );
  OAI21X1 U42 ( .A(n162), .B(n66), .C(n29), .Y(nxt_state[1]) );
  NAND3X1 U43 ( .A(n30), .B(n72), .C(N162), .Y(n31) );
  AOI21X1 U44 ( .A(state[4]), .B(n78), .C(n74), .Y(n42) );
  OAI21X1 U45 ( .A(state[0]), .B(n163), .C(n162), .Y(n32) );
  OAI21X1 U46 ( .A(n71), .B(n75), .C(n32), .Y(n40) );
  NOR2X1 U47 ( .A(n161), .B(state[3]), .Y(n46) );
  NAND2X1 U48 ( .A(N167), .B(state[0]), .Y(n47) );
  NAND3X1 U49 ( .A(n63), .B(n72), .C(N176), .Y(n33) );
  OAI21X1 U50 ( .A(n77), .B(n47), .C(n33), .Y(n34) );
  AOI21X1 U51 ( .A(state[0]), .B(n35), .C(n34), .Y(n38) );
  NAND2X1 U52 ( .A(n81), .B(n103), .Y(n37) );
  OAI21X1 U53 ( .A(n72), .B(done_2), .C(n50), .Y(n36) );
  OAI21X1 U54 ( .A(n38), .B(n37), .C(n36), .Y(n39) );
  AOI21X1 U55 ( .A(n40), .B(n46), .C(n39), .Y(n41) );
  NAND2X1 U56 ( .A(n81), .B(n161), .Y(n44) );
  OAI21X1 U57 ( .A(n72), .B(n157), .C(n162), .Y(n43) );
  OAI21X1 U58 ( .A(n47), .B(n44), .C(n43), .Y(n45) );
  OAI21X1 U59 ( .A(state[4]), .B(n45), .C(state[3]), .Y(n53) );
  AOI21X1 U60 ( .A(n155), .B(n72), .C(n76), .Y(n48) );
  NOR2X1 U61 ( .A(n68), .B(n48), .Y(n49) );
  NAND3X1 U62 ( .A(n88), .B(n103), .C(n49), .Y(n52) );
  NOR2X1 U63 ( .A(n74), .B(n50), .Y(n51) );
  NAND3X1 U64 ( .A(n53), .B(n52), .C(n51), .Y(nxt_state[3]) );
  OAI21X1 U65 ( .A(N162), .B(n70), .C(n54), .Y(n56) );
  AOI21X1 U66 ( .A(n82), .B(n56), .C(n55), .Y(n65) );
  OR2X1 U67 ( .A(n80), .B(n157), .Y(n59) );
  NAND2X1 U68 ( .A(n156), .B(n57), .Y(n58) );
  OAI21X1 U69 ( .A(n72), .B(n59), .C(n58), .Y(n62) );
  AOI22X1 U70 ( .A(n154), .B(n162), .C(n6), .D(n89), .Y(n60) );
  OAI21X1 U71 ( .A(n60), .B(n68), .C(n103), .Y(n61) );
  AOI22X1 U72 ( .A(n63), .B(n62), .C(n61), .D(n72), .Y(n64) );
  INVX2 U73 ( .A(n55), .Y(n66) );
  INVX2 U74 ( .A(n35), .Y(n67) );
  INVX2 U75 ( .A(n46), .Y(n68) );
  INVX2 U76 ( .A(n63), .Y(n69) );
  INVX2 U77 ( .A(n30), .Y(n70) );
  INVX2 U78 ( .A(n57), .Y(n71) );
  INVX2 U79 ( .A(state[0]), .Y(n72) );
  INVX2 U80 ( .A(n13), .Y(n73) );
  INVX2 U81 ( .A(n31), .Y(n74) );
  INVX2 U82 ( .A(n47), .Y(n76) );
  INVX2 U83 ( .A(n161), .Y(n77) );
  INVX2 U84 ( .A(n161), .Y(n78) );
  INVX2 U85 ( .A(n161), .Y(n79) );
  INVX2 U86 ( .A(n162), .Y(n80) );
  INVX2 U87 ( .A(n162), .Y(n81) );
  INVX2 U88 ( .A(n162), .Y(n82) );
  INVX2 U89 ( .A(n162), .Y(n88) );
  INVX2 U90 ( .A(n162), .Y(n89) );
  NOR2X1 U91 ( .A(n90), .B(n91), .Y(store_pid) );
  NAND2X1 U92 ( .A(state[2]), .B(n92), .Y(n91) );
  OAI22X1 U93 ( .A(state[4]), .B(n93), .C(state[0]), .D(n94), .Y(rcving) );
  OAI22X1 U94 ( .A(n95), .B(n72), .C(n162), .D(n94), .Y(r_error) );
  INVX1 U95 ( .A(n163), .Y(n154) );
  INVX1 U96 ( .A(n96), .Y(n155) );
  INVX1 U97 ( .A(n97), .Y(n156) );
  INVX1 U98 ( .A(done_64), .Y(n157) );
  INVX1 U99 ( .A(done_2), .Y(n158) );
  NOR2X1 U100 ( .A(n98), .B(n99), .Y(w_enable) );
  OR2X1 U101 ( .A(n92), .B(n100), .Y(n99) );
  NAND2X1 U102 ( .A(n162), .B(n161), .Y(n98) );
  INVX1 U103 ( .A(n95), .Y(disable_timer) );
  MUX2X1 U104 ( .B(n101), .A(n72), .S(n102), .Y(n87) );
  INVX1 U105 ( .A(nxt_state[0]), .Y(n101) );
  MUX2X1 U106 ( .B(n8), .A(n103), .S(n102), .Y(n86) );
  MUX2X1 U107 ( .B(n104), .A(n162), .S(n102), .Y(n85) );
  INVX1 U108 ( .A(nxt_state[1]), .Y(n104) );
  MUX2X1 U109 ( .B(n7), .A(n161), .S(n102), .Y(n84) );
  MUX2X1 U110 ( .B(n105), .A(n92), .S(n102), .Y(n83) );
  OAI21X1 U111 ( .A(d_edge), .B(n95), .C(n106), .Y(n102) );
  OAI21X1 U112 ( .A(n107), .B(n108), .C(n109), .Y(n106) );
  OAI21X1 U113 ( .A(n110), .B(n111), .C(n112), .Y(n109) );
  OAI21X1 U114 ( .A(n113), .B(n114), .C(n97), .Y(n112) );
  NAND2X1 U115 ( .A(shift_enable), .B(eop), .Y(n97) );
  OAI21X1 U116 ( .A(n115), .B(n116), .C(n94), .Y(n114) );
  NAND3X1 U117 ( .A(n161), .B(n92), .C(state[4]), .Y(n94) );
  OR2X1 U118 ( .A(n92), .B(n90), .Y(n116) );
  NAND2X1 U119 ( .A(n117), .B(n161), .Y(n115) );
  AOI21X1 U120 ( .A(N167), .B(n92), .C(n107), .Y(n113) );
  NAND2X1 U121 ( .A(n153), .B(n92), .Y(n111) );
  INVX1 U122 ( .A(N167), .Y(n153) );
  MUX2X1 U123 ( .B(n118), .A(n119), .S(state[2]), .Y(n110) );
  NOR2X1 U124 ( .A(state[1]), .B(n100), .Y(n119) );
  NAND2X1 U125 ( .A(N167), .B(n161), .Y(n108) );
  INVX1 U126 ( .A(n118), .Y(n107) );
  NOR2X1 U127 ( .A(n100), .B(n162), .Y(n118) );
  NAND2X1 U128 ( .A(state[0]), .B(n103), .Y(n100) );
  NAND2X1 U129 ( .A(n93), .B(n103), .Y(n95) );
  INVX1 U130 ( .A(n120), .Y(n93) );
  NAND3X1 U131 ( .A(n161), .B(n92), .C(n162), .Y(n120) );
  INVX1 U132 ( .A(nxt_state[3]), .Y(n105) );
  NOR2X1 U133 ( .A(n121), .B(n122), .Y(n163) );
  NAND3X1 U134 ( .A(p_out[7]), .B(n123), .C(n124), .Y(n122) );
  NOR2X1 U135 ( .A(p_out[2]), .B(p_out[1]), .Y(n124) );
  NAND3X1 U136 ( .A(n125), .B(n126), .C(n127), .Y(n121) );
  NOR2X1 U137 ( .A(p_out[6]), .B(p_out[5]), .Y(n127) );
  INVX1 U138 ( .A(p_out[4]), .Y(n126) );
  INVX1 U139 ( .A(p_out[3]), .Y(n125) );
  NOR2X1 U140 ( .A(n128), .B(n129), .Y(load_buf) );
  NAND2X1 U141 ( .A(state[3]), .B(n72), .Y(n129) );
  NAND2X1 U142 ( .A(n162), .B(n103), .Y(n128) );
  NOR2X1 U143 ( .A(n90), .B(n130), .Y(flush) );
  NAND2X1 U144 ( .A(n161), .B(n92), .Y(n130) );
  INVX1 U145 ( .A(state[3]), .Y(n92) );
  NAND3X1 U146 ( .A(n72), .B(n103), .C(state[1]), .Y(n90) );
  INVX1 U147 ( .A(state[4]), .Y(n103) );
  OAI21X1 U148 ( .A(done_2), .B(n117), .C(n131), .Y(N175) );
  INVX1 U149 ( .A(N176), .Y(n131) );
  NOR2X1 U150 ( .A(n117), .B(eop), .Y(N176) );
  INVX1 U151 ( .A(shift_enable), .Y(n117) );
  NOR2X1 U152 ( .A(n132), .B(n133), .Y(N162) );
  NAND3X1 U153 ( .A(old_2_byte[7]), .B(old_2_byte[0]), .C(n134), .Y(n133) );
  NOR2X1 U154 ( .A(new_2_byte[0]), .B(n135), .Y(n134) );
  OR2X1 U155 ( .A(new_2_byte[2]), .B(new_2_byte[1]), .Y(n135) );
  NAND3X1 U156 ( .A(n136), .B(n137), .C(n138), .Y(n132) );
  NOR2X1 U157 ( .A(old_2_byte[4]), .B(n139), .Y(n138) );
  OR2X1 U158 ( .A(old_2_byte[6]), .B(old_2_byte[5]), .Y(n139) );
  INVX1 U159 ( .A(old_2_byte[1]), .Y(n137) );
  NOR2X1 U160 ( .A(old_2_byte[3]), .B(old_2_byte[2]), .Y(n136) );
  NAND3X1 U161 ( .A(p_out[4]), .B(p_out[1]), .C(n140), .Y(N157) );
  AOI21X1 U162 ( .A(n141), .B(n142), .C(n143), .Y(n140) );
  NAND2X1 U163 ( .A(n123), .B(n144), .Y(n143) );
  NAND3X1 U164 ( .A(p_out[2]), .B(p_out[3]), .C(n145), .Y(n141) );
  NOR2X1 U165 ( .A(p_out[7]), .B(p_out[6]), .Y(n145) );
  NAND3X1 U166 ( .A(n146), .B(n147), .C(n148), .Y(n75) );
  AND2X1 U167 ( .A(p_out[0]), .B(p_out[1]), .Y(n148) );
  NOR2X1 U168 ( .A(p_out[5]), .B(p_out[4]), .Y(n146) );
  NAND3X1 U169 ( .A(n149), .B(n147), .C(n150), .Y(n96) );
  NOR2X1 U170 ( .A(n123), .B(n144), .Y(n150) );
  INVX1 U171 ( .A(p_out[5]), .Y(n144) );
  INVX1 U172 ( .A(p_out[0]), .Y(n123) );
  INVX1 U173 ( .A(n142), .Y(n147) );
  NAND3X1 U174 ( .A(n151), .B(n152), .C(p_out[6]), .Y(n142) );
  INVX1 U175 ( .A(p_out[2]), .Y(n152) );
  XOR2X1 U176 ( .A(p_out[7]), .B(p_out[3]), .Y(n151) );
  NOR2X1 U177 ( .A(p_out[4]), .B(p_out[1]), .Y(n149) );
endmodule


module flex_stp_sr_NUM_BITS8_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n3, n4, n5, n6, n7,
         n8;

  DFFSR \parallel_out_reg[7]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n24), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n22), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  INVX1 U2 ( .A(n1), .Y(n26) );
  MUX2X1 U3 ( .B(parallel_out[7]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n24) );
  MUX2X1 U5 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n22) );
  MUX2X1 U7 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n20) );
  MUX2X1 U9 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n18) );
  MUX2X1 U11 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n16) );
  MUX2X1 U13 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n14) );
  MUX2X1 U15 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n12) );
  MUX2X1 U17 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n8) );
endmodule


module stp_sr_8_lsb ( clk, n_rst, d_orig, shift_enable, p_out );
  output [7:0] p_out;
  input clk, n_rst, d_orig, shift_enable;


  flex_stp_sr_NUM_BITS8_SHIFT_MSB0 CORE ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_enable), .serial_in(d_orig), .parallel_out(p_out)
         );
endmodule


module rx_data_ready ( clk, n_rst, ready, buffer_occupancy, rx_data_ready );
  input [6:0] buffer_occupancy;
  input clk, n_rst, ready;
  output rx_data_ready;
  wire   state, n9, n2, n3, n4, n5, n6, n7, n8;
  assign rx_data_ready = state;

  DFFSR state_reg ( .D(n9), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state) );
  XOR2X1 U3 ( .A(n2), .B(state), .Y(n9) );
  MUX2X1 U4 ( .B(n3), .A(n4), .S(state), .Y(n2) );
  NAND3X1 U5 ( .A(n5), .B(n6), .C(n7), .Y(n4) );
  NOR2X1 U6 ( .A(buffer_occupancy[0]), .B(n8), .Y(n7) );
  OR2X1 U7 ( .A(buffer_occupancy[2]), .B(buffer_occupancy[1]), .Y(n8) );
  NOR2X1 U8 ( .A(buffer_occupancy[6]), .B(buffer_occupancy[5]), .Y(n6) );
  NOR2X1 U9 ( .A(buffer_occupancy[4]), .B(buffer_occupancy[3]), .Y(n5) );
  INVX1 U10 ( .A(ready), .Y(n3) );
endmodule


module rx_packet ( clk, n_rst, store_pid, p_out, rx_packet );
  input [7:0] p_out;
  output [3:0] rx_packet;
  input clk, n_rst, store_pid;
  wire   n46, n48, n50, n52, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42;

  DFFSR \rx_packet_reg[3]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rx_packet[3]) );
  DFFSR \rx_packet_reg[2]  ( .D(n50), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rx_packet[2]) );
  DFFSR \rx_packet_reg[1]  ( .D(n48), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rx_packet[1]) );
  DFFSR \rx_packet_reg[0]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rx_packet[0]) );
  INVX1 U3 ( .A(n1), .Y(n52) );
  AOI21X1 U4 ( .A(rx_packet[3]), .B(n2), .C(n3), .Y(n1) );
  OAI21X1 U5 ( .A(n4), .B(n5), .C(n6), .Y(n3) );
  NAND2X1 U6 ( .A(n7), .B(n8), .Y(n5) );
  OAI21X1 U7 ( .A(n9), .B(n10), .C(n11), .Y(n8) );
  NAND3X1 U8 ( .A(n12), .B(n13), .C(p_out[5]), .Y(n11) );
  INVX1 U9 ( .A(n14), .Y(n12) );
  INVX1 U10 ( .A(n15), .Y(n9) );
  OAI21X1 U11 ( .A(n16), .B(n17), .C(n6), .Y(n50) );
  INVX1 U12 ( .A(rx_packet[2]), .Y(n17) );
  OAI21X1 U13 ( .A(n16), .B(n18), .C(n19), .Y(n48) );
  AOI21X1 U14 ( .A(n20), .B(n21), .C(n22), .Y(n19) );
  INVX1 U15 ( .A(n6), .Y(n22) );
  NAND2X1 U16 ( .A(store_pid), .B(n23), .Y(n6) );
  AND2X1 U17 ( .A(n24), .B(n15), .Y(n21) );
  NOR2X1 U18 ( .A(n10), .B(n4), .Y(n20) );
  INVX1 U19 ( .A(n25), .Y(n10) );
  INVX1 U20 ( .A(rx_packet[1]), .Y(n18) );
  INVX1 U21 ( .A(n2), .Y(n16) );
  OAI21X1 U22 ( .A(n26), .B(n27), .C(n28), .Y(n46) );
  NAND2X1 U23 ( .A(rx_packet[0]), .B(n2), .Y(n28) );
  NAND2X1 U24 ( .A(store_pid), .B(n29), .Y(n2) );
  OAI21X1 U25 ( .A(n30), .B(n31), .C(n32), .Y(n29) );
  INVX1 U26 ( .A(n23), .Y(n32) );
  NOR2X1 U27 ( .A(n33), .B(n34), .Y(n23) );
  NAND3X1 U28 ( .A(p_out[2]), .B(n25), .C(p_out[4]), .Y(n34) );
  NAND3X1 U29 ( .A(n35), .B(n36), .C(n7), .Y(n33) );
  INVX1 U30 ( .A(n37), .Y(n7) );
  OR2X1 U31 ( .A(n26), .B(n36), .Y(n31) );
  INVX1 U32 ( .A(p_out[6]), .Y(n36) );
  OAI21X1 U33 ( .A(p_out[1]), .B(p_out[0]), .C(n15), .Y(n30) );
  OAI21X1 U34 ( .A(n38), .B(n39), .C(n14), .Y(n15) );
  NAND2X1 U35 ( .A(n35), .B(n40), .Y(n39) );
  INVX1 U36 ( .A(p_out[0]), .Y(n35) );
  OR2X1 U37 ( .A(n4), .B(n14), .Y(n27) );
  NAND3X1 U38 ( .A(n40), .B(n38), .C(p_out[0]), .Y(n14) );
  INVX1 U39 ( .A(p_out[4]), .Y(n38) );
  INVX1 U40 ( .A(p_out[2]), .Y(n40) );
  NAND2X1 U41 ( .A(p_out[6]), .B(store_pid), .Y(n4) );
  OAI21X1 U42 ( .A(n41), .B(n25), .C(n24), .Y(n26) );
  OAI21X1 U43 ( .A(p_out[3]), .B(n42), .C(n37), .Y(n24) );
  NAND2X1 U44 ( .A(p_out[3]), .B(n42), .Y(n37) );
  INVX1 U45 ( .A(p_out[7]), .Y(n42) );
  NOR2X1 U46 ( .A(n13), .B(p_out[5]), .Y(n25) );
  AND2X1 U47 ( .A(n13), .B(p_out[5]), .Y(n41) );
  INVX1 U48 ( .A(p_out[1]), .Y(n13) );
endmodule


module store_2_byte_buffer ( clk, n_rst, load_buf, flush, p_out, new_2_byte, 
        old_2_byte, rcv_data );
  input [7:0] p_out;
  output [7:0] new_2_byte;
  output [7:0] old_2_byte;
  output [7:0] rcv_data;
  input clk, n_rst, load_buf, flush;
  wire   n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60;

  DFFSR \new_2_byte_reg[7]  ( .D(n84), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[7]) );
  DFFSR \new_2_byte_reg[6]  ( .D(n83), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[6]) );
  DFFSR \new_2_byte_reg[5]  ( .D(n82), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[5]) );
  DFFSR \new_2_byte_reg[4]  ( .D(n81), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[4]) );
  DFFSR \new_2_byte_reg[3]  ( .D(n80), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[3]) );
  DFFSR \new_2_byte_reg[2]  ( .D(n79), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[2]) );
  DFFSR \new_2_byte_reg[1]  ( .D(n78), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[1]) );
  DFFSR \new_2_byte_reg[0]  ( .D(n77), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        new_2_byte[0]) );
  DFFSR \old_2_byte_reg[7]  ( .D(n76), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[7]) );
  DFFSR \rcv_data_reg[7]  ( .D(n61), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[7]) );
  DFFSR \old_2_byte_reg[6]  ( .D(n75), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[6]) );
  DFFSR \rcv_data_reg[6]  ( .D(n62), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[6]) );
  DFFSR \old_2_byte_reg[5]  ( .D(n74), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[5]) );
  DFFSR \rcv_data_reg[5]  ( .D(n63), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[5]) );
  DFFSR \old_2_byte_reg[4]  ( .D(n73), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[4]) );
  DFFSR \rcv_data_reg[4]  ( .D(n64), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[4]) );
  DFFSR \old_2_byte_reg[3]  ( .D(n72), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[3]) );
  DFFSR \rcv_data_reg[3]  ( .D(n65), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[3]) );
  DFFSR \old_2_byte_reg[2]  ( .D(n71), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[2]) );
  DFFSR \rcv_data_reg[2]  ( .D(n66), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[2]) );
  DFFSR \old_2_byte_reg[1]  ( .D(n70), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[1]) );
  DFFSR \rcv_data_reg[1]  ( .D(n67), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[1]) );
  DFFSR \old_2_byte_reg[0]  ( .D(n69), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        old_2_byte[0]) );
  DFFSR \rcv_data_reg[0]  ( .D(n68), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rcv_data[0]) );
  INVX2 U26 ( .A(n52), .Y(n25) );
  INVX2 U27 ( .A(n28), .Y(n44) );
  OAI21X1 U28 ( .A(n25), .B(n26), .C(n27), .Y(n84) );
  NAND2X1 U29 ( .A(p_out[7]), .B(n28), .Y(n27) );
  OAI21X1 U30 ( .A(n25), .B(n29), .C(n30), .Y(n83) );
  NAND2X1 U31 ( .A(p_out[6]), .B(n28), .Y(n30) );
  OAI21X1 U32 ( .A(n25), .B(n31), .C(n32), .Y(n82) );
  NAND2X1 U33 ( .A(p_out[5]), .B(n28), .Y(n32) );
  OAI21X1 U34 ( .A(n25), .B(n33), .C(n34), .Y(n81) );
  NAND2X1 U35 ( .A(p_out[4]), .B(n28), .Y(n34) );
  OAI21X1 U36 ( .A(n25), .B(n35), .C(n36), .Y(n80) );
  NAND2X1 U37 ( .A(p_out[3]), .B(n28), .Y(n36) );
  OAI21X1 U38 ( .A(n25), .B(n37), .C(n38), .Y(n79) );
  NAND2X1 U39 ( .A(p_out[2]), .B(n28), .Y(n38) );
  OAI21X1 U40 ( .A(n25), .B(n39), .C(n40), .Y(n78) );
  NAND2X1 U41 ( .A(p_out[1]), .B(n28), .Y(n40) );
  OAI21X1 U42 ( .A(n25), .B(n41), .C(n42), .Y(n77) );
  NAND2X1 U43 ( .A(p_out[0]), .B(n28), .Y(n42) );
  OAI22X1 U44 ( .A(n25), .B(n43), .C(n44), .D(n26), .Y(n76) );
  INVX1 U45 ( .A(new_2_byte[7]), .Y(n26) );
  OAI22X1 U46 ( .A(n25), .B(n45), .C(n44), .D(n29), .Y(n75) );
  INVX1 U47 ( .A(new_2_byte[6]), .Y(n29) );
  OAI22X1 U48 ( .A(n25), .B(n46), .C(n44), .D(n31), .Y(n74) );
  INVX1 U49 ( .A(new_2_byte[5]), .Y(n31) );
  OAI22X1 U50 ( .A(n25), .B(n47), .C(n44), .D(n33), .Y(n73) );
  INVX1 U51 ( .A(new_2_byte[4]), .Y(n33) );
  OAI22X1 U52 ( .A(n25), .B(n48), .C(n44), .D(n35), .Y(n72) );
  INVX1 U53 ( .A(new_2_byte[3]), .Y(n35) );
  OAI22X1 U54 ( .A(n25), .B(n49), .C(n44), .D(n37), .Y(n71) );
  INVX1 U55 ( .A(new_2_byte[2]), .Y(n37) );
  OAI22X1 U56 ( .A(n25), .B(n50), .C(n44), .D(n39), .Y(n70) );
  INVX1 U57 ( .A(new_2_byte[1]), .Y(n39) );
  OAI22X1 U58 ( .A(n25), .B(n51), .C(n44), .D(n41), .Y(n69) );
  INVX1 U59 ( .A(new_2_byte[0]), .Y(n41) );
  OAI21X1 U60 ( .A(n44), .B(n51), .C(n53), .Y(n68) );
  NAND2X1 U61 ( .A(rcv_data[0]), .B(n52), .Y(n53) );
  INVX1 U62 ( .A(old_2_byte[0]), .Y(n51) );
  OAI21X1 U63 ( .A(n44), .B(n50), .C(n54), .Y(n67) );
  NAND2X1 U64 ( .A(rcv_data[1]), .B(n52), .Y(n54) );
  INVX1 U65 ( .A(old_2_byte[1]), .Y(n50) );
  OAI21X1 U66 ( .A(n44), .B(n49), .C(n55), .Y(n66) );
  NAND2X1 U67 ( .A(rcv_data[2]), .B(n52), .Y(n55) );
  INVX1 U68 ( .A(old_2_byte[2]), .Y(n49) );
  OAI21X1 U69 ( .A(n44), .B(n48), .C(n56), .Y(n65) );
  NAND2X1 U70 ( .A(rcv_data[3]), .B(n52), .Y(n56) );
  INVX1 U71 ( .A(old_2_byte[3]), .Y(n48) );
  OAI21X1 U72 ( .A(n44), .B(n47), .C(n57), .Y(n64) );
  NAND2X1 U73 ( .A(rcv_data[4]), .B(n52), .Y(n57) );
  INVX1 U74 ( .A(old_2_byte[4]), .Y(n47) );
  OAI21X1 U75 ( .A(n44), .B(n46), .C(n58), .Y(n63) );
  NAND2X1 U76 ( .A(rcv_data[5]), .B(n52), .Y(n58) );
  INVX1 U77 ( .A(old_2_byte[5]), .Y(n46) );
  OAI21X1 U78 ( .A(n44), .B(n45), .C(n59), .Y(n62) );
  NAND2X1 U79 ( .A(rcv_data[6]), .B(n52), .Y(n59) );
  INVX1 U80 ( .A(old_2_byte[6]), .Y(n45) );
  OAI21X1 U81 ( .A(n44), .B(n43), .C(n60), .Y(n61) );
  NAND2X1 U82 ( .A(rcv_data[7]), .B(n52), .Y(n60) );
  INVX1 U83 ( .A(old_2_byte[7]), .Y(n43) );
  NOR2X1 U84 ( .A(n52), .B(flush), .Y(n28) );
  NOR2X1 U85 ( .A(load_buf), .B(flush), .Y(n52) );
endmodule


module count_to_2 ( clk, n_rst, flush, load_buf, done_2 );
  input clk, n_rst, flush, load_buf;
  output done_2;
  wire   n13, n14, n3, n4, n5, n6, n7, n8, n9;
  wire   [1:0] count;

  DFFSR \count_reg[0]  ( .D(n14), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[0])
         );
  DFFSR \count_reg[1]  ( .D(n13), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[1])
         );
  INVX1 U5 ( .A(n3), .Y(done_2) );
  NOR2X1 U6 ( .A(flush), .B(n4), .Y(n14) );
  MUX2X1 U7 ( .B(count[0]), .A(n5), .S(load_buf), .Y(n4) );
  NOR2X1 U8 ( .A(count[1]), .B(count[0]), .Y(n5) );
  AOI21X1 U9 ( .A(n6), .B(n3), .C(flush), .Y(n13) );
  NAND2X1 U10 ( .A(count[1]), .B(n7), .Y(n3) );
  MUX2X1 U11 ( .B(n8), .A(n9), .S(count[1]), .Y(n6) );
  NOR2X1 U12 ( .A(n9), .B(n7), .Y(n8) );
  INVX1 U13 ( .A(count[0]), .Y(n7) );
  INVX1 U14 ( .A(load_buf), .Y(n9) );
endmodule


module count_to_64_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module count_to_64 ( clk, n_rst, flush, w_enable, done_64 );
  input clk, n_rst, flush, w_enable;
  output done_64;
  wire   N4, N5, N6, N7, N8, N9, N10, n29, n30, n31, n32, n33, n34, n35, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28;
  wire   [6:0] count;

  DFFSR \count_reg[0]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[0])
         );
  DFFSR \count_reg[6]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[6])
         );
  DFFSR \count_reg[1]  ( .D(n33), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[1])
         );
  DFFSR \count_reg[2]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[2])
         );
  DFFSR \count_reg[3]  ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[3])
         );
  DFFSR \count_reg[4]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[4])
         );
  DFFSR \count_reg[5]  ( .D(n29), .CLK(clk), .R(n_rst), .S(1'b1), .Q(count[5])
         );
  count_to_64_DW01_inc_0 add_21 ( .A(count), .SUM({N10, N9, N8, N7, N6, N5, N4}) );
  OAI21X1 U10 ( .A(n8), .B(n9), .C(n10), .Y(n35) );
  NAND2X1 U11 ( .A(N4), .B(n11), .Y(n10) );
  OAI21X1 U12 ( .A(n12), .B(n8), .C(n13), .Y(n34) );
  NAND2X1 U13 ( .A(N10), .B(n11), .Y(n13) );
  INVX1 U14 ( .A(count[6]), .Y(n12) );
  OAI21X1 U15 ( .A(n8), .B(n14), .C(n15), .Y(n33) );
  NAND2X1 U16 ( .A(N5), .B(n11), .Y(n15) );
  OAI21X1 U17 ( .A(n8), .B(n16), .C(n17), .Y(n32) );
  NAND2X1 U18 ( .A(N6), .B(n11), .Y(n17) );
  OAI21X1 U19 ( .A(n8), .B(n18), .C(n19), .Y(n31) );
  NAND2X1 U20 ( .A(N7), .B(n11), .Y(n19) );
  OAI21X1 U21 ( .A(n8), .B(n20), .C(n21), .Y(n30) );
  NAND2X1 U22 ( .A(N8), .B(n11), .Y(n21) );
  INVX1 U23 ( .A(count[4]), .Y(n20) );
  OAI21X1 U24 ( .A(n8), .B(n22), .C(n23), .Y(n29) );
  NAND2X1 U25 ( .A(N9), .B(n11), .Y(n23) );
  AND2X1 U26 ( .A(n8), .B(n24), .Y(n11) );
  INVX1 U27 ( .A(count[5]), .Y(n22) );
  OAI21X1 U28 ( .A(done_64), .B(n25), .C(n24), .Y(n8) );
  INVX1 U29 ( .A(flush), .Y(n24) );
  INVX1 U30 ( .A(w_enable), .Y(n25) );
  NOR2X1 U31 ( .A(n26), .B(n27), .Y(done_64) );
  NAND3X1 U32 ( .A(n9), .B(n14), .C(count[6]), .Y(n27) );
  INVX1 U33 ( .A(count[1]), .Y(n14) );
  INVX1 U34 ( .A(count[0]), .Y(n9) );
  NAND3X1 U35 ( .A(n16), .B(n18), .C(n28), .Y(n26) );
  NOR2X1 U36 ( .A(count[5]), .B(count[4]), .Y(n28) );
  INVX1 U37 ( .A(count[3]), .Y(n18) );
  INVX1 U38 ( .A(count[2]), .Y(n16) );
endmodule


module rcv_block ( clk, n_rst, d_plus, d_minus, buffer_occupancy, rx_error, 
        rx_transfer_active, flush, rx_data_ready, rx_packet, w_enable, 
        rcv_data );
  input [6:0] buffer_occupancy;
  output [3:0] rx_packet;
  output [7:0] rcv_data;
  input clk, n_rst, d_plus, d_minus;
  output rx_error, rx_transfer_active, flush, rx_data_ready, w_enable;
  wire   d_plus_sync, d_minus_sync, shift_enable, eop, d_orig, d_edge,
         disable_timer, byte_received, done_2, done_64, store_pid, load_buf,
         ready;
  wire   [7:0] p_out;
  wire   [7:0] old_2_byte;
  wire   [7:0] new_2_byte;

  sync_high SYNC_HIGH ( .clk(clk), .n_rst(n_rst), .async_in(d_plus), 
        .sync_out(d_plus_sync) );
  sync_low SYNC_LOW ( .clk(clk), .n_rst(n_rst), .async_in(d_minus), .sync_out(
        d_minus_sync) );
  eop_detect EOP_DETECTOR ( .clk(clk), .n_rst(n_rst), .d_plus_sync(d_plus_sync), .d_minus_sync(d_minus_sync), .shift_enable(shift_enable), .eop(eop) );
  decoder DECODER ( .clk(clk), .n_rst(n_rst), .d_plus_sync(d_plus_sync), 
        .shift_enable(shift_enable), .d_orig(d_orig) );
  edge_detector EDGE_DETECTOR ( .clk(clk), .n_rst(n_rst), .d_plus_sync(
        d_plus_sync), .d_edge(d_edge) );
  timer TIMER ( .clk(clk), .n_rst(n_rst), .d_edge(d_edge), .disable_timer(
        disable_timer), .shift_enable(shift_enable), .byte_received(
        byte_received) );
  rcu RCU ( .clk(clk), .n_rst(n_rst), .d_edge(d_edge), .shift_enable(
        shift_enable), .byte_received(byte_received), .p_out(p_out), 
        .old_2_byte(old_2_byte), .new_2_byte(new_2_byte), .eop(eop), .done_2(
        done_2), .done_64(done_64), .disable_timer(disable_timer), .rcving(
        rx_transfer_active), .flush(flush), .r_error(rx_error), .store_pid(
        store_pid), .load_buf(load_buf), .w_enable(w_enable), .ready(ready) );
  stp_sr_8_lsb SHIFT_REGISTER ( .clk(clk), .n_rst(n_rst), .d_orig(d_orig), 
        .shift_enable(shift_enable), .p_out(p_out) );
  rx_data_ready READY ( .clk(clk), .n_rst(n_rst), .ready(ready), 
        .buffer_occupancy(buffer_occupancy), .rx_data_ready(rx_data_ready) );
  rx_packet PACKET ( .clk(clk), .n_rst(n_rst), .store_pid(store_pid), .p_out(
        p_out), .rx_packet(rx_packet) );
  store_2_byte_buffer STORE_2_BYTE ( .clk(clk), .n_rst(n_rst), .load_buf(
        load_buf), .flush(flush), .p_out(p_out), .new_2_byte(new_2_byte), 
        .old_2_byte(old_2_byte), .rcv_data(rcv_data) );
  count_to_2 COUNT_TO_2 ( .clk(clk), .n_rst(n_rst), .flush(flush), .load_buf(
        load_buf), .done_2(done_2) );
  count_to_64 COUNT_TO_64 ( .clk(clk), .n_rst(n_rst), .flush(flush), 
        .w_enable(w_enable), .done_64(done_64) );
endmodule

