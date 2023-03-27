/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Mar 20 16:24:06 2023
/////////////////////////////////////////////////////////////


module ahb_lite_slave ( clk, n_rst, coefficient_num, modwait, fir_out, err, 
        hsel, haddr, hsize, htrans, hwrite, hwdata, clear_new_coeff, 
        sample_data, data_ready, new_coefficient_set, fir_coefficient, hrdata, 
        hresp );
  input [1:0] coefficient_num;
  input [15:0] fir_out;
  input [3:0] haddr;
  input [1:0] htrans;
  input [15:0] hwdata;
  output [15:0] sample_data;
  output [15:0] fir_coefficient;
  output [15:0] hrdata;
  input clk, n_rst, modwait, err, hsel, hsize, hwrite, clear_new_coeff;
  output data_ready, new_coefficient_set, hresp;
  wire   size, next_new_coefficient_set, next_data_ready, n104, n105, n106,
         n107, n108, n109, n110, n111, n113, n114, n115, n116, n117, n118,
         n119, n121, n122, n123, n124, n125, n126, n127, n128, n130, n131,
         n132, n133, n134, n135, n136, n137, n139, n140, n141, n142, n143,
         n144, n145, n146, n148, n149, n150, n151, n152, n153, n154, n156,
         n157, n158, n159, n160, n161, n162, n163, n165, n166, n167, n168,
         n169, n170, n171, n173, n174, n175, n176, n177, n178, n179, n180,
         n182, n183, n184, n185, n186, n187, n188, n577, n578, n579, n580,
         n581, n582, n583, n584, n585, n586, n587, n588, n589, n590, n591,
         n592, n593, n594, n595, n596, n597, n598, n599, n600, n601, n602,
         n603, n604, n605, n606, n607, n608, n609, n610, n611, n612, n613,
         n614, n615, n616, n617, n618, n619, n620, n621, n622, n623, n624,
         n625, n626, n627, n628, n629, n630, n631, n632, n633, n634, n635,
         n636, n637, n638, n639, n640, n641, n642, n643, n644, n645, n646,
         n647, n648, n649, n650, n651, n652, n653, n654, n655, n656, n657,
         n658, n659, n660, n661, n662, n663, n664, n665, n666, n667, n668,
         n669, n670, n671, n672, n673, n674, n675, n676, n677, n678, n679,
         n680, n681, n682, n683, n684, n685, n686, n687, n688, n689, n690,
         n691, n692, n693, n694, n695, n696, n697, n698, n699, n700, n701,
         n702, n703, n704, n705, n706, n707, n708, n709, n710, n711, n712,
         n713, n714, n715, n716, n717, n718, n719, n720, n721, n722, n723,
         n724, n725, n726, n727, n728, n729, n730, n731, n732, n733, n734,
         n735, n736, n737, n738, n739, n740, n741, n742, n743, n744, n745,
         n746, n747, n748, n749, n750, n751, n752, n753, n754, n755, n756,
         n757, n758, n759, n760, n761, n762, n763, n764, n765, n766, n767,
         n768, n769, n770, n771, n772, n773, n774, n775, n776, n777, n778,
         n779, n780, n781, n782, n783, n784, n785, n786, n787, n788, n789,
         n790, n791, n792, n793, n794, n795, n796, n797, n798, n799, n800,
         n801, n802, n803, n804, n805, n806, n807, n808, n809, n810, n811,
         n812, n813, n814, n815, n816, n817, n818, n819, n820, n821, n822,
         n823, n824, n825, n826, n827, n828, n829, n830, n831, n832, n833,
         n834, n835, n836, n837, n838, n839, n840, n841, n842, n843, n844,
         n845, n846, n847, n848, n849, n850, n851, n852, n853, n854, n855,
         n856, n857, n858, n859, n860, n861, n862, n863, n864, n865, n866,
         n867, n868, n869, n870, n871, n872, n873, n874, n875, n876, n877,
         n878, n879, n880, n881, n882, n883, n884, n885, n886, n887, n888,
         n889, n890, n891, n892, n893, n894, n895, n896, n897, n898, n899,
         n900, n901, n902, n903, n904, n905, n906, n907, n908, n909, n910,
         n911, n912, n913, n914, n915, n916, n917, n918, n919, n920, n921,
         n922, n923, n924, n925, n926, n927, n928, n929, n930, n931, n932,
         n933, n934, n935, n936, n937, n938, n939, n940, n941, n942, n943,
         n944, n945, n946, n947, n948, n949, n950, n951, n952, n953, n954,
         n955, n956, n957, n958, n959, n960, n961, n962, n963, n964, n965,
         n966, n967, n968, n969, n970, n971, n972, n973, n974, n975, n976,
         n977, n978, n979, n980, n981;
  wire   [15:0] f0;
  wire   [15:0] f1;
  wire   [15:0] f2;
  wire   [15:0] f3;
  wire   [3:0] write_select;
  wire   [3:0] next_write_select;

  DFFSR size_reg ( .D(n597), .CLK(clk), .R(n_rst), .S(1'b1), .Q(size) );
  DFFSR \write_select_reg[3]  ( .D(next_write_select[3]), .CLK(clk), .R(1'b1), 
        .S(n_rst), .Q(write_select[3]) );
  DFFSR \write_select_reg[2]  ( .D(next_write_select[2]), .CLK(clk), .R(1'b1), 
        .S(n_rst), .Q(write_select[2]) );
  DFFSR \write_select_reg[1]  ( .D(next_write_select[1]), .CLK(clk), .R(1'b1), 
        .S(n_rst), .Q(write_select[1]) );
  DFFSR \write_select_reg[0]  ( .D(next_write_select[0]), .CLK(clk), .R(1'b1), 
        .S(n_rst), .Q(write_select[0]) );
  DFFSR new_coefficient_set_reg ( .D(next_new_coefficient_set), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(new_coefficient_set) );
  DFFSR \f2_reg[8]  ( .D(n139), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[8]) );
  DFFSR \f2_reg[9]  ( .D(n140), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[9]) );
  DFFSR \f2_reg[10]  ( .D(n141), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[10]) );
  DFFSR \f2_reg[11]  ( .D(n142), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[11]) );
  DFFSR \f2_reg[12]  ( .D(n143), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[12]) );
  DFFSR \f2_reg[13]  ( .D(n144), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[13]) );
  DFFSR \f2_reg[14]  ( .D(n145), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[14]) );
  DFFSR \f2_reg[15]  ( .D(n146), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[15]) );
  DFFSR \f2_reg[0]  ( .D(n594), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[0]) );
  DFFSR \f2_reg[1]  ( .D(n148), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[1]) );
  DFFSR \f2_reg[2]  ( .D(n149), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[2]) );
  DFFSR \f2_reg[3]  ( .D(n150), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[3]) );
  DFFSR \f2_reg[4]  ( .D(n151), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[4]) );
  DFFSR \f2_reg[5]  ( .D(n152), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[5]) );
  DFFSR \f2_reg[6]  ( .D(n153), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[6]) );
  DFFSR \f2_reg[7]  ( .D(n154), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f2[7]) );
  DFFSR \f0_reg[8]  ( .D(n173), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[8]) );
  DFFSR \f0_reg[9]  ( .D(n174), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[9]) );
  DFFSR \f0_reg[10]  ( .D(n175), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[10]) );
  DFFSR \f0_reg[11]  ( .D(n176), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[11]) );
  DFFSR \f0_reg[12]  ( .D(n177), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[12]) );
  DFFSR \f0_reg[13]  ( .D(n178), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[13]) );
  DFFSR \f0_reg[14]  ( .D(n179), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[14]) );
  DFFSR \f0_reg[15]  ( .D(n180), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[15]) );
  DFFSR \f0_reg[0]  ( .D(n596), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[0]) );
  DFFSR \f0_reg[1]  ( .D(n182), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[1]) );
  DFFSR \f0_reg[2]  ( .D(n183), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[2]) );
  DFFSR \f0_reg[3]  ( .D(n184), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[3]) );
  DFFSR \f0_reg[4]  ( .D(n185), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[4]) );
  DFFSR \f0_reg[5]  ( .D(n186), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[5]) );
  DFFSR \f0_reg[6]  ( .D(n187), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[6]) );
  DFFSR \f0_reg[7]  ( .D(n188), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f0[7]) );
  DFFSR \f3_reg[8]  ( .D(n121), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[8]) );
  DFFSR \f3_reg[9]  ( .D(n122), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[9]) );
  DFFSR \f3_reg[10]  ( .D(n123), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[10]) );
  DFFSR \f3_reg[11]  ( .D(n124), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[11]) );
  DFFSR \f3_reg[12]  ( .D(n125), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[12]) );
  DFFSR \f3_reg[13]  ( .D(n126), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[13]) );
  DFFSR \f3_reg[14]  ( .D(n127), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[14]) );
  DFFSR \f3_reg[15]  ( .D(n128), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[15]) );
  DFFSR \f3_reg[0]  ( .D(n130), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[0]) );
  DFFSR \f3_reg[1]  ( .D(n131), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[1]) );
  DFFSR \f3_reg[2]  ( .D(n132), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[2]) );
  DFFSR \f3_reg[3]  ( .D(n133), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[3]) );
  DFFSR \f3_reg[4]  ( .D(n134), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[4]) );
  DFFSR \f3_reg[5]  ( .D(n135), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[5]) );
  DFFSR \f3_reg[6]  ( .D(n136), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[6]) );
  DFFSR \f3_reg[7]  ( .D(n137), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f3[7]) );
  DFFSR \f1_reg[8]  ( .D(n156), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[8]) );
  DFFSR \f1_reg[9]  ( .D(n157), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[9]) );
  DFFSR \f1_reg[10]  ( .D(n158), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[10]) );
  DFFSR \f1_reg[11]  ( .D(n159), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[11]) );
  DFFSR \f1_reg[12]  ( .D(n160), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[12]) );
  DFFSR \f1_reg[13]  ( .D(n161), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[13]) );
  DFFSR \f1_reg[14]  ( .D(n162), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[14]) );
  DFFSR \f1_reg[15]  ( .D(n163), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[15]) );
  DFFSR \f1_reg[0]  ( .D(n595), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[0]) );
  DFFSR \f1_reg[1]  ( .D(n165), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[1]) );
  DFFSR \f1_reg[2]  ( .D(n166), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[2]) );
  DFFSR \f1_reg[3]  ( .D(n167), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[3]) );
  DFFSR \f1_reg[4]  ( .D(n168), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[4]) );
  DFFSR \f1_reg[5]  ( .D(n169), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[5]) );
  DFFSR \f1_reg[6]  ( .D(n170), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[6]) );
  DFFSR \f1_reg[7]  ( .D(n171), .CLK(clk), .R(n_rst), .S(1'b1), .Q(f1[7]) );
  DFFSR \sample_data_reg[8]  ( .D(n104), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[8]) );
  DFFSR \sample_data_reg[9]  ( .D(n105), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[9]) );
  DFFSR \sample_data_reg[10]  ( .D(n106), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[10]) );
  DFFSR \sample_data_reg[11]  ( .D(n107), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[11]) );
  DFFSR \sample_data_reg[12]  ( .D(n108), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[12]) );
  DFFSR \sample_data_reg[13]  ( .D(n109), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[13]) );
  DFFSR \sample_data_reg[14]  ( .D(n110), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[14]) );
  DFFSR \sample_data_reg[15]  ( .D(n111), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[15]) );
  DFFSR \sample_data_reg[0]  ( .D(n593), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[0]) );
  DFFSR \sample_data_reg[1]  ( .D(n113), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[1]) );
  DFFSR \sample_data_reg[2]  ( .D(n114), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[2]) );
  DFFSR \sample_data_reg[3]  ( .D(n115), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[3]) );
  DFFSR \sample_data_reg[4]  ( .D(n116), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[4]) );
  DFFSR \sample_data_reg[5]  ( .D(n117), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[5]) );
  DFFSR \sample_data_reg[6]  ( .D(n118), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[6]) );
  DFFSR \sample_data_reg[7]  ( .D(n119), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sample_data[7]) );
  DFFSR \hrdata_reg[15]  ( .D(n577), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[15]) );
  DFFSR \hrdata_reg[14]  ( .D(n578), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[14]) );
  DFFSR \hrdata_reg[13]  ( .D(n579), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[13]) );
  DFFSR \hrdata_reg[12]  ( .D(n580), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[12]) );
  DFFSR \hrdata_reg[11]  ( .D(n581), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[11]) );
  DFFSR \hrdata_reg[10]  ( .D(n582), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[10]) );
  DFFSR \hrdata_reg[9]  ( .D(n583), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[9]) );
  DFFSR \hrdata_reg[8]  ( .D(n584), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[8]) );
  DFFSR \hrdata_reg[7]  ( .D(n585), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[7]) );
  DFFSR \hrdata_reg[6]  ( .D(n586), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[6]) );
  DFFSR \hrdata_reg[5]  ( .D(n587), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[5]) );
  DFFSR \hrdata_reg[4]  ( .D(n588), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[4]) );
  DFFSR \hrdata_reg[3]  ( .D(n589), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[3]) );
  DFFSR \hrdata_reg[2]  ( .D(n590), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[2]) );
  DFFSR \hrdata_reg[1]  ( .D(n591), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[1]) );
  DFFSR \hrdata_reg[0]  ( .D(n592), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        hrdata[0]) );
  DFFSR data_ready_reg ( .D(next_data_ready), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(data_ready) );
  AND2X2 U623 ( .A(coefficient_num[1]), .B(n981), .Y(n947) );
  AND2X2 U624 ( .A(coefficient_num[0]), .B(coefficient_num[1]), .Y(n948) );
  BUFX2 U625 ( .A(n949), .Y(n598) );
  BUFX2 U626 ( .A(n655), .Y(n599) );
  BUFX2 U627 ( .A(n950), .Y(n600) );
  NAND2X1 U628 ( .A(n601), .B(n602), .Y(next_write_select[3]) );
  NAND2X1 U629 ( .A(n601), .B(n603), .Y(next_write_select[2]) );
  NAND2X1 U630 ( .A(n601), .B(n604), .Y(next_write_select[1]) );
  NAND2X1 U631 ( .A(n601), .B(n605), .Y(next_write_select[0]) );
  NOR2X1 U632 ( .A(n606), .B(n607), .Y(n601) );
  NOR2X1 U633 ( .A(clear_new_coeff), .B(n608), .Y(next_new_coefficient_set) );
  AOI21X1 U634 ( .A(n609), .B(n610), .C(modwait), .Y(next_data_ready) );
  NOR2X1 U635 ( .A(data_ready), .B(n611), .Y(n609) );
  INVX1 U636 ( .A(n612), .Y(n597) );
  MUX2X1 U637 ( .B(size), .A(hsize), .S(n613), .Y(n612) );
  NOR2X1 U638 ( .A(n606), .B(n614), .Y(n613) );
  NAND2X1 U639 ( .A(n615), .B(n616), .Y(n614) );
  NAND3X1 U640 ( .A(n617), .B(n618), .C(hwrite), .Y(n606) );
  MUX2X1 U641 ( .B(n619), .A(n620), .S(n621), .Y(n596) );
  INVX1 U642 ( .A(f0[0]), .Y(n620) );
  MUX2X1 U643 ( .B(n619), .A(n622), .S(n623), .Y(n595) );
  INVX1 U644 ( .A(hwdata[0]), .Y(n619) );
  INVX1 U645 ( .A(n624), .Y(n594) );
  MUX2X1 U646 ( .B(hwdata[0]), .A(f2[0]), .S(n625), .Y(n624) );
  INVX1 U647 ( .A(n626), .Y(n593) );
  MUX2X1 U648 ( .B(hwdata[0]), .A(sample_data[0]), .S(n627), .Y(n626) );
  INVX1 U649 ( .A(n628), .Y(n592) );
  MUX2X1 U650 ( .B(hrdata[0]), .A(n629), .S(n630), .Y(n628) );
  NAND3X1 U651 ( .A(n631), .B(n632), .C(n633), .Y(n629) );
  NOR2X1 U652 ( .A(n634), .B(n635), .Y(n633) );
  INVX1 U653 ( .A(n636), .Y(n635) );
  AOI22X1 U654 ( .A(n607), .B(hrdata[0]), .C(n637), .D(f0[0]), .Y(n636) );
  OAI21X1 U655 ( .A(n638), .B(n622), .C(n639), .Y(n634) );
  AOI22X1 U656 ( .A(sample_data[0]), .B(n640), .C(fir_out[0]), .D(n641), .Y(
        n639) );
  INVX1 U657 ( .A(f1[0]), .Y(n622) );
  INVX1 U658 ( .A(n642), .Y(n638) );
  AOI21X1 U659 ( .A(f3[0]), .B(n643), .C(n644), .Y(n632) );
  OAI21X1 U660 ( .A(n616), .B(n645), .C(n646), .Y(n644) );
  NAND3X1 U661 ( .A(modwait), .B(n647), .C(n648), .Y(n646) );
  NOR2X1 U662 ( .A(haddr[1]), .B(n649), .Y(n648) );
  OR2X1 U663 ( .A(n608), .B(hsize), .Y(n645) );
  MUX2X1 U664 ( .B(new_coefficient_set), .A(hwdata[0]), .S(n650), .Y(n608) );
  NOR2X1 U665 ( .A(n651), .B(n652), .Y(n650) );
  AOI22X1 U666 ( .A(f2[0]), .B(n653), .C(hwdata[0]), .D(n654), .Y(n631) );
  OAI21X1 U667 ( .A(n599), .B(n656), .C(n657), .Y(n591) );
  OAI21X1 U668 ( .A(n658), .B(n659), .C(n630), .Y(n657) );
  OAI21X1 U669 ( .A(n660), .B(n661), .C(n662), .Y(n659) );
  AOI22X1 U670 ( .A(fir_out[1]), .B(n641), .C(f1[1]), .D(n642), .Y(n662) );
  NAND2X1 U671 ( .A(n663), .B(n664), .Y(n658) );
  AOI22X1 U672 ( .A(f3[1]), .B(n643), .C(f2[1]), .D(n653), .Y(n664) );
  AOI22X1 U673 ( .A(hwdata[1]), .B(n654), .C(sample_data[1]), .D(n640), .Y(
        n663) );
  INVX1 U674 ( .A(hrdata[1]), .Y(n656) );
  OAI21X1 U675 ( .A(n599), .B(n665), .C(n666), .Y(n590) );
  OAI21X1 U676 ( .A(n667), .B(n668), .C(n630), .Y(n666) );
  OAI21X1 U677 ( .A(n660), .B(n669), .C(n670), .Y(n668) );
  AOI22X1 U678 ( .A(fir_out[2]), .B(n641), .C(f1[2]), .D(n642), .Y(n670) );
  NAND2X1 U679 ( .A(n671), .B(n672), .Y(n667) );
  AOI22X1 U680 ( .A(f3[2]), .B(n643), .C(f2[2]), .D(n653), .Y(n672) );
  AOI22X1 U681 ( .A(hwdata[2]), .B(n654), .C(sample_data[2]), .D(n640), .Y(
        n671) );
  INVX1 U682 ( .A(hrdata[2]), .Y(n665) );
  OAI21X1 U683 ( .A(n599), .B(n673), .C(n674), .Y(n589) );
  OAI21X1 U684 ( .A(n675), .B(n676), .C(n630), .Y(n674) );
  OAI21X1 U685 ( .A(n660), .B(n677), .C(n678), .Y(n676) );
  AOI22X1 U686 ( .A(fir_out[3]), .B(n641), .C(f1[3]), .D(n642), .Y(n678) );
  NAND2X1 U687 ( .A(n679), .B(n680), .Y(n675) );
  AOI22X1 U688 ( .A(f3[3]), .B(n643), .C(f2[3]), .D(n653), .Y(n680) );
  AOI22X1 U689 ( .A(hwdata[3]), .B(n654), .C(sample_data[3]), .D(n640), .Y(
        n679) );
  INVX1 U690 ( .A(hrdata[3]), .Y(n673) );
  OAI21X1 U691 ( .A(n599), .B(n681), .C(n682), .Y(n588) );
  OAI21X1 U692 ( .A(n683), .B(n684), .C(n630), .Y(n682) );
  OAI21X1 U693 ( .A(n660), .B(n685), .C(n686), .Y(n684) );
  AOI22X1 U694 ( .A(fir_out[4]), .B(n641), .C(f1[4]), .D(n642), .Y(n686) );
  NAND2X1 U695 ( .A(n687), .B(n688), .Y(n683) );
  AOI22X1 U696 ( .A(f3[4]), .B(n643), .C(f2[4]), .D(n653), .Y(n688) );
  AOI22X1 U697 ( .A(hwdata[4]), .B(n654), .C(sample_data[4]), .D(n640), .Y(
        n687) );
  INVX1 U698 ( .A(hrdata[4]), .Y(n681) );
  OAI21X1 U699 ( .A(n599), .B(n689), .C(n690), .Y(n587) );
  OAI21X1 U700 ( .A(n691), .B(n692), .C(n630), .Y(n690) );
  OAI21X1 U701 ( .A(n660), .B(n693), .C(n694), .Y(n692) );
  AOI22X1 U702 ( .A(fir_out[5]), .B(n641), .C(f1[5]), .D(n642), .Y(n694) );
  NAND2X1 U703 ( .A(n695), .B(n696), .Y(n691) );
  AOI22X1 U704 ( .A(f3[5]), .B(n643), .C(f2[5]), .D(n653), .Y(n696) );
  AOI22X1 U705 ( .A(hwdata[5]), .B(n654), .C(sample_data[5]), .D(n640), .Y(
        n695) );
  INVX1 U706 ( .A(hrdata[5]), .Y(n689) );
  OAI21X1 U707 ( .A(n599), .B(n697), .C(n698), .Y(n586) );
  OAI21X1 U708 ( .A(n699), .B(n700), .C(n630), .Y(n698) );
  OAI21X1 U709 ( .A(n660), .B(n701), .C(n702), .Y(n700) );
  AOI22X1 U710 ( .A(fir_out[6]), .B(n641), .C(f1[6]), .D(n642), .Y(n702) );
  NAND2X1 U711 ( .A(n703), .B(n704), .Y(n699) );
  AOI22X1 U712 ( .A(f3[6]), .B(n643), .C(f2[6]), .D(n653), .Y(n704) );
  AOI22X1 U713 ( .A(hwdata[6]), .B(n654), .C(sample_data[6]), .D(n640), .Y(
        n703) );
  INVX1 U714 ( .A(hrdata[6]), .Y(n697) );
  OAI21X1 U715 ( .A(n599), .B(n705), .C(n706), .Y(n585) );
  OAI21X1 U716 ( .A(n707), .B(n708), .C(n630), .Y(n706) );
  OAI21X1 U717 ( .A(n660), .B(n709), .C(n710), .Y(n708) );
  AOI22X1 U718 ( .A(fir_out[7]), .B(n641), .C(f1[7]), .D(n642), .Y(n710) );
  OAI21X1 U719 ( .A(n711), .B(n712), .C(n713), .Y(n642) );
  NAND3X1 U720 ( .A(hsize), .B(n714), .C(n715), .Y(n713) );
  INVX1 U721 ( .A(n716), .Y(n715) );
  NOR3X1 U722 ( .A(n604), .B(n649), .C(n618), .Y(n641) );
  NOR2X1 U723 ( .A(n605), .B(hsize), .Y(n649) );
  INVX1 U724 ( .A(n637), .Y(n660) );
  OAI21X1 U725 ( .A(n717), .B(n718), .C(n719), .Y(n637) );
  NAND3X1 U726 ( .A(hsize), .B(n720), .C(n721), .Y(n719) );
  INVX1 U727 ( .A(n722), .Y(n721) );
  NAND2X1 U728 ( .A(n723), .B(n724), .Y(n707) );
  AOI22X1 U729 ( .A(f3[7]), .B(n643), .C(f2[7]), .D(n653), .Y(n724) );
  OAI22X1 U730 ( .A(n725), .B(n726), .C(n727), .D(n728), .Y(n653) );
  OAI21X1 U731 ( .A(n729), .B(n730), .C(n731), .Y(n643) );
  NAND3X1 U732 ( .A(hsize), .B(n732), .C(n733), .Y(n731) );
  INVX1 U733 ( .A(n734), .Y(n733) );
  AOI22X1 U734 ( .A(hwdata[7]), .B(n654), .C(sample_data[7]), .D(n640), .Y(
        n723) );
  OAI21X1 U735 ( .A(n611), .B(n735), .C(n736), .Y(n640) );
  NAND3X1 U736 ( .A(hsize), .B(n610), .C(n737), .Y(n736) );
  OAI21X1 U737 ( .A(n738), .B(n728), .C(n739), .Y(n654) );
  INVX1 U738 ( .A(hrdata[7]), .Y(n705) );
  MUX2X1 U739 ( .B(n740), .A(n741), .S(n630), .Y(n584) );
  NOR2X1 U740 ( .A(n742), .B(n743), .Y(n741) );
  NAND2X1 U741 ( .A(n744), .B(n745), .Y(n743) );
  AOI22X1 U742 ( .A(hrdata[8]), .B(n607), .C(hwdata[8]), .D(n746), .Y(n745) );
  AOI22X1 U743 ( .A(f1[8]), .B(n747), .C(f0[8]), .D(n748), .Y(n744) );
  NAND2X1 U744 ( .A(n749), .B(n750), .Y(n742) );
  AOI21X1 U745 ( .A(f2[8]), .B(n751), .C(n752), .Y(n750) );
  OAI21X1 U746 ( .A(n753), .B(n754), .C(n755), .Y(n752) );
  NAND3X1 U747 ( .A(err), .B(n647), .C(n756), .Y(n755) );
  NOR2X1 U748 ( .A(haddr[1]), .B(n757), .Y(n756) );
  INVX1 U749 ( .A(n618), .Y(n647) );
  INVX1 U750 ( .A(n758), .Y(n753) );
  AOI22X1 U751 ( .A(sample_data[8]), .B(n759), .C(fir_out[8]), .D(n760), .Y(
        n749) );
  INVX1 U752 ( .A(hrdata[8]), .Y(n740) );
  OAI21X1 U753 ( .A(n599), .B(n761), .C(n762), .Y(n583) );
  OAI21X1 U754 ( .A(n763), .B(n764), .C(n630), .Y(n762) );
  OAI21X1 U755 ( .A(n765), .B(n766), .C(n767), .Y(n764) );
  AOI22X1 U756 ( .A(hwdata[9]), .B(n746), .C(f1[9]), .D(n747), .Y(n767) );
  NAND2X1 U757 ( .A(n768), .B(n769), .Y(n763) );
  AOI22X1 U758 ( .A(f3[9]), .B(n758), .C(f2[9]), .D(n751), .Y(n769) );
  AOI22X1 U759 ( .A(sample_data[9]), .B(n759), .C(fir_out[9]), .D(n760), .Y(
        n768) );
  INVX1 U760 ( .A(hrdata[9]), .Y(n761) );
  OAI21X1 U761 ( .A(n599), .B(n770), .C(n771), .Y(n582) );
  OAI21X1 U762 ( .A(n772), .B(n773), .C(n630), .Y(n771) );
  OAI21X1 U763 ( .A(n765), .B(n774), .C(n775), .Y(n773) );
  AOI22X1 U764 ( .A(hwdata[10]), .B(n746), .C(f1[10]), .D(n747), .Y(n775) );
  NAND2X1 U765 ( .A(n776), .B(n777), .Y(n772) );
  AOI22X1 U766 ( .A(f3[10]), .B(n758), .C(f2[10]), .D(n751), .Y(n777) );
  AOI22X1 U767 ( .A(sample_data[10]), .B(n759), .C(fir_out[10]), .D(n760), .Y(
        n776) );
  INVX1 U768 ( .A(hrdata[10]), .Y(n770) );
  OAI21X1 U769 ( .A(n599), .B(n778), .C(n779), .Y(n581) );
  OAI21X1 U770 ( .A(n780), .B(n781), .C(n630), .Y(n779) );
  OAI21X1 U771 ( .A(n765), .B(n782), .C(n783), .Y(n781) );
  AOI22X1 U772 ( .A(hwdata[11]), .B(n746), .C(f1[11]), .D(n747), .Y(n783) );
  NAND2X1 U773 ( .A(n784), .B(n785), .Y(n780) );
  AOI22X1 U774 ( .A(f3[11]), .B(n758), .C(f2[11]), .D(n751), .Y(n785) );
  AOI22X1 U775 ( .A(sample_data[11]), .B(n759), .C(fir_out[11]), .D(n760), .Y(
        n784) );
  INVX1 U776 ( .A(hrdata[11]), .Y(n778) );
  OAI21X1 U777 ( .A(n599), .B(n786), .C(n787), .Y(n580) );
  OAI21X1 U778 ( .A(n788), .B(n789), .C(n630), .Y(n787) );
  OAI21X1 U779 ( .A(n765), .B(n790), .C(n791), .Y(n789) );
  AOI22X1 U780 ( .A(hwdata[12]), .B(n746), .C(f1[12]), .D(n747), .Y(n791) );
  NAND2X1 U781 ( .A(n792), .B(n793), .Y(n788) );
  AOI22X1 U782 ( .A(f3[12]), .B(n758), .C(f2[12]), .D(n751), .Y(n793) );
  AOI22X1 U783 ( .A(sample_data[12]), .B(n759), .C(fir_out[12]), .D(n760), .Y(
        n792) );
  INVX1 U784 ( .A(hrdata[12]), .Y(n786) );
  OAI21X1 U785 ( .A(n599), .B(n794), .C(n795), .Y(n579) );
  OAI21X1 U786 ( .A(n796), .B(n797), .C(n630), .Y(n795) );
  OAI21X1 U787 ( .A(n765), .B(n798), .C(n799), .Y(n797) );
  AOI22X1 U788 ( .A(hwdata[13]), .B(n746), .C(f1[13]), .D(n747), .Y(n799) );
  NAND2X1 U789 ( .A(n800), .B(n801), .Y(n796) );
  AOI22X1 U790 ( .A(f3[13]), .B(n758), .C(f2[13]), .D(n751), .Y(n801) );
  AOI22X1 U791 ( .A(sample_data[13]), .B(n759), .C(fir_out[13]), .D(n760), .Y(
        n800) );
  INVX1 U792 ( .A(hrdata[13]), .Y(n794) );
  OAI21X1 U793 ( .A(n599), .B(n802), .C(n803), .Y(n578) );
  OAI21X1 U794 ( .A(n804), .B(n805), .C(n630), .Y(n803) );
  OAI21X1 U795 ( .A(n765), .B(n806), .C(n807), .Y(n805) );
  AOI22X1 U796 ( .A(hwdata[14]), .B(n746), .C(f1[14]), .D(n747), .Y(n807) );
  NAND2X1 U797 ( .A(n808), .B(n809), .Y(n804) );
  AOI22X1 U798 ( .A(f3[14]), .B(n758), .C(f2[14]), .D(n751), .Y(n809) );
  AOI22X1 U799 ( .A(sample_data[14]), .B(n759), .C(fir_out[14]), .D(n760), .Y(
        n808) );
  INVX1 U800 ( .A(hrdata[14]), .Y(n802) );
  OAI21X1 U801 ( .A(n599), .B(n810), .C(n811), .Y(n577) );
  OAI21X1 U802 ( .A(n812), .B(n813), .C(n630), .Y(n811) );
  INVX1 U803 ( .A(n814), .Y(n630) );
  OAI21X1 U804 ( .A(n765), .B(n815), .C(n816), .Y(n813) );
  AOI22X1 U805 ( .A(hwdata[15]), .B(n746), .C(f1[15]), .D(n747), .Y(n816) );
  OAI21X1 U806 ( .A(n817), .B(n716), .C(n818), .Y(n747) );
  NAND3X1 U807 ( .A(hsize), .B(n819), .C(n820), .Y(n818) );
  INVX1 U808 ( .A(n712), .Y(n820) );
  OAI21X1 U809 ( .A(n739), .B(n728), .C(n738), .Y(n746) );
  NOR2X1 U810 ( .A(n821), .B(n822), .Y(n738) );
  OAI22X1 U811 ( .A(n720), .B(n722), .C(n714), .D(n716), .Y(n822) );
  NAND3X1 U812 ( .A(haddr[0]), .B(n603), .C(n823), .Y(n716) );
  OAI21X1 U813 ( .A(n734), .B(n732), .C(n824), .Y(n821) );
  AOI22X1 U814 ( .A(n825), .B(n826), .C(n737), .D(n827), .Y(n824) );
  INVX1 U815 ( .A(n828), .Y(n737) );
  NOR2X1 U816 ( .A(n829), .B(n830), .Y(n739) );
  OAI22X1 U817 ( .A(n718), .B(n831), .C(n712), .D(n819), .Y(n830) );
  NAND3X1 U818 ( .A(n605), .B(n603), .C(n823), .Y(n712) );
  OAI21X1 U819 ( .A(n730), .B(n832), .C(n833), .Y(n829) );
  AOI22X1 U820 ( .A(n611), .B(n834), .C(n725), .D(n835), .Y(n833) );
  INVX1 U821 ( .A(n748), .Y(n765) );
  OAI21X1 U822 ( .A(n836), .B(n722), .C(n837), .Y(n748) );
  NAND3X1 U823 ( .A(hsize), .B(n831), .C(n838), .Y(n837) );
  INVX1 U824 ( .A(n718), .Y(n838) );
  NAND3X1 U825 ( .A(haddr[1]), .B(n605), .C(n839), .Y(n718) );
  NAND3X1 U826 ( .A(haddr[0]), .B(haddr[1]), .C(n839), .Y(n722) );
  NAND2X1 U827 ( .A(n840), .B(n841), .Y(n812) );
  AOI22X1 U828 ( .A(f3[15]), .B(n758), .C(f2[15]), .D(n751), .Y(n841) );
  OAI21X1 U829 ( .A(n727), .B(n728), .C(n842), .Y(n751) );
  INVX1 U830 ( .A(n843), .Y(n727) );
  OAI21X1 U831 ( .A(n725), .B(n726), .C(n842), .Y(n843) );
  NAND2X1 U832 ( .A(n826), .B(n844), .Y(n842) );
  INVX1 U833 ( .A(n835), .Y(n726) );
  NOR2X1 U834 ( .A(n845), .B(haddr[2]), .Y(n835) );
  OAI21X1 U835 ( .A(n846), .B(n734), .C(n847), .Y(n758) );
  NAND3X1 U836 ( .A(hsize), .B(n832), .C(n848), .Y(n847) );
  INVX1 U837 ( .A(n730), .Y(n848) );
  NAND3X1 U838 ( .A(haddr[2]), .B(n605), .C(n823), .Y(n730) );
  NAND3X1 U839 ( .A(haddr[0]), .B(haddr[2]), .C(n823), .Y(n734) );
  NOR2X1 U840 ( .A(n602), .B(haddr[1]), .Y(n823) );
  AOI22X1 U841 ( .A(sample_data[15]), .B(n759), .C(fir_out[15]), .D(n760), .Y(
        n840) );
  NOR3X1 U842 ( .A(n604), .B(n757), .C(n618), .Y(n760) );
  NOR2X1 U843 ( .A(hsize), .B(haddr[0]), .Y(n757) );
  OAI21X1 U844 ( .A(n827), .B(n828), .C(n849), .Y(n759) );
  NAND3X1 U845 ( .A(hsize), .B(n850), .C(n834), .Y(n849) );
  INVX1 U846 ( .A(n735), .Y(n834) );
  NAND3X1 U847 ( .A(n605), .B(n604), .C(n839), .Y(n735) );
  NAND3X1 U848 ( .A(haddr[0]), .B(n604), .C(n839), .Y(n828) );
  NOR2X1 U849 ( .A(n603), .B(haddr[3]), .Y(n839) );
  INVX1 U850 ( .A(haddr[1]), .Y(n604) );
  INVX1 U851 ( .A(hrdata[15]), .Y(n810) );
  NOR2X1 U852 ( .A(n814), .B(n607), .Y(n655) );
  NAND3X1 U853 ( .A(n615), .B(n851), .C(n617), .Y(n814) );
  MUX2X1 U854 ( .B(n852), .A(n709), .S(n621), .Y(n188) );
  INVX1 U855 ( .A(f0[7]), .Y(n709) );
  INVX1 U856 ( .A(hwdata[7]), .Y(n852) );
  MUX2X1 U857 ( .B(n853), .A(n701), .S(n621), .Y(n187) );
  INVX1 U858 ( .A(f0[6]), .Y(n701) );
  INVX1 U859 ( .A(hwdata[6]), .Y(n853) );
  MUX2X1 U860 ( .B(n854), .A(n693), .S(n621), .Y(n186) );
  INVX1 U861 ( .A(f0[5]), .Y(n693) );
  INVX1 U862 ( .A(hwdata[5]), .Y(n854) );
  MUX2X1 U863 ( .B(n855), .A(n685), .S(n621), .Y(n185) );
  INVX1 U864 ( .A(f0[4]), .Y(n685) );
  INVX1 U865 ( .A(hwdata[4]), .Y(n855) );
  MUX2X1 U866 ( .B(n856), .A(n677), .S(n621), .Y(n184) );
  INVX1 U867 ( .A(f0[3]), .Y(n677) );
  INVX1 U868 ( .A(hwdata[3]), .Y(n856) );
  MUX2X1 U869 ( .B(n857), .A(n669), .S(n621), .Y(n183) );
  INVX1 U870 ( .A(f0[2]), .Y(n669) );
  INVX1 U871 ( .A(hwdata[2]), .Y(n857) );
  MUX2X1 U872 ( .B(n858), .A(n661), .S(n621), .Y(n182) );
  MUX2X1 U873 ( .B(size), .A(n717), .S(n720), .Y(n621) );
  INVX1 U874 ( .A(n831), .Y(n717) );
  INVX1 U875 ( .A(f0[1]), .Y(n661) );
  INVX1 U876 ( .A(hwdata[1]), .Y(n858) );
  MUX2X1 U877 ( .B(n859), .A(n815), .S(n860), .Y(n180) );
  INVX1 U878 ( .A(f0[15]), .Y(n815) );
  INVX1 U879 ( .A(hwdata[15]), .Y(n859) );
  MUX2X1 U880 ( .B(n861), .A(n806), .S(n860), .Y(n179) );
  INVX1 U881 ( .A(f0[14]), .Y(n806) );
  INVX1 U882 ( .A(hwdata[14]), .Y(n861) );
  MUX2X1 U883 ( .B(n862), .A(n798), .S(n860), .Y(n178) );
  INVX1 U884 ( .A(f0[13]), .Y(n798) );
  INVX1 U885 ( .A(hwdata[13]), .Y(n862) );
  MUX2X1 U886 ( .B(n863), .A(n790), .S(n860), .Y(n177) );
  INVX1 U887 ( .A(f0[12]), .Y(n790) );
  INVX1 U888 ( .A(hwdata[12]), .Y(n863) );
  MUX2X1 U889 ( .B(n864), .A(n782), .S(n860), .Y(n176) );
  INVX1 U890 ( .A(f0[11]), .Y(n782) );
  INVX1 U891 ( .A(hwdata[11]), .Y(n864) );
  MUX2X1 U892 ( .B(n865), .A(n774), .S(n860), .Y(n175) );
  INVX1 U893 ( .A(f0[10]), .Y(n774) );
  INVX1 U894 ( .A(hwdata[10]), .Y(n865) );
  MUX2X1 U895 ( .B(n866), .A(n766), .S(n860), .Y(n174) );
  INVX1 U896 ( .A(f0[9]), .Y(n766) );
  INVX1 U897 ( .A(hwdata[9]), .Y(n866) );
  MUX2X1 U898 ( .B(n867), .A(n868), .S(n860), .Y(n173) );
  MUX2X1 U899 ( .B(size), .A(n836), .S(n831), .Y(n860) );
  NAND3X1 U900 ( .A(write_select[1]), .B(n869), .C(n870), .Y(n831) );
  INVX1 U901 ( .A(n720), .Y(n836) );
  NAND3X1 U902 ( .A(n870), .B(write_select[1]), .C(write_select[0]), .Y(n720)
         );
  INVX1 U903 ( .A(f0[8]), .Y(n868) );
  INVX1 U904 ( .A(n871), .Y(n171) );
  MUX2X1 U905 ( .B(hwdata[7]), .A(f1[7]), .S(n623), .Y(n871) );
  INVX1 U906 ( .A(n872), .Y(n170) );
  MUX2X1 U907 ( .B(hwdata[6]), .A(f1[6]), .S(n623), .Y(n872) );
  INVX1 U908 ( .A(n873), .Y(n169) );
  MUX2X1 U909 ( .B(hwdata[5]), .A(f1[5]), .S(n623), .Y(n873) );
  INVX1 U910 ( .A(n874), .Y(n168) );
  MUX2X1 U911 ( .B(hwdata[4]), .A(f1[4]), .S(n623), .Y(n874) );
  INVX1 U912 ( .A(n875), .Y(n167) );
  MUX2X1 U913 ( .B(hwdata[3]), .A(f1[3]), .S(n623), .Y(n875) );
  INVX1 U914 ( .A(n876), .Y(n166) );
  MUX2X1 U915 ( .B(hwdata[2]), .A(f1[2]), .S(n623), .Y(n876) );
  INVX1 U916 ( .A(n877), .Y(n165) );
  MUX2X1 U917 ( .B(hwdata[1]), .A(f1[1]), .S(n623), .Y(n877) );
  MUX2X1 U918 ( .B(size), .A(n711), .S(n714), .Y(n623) );
  INVX1 U919 ( .A(n819), .Y(n711) );
  INVX1 U920 ( .A(n878), .Y(n163) );
  MUX2X1 U921 ( .B(hwdata[15]), .A(f1[15]), .S(n879), .Y(n878) );
  INVX1 U922 ( .A(n880), .Y(n162) );
  MUX2X1 U923 ( .B(hwdata[14]), .A(f1[14]), .S(n879), .Y(n880) );
  INVX1 U924 ( .A(n881), .Y(n161) );
  MUX2X1 U925 ( .B(hwdata[13]), .A(f1[13]), .S(n879), .Y(n881) );
  INVX1 U926 ( .A(n882), .Y(n160) );
  MUX2X1 U927 ( .B(hwdata[12]), .A(f1[12]), .S(n879), .Y(n882) );
  INVX1 U928 ( .A(n883), .Y(n159) );
  MUX2X1 U929 ( .B(hwdata[11]), .A(f1[11]), .S(n879), .Y(n883) );
  INVX1 U930 ( .A(n884), .Y(n158) );
  MUX2X1 U931 ( .B(hwdata[10]), .A(f1[10]), .S(n879), .Y(n884) );
  INVX1 U932 ( .A(n885), .Y(n157) );
  MUX2X1 U933 ( .B(hwdata[9]), .A(f1[9]), .S(n879), .Y(n885) );
  MUX2X1 U934 ( .B(n867), .A(n886), .S(n879), .Y(n156) );
  MUX2X1 U935 ( .B(size), .A(n817), .S(n819), .Y(n879) );
  NAND3X1 U936 ( .A(n869), .B(n652), .C(n887), .Y(n819) );
  INVX1 U937 ( .A(n714), .Y(n817) );
  NAND3X1 U938 ( .A(write_select[0]), .B(n652), .C(n887), .Y(n714) );
  INVX1 U939 ( .A(f1[8]), .Y(n886) );
  INVX1 U940 ( .A(n888), .Y(n154) );
  MUX2X1 U941 ( .B(hwdata[7]), .A(f2[7]), .S(n625), .Y(n888) );
  INVX1 U942 ( .A(n889), .Y(n153) );
  MUX2X1 U943 ( .B(hwdata[6]), .A(f2[6]), .S(n625), .Y(n889) );
  INVX1 U944 ( .A(n890), .Y(n152) );
  MUX2X1 U945 ( .B(hwdata[5]), .A(f2[5]), .S(n625), .Y(n890) );
  INVX1 U946 ( .A(n891), .Y(n151) );
  MUX2X1 U947 ( .B(hwdata[4]), .A(f2[4]), .S(n625), .Y(n891) );
  INVX1 U948 ( .A(n892), .Y(n150) );
  MUX2X1 U949 ( .B(hwdata[3]), .A(f2[3]), .S(n625), .Y(n892) );
  INVX1 U950 ( .A(n893), .Y(n149) );
  MUX2X1 U951 ( .B(hwdata[2]), .A(f2[2]), .S(n625), .Y(n893) );
  INVX1 U952 ( .A(n894), .Y(n148) );
  MUX2X1 U953 ( .B(hwdata[1]), .A(f2[1]), .S(n625), .Y(n894) );
  MUX2X1 U954 ( .B(size), .A(n725), .S(n844), .Y(n625) );
  INVX1 U955 ( .A(n895), .Y(n146) );
  MUX2X1 U956 ( .B(hwdata[15]), .A(f2[15]), .S(n896), .Y(n895) );
  INVX1 U957 ( .A(n897), .Y(n145) );
  MUX2X1 U958 ( .B(hwdata[14]), .A(f2[14]), .S(n896), .Y(n897) );
  INVX1 U959 ( .A(n898), .Y(n144) );
  MUX2X1 U960 ( .B(hwdata[13]), .A(f2[13]), .S(n896), .Y(n898) );
  INVX1 U961 ( .A(n899), .Y(n143) );
  MUX2X1 U962 ( .B(hwdata[12]), .A(f2[12]), .S(n896), .Y(n899) );
  INVX1 U963 ( .A(n900), .Y(n142) );
  MUX2X1 U964 ( .B(hwdata[11]), .A(f2[11]), .S(n896), .Y(n900) );
  INVX1 U965 ( .A(n901), .Y(n141) );
  MUX2X1 U966 ( .B(hwdata[10]), .A(f2[10]), .S(n896), .Y(n901) );
  INVX1 U967 ( .A(n902), .Y(n140) );
  MUX2X1 U968 ( .B(hwdata[9]), .A(f2[9]), .S(n896), .Y(n902) );
  MUX2X1 U969 ( .B(n867), .A(n903), .S(n896), .Y(n139) );
  MUX2X1 U970 ( .B(n825), .A(size), .S(n725), .Y(n896) );
  NOR2X1 U971 ( .A(n651), .B(write_select[2]), .Y(n725) );
  NAND3X1 U972 ( .A(write_select[1]), .B(n869), .C(write_select[3]), .Y(n651)
         );
  INVX1 U973 ( .A(n844), .Y(n825) );
  NAND3X1 U974 ( .A(write_select[0]), .B(write_select[3]), .C(n904), .Y(n844)
         );
  NOR2X1 U975 ( .A(write_select[2]), .B(n905), .Y(n904) );
  INVX1 U976 ( .A(f2[8]), .Y(n903) );
  INVX1 U977 ( .A(n906), .Y(n137) );
  MUX2X1 U978 ( .B(hwdata[7]), .A(f3[7]), .S(n907), .Y(n906) );
  INVX1 U979 ( .A(n908), .Y(n136) );
  MUX2X1 U980 ( .B(hwdata[6]), .A(f3[6]), .S(n907), .Y(n908) );
  INVX1 U981 ( .A(n909), .Y(n135) );
  MUX2X1 U982 ( .B(hwdata[5]), .A(f3[5]), .S(n907), .Y(n909) );
  INVX1 U983 ( .A(n910), .Y(n134) );
  MUX2X1 U984 ( .B(hwdata[4]), .A(f3[4]), .S(n907), .Y(n910) );
  INVX1 U985 ( .A(n911), .Y(n133) );
  MUX2X1 U986 ( .B(hwdata[3]), .A(f3[3]), .S(n907), .Y(n911) );
  INVX1 U987 ( .A(n912), .Y(n132) );
  MUX2X1 U988 ( .B(hwdata[2]), .A(f3[2]), .S(n907), .Y(n912) );
  INVX1 U989 ( .A(n913), .Y(n131) );
  MUX2X1 U990 ( .B(hwdata[1]), .A(f3[1]), .S(n907), .Y(n913) );
  INVX1 U991 ( .A(n914), .Y(n130) );
  MUX2X1 U992 ( .B(hwdata[0]), .A(f3[0]), .S(n907), .Y(n914) );
  MUX2X1 U993 ( .B(size), .A(n729), .S(n732), .Y(n907) );
  INVX1 U994 ( .A(n832), .Y(n729) );
  INVX1 U995 ( .A(n915), .Y(n128) );
  MUX2X1 U996 ( .B(hwdata[15]), .A(f3[15]), .S(n916), .Y(n915) );
  INVX1 U997 ( .A(n917), .Y(n127) );
  MUX2X1 U998 ( .B(hwdata[14]), .A(f3[14]), .S(n916), .Y(n917) );
  INVX1 U999 ( .A(n918), .Y(n126) );
  MUX2X1 U1000 ( .B(hwdata[13]), .A(f3[13]), .S(n916), .Y(n918) );
  INVX1 U1001 ( .A(n919), .Y(n125) );
  MUX2X1 U1002 ( .B(hwdata[12]), .A(f3[12]), .S(n916), .Y(n919) );
  INVX1 U1003 ( .A(n920), .Y(n124) );
  MUX2X1 U1004 ( .B(hwdata[11]), .A(f3[11]), .S(n916), .Y(n920) );
  INVX1 U1005 ( .A(n921), .Y(n123) );
  MUX2X1 U1006 ( .B(hwdata[10]), .A(f3[10]), .S(n916), .Y(n921) );
  INVX1 U1007 ( .A(n922), .Y(n122) );
  MUX2X1 U1008 ( .B(hwdata[9]), .A(f3[9]), .S(n916), .Y(n922) );
  MUX2X1 U1009 ( .B(n867), .A(n754), .S(n916), .Y(n121) );
  MUX2X1 U1010 ( .B(size), .A(n846), .S(n832), .Y(n916) );
  NAND3X1 U1011 ( .A(write_select[2]), .B(n869), .C(n887), .Y(n832) );
  INVX1 U1012 ( .A(n732), .Y(n846) );
  NAND3X1 U1013 ( .A(write_select[0]), .B(write_select[2]), .C(n887), .Y(n732)
         );
  AND2X1 U1014 ( .A(write_select[3]), .B(n905), .Y(n887) );
  INVX1 U1015 ( .A(f3[8]), .Y(n754) );
  INVX1 U1016 ( .A(n923), .Y(n119) );
  MUX2X1 U1017 ( .B(hwdata[7]), .A(sample_data[7]), .S(n627), .Y(n923) );
  INVX1 U1018 ( .A(n924), .Y(n118) );
  MUX2X1 U1019 ( .B(hwdata[6]), .A(sample_data[6]), .S(n627), .Y(n924) );
  INVX1 U1020 ( .A(n925), .Y(n117) );
  MUX2X1 U1021 ( .B(hwdata[5]), .A(sample_data[5]), .S(n627), .Y(n925) );
  INVX1 U1022 ( .A(n926), .Y(n116) );
  MUX2X1 U1023 ( .B(hwdata[4]), .A(sample_data[4]), .S(n627), .Y(n926) );
  INVX1 U1024 ( .A(n927), .Y(n115) );
  MUX2X1 U1025 ( .B(hwdata[3]), .A(sample_data[3]), .S(n627), .Y(n927) );
  INVX1 U1026 ( .A(n928), .Y(n114) );
  MUX2X1 U1027 ( .B(hwdata[2]), .A(sample_data[2]), .S(n627), .Y(n928) );
  INVX1 U1028 ( .A(n929), .Y(n113) );
  MUX2X1 U1029 ( .B(hwdata[1]), .A(sample_data[1]), .S(n627), .Y(n929) );
  MUX2X1 U1030 ( .B(size), .A(n611), .S(n610), .Y(n627) );
  INVX1 U1031 ( .A(n850), .Y(n611) );
  INVX1 U1032 ( .A(n930), .Y(n111) );
  MUX2X1 U1033 ( .B(hwdata[15]), .A(sample_data[15]), .S(n931), .Y(n930) );
  INVX1 U1034 ( .A(n932), .Y(n110) );
  MUX2X1 U1035 ( .B(hwdata[14]), .A(sample_data[14]), .S(n931), .Y(n932) );
  INVX1 U1036 ( .A(n933), .Y(n109) );
  MUX2X1 U1037 ( .B(hwdata[13]), .A(sample_data[13]), .S(n931), .Y(n933) );
  INVX1 U1038 ( .A(n934), .Y(n108) );
  MUX2X1 U1039 ( .B(hwdata[12]), .A(sample_data[12]), .S(n931), .Y(n934) );
  INVX1 U1040 ( .A(n935), .Y(n107) );
  MUX2X1 U1041 ( .B(hwdata[11]), .A(sample_data[11]), .S(n931), .Y(n935) );
  INVX1 U1042 ( .A(n936), .Y(n106) );
  MUX2X1 U1043 ( .B(hwdata[10]), .A(sample_data[10]), .S(n931), .Y(n936) );
  INVX1 U1044 ( .A(n937), .Y(n105) );
  MUX2X1 U1045 ( .B(hwdata[9]), .A(sample_data[9]), .S(n931), .Y(n937) );
  MUX2X1 U1046 ( .B(n867), .A(n938), .S(n931), .Y(n104) );
  MUX2X1 U1047 ( .B(size), .A(n827), .S(n850), .Y(n931) );
  NAND3X1 U1048 ( .A(n869), .B(n905), .C(n870), .Y(n850) );
  INVX1 U1049 ( .A(write_select[0]), .Y(n869) );
  INVX1 U1050 ( .A(n610), .Y(n827) );
  NAND3X1 U1051 ( .A(n870), .B(n905), .C(write_select[0]), .Y(n610) );
  INVX1 U1052 ( .A(write_select[1]), .Y(n905) );
  NOR2X1 U1053 ( .A(n652), .B(write_select[3]), .Y(n870) );
  INVX1 U1054 ( .A(write_select[2]), .Y(n652) );
  INVX1 U1055 ( .A(sample_data[8]), .Y(n938) );
  INVX1 U1056 ( .A(hwdata[8]), .Y(n867) );
  AND2X1 U1057 ( .A(n617), .B(n939), .Y(hresp) );
  OAI21X1 U1058 ( .A(n851), .B(n618), .C(n940), .Y(n939) );
  NOR2X1 U1059 ( .A(n607), .B(n941), .Y(n940) );
  INVX1 U1060 ( .A(n615), .Y(n941) );
  NAND2X1 U1061 ( .A(n826), .B(haddr[2]), .Y(n615) );
  INVX1 U1062 ( .A(n942), .Y(n826) );
  NAND3X1 U1063 ( .A(haddr[3]), .B(haddr[1]), .C(haddr[0]), .Y(n942) );
  NOR2X1 U1064 ( .A(n728), .B(n616), .Y(n607) );
  OR2X1 U1065 ( .A(n603), .B(n845), .Y(n616) );
  NAND3X1 U1066 ( .A(haddr[1]), .B(n605), .C(haddr[3]), .Y(n845) );
  INVX1 U1067 ( .A(haddr[0]), .Y(n605) );
  INVX1 U1068 ( .A(hsize), .Y(n728) );
  NAND2X1 U1069 ( .A(n603), .B(n602), .Y(n618) );
  INVX1 U1070 ( .A(haddr[3]), .Y(n602) );
  INVX1 U1071 ( .A(haddr[2]), .Y(n603) );
  INVX1 U1072 ( .A(hwrite), .Y(n851) );
  INVX1 U1073 ( .A(n943), .Y(n617) );
  NAND3X1 U1074 ( .A(hsel), .B(n944), .C(htrans[1]), .Y(n943) );
  INVX1 U1075 ( .A(htrans[0]), .Y(n944) );
  NAND2X1 U1076 ( .A(n945), .B(n946), .Y(fir_coefficient[9]) );
  AOI22X1 U1077 ( .A(n947), .B(f2[9]), .C(n948), .D(f3[9]), .Y(n946) );
  AOI22X1 U1078 ( .A(n598), .B(f0[9]), .C(n600), .D(f1[9]), .Y(n945) );
  NAND2X1 U1079 ( .A(n951), .B(n952), .Y(fir_coefficient[8]) );
  AOI22X1 U1080 ( .A(n947), .B(f2[8]), .C(n948), .D(f3[8]), .Y(n952) );
  AOI22X1 U1081 ( .A(n598), .B(f0[8]), .C(n600), .D(f1[8]), .Y(n951) );
  NAND2X1 U1082 ( .A(n953), .B(n954), .Y(fir_coefficient[7]) );
  AOI22X1 U1083 ( .A(n947), .B(f2[7]), .C(n948), .D(f3[7]), .Y(n954) );
  AOI22X1 U1084 ( .A(n598), .B(f0[7]), .C(n600), .D(f1[7]), .Y(n953) );
  NAND2X1 U1085 ( .A(n955), .B(n956), .Y(fir_coefficient[6]) );
  AOI22X1 U1086 ( .A(n947), .B(f2[6]), .C(n948), .D(f3[6]), .Y(n956) );
  AOI22X1 U1087 ( .A(n598), .B(f0[6]), .C(n600), .D(f1[6]), .Y(n955) );
  NAND2X1 U1088 ( .A(n957), .B(n958), .Y(fir_coefficient[5]) );
  AOI22X1 U1089 ( .A(n947), .B(f2[5]), .C(n948), .D(f3[5]), .Y(n958) );
  AOI22X1 U1090 ( .A(n598), .B(f0[5]), .C(n600), .D(f1[5]), .Y(n957) );
  NAND2X1 U1091 ( .A(n959), .B(n960), .Y(fir_coefficient[4]) );
  AOI22X1 U1092 ( .A(n947), .B(f2[4]), .C(n948), .D(f3[4]), .Y(n960) );
  AOI22X1 U1093 ( .A(n598), .B(f0[4]), .C(n600), .D(f1[4]), .Y(n959) );
  NAND2X1 U1094 ( .A(n961), .B(n962), .Y(fir_coefficient[3]) );
  AOI22X1 U1095 ( .A(n947), .B(f2[3]), .C(n948), .D(f3[3]), .Y(n962) );
  AOI22X1 U1096 ( .A(n598), .B(f0[3]), .C(n600), .D(f1[3]), .Y(n961) );
  NAND2X1 U1097 ( .A(n963), .B(n964), .Y(fir_coefficient[2]) );
  AOI22X1 U1098 ( .A(n947), .B(f2[2]), .C(n948), .D(f3[2]), .Y(n964) );
  AOI22X1 U1099 ( .A(n598), .B(f0[2]), .C(n600), .D(f1[2]), .Y(n963) );
  NAND2X1 U1100 ( .A(n965), .B(n966), .Y(fir_coefficient[1]) );
  AOI22X1 U1101 ( .A(n947), .B(f2[1]), .C(n948), .D(f3[1]), .Y(n966) );
  AOI22X1 U1102 ( .A(n598), .B(f0[1]), .C(n600), .D(f1[1]), .Y(n965) );
  NAND2X1 U1103 ( .A(n967), .B(n968), .Y(fir_coefficient[15]) );
  AOI22X1 U1104 ( .A(n947), .B(f2[15]), .C(n948), .D(f3[15]), .Y(n968) );
  AOI22X1 U1105 ( .A(n598), .B(f0[15]), .C(n600), .D(f1[15]), .Y(n967) );
  NAND2X1 U1106 ( .A(n969), .B(n970), .Y(fir_coefficient[14]) );
  AOI22X1 U1107 ( .A(n947), .B(f2[14]), .C(n948), .D(f3[14]), .Y(n970) );
  AOI22X1 U1108 ( .A(n598), .B(f0[14]), .C(n600), .D(f1[14]), .Y(n969) );
  NAND2X1 U1109 ( .A(n971), .B(n972), .Y(fir_coefficient[13]) );
  AOI22X1 U1110 ( .A(n947), .B(f2[13]), .C(n948), .D(f3[13]), .Y(n972) );
  AOI22X1 U1111 ( .A(n598), .B(f0[13]), .C(n600), .D(f1[13]), .Y(n971) );
  NAND2X1 U1112 ( .A(n973), .B(n974), .Y(fir_coefficient[12]) );
  AOI22X1 U1113 ( .A(n947), .B(f2[12]), .C(n948), .D(f3[12]), .Y(n974) );
  AOI22X1 U1114 ( .A(n598), .B(f0[12]), .C(n600), .D(f1[12]), .Y(n973) );
  NAND2X1 U1115 ( .A(n975), .B(n976), .Y(fir_coefficient[11]) );
  AOI22X1 U1116 ( .A(n947), .B(f2[11]), .C(n948), .D(f3[11]), .Y(n976) );
  AOI22X1 U1117 ( .A(n598), .B(f0[11]), .C(n600), .D(f1[11]), .Y(n975) );
  NAND2X1 U1118 ( .A(n977), .B(n978), .Y(fir_coefficient[10]) );
  AOI22X1 U1119 ( .A(n947), .B(f2[10]), .C(n948), .D(f3[10]), .Y(n978) );
  AOI22X1 U1120 ( .A(n598), .B(f0[10]), .C(n600), .D(f1[10]), .Y(n977) );
  NAND2X1 U1121 ( .A(n979), .B(n980), .Y(fir_coefficient[0]) );
  AOI22X1 U1122 ( .A(n947), .B(f2[0]), .C(n948), .D(f3[0]), .Y(n980) );
  AOI22X1 U1123 ( .A(n598), .B(f0[0]), .C(n600), .D(f1[0]), .Y(n979) );
  NOR2X1 U1124 ( .A(n981), .B(coefficient_num[1]), .Y(n950) );
  INVX1 U1125 ( .A(coefficient_num[0]), .Y(n981) );
  NOR2X1 U1126 ( .A(coefficient_num[0]), .B(coefficient_num[1]), .Y(n949) );
endmodule

