// $Id: $
// File name:   sensor_s.sv
// Created:     1/18/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Structural Style Sensor Error Detector.

module sensor_s
(
    input wire [3:0] sensors,
    output wire error
);
    wire tmp1;
    wire tmp2;
    wire tmp3;
    wire tmp4;
    assign tmp1 = sensors[0];
    AND2X1 A1 (.Y(tmp2), .A(sensors[1]), .B(sensors[2]));
    AND2X1 A2 (.Y(tmp3), .A(sensors[1]), .B(sensors[3]));
    OR2X1 B1 (.Y(tmp4), .A(tmp1), .B(tmp2));
    OR2X1 B2 (.Y(error), .A(tmp4), .B(tmp3));
endmodule