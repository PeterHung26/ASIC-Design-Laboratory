/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Mar  3 12:07:06 2023
/////////////////////////////////////////////////////////////


module apb_slave ( clk, n_rst, rx_data, data_ready, overrun_error, 
        framing_error, psel, paddr, penable, pwrite, pwdata, data_read, prdata, 
        pslverr, data_size, bit_period );
  input [7:0] rx_data;
  input [2:0] paddr;
  input [7:0] pwdata;
  output [7:0] prdata;
  output [3:0] data_size;
  output [13:0] bit_period;
  input clk, n_rst, data_ready, overrun_error, framing_error, psel, penable,
         pwrite;
  output data_read, pslverr;
  wire   next_data_read, next_pslverr, n29, n30, n36, n38, n45, n46, n120,
         n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131,
         n132, n133, n134, n135, n136, n137, n138, n139, n140, n141, n142,
         n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, n153,
         n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164,
         n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208,
         n209, n210, n211, n212, n213, n214;

  DFFSR pslverr_reg ( .D(next_pslverr), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        pslverr) );
  DFFSR \bit_period_reg[13]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[13]) );
  DFFSR \bit_period_reg[12]  ( .D(n38), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[12]) );
  DFFSR \bit_period_reg[11]  ( .D(n136), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[11]) );
  DFFSR \bit_period_reg[10]  ( .D(n137), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[10]) );
  DFFSR \bit_period_reg[9]  ( .D(n138), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[9]) );
  DFFSR \bit_period_reg[8]  ( .D(n139), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[8]) );
  DFFSR \bit_period_reg[7]  ( .D(n130), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[7]) );
  DFFSR \prdata_reg[7]  ( .D(n120), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[7]) );
  DFFSR \bit_period_reg[6]  ( .D(n131), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[6]) );
  DFFSR \prdata_reg[6]  ( .D(n121), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[6]) );
  DFFSR \bit_period_reg[5]  ( .D(n45), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[5]) );
  DFFSR \prdata_reg[5]  ( .D(n29), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[5]) );
  DFFSR \bit_period_reg[4]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[4]) );
  DFFSR \prdata_reg[4]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[4]) );
  DFFSR \bit_period_reg[3]  ( .D(n132), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[3]) );
  DFFSR \bit_period_reg[2]  ( .D(n133), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[2]) );
  DFFSR \bit_period_reg[1]  ( .D(n134), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[1]) );
  DFFSR \bit_period_reg[0]  ( .D(n135), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        bit_period[0]) );
  DFFSR \data_size_reg[3]  ( .D(n126), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_size[3]) );
  DFFSR \prdata_reg[3]  ( .D(n122), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[3]) );
  DFFSR \data_size_reg[2]  ( .D(n127), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_size[2]) );
  DFFSR \prdata_reg[2]  ( .D(n123), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[2]) );
  DFFSR \data_size_reg[1]  ( .D(n128), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_size[1]) );
  DFFSR \prdata_reg[1]  ( .D(n124), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[1]) );
  DFFSR \data_size_reg[0]  ( .D(n129), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_size[0]) );
  DFFSR \prdata_reg[0]  ( .D(n125), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        prdata[0]) );
  DFFSR data_read_reg ( .D(next_data_read), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(data_read) );
  OAI21X1 U144 ( .A(n140), .B(n141), .C(n142), .Y(next_pslverr) );
  NAND3X1 U145 ( .A(paddr[2]), .B(paddr[0]), .C(psel), .Y(n142) );
  NOR2X1 U146 ( .A(n143), .B(n144), .Y(next_data_read) );
  NAND2X1 U147 ( .A(psel), .B(n145), .Y(n144) );
  MUX2X1 U148 ( .B(n146), .A(n147), .S(n148), .Y(n46) );
  MUX2X1 U149 ( .B(n149), .A(n150), .S(n148), .Y(n45) );
  MUX2X1 U150 ( .B(n151), .A(n147), .S(n152), .Y(n38) );
  INVX1 U151 ( .A(pwdata[4]), .Y(n147) );
  MUX2X1 U152 ( .B(n153), .A(n150), .S(n152), .Y(n36) );
  INVX1 U153 ( .A(pwdata[5]), .Y(n150) );
  MUX2X1 U154 ( .B(n154), .A(n155), .S(n156), .Y(n30) );
  AOI21X1 U155 ( .A(rx_data[4]), .B(n157), .C(n158), .Y(n155) );
  OAI22X1 U156 ( .A(n159), .B(n146), .C(n160), .D(n151), .Y(n158) );
  INVX1 U157 ( .A(bit_period[12]), .Y(n151) );
  INVX1 U158 ( .A(bit_period[4]), .Y(n146) );
  INVX1 U159 ( .A(prdata[4]), .Y(n154) );
  MUX2X1 U160 ( .B(n161), .A(n162), .S(n156), .Y(n29) );
  AOI21X1 U161 ( .A(rx_data[5]), .B(n157), .C(n163), .Y(n162) );
  OAI22X1 U162 ( .A(n159), .B(n149), .C(n160), .D(n153), .Y(n163) );
  INVX1 U163 ( .A(bit_period[13]), .Y(n153) );
  INVX1 U164 ( .A(bit_period[5]), .Y(n149) );
  INVX1 U165 ( .A(prdata[5]), .Y(n161) );
  MUX2X1 U166 ( .B(n164), .A(n165), .S(n152), .Y(n139) );
  MUX2X1 U167 ( .B(n166), .A(n167), .S(n152), .Y(n138) );
  INVX1 U168 ( .A(n168), .Y(n137) );
  MUX2X1 U169 ( .B(bit_period[10]), .A(pwdata[2]), .S(n152), .Y(n168) );
  INVX1 U170 ( .A(n169), .Y(n136) );
  MUX2X1 U171 ( .B(bit_period[11]), .A(pwdata[3]), .S(n152), .Y(n169) );
  AND2X1 U172 ( .A(n170), .B(n171), .Y(n152) );
  MUX2X1 U173 ( .B(n172), .A(n165), .S(n148), .Y(n135) );
  INVX1 U174 ( .A(bit_period[0]), .Y(n172) );
  MUX2X1 U175 ( .B(n173), .A(n167), .S(n148), .Y(n134) );
  INVX1 U176 ( .A(bit_period[1]), .Y(n173) );
  INVX1 U177 ( .A(n174), .Y(n133) );
  MUX2X1 U178 ( .B(bit_period[2]), .A(pwdata[2]), .S(n148), .Y(n174) );
  INVX1 U179 ( .A(n175), .Y(n132) );
  MUX2X1 U180 ( .B(bit_period[3]), .A(pwdata[3]), .S(n148), .Y(n175) );
  INVX1 U181 ( .A(n176), .Y(n131) );
  MUX2X1 U182 ( .B(bit_period[6]), .A(pwdata[6]), .S(n148), .Y(n176) );
  INVX1 U183 ( .A(n177), .Y(n130) );
  MUX2X1 U184 ( .B(bit_period[7]), .A(pwdata[7]), .S(n148), .Y(n177) );
  AND2X1 U185 ( .A(n178), .B(n171), .Y(n148) );
  MUX2X1 U186 ( .B(n179), .A(n165), .S(n180), .Y(n129) );
  INVX1 U187 ( .A(pwdata[0]), .Y(n165) );
  INVX1 U188 ( .A(data_size[0]), .Y(n179) );
  MUX2X1 U189 ( .B(n181), .A(n167), .S(n180), .Y(n128) );
  INVX1 U190 ( .A(pwdata[1]), .Y(n167) );
  INVX1 U191 ( .A(data_size[1]), .Y(n181) );
  INVX1 U192 ( .A(n182), .Y(n127) );
  MUX2X1 U193 ( .B(data_size[2]), .A(pwdata[2]), .S(n180), .Y(n182) );
  INVX1 U194 ( .A(n183), .Y(n126) );
  MUX2X1 U195 ( .B(data_size[3]), .A(pwdata[3]), .S(n180), .Y(n183) );
  NOR2X1 U196 ( .A(n184), .B(n141), .Y(n180) );
  NAND3X1 U197 ( .A(n160), .B(n159), .C(n171), .Y(n141) );
  NOR2X1 U198 ( .A(n145), .B(n185), .Y(n171) );
  INVX1 U199 ( .A(n186), .Y(n125) );
  MUX2X1 U200 ( .B(prdata[0]), .A(n187), .S(n156), .Y(n186) );
  NAND2X1 U201 ( .A(n188), .B(n189), .Y(n187) );
  AOI21X1 U202 ( .A(data_size[0]), .B(n140), .C(n190), .Y(n189) );
  OAI22X1 U203 ( .A(n160), .B(n164), .C(n191), .D(n192), .Y(n190) );
  NAND2X1 U204 ( .A(n193), .B(n194), .Y(n192) );
  MUX2X1 U205 ( .B(framing_error), .A(data_ready), .S(n195), .Y(n191) );
  INVX1 U206 ( .A(bit_period[8]), .Y(n164) );
  AOI22X1 U207 ( .A(bit_period[0]), .B(n178), .C(rx_data[0]), .D(n157), .Y(
        n188) );
  INVX1 U208 ( .A(n196), .Y(n124) );
  MUX2X1 U209 ( .B(prdata[1]), .A(n197), .S(n156), .Y(n196) );
  NAND2X1 U210 ( .A(n198), .B(n199), .Y(n197) );
  AOI21X1 U211 ( .A(data_size[1]), .B(n140), .C(n200), .Y(n199) );
  OAI21X1 U212 ( .A(n160), .B(n166), .C(n201), .Y(n200) );
  NAND3X1 U213 ( .A(paddr[0]), .B(n193), .C(overrun_error), .Y(n201) );
  INVX1 U214 ( .A(bit_period[9]), .Y(n166) );
  AOI22X1 U215 ( .A(bit_period[1]), .B(n178), .C(rx_data[1]), .D(n157), .Y(
        n198) );
  INVX1 U216 ( .A(n202), .Y(n123) );
  MUX2X1 U217 ( .B(prdata[2]), .A(n203), .S(n156), .Y(n202) );
  NAND2X1 U218 ( .A(n204), .B(n205), .Y(n203) );
  AOI22X1 U219 ( .A(bit_period[10]), .B(n170), .C(data_size[2]), .D(n140), .Y(
        n205) );
  AOI22X1 U220 ( .A(bit_period[2]), .B(n178), .C(rx_data[2]), .D(n157), .Y(
        n204) );
  INVX1 U221 ( .A(n206), .Y(n122) );
  MUX2X1 U222 ( .B(prdata[3]), .A(n207), .S(n156), .Y(n206) );
  NAND2X1 U223 ( .A(n208), .B(n209), .Y(n207) );
  AOI22X1 U224 ( .A(bit_period[11]), .B(n170), .C(data_size[3]), .D(n140), .Y(
        n209) );
  INVX1 U225 ( .A(n184), .Y(n140) );
  NAND3X1 U226 ( .A(n195), .B(n193), .C(paddr[2]), .Y(n184) );
  INVX1 U227 ( .A(paddr[1]), .Y(n193) );
  INVX1 U228 ( .A(n160), .Y(n170) );
  NAND3X1 U229 ( .A(paddr[0]), .B(n194), .C(paddr[1]), .Y(n160) );
  AOI22X1 U230 ( .A(bit_period[3]), .B(n178), .C(rx_data[3]), .D(n157), .Y(
        n208) );
  MUX2X1 U231 ( .B(n210), .A(n211), .S(n156), .Y(n121) );
  AOI22X1 U232 ( .A(bit_period[6]), .B(n178), .C(rx_data[6]), .D(n157), .Y(
        n211) );
  INVX1 U233 ( .A(prdata[6]), .Y(n210) );
  MUX2X1 U234 ( .B(n212), .A(n213), .S(n156), .Y(n120) );
  NOR2X1 U235 ( .A(n185), .B(n214), .Y(n156) );
  OAI21X1 U236 ( .A(n195), .B(n194), .C(n145), .Y(n214) );
  INVX1 U237 ( .A(pwrite), .Y(n145) );
  INVX1 U238 ( .A(psel), .Y(n185) );
  AOI22X1 U239 ( .A(bit_period[7]), .B(n178), .C(rx_data[7]), .D(n157), .Y(
        n213) );
  INVX1 U240 ( .A(n143), .Y(n157) );
  NAND3X1 U241 ( .A(paddr[2]), .B(n195), .C(paddr[1]), .Y(n143) );
  INVX1 U242 ( .A(n159), .Y(n178) );
  NAND3X1 U243 ( .A(n195), .B(n194), .C(paddr[1]), .Y(n159) );
  INVX1 U244 ( .A(paddr[2]), .Y(n194) );
  INVX1 U245 ( .A(paddr[0]), .Y(n195) );
  INVX1 U246 ( .A(prdata[7]), .Y(n212) );
endmodule

