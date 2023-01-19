// $Id: $
// File name:   sensor_b.sv
// Created:     1/19/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Behavioral Coding of Sensor Error Detector.

module sensor_b
(
    input wire [3:0] sensors,
    output reg error
);
    reg tmp1;
    reg tmp2;
    reg tmp3;
    always_comb begin: DETECT
        tmp1 = sensors[0];
        tmp2 = sensors[1] & sensors[2];
        tmp3 = sensors[1] & sensors[3];
        error = tmp1 | tmp2 | tmp3;
    end
endmodule