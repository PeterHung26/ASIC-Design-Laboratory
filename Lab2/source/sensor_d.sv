// $Id: $
// File name:   sensor_d.sv
// Created:     1/19/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Dataflow Style Sensor Error Detector.

module sensor_d
(
    input wire [3:0] sensors,
    output wire error
);

    wire tmp1;
    wire tmp2;
    wire tmp3;
    assign tmp1 = sensors[0];
    assign tmp2 = sensors[1] & sensors[2];
    assign tmp3 = sensors[1] & sensors[3];
    assign error = tmp1 | tmp2 | tmp3;
endmodule