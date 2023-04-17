module stp_sr_8_lsb
(
  input wire clk,
  input wire n_rst,
  input wire d_orig,
  input wire shift_enable,
  output wire [7:0] p_out 
);

  flex_stp_sr #(
    .SHIFT_MSB(0),
    .NUM_BITS(8)
    )
  CORE(
    .clk(clk),
    .n_rst(n_rst),
    .serial_in(d_orig),
    .shift_enable(shift_enable),
    .parallel_out(p_out)
  );

endmodule