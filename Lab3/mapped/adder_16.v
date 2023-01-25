/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Jan 25 09:44:53 2023
/////////////////////////////////////////////////////////////


module adder_16_DW01_add_1 ( A, B, CI, SUM, CO );
  input [16:0] A;
  input [16:0] B;
  output [16:0] SUM;
  input CI;
  output CO;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n18, n19, n29, n30, n31, n32, n34, n35, n36, n37, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n50, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n77, n78, n84, n85,
         n86, n87, n89, n90, n95, n96, n98, n107, n109, n111, n112, n115,
         net361, n51, n49, n48, n38, n33, n28, n27, n25, n23, n105, net574,
         net686, net673, net672, net671, net659, net644, net640, net639,
         net617, net823, net808, net780, net969, net949, net948, net1126,
         net1116, net1115, net1112, net1110, net1109, net1095, net1072,
         net1066, net1053, net645, net1065, net965, net959, net958, net670,
         n94, net904, net807, net664, net699, net660, net1132, net1107,
         net1105, net1101, net1099, n104, n1, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203;

  OAI21X1 U3 ( .A(net574), .B(n18), .C(n19), .Y(SUM[16]) );
  NOR2X1 U6 ( .A(B[15]), .B(A[15]), .Y(n18) );
  NAND2X1 U7 ( .A(B[15]), .B(A[15]), .Y(n19) );
  XOR2X1 U8 ( .A(n29), .B(n2), .Y(SUM[14]) );
  XNOR2X1 U20 ( .A(n34), .B(n3), .Y(SUM[13]) );
  AOI21X1 U21 ( .A(n30), .B(n34), .C(n31), .Y(n29) );
  NOR2X1 U26 ( .A(B[13]), .B(A[13]), .Y(n32) );
  XOR2X1 U28 ( .A(n41), .B(n4), .Y(SUM[12]) );
  OAI21X1 U29 ( .A(n46), .B(n35), .C(n36), .Y(n34) );
  NOR2X1 U32 ( .A(n39), .B(n44), .Y(n37) );
  NAND2X1 U34 ( .A(n40), .B(n107), .Y(n4) );
  NOR2X1 U36 ( .A(B[12]), .B(A[12]), .Y(n39) );
  NAND2X1 U37 ( .A(B[12]), .B(A[12]), .Y(n40) );
  XOR2X1 U38 ( .A(n46), .B(n5), .Y(SUM[11]) );
  AOI21X1 U39 ( .A(n42), .B(n47), .C(n43), .Y(n41) );
  NAND2X1 U42 ( .A(n45), .B(n42), .Y(n5) );
  NOR2X1 U44 ( .A(B[11]), .B(A[11]), .Y(n44) );
  NAND2X1 U45 ( .A(B[11]), .B(A[11]), .Y(n45) );
  XOR2X1 U46 ( .A(n54), .B(n6), .Y(SUM[10]) );
  NOR2X1 U51 ( .A(n52), .B(n57), .Y(n50) );
  NAND2X1 U53 ( .A(n53), .B(n109), .Y(n6) );
  NOR2X1 U55 ( .A(B[10]), .B(A[10]), .Y(n52) );
  NAND2X1 U56 ( .A(B[10]), .B(A[10]), .Y(n53) );
  XNOR2X1 U57 ( .A(n59), .B(n7), .Y(SUM[9]) );
  AOI21X1 U58 ( .A(n55), .B(n59), .C(n56), .Y(n54) );
  NAND2X1 U61 ( .A(n58), .B(n55), .Y(n7) );
  NOR2X1 U63 ( .A(B[9]), .B(A[9]), .Y(n57) );
  NAND2X1 U64 ( .A(B[9]), .B(A[9]), .Y(n58) );
  XNOR2X1 U65 ( .A(n66), .B(n8), .Y(SUM[8]) );
  OAI21X1 U66 ( .A(n69), .B(n60), .C(n61), .Y(n59) );
  NOR2X1 U69 ( .A(n64), .B(n67), .Y(n62) );
  OAI21X1 U70 ( .A(n64), .B(n68), .C(n65), .Y(n63) );
  NAND2X1 U71 ( .A(n65), .B(n111), .Y(n8) );
  NOR2X1 U73 ( .A(B[8]), .B(A[8]), .Y(n64) );
  NAND2X1 U74 ( .A(B[8]), .B(A[8]), .Y(n65) );
  XOR2X1 U75 ( .A(n69), .B(n9), .Y(SUM[7]) );
  OAI21X1 U76 ( .A(n69), .B(n67), .C(n68), .Y(n66) );
  NAND2X1 U77 ( .A(n68), .B(n112), .Y(n9) );
  NOR2X1 U79 ( .A(B[7]), .B(A[7]), .Y(n67) );
  NAND2X1 U80 ( .A(B[7]), .B(A[7]), .Y(n68) );
  XNOR2X1 U81 ( .A(n77), .B(n10), .Y(SUM[6]) );
  XOR2X1 U92 ( .A(n177), .B(n11), .Y(SUM[5]) );
  NOR2X1 U96 ( .A(B[5]), .B(A[5]), .Y(n78) );
  XOR2X1 U98 ( .A(n85), .B(n12), .Y(SUM[4]) );
  XNOR2X1 U106 ( .A(n90), .B(n13), .Y(SUM[3]) );
  XNOR2X1 U114 ( .A(n96), .B(n14), .Y(SUM[2]) );
  XOR2X1 U123 ( .A(net969), .B(n15), .Y(SUM[1]) );
  NAND2X1 U132 ( .A(n182), .B(net361), .Y(n16) );
  NAND2X1 U49 ( .A(n50), .B(n62), .Y(n48) );
  NAND2X1 U16 ( .A(n28), .B(n105), .Y(n2) );
  NAND2X1 U19 ( .A(B[14]), .B(A[14]), .Y(n28) );
  NAND2X1 U24 ( .A(n33), .B(n30), .Y(n3) );
  NAND2X1 U27 ( .A(B[13]), .B(A[13]), .Y(n33) );
  NOR2X1 U18 ( .A(B[14]), .B(A[14]), .Y(n27) );
  NOR2X1 U14 ( .A(n27), .B(n32), .Y(n25) );
  OAI21X1 U33 ( .A(n39), .B(n45), .C(n40), .Y(n38) );
  OAI21X1 U52 ( .A(n52), .B(n58), .C(n53), .Y(n51) );
  OAI21X1 U48 ( .A(n69), .B(n48), .C(n49), .Y(n47) );
  AOI21X1 U50 ( .A(n63), .B(n50), .C(n51), .Y(n49) );
  NAND2X1 U12 ( .A(n25), .B(n37), .Y(n23) );
  NAND2X1 U102 ( .A(n84), .B(n115), .Y(n12) );
  AOI21X1 U107 ( .A(n86), .B(n90), .C(n87), .Y(n85) );
  NAND2X1 U4 ( .A(n19), .B(n104), .Y(n1) );
  AND2X2 U140 ( .A(n181), .B(n179), .Y(n177) );
  AND2X2 U141 ( .A(n189), .B(n190), .Y(n178) );
  OR2X2 U142 ( .A(net969), .B(net808), .Y(n179) );
  NOR2X1 U143 ( .A(n23), .B(n49), .Y(n180) );
  AND2X2 U144 ( .A(net958), .B(net959), .Y(n181) );
  NAND2X1 U145 ( .A(B[0]), .B(A[0]), .Y(n182) );
  INVX1 U146 ( .A(net959), .Y(n183) );
  NAND2X1 U147 ( .A(net904), .B(net1132), .Y(n184) );
  NOR2X1 U148 ( .A(n183), .B(net1101), .Y(n185) );
  NAND2X1 U149 ( .A(n184), .B(n185), .Y(n186) );
  AOI22X1 U150 ( .A(net1107), .B(net1065), .C(n178), .D(n186), .Y(net1105) );
  XOR2X1 U151 ( .A(net1105), .B(n1), .Y(SUM[15]) );
  INVX2 U152 ( .A(n18), .Y(n104) );
  NAND2X1 U153 ( .A(n194), .B(n193), .Y(net1107) );
  NOR2X1 U154 ( .A(n190), .B(n192), .Y(n193) );
  NAND2X1 U155 ( .A(net948), .B(net949), .Y(n192) );
  NOR2X1 U156 ( .A(n190), .B(net1109), .Y(net1110) );
  NOR2X1 U157 ( .A(n180), .B(n188), .Y(n194) );
  INVX2 U158 ( .A(n28), .Y(n188) );
  NOR2X1 U159 ( .A(n180), .B(n188), .Y(net1112) );
  AOI21X1 U160 ( .A(n178), .B(net644), .C(net645), .Y(net574) );
  NOR2X1 U161 ( .A(n23), .B(n48), .Y(n190) );
  AND2X2 U162 ( .A(net659), .B(net660), .Y(n189) );
  INVX2 U163 ( .A(n78), .Y(net660) );
  NAND2X1 U164 ( .A(net660), .B(net659), .Y(net1053) );
  AND2X2 U165 ( .A(net807), .B(n191), .Y(net1132) );
  NOR2X1 U166 ( .A(net664), .B(n187), .Y(n191) );
  INVX2 U167 ( .A(net780), .Y(n187) );
  NOR2X1 U168 ( .A(net664), .B(net1099), .Y(net1101) );
  INVX2 U169 ( .A(net670), .Y(net1099) );
  OAI21X1 U170 ( .A(A[0]), .B(B[0]), .C(CI), .Y(n195) );
  NAND2X1 U171 ( .A(net699), .B(n195), .Y(net904) );
  OR2X1 U172 ( .A(A[0]), .B(B[0]), .Y(net361) );
  NAND2X1 U173 ( .A(B[0]), .B(A[0]), .Y(net699) );
  XNOR2X1 U174 ( .A(CI), .B(n16), .Y(SUM[0]) );
  INVX1 U175 ( .A(net904), .Y(net969) );
  OR2X1 U176 ( .A(B[2]), .B(A[2]), .Y(net807) );
  INVX2 U177 ( .A(net807), .Y(n94) );
  NAND3X1 U178 ( .A(net807), .B(net780), .C(net823), .Y(net640) );
  NAND2X1 U179 ( .A(n86), .B(n115), .Y(net664) );
  OR2X1 U180 ( .A(net1099), .B(net664), .Y(net958) );
  NOR2X1 U181 ( .A(net664), .B(n94), .Y(net1072) );
  OR2X1 U182 ( .A(B[1]), .B(A[1]), .Y(net780) );
  NAND2X1 U183 ( .A(B[2]), .B(A[2]), .Y(n95) );
  NAND2X1 U184 ( .A(n89), .B(n86), .Y(n13) );
  NAND2X1 U185 ( .A(n115), .B(net965), .Y(net959) );
  NAND2X1 U186 ( .A(B[1]), .B(A[1]), .Y(n98) );
  NAND2X1 U187 ( .A(n84), .B(n89), .Y(net965) );
  OAI21X1 U188 ( .A(n98), .B(n94), .C(n95), .Y(net670) );
  OR2X1 U189 ( .A(n94), .B(net617), .Y(n14) );
  OR2X1 U190 ( .A(n98), .B(n94), .Y(net639) );
  NAND3X1 U191 ( .A(net1116), .B(net1126), .C(net1115), .Y(net1065) );
  AND2X2 U192 ( .A(net1065), .B(net1066), .Y(net645) );
  OAI21X1 U193 ( .A(n177), .B(net1053), .C(net671), .Y(net686) );
  NAND2X1 U194 ( .A(net1072), .B(net780), .Y(net808) );
  INVX2 U195 ( .A(net948), .Y(net1095) );
  NAND2X1 U196 ( .A(net948), .B(net949), .Y(net1109) );
  NAND2X1 U197 ( .A(net949), .B(net673), .Y(n196) );
  NOR2X1 U198 ( .A(net1095), .B(n196), .Y(net1115) );
  AND2X2 U199 ( .A(n28), .B(net672), .Y(net1116) );
  NAND2X1 U200 ( .A(net1112), .B(net1110), .Y(net1066) );
  OR2X1 U201 ( .A(n23), .B(n49), .Y(net1126) );
  NAND2X1 U202 ( .A(n38), .B(n25), .Y(net948) );
  OR2X1 U203 ( .A(n27), .B(n33), .Y(net949) );
  INVX2 U204 ( .A(net969), .Y(net823) );
  NAND2X1 U205 ( .A(B[4]), .B(A[4]), .Y(n84) );
  NAND2X1 U206 ( .A(B[3]), .B(A[3]), .Y(n89) );
  AOI21X1 U207 ( .A(n98), .B(net969), .C(n187), .Y(n96) );
  NAND2X1 U208 ( .A(n98), .B(net780), .Y(n15) );
  NAND2X1 U209 ( .A(n197), .B(n198), .Y(n115) );
  NAND2X1 U210 ( .A(n199), .B(n200), .Y(n86) );
  INVX2 U211 ( .A(A[3]), .Y(n200) );
  INVX2 U212 ( .A(B[3]), .Y(n199) );
  INVX2 U213 ( .A(A[4]), .Y(n197) );
  INVX2 U214 ( .A(B[4]), .Y(n198) );
  INVX2 U215 ( .A(n89), .Y(n87) );
  NAND2X1 U216 ( .A(net660), .B(n201), .Y(n11) );
  OAI21X1 U217 ( .A(n177), .B(n78), .C(n202), .Y(n77) );
  NAND3X1 U218 ( .A(n95), .B(net639), .C(net640), .Y(n90) );
  INVX2 U219 ( .A(n95), .Y(net617) );
  NAND2X1 U220 ( .A(B[5]), .B(A[5]), .Y(n202) );
  XNOR2X1 U221 ( .A(B[6]), .B(A[6]), .Y(n10) );
  AND2X2 U222 ( .A(net672), .B(net673), .Y(net671) );
  INVX2 U223 ( .A(n202), .Y(n203) );
  OR2X1 U224 ( .A(A[6]), .B(B[6]), .Y(net659) );
  NAND2X1 U225 ( .A(B[6]), .B(A[6]), .Y(net673) );
  INVX2 U226 ( .A(net686), .Y(n69) );
  NAND2X1 U227 ( .A(B[5]), .B(A[5]), .Y(n201) );
  NAND2X1 U228 ( .A(n203), .B(net659), .Y(net672) );
  NAND2X1 U229 ( .A(n181), .B(n179), .Y(net644) );
  INVX2 U230 ( .A(n38), .Y(n36) );
  INVX2 U231 ( .A(n27), .Y(n105) );
  INVX2 U232 ( .A(n33), .Y(n31) );
  INVX2 U233 ( .A(n63), .Y(n61) );
  INVX2 U234 ( .A(n62), .Y(n60) );
  INVX2 U235 ( .A(n58), .Y(n56) );
  INVX2 U236 ( .A(n47), .Y(n46) );
  INVX2 U237 ( .A(n45), .Y(n43) );
  INVX2 U238 ( .A(n37), .Y(n35) );
  INVX2 U239 ( .A(n67), .Y(n112) );
  INVX2 U240 ( .A(n64), .Y(n111) );
  INVX2 U241 ( .A(n57), .Y(n55) );
  INVX2 U242 ( .A(n52), .Y(n109) );
  INVX2 U243 ( .A(n44), .Y(n42) );
  INVX2 U244 ( .A(n39), .Y(n107) );
  INVX2 U245 ( .A(n32), .Y(n30) );
endmodule


module adder_16 ( a, b, carry_in, sum, overflow );
  input [15:0] a;
  input [15:0] b;
  output [15:0] sum;
  input carry_in;
  output overflow;


  adder_16_DW01_add_1 r304 ( .A({1'b0, a}), .B({1'b0, b}), .CI(carry_in), 
        .SUM({overflow, sum}) );
endmodule

