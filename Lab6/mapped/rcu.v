/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Feb 18 21:39:47 2023
/////////////////////////////////////////////////////////////


module rcu ( clk, n_rst, new_packet_detected, packet_done, framing_error, 
        sbc_clear, sbc_enable, load_buffer, enable_timer );
  input clk, n_rst, new_packet_detected, packet_done, framing_error;
  output sbc_clear, sbc_enable, load_buffer, enable_timer;
  wire   n30, n31, n32, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52;
  wire   [3:0] state;

  DFFSR \state_reg[0]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[2]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  INVX1 U40 ( .A(n37), .Y(sbc_enable) );
  INVX1 U41 ( .A(n38), .Y(sbc_clear) );
  OR2X1 U42 ( .A(enable_timer), .B(n39), .Y(n32) );
  MUX2X1 U43 ( .B(n40), .A(n41), .S(state[0]), .Y(n39) );
  MUX2X1 U44 ( .B(new_packet_detected), .A(n42), .S(state[2]), .Y(n40) );
  AND2X1 U45 ( .A(packet_done), .B(n43), .Y(n42) );
  OAI21X1 U46 ( .A(framing_error), .B(n37), .C(n44), .Y(n31) );
  INVX1 U47 ( .A(n45), .Y(n44) );
  OAI21X1 U48 ( .A(n41), .B(n43), .C(n38), .Y(n45) );
  NAND3X1 U49 ( .A(n43), .B(n46), .C(state[0]), .Y(n38) );
  OAI21X1 U50 ( .A(n47), .B(n43), .C(n48), .Y(n30) );
  INVX1 U51 ( .A(n49), .Y(n48) );
  OAI22X1 U52 ( .A(n37), .B(framing_error), .C(n41), .D(n46), .Y(n49) );
  NAND2X1 U53 ( .A(n50), .B(n37), .Y(n41) );
  MUX2X1 U54 ( .B(n51), .A(n46), .S(state[0]), .Y(n50) );
  NAND3X1 U55 ( .A(state[0]), .B(n43), .C(state[2]), .Y(n37) );
  AND2X1 U56 ( .A(n47), .B(n51), .Y(load_buffer) );
  NOR2X1 U57 ( .A(n43), .B(n46), .Y(n51) );
  INVX1 U58 ( .A(state[1]), .Y(n43) );
  INVX1 U59 ( .A(n52), .Y(enable_timer) );
  NAND3X1 U60 ( .A(n47), .B(n46), .C(state[1]), .Y(n52) );
  INVX1 U61 ( .A(state[2]), .Y(n46) );
  INVX1 U62 ( .A(state[0]), .Y(n47) );
endmodule

