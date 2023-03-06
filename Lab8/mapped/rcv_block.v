/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar  4 00:06:42 2023
/////////////////////////////////////////////////////////////


module rx_data_buff ( clk, n_rst, load_buffer, packet_data, data_read, rx_data, 
        data_ready, overrun_error );
  input [7:0] packet_data;
  output [7:0] rx_data;
  input clk, n_rst, load_buffer, data_read;
  output data_ready, overrun_error;
  wire   n30, n31, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n15, n17, n19,
         n21, n23, n25, n27, n29;

  DFFSR \rx_data_reg[7]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[7]) );
  DFFSR \rx_data_reg[6]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[6]) );
  DFFSR \rx_data_reg[5]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[5]) );
  DFFSR \rx_data_reg[4]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[4]) );
  DFFSR \rx_data_reg[3]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[3]) );
  DFFSR \rx_data_reg[2]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[2]) );
  DFFSR \rx_data_reg[1]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[1]) );
  DFFSR \rx_data_reg[0]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[0]) );
  DFFSR data_ready_reg ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_ready) );
  DFFSR overrun_error_reg ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        overrun_error) );
  INVX1 U3 ( .A(n1), .Y(n15) );
  MUX2X1 U4 ( .B(rx_data[4]), .A(packet_data[4]), .S(load_buffer), .Y(n1) );
  INVX1 U5 ( .A(n2), .Y(n17) );
  MUX2X1 U6 ( .B(rx_data[6]), .A(packet_data[6]), .S(load_buffer), .Y(n2) );
  INVX1 U7 ( .A(n3), .Y(n19) );
  MUX2X1 U8 ( .B(rx_data[7]), .A(packet_data[7]), .S(load_buffer), .Y(n3) );
  INVX1 U9 ( .A(n4), .Y(n21) );
  MUX2X1 U10 ( .B(rx_data[3]), .A(packet_data[3]), .S(load_buffer), .Y(n4) );
  INVX1 U11 ( .A(n5), .Y(n23) );
  MUX2X1 U12 ( .B(rx_data[5]), .A(packet_data[5]), .S(load_buffer), .Y(n5) );
  INVX1 U13 ( .A(n6), .Y(n25) );
  MUX2X1 U14 ( .B(rx_data[2]), .A(packet_data[2]), .S(load_buffer), .Y(n6) );
  INVX1 U15 ( .A(n7), .Y(n27) );
  MUX2X1 U16 ( .B(rx_data[1]), .A(packet_data[1]), .S(load_buffer), .Y(n7) );
  INVX1 U17 ( .A(n8), .Y(n29) );
  MUX2X1 U18 ( .B(rx_data[0]), .A(packet_data[0]), .S(load_buffer), .Y(n8) );
  OAI21X1 U19 ( .A(data_read), .B(n9), .C(n10), .Y(n31) );
  INVX1 U20 ( .A(load_buffer), .Y(n10) );
  INVX1 U21 ( .A(data_ready), .Y(n9) );
  NOR2X1 U22 ( .A(data_read), .B(n11), .Y(n30) );
  AOI21X1 U23 ( .A(data_ready), .B(load_buffer), .C(overrun_error), .Y(n11) );
endmodule


module flex_counter_NUM_CNT_BITS14_1_DW01_inc_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;

  wire   [13:2] carry;

  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[13]), .B(A[13]), .Y(SUM[13]) );
endmodule


module flex_counter_NUM_CNT_BITS14_1_DW01_dec_0 ( A, SUM );
  input [14:0] A;
  output [14:0] SUM;
  wire   n2, n4, n6, n8, n10, n12, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33;

  INVX2 U1 ( .A(n29), .Y(SUM[13]) );
  INVX2 U2 ( .A(A[12]), .Y(n2) );
  INVX2 U3 ( .A(n32), .Y(SUM[11]) );
  INVX2 U4 ( .A(A[10]), .Y(n4) );
  INVX2 U5 ( .A(n15), .Y(SUM[9]) );
  INVX2 U6 ( .A(A[8]), .Y(n6) );
  INVX2 U7 ( .A(n19), .Y(SUM[7]) );
  INVX2 U8 ( .A(A[6]), .Y(n8) );
  INVX2 U9 ( .A(n22), .Y(SUM[5]) );
  INVX2 U10 ( .A(A[4]), .Y(n10) );
  INVX2 U11 ( .A(n25), .Y(SUM[3]) );
  INVX2 U12 ( .A(A[2]), .Y(n12) );
  INVX2 U13 ( .A(n28), .Y(SUM[1]) );
  INVX2 U14 ( .A(A[0]), .Y(SUM[0]) );
  AOI21X1 U15 ( .A(n16), .B(A[9]), .C(n17), .Y(n15) );
  OAI21X1 U16 ( .A(n18), .B(n6), .C(n16), .Y(SUM[8]) );
  AOI21X1 U17 ( .A(n20), .B(A[7]), .C(n18), .Y(n19) );
  OAI21X1 U18 ( .A(n21), .B(n8), .C(n20), .Y(SUM[6]) );
  AOI21X1 U19 ( .A(n23), .B(A[5]), .C(n21), .Y(n22) );
  OAI21X1 U20 ( .A(n24), .B(n10), .C(n23), .Y(SUM[4]) );
  AOI21X1 U21 ( .A(n26), .B(A[3]), .C(n24), .Y(n25) );
  OAI21X1 U22 ( .A(n27), .B(n12), .C(n26), .Y(SUM[2]) );
  AOI21X1 U23 ( .A(A[0]), .B(A[1]), .C(n27), .Y(n28) );
  AOI21X1 U24 ( .A(n30), .B(A[13]), .C(SUM[14]), .Y(n29) );
  NOR2X1 U25 ( .A(n30), .B(A[13]), .Y(SUM[14]) );
  OAI21X1 U26 ( .A(n31), .B(n2), .C(n30), .Y(SUM[12]) );
  NAND2X1 U27 ( .A(n31), .B(n2), .Y(n30) );
  AOI21X1 U28 ( .A(n33), .B(A[11]), .C(n31), .Y(n32) );
  NOR2X1 U29 ( .A(n33), .B(A[11]), .Y(n31) );
  OAI21X1 U30 ( .A(n17), .B(n4), .C(n33), .Y(SUM[10]) );
  NAND2X1 U31 ( .A(n17), .B(n4), .Y(n33) );
  NOR2X1 U32 ( .A(n16), .B(A[9]), .Y(n17) );
  NAND2X1 U33 ( .A(n18), .B(n6), .Y(n16) );
  NOR2X1 U34 ( .A(n20), .B(A[7]), .Y(n18) );
  NAND2X1 U35 ( .A(n21), .B(n8), .Y(n20) );
  NOR2X1 U36 ( .A(n23), .B(A[5]), .Y(n21) );
  NAND2X1 U37 ( .A(n24), .B(n10), .Y(n23) );
  NOR2X1 U38 ( .A(n26), .B(A[3]), .Y(n24) );
  NAND2X1 U39 ( .A(n27), .B(n12), .Y(n26) );
  NOR2X1 U40 ( .A(A[1]), .B(A[0]), .Y(n27) );
endmodule


module flex_counter_NUM_CNT_BITS14_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [13:0] rollover_val;
  output [13:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18, N19,
         N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36, N37,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n1, n2, n4, n5, n6, n7, n8, n9, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113;

  DFFSR \count_out_reg[0]  ( .D(n98), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[13]  ( .D(n85), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[13]) );
  DFFSR \count_out_reg[12]  ( .D(n86), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[12]) );
  DFFSR \count_out_reg[11]  ( .D(n87), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[11]) );
  DFFSR \count_out_reg[10]  ( .D(n88), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[10]) );
  DFFSR \count_out_reg[9]  ( .D(n89), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR \count_out_reg[8]  ( .D(n90), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[7]  ( .D(n91), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[6]  ( .D(n92), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[5]  ( .D(n93), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[4]  ( .D(n94), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[3]  ( .D(n95), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[2]  ( .D(n96), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[1]  ( .D(n97), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR rollover_flag_reg ( .D(n113), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  flex_counter_NUM_CNT_BITS14_1_DW01_inc_0 r315 ( .A(count_out), .SUM({N37, 
        N36, N35, N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24}) );
  flex_counter_NUM_CNT_BITS14_1_DW01_dec_0 sub_49 ( .A({1'b0, rollover_val}), 
        .SUM({N19, N18, N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, 
        N5}) );
  INVX2 U8 ( .A(n5), .Y(n52) );
  INVX1 U20 ( .A(n1), .Y(n113) );
  AOI22X1 U21 ( .A(n2), .B(n4), .C(rollover_flag), .D(n5), .Y(n1) );
  NOR2X1 U22 ( .A(n6), .B(n7), .Y(n4) );
  NAND3X1 U23 ( .A(n8), .B(n9), .C(n25), .Y(n7) );
  NOR2X1 U24 ( .A(n26), .B(n27), .Y(n25) );
  XNOR2X1 U25 ( .A(n28), .B(N6), .Y(n27) );
  XOR2X1 U26 ( .A(count_out[0]), .B(N5), .Y(n26) );
  XNOR2X1 U27 ( .A(count_out[2]), .B(N7), .Y(n9) );
  XNOR2X1 U28 ( .A(count_out[7]), .B(N12), .Y(n8) );
  NAND3X1 U29 ( .A(n29), .B(n30), .C(n31), .Y(n6) );
  NOR2X1 U30 ( .A(N19), .B(n32), .Y(n31) );
  XNOR2X1 U31 ( .A(count_out[11]), .B(N16), .Y(n30) );
  XNOR2X1 U32 ( .A(count_out[6]), .B(N11), .Y(n29) );
  NOR2X1 U33 ( .A(n33), .B(n34), .Y(n2) );
  NAND3X1 U34 ( .A(n35), .B(n36), .C(n37), .Y(n34) );
  NOR2X1 U35 ( .A(n38), .B(n39), .Y(n37) );
  XNOR2X1 U36 ( .A(n40), .B(N13), .Y(n39) );
  XNOR2X1 U37 ( .A(n41), .B(N10), .Y(n38) );
  XNOR2X1 U38 ( .A(count_out[9]), .B(N14), .Y(n36) );
  XNOR2X1 U39 ( .A(count_out[10]), .B(N15), .Y(n35) );
  NAND3X1 U40 ( .A(n42), .B(n43), .C(n44), .Y(n33) );
  NOR2X1 U41 ( .A(n45), .B(n46), .Y(n44) );
  XNOR2X1 U42 ( .A(n47), .B(N8), .Y(n46) );
  XNOR2X1 U43 ( .A(n48), .B(N18), .Y(n45) );
  XNOR2X1 U44 ( .A(count_out[4]), .B(N9), .Y(n43) );
  XNOR2X1 U45 ( .A(count_out[12]), .B(N17), .Y(n42) );
  OAI21X1 U46 ( .A(n32), .B(n49), .C(n50), .Y(n98) );
  MUX2X1 U47 ( .B(count_out[0]), .A(n51), .S(n52), .Y(n50) );
  NOR2X1 U48 ( .A(clear), .B(n53), .Y(n51) );
  INVX1 U49 ( .A(N24), .Y(n49) );
  OAI21X1 U50 ( .A(n28), .B(n52), .C(n54), .Y(n97) );
  NAND2X1 U51 ( .A(N25), .B(n55), .Y(n54) );
  INVX1 U52 ( .A(count_out[1]), .Y(n28) );
  OAI21X1 U53 ( .A(n56), .B(n52), .C(n57), .Y(n96) );
  NAND2X1 U54 ( .A(N26), .B(n55), .Y(n57) );
  INVX1 U55 ( .A(count_out[2]), .Y(n56) );
  OAI21X1 U56 ( .A(n47), .B(n52), .C(n58), .Y(n95) );
  NAND2X1 U57 ( .A(N27), .B(n55), .Y(n58) );
  INVX1 U58 ( .A(count_out[3]), .Y(n47) );
  OAI21X1 U59 ( .A(n59), .B(n52), .C(n60), .Y(n94) );
  NAND2X1 U60 ( .A(N28), .B(n55), .Y(n60) );
  INVX1 U61 ( .A(count_out[4]), .Y(n59) );
  OAI21X1 U62 ( .A(n41), .B(n52), .C(n61), .Y(n93) );
  NAND2X1 U63 ( .A(N29), .B(n55), .Y(n61) );
  INVX1 U64 ( .A(count_out[5]), .Y(n41) );
  OAI21X1 U65 ( .A(n62), .B(n52), .C(n63), .Y(n92) );
  NAND2X1 U66 ( .A(N30), .B(n55), .Y(n63) );
  OAI21X1 U67 ( .A(n64), .B(n52), .C(n65), .Y(n91) );
  NAND2X1 U68 ( .A(N31), .B(n55), .Y(n65) );
  OAI21X1 U69 ( .A(n40), .B(n52), .C(n66), .Y(n90) );
  NAND2X1 U70 ( .A(N32), .B(n55), .Y(n66) );
  INVX1 U71 ( .A(count_out[8]), .Y(n40) );
  OAI21X1 U72 ( .A(n67), .B(n52), .C(n68), .Y(n89) );
  NAND2X1 U73 ( .A(N33), .B(n55), .Y(n68) );
  INVX1 U74 ( .A(count_out[9]), .Y(n67) );
  OAI21X1 U75 ( .A(n69), .B(n52), .C(n70), .Y(n88) );
  NAND2X1 U76 ( .A(N34), .B(n55), .Y(n70) );
  INVX1 U77 ( .A(count_out[10]), .Y(n69) );
  OAI21X1 U78 ( .A(n71), .B(n52), .C(n72), .Y(n87) );
  NAND2X1 U79 ( .A(N35), .B(n55), .Y(n72) );
  INVX1 U80 ( .A(count_out[11]), .Y(n71) );
  OAI21X1 U81 ( .A(n73), .B(n52), .C(n74), .Y(n86) );
  NAND2X1 U82 ( .A(N36), .B(n55), .Y(n74) );
  INVX1 U83 ( .A(count_out[12]), .Y(n73) );
  OAI21X1 U84 ( .A(n48), .B(n52), .C(n75), .Y(n85) );
  NAND2X1 U85 ( .A(N37), .B(n55), .Y(n75) );
  INVX1 U86 ( .A(n32), .Y(n55) );
  NAND3X1 U87 ( .A(n52), .B(n76), .C(n53), .Y(n32) );
  NAND2X1 U88 ( .A(n77), .B(n78), .Y(n53) );
  NOR2X1 U89 ( .A(n79), .B(n80), .Y(n78) );
  NAND3X1 U90 ( .A(n81), .B(n82), .C(n83), .Y(n80) );
  XNOR2X1 U91 ( .A(count_out[11]), .B(rollover_val[11]), .Y(n83) );
  XNOR2X1 U92 ( .A(count_out[12]), .B(rollover_val[12]), .Y(n82) );
  XNOR2X1 U93 ( .A(count_out[10]), .B(rollover_val[10]), .Y(n81) );
  NAND3X1 U94 ( .A(n84), .B(n99), .C(n100), .Y(n79) );
  NOR2X1 U95 ( .A(n101), .B(n102), .Y(n100) );
  XNOR2X1 U96 ( .A(rollover_val[7]), .B(n64), .Y(n102) );
  INVX1 U97 ( .A(count_out[7]), .Y(n64) );
  XNOR2X1 U98 ( .A(rollover_val[6]), .B(n62), .Y(n101) );
  INVX1 U99 ( .A(count_out[6]), .Y(n62) );
  XNOR2X1 U100 ( .A(count_out[8]), .B(rollover_val[8]), .Y(n99) );
  XNOR2X1 U101 ( .A(count_out[9]), .B(rollover_val[9]), .Y(n84) );
  NOR2X1 U102 ( .A(n103), .B(n104), .Y(n77) );
  NAND3X1 U103 ( .A(n105), .B(n106), .C(n107), .Y(n104) );
  XNOR2X1 U104 ( .A(count_out[4]), .B(rollover_val[4]), .Y(n107) );
  XNOR2X1 U105 ( .A(count_out[5]), .B(rollover_val[5]), .Y(n106) );
  XNOR2X1 U106 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n105) );
  NAND3X1 U107 ( .A(n108), .B(n109), .C(n110), .Y(n103) );
  NOR2X1 U108 ( .A(n111), .B(n112), .Y(n110) );
  XNOR2X1 U109 ( .A(rollover_val[13]), .B(n48), .Y(n112) );
  XOR2X1 U110 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n111) );
  XNOR2X1 U111 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n109) );
  XNOR2X1 U112 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n108) );
  INVX1 U113 ( .A(clear), .Y(n76) );
  NOR2X1 U114 ( .A(count_enable), .B(clear), .Y(n5) );
  INVX1 U115 ( .A(count_out[13]), .Y(n48) );
endmodule


module flex_counter_NUM_CNT_BITS14_0_DW01_inc_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;

  wire   [13:2] carry;

  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[13]), .B(A[13]), .Y(SUM[13]) );
endmodule


module flex_counter_NUM_CNT_BITS14_0_DW01_dec_0 ( A, SUM );
  input [14:0] A;
  output [14:0] SUM;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33;

  INVX2 U1 ( .A(n28), .Y(SUM[1]) );
  INVX2 U2 ( .A(n32), .Y(SUM[11]) );
  INVX2 U3 ( .A(n29), .Y(SUM[13]) );
  INVX2 U4 ( .A(n15), .Y(SUM[9]) );
  INVX2 U5 ( .A(n19), .Y(SUM[7]) );
  INVX2 U6 ( .A(n22), .Y(SUM[5]) );
  INVX2 U7 ( .A(n25), .Y(SUM[3]) );
  INVX2 U8 ( .A(A[0]), .Y(SUM[0]) );
  INVX2 U9 ( .A(A[2]), .Y(n9) );
  INVX2 U10 ( .A(A[4]), .Y(n10) );
  INVX2 U11 ( .A(A[6]), .Y(n11) );
  INVX2 U12 ( .A(A[8]), .Y(n12) );
  INVX2 U13 ( .A(A[10]), .Y(n13) );
  INVX2 U14 ( .A(A[12]), .Y(n14) );
  AOI21X1 U15 ( .A(n16), .B(A[9]), .C(n17), .Y(n15) );
  OAI21X1 U16 ( .A(n18), .B(n12), .C(n16), .Y(SUM[8]) );
  AOI21X1 U17 ( .A(n20), .B(A[7]), .C(n18), .Y(n19) );
  OAI21X1 U18 ( .A(n21), .B(n11), .C(n20), .Y(SUM[6]) );
  AOI21X1 U19 ( .A(n23), .B(A[5]), .C(n21), .Y(n22) );
  OAI21X1 U20 ( .A(n24), .B(n10), .C(n23), .Y(SUM[4]) );
  AOI21X1 U21 ( .A(n26), .B(A[3]), .C(n24), .Y(n25) );
  OAI21X1 U22 ( .A(n27), .B(n9), .C(n26), .Y(SUM[2]) );
  AOI21X1 U23 ( .A(A[0]), .B(A[1]), .C(n27), .Y(n28) );
  AOI21X1 U24 ( .A(n30), .B(A[13]), .C(SUM[14]), .Y(n29) );
  NOR2X1 U25 ( .A(n30), .B(A[13]), .Y(SUM[14]) );
  OAI21X1 U26 ( .A(n31), .B(n14), .C(n30), .Y(SUM[12]) );
  NAND2X1 U27 ( .A(n31), .B(n14), .Y(n30) );
  AOI21X1 U28 ( .A(n33), .B(A[11]), .C(n31), .Y(n32) );
  NOR2X1 U29 ( .A(n33), .B(A[11]), .Y(n31) );
  OAI21X1 U30 ( .A(n17), .B(n13), .C(n33), .Y(SUM[10]) );
  NAND2X1 U31 ( .A(n17), .B(n13), .Y(n33) );
  NOR2X1 U32 ( .A(n16), .B(A[9]), .Y(n17) );
  NAND2X1 U33 ( .A(n18), .B(n12), .Y(n16) );
  NOR2X1 U34 ( .A(n20), .B(A[7]), .Y(n18) );
  NAND2X1 U35 ( .A(n21), .B(n11), .Y(n20) );
  NOR2X1 U36 ( .A(n23), .B(A[5]), .Y(n21) );
  NAND2X1 U37 ( .A(n24), .B(n10), .Y(n23) );
  NOR2X1 U38 ( .A(n26), .B(A[3]), .Y(n24) );
  NAND2X1 U39 ( .A(n27), .B(n9), .Y(n26) );
  NOR2X1 U40 ( .A(A[1]), .B(A[0]), .Y(n27) );
endmodule


module flex_counter_NUM_CNT_BITS14_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [13:0] rollover_val;
  output [13:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18, N19,
         N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36, N37,
         n1, n2, n4, n5, n6, n7, n8, n9, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127;

  DFFSR \count_out_reg[0]  ( .D(n114), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[13]  ( .D(n127), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[13]) );
  DFFSR \count_out_reg[12]  ( .D(n126), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[12]) );
  DFFSR \count_out_reg[11]  ( .D(n125), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[11]) );
  DFFSR \count_out_reg[10]  ( .D(n124), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[10]) );
  DFFSR \count_out_reg[9]  ( .D(n123), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR \count_out_reg[8]  ( .D(n122), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[7]  ( .D(n121), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[6]  ( .D(n120), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[5]  ( .D(n119), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[4]  ( .D(n118), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[3]  ( .D(n117), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[2]  ( .D(n116), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[1]  ( .D(n115), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR rollover_flag_reg ( .D(n113), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  flex_counter_NUM_CNT_BITS14_0_DW01_inc_0 r315 ( .A(count_out), .SUM({N37, 
        N36, N35, N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24}) );
  flex_counter_NUM_CNT_BITS14_0_DW01_dec_0 sub_49 ( .A({1'b0, rollover_val}), 
        .SUM({N19, N18, N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, 
        N5}) );
  INVX2 U8 ( .A(n5), .Y(n52) );
  INVX1 U20 ( .A(n1), .Y(n113) );
  AOI22X1 U21 ( .A(n2), .B(n4), .C(rollover_flag), .D(n5), .Y(n1) );
  NOR2X1 U22 ( .A(n6), .B(n7), .Y(n4) );
  NAND3X1 U23 ( .A(n8), .B(n9), .C(n25), .Y(n7) );
  NOR2X1 U24 ( .A(n26), .B(n27), .Y(n25) );
  XNOR2X1 U25 ( .A(n28), .B(N6), .Y(n27) );
  XOR2X1 U26 ( .A(count_out[0]), .B(N5), .Y(n26) );
  XNOR2X1 U27 ( .A(count_out[2]), .B(N7), .Y(n9) );
  XNOR2X1 U28 ( .A(count_out[7]), .B(N12), .Y(n8) );
  NAND3X1 U29 ( .A(n29), .B(n30), .C(n31), .Y(n6) );
  NOR2X1 U30 ( .A(N19), .B(n32), .Y(n31) );
  XNOR2X1 U31 ( .A(count_out[11]), .B(N16), .Y(n30) );
  XNOR2X1 U32 ( .A(count_out[6]), .B(N11), .Y(n29) );
  NOR2X1 U33 ( .A(n33), .B(n34), .Y(n2) );
  NAND3X1 U34 ( .A(n35), .B(n36), .C(n37), .Y(n34) );
  NOR2X1 U35 ( .A(n38), .B(n39), .Y(n37) );
  XNOR2X1 U36 ( .A(n40), .B(N13), .Y(n39) );
  XNOR2X1 U37 ( .A(n41), .B(N10), .Y(n38) );
  XNOR2X1 U38 ( .A(count_out[9]), .B(N14), .Y(n36) );
  XNOR2X1 U39 ( .A(count_out[10]), .B(N15), .Y(n35) );
  NAND3X1 U40 ( .A(n42), .B(n43), .C(n44), .Y(n33) );
  NOR2X1 U41 ( .A(n45), .B(n46), .Y(n44) );
  XNOR2X1 U42 ( .A(n47), .B(N8), .Y(n46) );
  XNOR2X1 U43 ( .A(n48), .B(N18), .Y(n45) );
  XNOR2X1 U44 ( .A(count_out[4]), .B(N9), .Y(n43) );
  XNOR2X1 U45 ( .A(count_out[12]), .B(N17), .Y(n42) );
  OAI21X1 U46 ( .A(n32), .B(n49), .C(n50), .Y(n114) );
  MUX2X1 U47 ( .B(count_out[0]), .A(n51), .S(n52), .Y(n50) );
  NOR2X1 U48 ( .A(clear), .B(n53), .Y(n51) );
  INVX1 U49 ( .A(N24), .Y(n49) );
  OAI21X1 U50 ( .A(n28), .B(n52), .C(n54), .Y(n115) );
  NAND2X1 U51 ( .A(N25), .B(n55), .Y(n54) );
  INVX1 U52 ( .A(count_out[1]), .Y(n28) );
  OAI21X1 U53 ( .A(n56), .B(n52), .C(n57), .Y(n116) );
  NAND2X1 U54 ( .A(N26), .B(n55), .Y(n57) );
  INVX1 U55 ( .A(count_out[2]), .Y(n56) );
  OAI21X1 U56 ( .A(n47), .B(n52), .C(n58), .Y(n117) );
  NAND2X1 U57 ( .A(N27), .B(n55), .Y(n58) );
  INVX1 U58 ( .A(count_out[3]), .Y(n47) );
  OAI21X1 U59 ( .A(n59), .B(n52), .C(n60), .Y(n118) );
  NAND2X1 U60 ( .A(N28), .B(n55), .Y(n60) );
  INVX1 U61 ( .A(count_out[4]), .Y(n59) );
  OAI21X1 U62 ( .A(n41), .B(n52), .C(n61), .Y(n119) );
  NAND2X1 U63 ( .A(N29), .B(n55), .Y(n61) );
  INVX1 U64 ( .A(count_out[5]), .Y(n41) );
  OAI21X1 U65 ( .A(n62), .B(n52), .C(n63), .Y(n120) );
  NAND2X1 U66 ( .A(N30), .B(n55), .Y(n63) );
  OAI21X1 U67 ( .A(n64), .B(n52), .C(n65), .Y(n121) );
  NAND2X1 U68 ( .A(N31), .B(n55), .Y(n65) );
  OAI21X1 U69 ( .A(n40), .B(n52), .C(n66), .Y(n122) );
  NAND2X1 U70 ( .A(N32), .B(n55), .Y(n66) );
  INVX1 U71 ( .A(count_out[8]), .Y(n40) );
  OAI21X1 U72 ( .A(n67), .B(n52), .C(n68), .Y(n123) );
  NAND2X1 U73 ( .A(N33), .B(n55), .Y(n68) );
  INVX1 U74 ( .A(count_out[9]), .Y(n67) );
  OAI21X1 U75 ( .A(n69), .B(n52), .C(n70), .Y(n124) );
  NAND2X1 U76 ( .A(N34), .B(n55), .Y(n70) );
  INVX1 U77 ( .A(count_out[10]), .Y(n69) );
  OAI21X1 U78 ( .A(n71), .B(n52), .C(n72), .Y(n125) );
  NAND2X1 U79 ( .A(N35), .B(n55), .Y(n72) );
  INVX1 U80 ( .A(count_out[11]), .Y(n71) );
  OAI21X1 U81 ( .A(n73), .B(n52), .C(n74), .Y(n126) );
  NAND2X1 U82 ( .A(N36), .B(n55), .Y(n74) );
  INVX1 U83 ( .A(count_out[12]), .Y(n73) );
  OAI21X1 U84 ( .A(n48), .B(n52), .C(n75), .Y(n127) );
  NAND2X1 U85 ( .A(N37), .B(n55), .Y(n75) );
  INVX1 U86 ( .A(n32), .Y(n55) );
  NAND3X1 U87 ( .A(n52), .B(n76), .C(n53), .Y(n32) );
  NAND2X1 U88 ( .A(n77), .B(n78), .Y(n53) );
  NOR2X1 U89 ( .A(n79), .B(n80), .Y(n78) );
  NAND3X1 U90 ( .A(n81), .B(n82), .C(n83), .Y(n80) );
  XNOR2X1 U91 ( .A(count_out[11]), .B(rollover_val[11]), .Y(n83) );
  XNOR2X1 U92 ( .A(count_out[12]), .B(rollover_val[12]), .Y(n82) );
  XNOR2X1 U93 ( .A(count_out[10]), .B(rollover_val[10]), .Y(n81) );
  NAND3X1 U94 ( .A(n84), .B(n99), .C(n100), .Y(n79) );
  NOR2X1 U95 ( .A(n101), .B(n102), .Y(n100) );
  XNOR2X1 U96 ( .A(rollover_val[7]), .B(n64), .Y(n102) );
  INVX1 U97 ( .A(count_out[7]), .Y(n64) );
  XNOR2X1 U98 ( .A(rollover_val[6]), .B(n62), .Y(n101) );
  INVX1 U99 ( .A(count_out[6]), .Y(n62) );
  XNOR2X1 U100 ( .A(count_out[8]), .B(rollover_val[8]), .Y(n99) );
  XNOR2X1 U101 ( .A(count_out[9]), .B(rollover_val[9]), .Y(n84) );
  NOR2X1 U102 ( .A(n103), .B(n104), .Y(n77) );
  NAND3X1 U103 ( .A(n105), .B(n106), .C(n107), .Y(n104) );
  XNOR2X1 U104 ( .A(count_out[4]), .B(rollover_val[4]), .Y(n107) );
  XNOR2X1 U105 ( .A(count_out[5]), .B(rollover_val[5]), .Y(n106) );
  XNOR2X1 U106 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n105) );
  NAND3X1 U107 ( .A(n108), .B(n109), .C(n110), .Y(n103) );
  NOR2X1 U108 ( .A(n111), .B(n112), .Y(n110) );
  XNOR2X1 U109 ( .A(rollover_val[13]), .B(n48), .Y(n112) );
  XOR2X1 U110 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n111) );
  XNOR2X1 U111 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n109) );
  XNOR2X1 U112 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n108) );
  INVX1 U113 ( .A(clear), .Y(n76) );
  NOR2X1 U114 ( .A(count_enable), .B(clear), .Y(n5) );
  INVX1 U115 ( .A(count_out[13]), .Y(n48) );
endmodule


module timer ( clk, n_rst, enable_timer, shift_strobe, packet_done, bit_period, 
        data_size );
  input [13:0] bit_period;
  input [3:0] data_size;
  input clk, n_rst, enable_timer;
  output shift_strobe, packet_done;
  wire   N27, n12, n13, n14, n15, n1, n2, n3, n4, n5, n8, n9, n10, n11, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36;
  wire   [13:0] bit_count;
  wire   [1:0] state;
  assign packet_done = N27;

  DFFSR \state_reg[0]  ( .D(n13), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n12), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  flex_counter_NUM_CNT_BITS14_1 CLK_COUNT ( .clk(clk), .n_rst(n_rst), .clear(
        n15), .count_enable(n14), .rollover_val(bit_period), .rollover_flag(
        shift_strobe) );
  flex_counter_NUM_CNT_BITS14_0 BIT_COUNT ( .clk(clk), .n_rst(n_rst), .clear(
        n15), .count_enable(shift_strobe), .rollover_val({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0}), 
        .count_out(bit_count) );
  NOR2X1 U4 ( .A(state[0]), .B(n1), .Y(n13) );
  MUX2X1 U5 ( .B(n2), .A(enable_timer), .S(n3), .Y(n1) );
  NOR2X1 U7 ( .A(n4), .B(n5), .Y(n2) );
  OR2X1 U8 ( .A(n8), .B(n9), .Y(n5) );
  NAND3X1 U9 ( .A(n10), .B(n11), .C(n16), .Y(n9) );
  MUX2X1 U10 ( .B(n17), .A(n18), .S(n19), .Y(n16) );
  NOR2X1 U11 ( .A(n20), .B(n21), .Y(n19) );
  MUX2X1 U12 ( .B(bit_count[3]), .A(bit_count[4]), .S(data_size[3]), .Y(n18)
         );
  NAND2X1 U13 ( .A(n22), .B(n23), .Y(n17) );
  XNOR2X1 U14 ( .A(bit_count[3]), .B(data_size[3]), .Y(n22) );
  XOR2X1 U15 ( .A(n21), .B(n24), .Y(n11) );
  XNOR2X1 U16 ( .A(n20), .B(bit_count[2]), .Y(n24) );
  INVX1 U17 ( .A(data_size[2]), .Y(n20) );
  NAND2X1 U18 ( .A(data_size[0]), .B(data_size[1]), .Y(n21) );
  MUX2X1 U19 ( .B(n25), .A(n26), .S(data_size[0]), .Y(n10) );
  NAND2X1 U20 ( .A(n27), .B(n28), .Y(n26) );
  INVX1 U21 ( .A(bit_count[0]), .Y(n28) );
  XOR2X1 U22 ( .A(data_size[1]), .B(bit_count[1]), .Y(n27) );
  NAND2X1 U23 ( .A(n29), .B(bit_count[0]), .Y(n25) );
  XNOR2X1 U24 ( .A(bit_count[1]), .B(data_size[1]), .Y(n29) );
  OAI21X1 U25 ( .A(n30), .B(n23), .C(n31), .Y(n8) );
  NOR2X1 U26 ( .A(bit_count[11]), .B(bit_count[10]), .Y(n31) );
  INVX1 U27 ( .A(bit_count[4]), .Y(n23) );
  INVX1 U28 ( .A(bit_count[3]), .Y(n30) );
  NAND3X1 U29 ( .A(n32), .B(n33), .C(n34), .Y(n4) );
  NOR2X1 U30 ( .A(bit_count[12]), .B(n35), .Y(n34) );
  OR2X1 U31 ( .A(bit_count[5]), .B(bit_count[13]), .Y(n35) );
  NOR2X1 U32 ( .A(bit_count[9]), .B(bit_count[8]), .Y(n33) );
  NOR2X1 U33 ( .A(bit_count[7]), .B(bit_count[6]), .Y(n32) );
  OR2X1 U34 ( .A(n15), .B(n14), .Y(n12) );
  NOR2X1 U35 ( .A(n3), .B(state[0]), .Y(n14) );
  NOR2X1 U36 ( .A(n36), .B(state[1]), .Y(n15) );
  NOR2X1 U37 ( .A(n36), .B(n3), .Y(N27) );
  INVX1 U38 ( .A(state[1]), .Y(n3) );
  INVX1 U39 ( .A(state[0]), .Y(n36) );
endmodule


module flex_stp_sr_NUM_BITS9_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [8:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n13, n15, n17, n19, n21, n23, n25, n27, n29, n1, n2, n3, n4, n5, n6,
         n7, n8, n9;

  DFFSR \parallel_out_reg[8]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[8]) );
  DFFSR \parallel_out_reg[7]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n13), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  INVX1 U2 ( .A(n1), .Y(n29) );
  MUX2X1 U3 ( .B(parallel_out[8]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n27) );
  MUX2X1 U5 ( .B(parallel_out[7]), .A(parallel_out[8]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n25) );
  MUX2X1 U7 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n23) );
  MUX2X1 U9 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n21) );
  MUX2X1 U11 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n19) );
  MUX2X1 U13 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n17) );
  MUX2X1 U15 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n15) );
  MUX2X1 U17 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n8) );
  INVX1 U18 ( .A(n9), .Y(n13) );
  MUX2X1 U19 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n9) );
endmodule


module sr_9bit ( clk, n_rst, shift_strobe, serial_in, data_size, packet_data, 
        stop_bit );
  input [3:0] data_size;
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in;
  output stop_bit;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18;
  wire   [7:0] pre_packet_data;

  flex_stp_sr_NUM_BITS9_SHIFT_MSB0 CORE ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_strobe), .serial_in(serial_in), .parallel_out({
        stop_bit, pre_packet_data}) );
  NOR2X1 U2 ( .A(n1), .B(n2), .Y(packet_data[7]) );
  OAI22X1 U3 ( .A(n2), .B(n3), .C(n1), .D(n4), .Y(packet_data[6]) );
  OAI22X1 U4 ( .A(n4), .B(n3), .C(n1), .D(n5), .Y(packet_data[5]) );
  OAI21X1 U5 ( .A(n2), .B(n6), .C(n7), .Y(packet_data[4]) );
  AOI22X1 U6 ( .A(pre_packet_data[4]), .B(n8), .C(pre_packet_data[5]), .D(n9), 
        .Y(n7) );
  INVX1 U7 ( .A(pre_packet_data[7]), .Y(n2) );
  OAI21X1 U8 ( .A(n4), .B(n6), .C(n10), .Y(packet_data[3]) );
  AOI22X1 U9 ( .A(pre_packet_data[3]), .B(n8), .C(pre_packet_data[4]), .D(n9), 
        .Y(n10) );
  INVX1 U10 ( .A(pre_packet_data[6]), .Y(n4) );
  OAI21X1 U11 ( .A(n5), .B(n6), .C(n11), .Y(packet_data[2]) );
  AOI22X1 U12 ( .A(pre_packet_data[2]), .B(n8), .C(pre_packet_data[3]), .D(n9), 
        .Y(n11) );
  INVX1 U13 ( .A(pre_packet_data[5]), .Y(n5) );
  OAI21X1 U14 ( .A(n12), .B(n6), .C(n13), .Y(packet_data[1]) );
  AOI22X1 U15 ( .A(pre_packet_data[1]), .B(n8), .C(pre_packet_data[2]), .D(n9), 
        .Y(n13) );
  INVX1 U16 ( .A(pre_packet_data[4]), .Y(n12) );
  OAI21X1 U17 ( .A(n6), .B(n14), .C(n15), .Y(packet_data[0]) );
  AOI22X1 U18 ( .A(pre_packet_data[0]), .B(n8), .C(pre_packet_data[1]), .D(n9), 
        .Y(n15) );
  INVX1 U19 ( .A(n3), .Y(n9) );
  INVX1 U20 ( .A(n1), .Y(n8) );
  NAND2X1 U21 ( .A(n6), .B(n3), .Y(n1) );
  NAND3X1 U22 ( .A(data_size[2]), .B(data_size[1]), .C(n16), .Y(n3) );
  NOR2X1 U23 ( .A(data_size[3]), .B(n17), .Y(n16) );
  INVX1 U24 ( .A(data_size[0]), .Y(n17) );
  INVX1 U25 ( .A(pre_packet_data[3]), .Y(n14) );
  NAND3X1 U26 ( .A(data_size[2]), .B(data_size[0]), .C(n18), .Y(n6) );
  NOR2X1 U27 ( .A(data_size[3]), .B(data_size[1]), .Y(n18) );
endmodule


module rcu ( clk, n_rst, new_packet_detected, packet_done, framing_error, 
        sbc_clear, sbc_enable, load_buffer, enable_timer );
  input clk, n_rst, new_packet_detected, packet_done, framing_error;
  output sbc_clear, sbc_enable, load_buffer, enable_timer;
  wire   n34, n35, n36, sbc_clear, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24;
  wire   [3:0] state;
  assign enable_timer = sbc_clear;

  DFFSR \state_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  INVX1 U6 ( .A(n4), .Y(sbc_enable) );
  INVX1 U7 ( .A(n5), .Y(load_buffer) );
  NAND3X1 U8 ( .A(n6), .B(n4), .C(n7), .Y(n36) );
  MUX2X1 U9 ( .B(n8), .A(n9), .S(n10), .Y(n7) );
  AND2X1 U10 ( .A(new_packet_detected), .B(n11), .Y(n9) );
  NAND3X1 U11 ( .A(n10), .B(n11), .C(state[2]), .Y(n4) );
  INVX1 U12 ( .A(n12), .Y(n6) );
  NAND3X1 U13 ( .A(n13), .B(n14), .C(n15), .Y(n35) );
  AOI21X1 U14 ( .A(n8), .B(state[1]), .C(n12), .Y(n15) );
  OAI21X1 U15 ( .A(packet_done), .B(n16), .C(n17), .Y(n12) );
  NAND3X1 U16 ( .A(n10), .B(n18), .C(state[1]), .Y(n17) );
  OAI21X1 U17 ( .A(n16), .B(n19), .C(n20), .Y(n34) );
  OAI21X1 U18 ( .A(n21), .B(n8), .C(state[2]), .Y(n20) );
  INVX1 U19 ( .A(n22), .Y(n8) );
  OAI21X1 U20 ( .A(state[1]), .B(n10), .C(n23), .Y(n22) );
  AND2X1 U21 ( .A(n5), .B(n16), .Y(n23) );
  NAND3X1 U22 ( .A(state[2]), .B(n10), .C(state[1]), .Y(n5) );
  INVX1 U23 ( .A(state[0]), .Y(n10) );
  INVX1 U24 ( .A(n13), .Y(n21) );
  NAND2X1 U25 ( .A(n24), .B(state[0]), .Y(n13) );
  NOR2X1 U26 ( .A(state[1]), .B(framing_error), .Y(n24) );
  INVX1 U27 ( .A(packet_done), .Y(n19) );
  NAND3X1 U28 ( .A(state[1]), .B(n18), .C(state[0]), .Y(n16) );
  INVX1 U29 ( .A(n14), .Y(sbc_clear) );
  NAND3X1 U30 ( .A(n11), .B(n18), .C(state[0]), .Y(n14) );
  INVX1 U31 ( .A(state[2]), .Y(n18) );
  INVX1 U32 ( .A(state[1]), .Y(n11) );
endmodule


module start_bit_det ( clk, n_rst, serial_in, start_bit_detected, 
        new_packet_detected );
  input clk, n_rst, serial_in;
  output start_bit_detected, new_packet_detected;
  wire   start_bit_detected, old_sample, new_sample, sync_phase, n4;
  assign new_packet_detected = start_bit_detected;

  DFFSR sync_phase_reg ( .D(serial_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_phase) );
  DFFSR new_sample_reg ( .D(sync_phase), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        new_sample) );
  DFFSR old_sample_reg ( .D(new_sample), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        old_sample) );
  NOR2X1 U6 ( .A(new_sample), .B(n4), .Y(start_bit_detected) );
  INVX1 U7 ( .A(old_sample), .Y(n4) );
endmodule


module stop_bit_chk ( clk, n_rst, sbc_clear, sbc_enable, stop_bit, 
        framing_error );
  input clk, n_rst, sbc_clear, sbc_enable, stop_bit;
  output framing_error;
  wire   n5, n2, n3;

  DFFSR framing_error_reg ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        framing_error) );
  NOR2X1 U3 ( .A(sbc_clear), .B(n2), .Y(n5) );
  MUX2X1 U4 ( .B(framing_error), .A(n3), .S(sbc_enable), .Y(n2) );
  INVX1 U5 ( .A(stop_bit), .Y(n3) );
endmodule


module rcv_block ( clk, n_rst, data_size, bit_period, serial_in, data_read, 
        rx_data, data_ready, overrun_error, framing_error );
  input [3:0] data_size;
  input [13:0] bit_period;
  output [7:0] rx_data;
  input clk, n_rst, serial_in, data_read;
  output data_ready, overrun_error, framing_error;
  wire   load_buffer, enable_timer, shift_strobe, packet_done, stop_bit,
         new_packet_detected, sbc_clear, sbc_enable;
  wire   [7:0] packet_data;

  rx_data_buff RX_DATA_BUFF ( .clk(clk), .n_rst(n_rst), .load_buffer(
        load_buffer), .packet_data(packet_data), .data_read(data_read), 
        .rx_data(rx_data), .data_ready(data_ready), .overrun_error(
        overrun_error) );
  timer TIMER ( .clk(clk), .n_rst(n_rst), .enable_timer(enable_timer), 
        .shift_strobe(shift_strobe), .packet_done(packet_done), .bit_period(
        bit_period), .data_size(data_size) );
  sr_9bit SR_9BIT ( .clk(clk), .n_rst(n_rst), .shift_strobe(shift_strobe), 
        .serial_in(serial_in), .data_size(data_size), .packet_data(packet_data), .stop_bit(stop_bit) );
  rcu RCU ( .clk(clk), .n_rst(n_rst), .new_packet_detected(new_packet_detected), .packet_done(packet_done), .framing_error(framing_error), .sbc_clear(
        sbc_clear), .sbc_enable(sbc_enable), .load_buffer(load_buffer), 
        .enable_timer(enable_timer) );
  start_bit_det START_BIT_DET ( .clk(clk), .n_rst(n_rst), .serial_in(serial_in), .new_packet_detected(new_packet_detected) );
  stop_bit_chk STOP_BIT_CHK ( .clk(clk), .n_rst(n_rst), .sbc_clear(sbc_clear), 
        .sbc_enable(sbc_enable), .stop_bit(stop_bit), .framing_error(
        framing_error) );
endmodule

