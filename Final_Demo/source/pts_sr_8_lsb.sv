module pts_sr_8_lsb
(
  input logic clk,
  input logic n_rst,
  input logic strobe,
  input logic strobe_middle,
  input logic [7:0] d_par,
  input logic pts_load_enable,
  input logic pts_shift_enable,
  output logic d_orig 
);

  flex_pts_sr #(
    .NUM_BITS(8),
    .SHIFT_MSB(0)
  )
  CORE(
    .clk(clk),
    .n_rst(n_rst),
    .parallel_in(d_par),
    .load_enable(pts_load_enable),
    .shift_enable(strobe),
    .serial_out(d_orig)
  );

endmodule
