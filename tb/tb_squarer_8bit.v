`timescale 1ns/1ps

module tb_squarer_8bit;

  reg  [7:0] a;
  wire [15:0] Y;
  wire [55:0] gpp;
  wire [127:0] gsum;

  integer i;
  integer fails;

  // expected as wire (continuous)
  wire [15:0] expected;
  assign expected = a * a;

  integer ones_gpp;
  integer ones_gsum;
  integer total_ones;

  function integer count_ones_56;
    input [55:0] bus;
    integer k;
    begin
      count_ones_56 = 0;
      for (k = 0; k < 56; k = k + 1)
        if (bus[k]) count_ones_56 = count_ones_56 + 1;
    end
  endfunction

  function integer count_ones_128;
    input [127:0] bus;
    integer k;
    begin
      count_ones_128 = 0;
      for (k = 0; k < 128; k = k + 1)
        if (bus[k]) count_ones_128 = count_ones_128 + 1;
    end
  endfunction

  squarer_8bit dut (
    .a(a),
    .Y(Y),
    .garbage_pp(gpp),
    .garbage_sum(gsum)
  );

  initial begin
    fails = 0;

    for (i = 0; i < 256; i = i + 1) begin
      a = i;
      #10;

      ones_gpp  = count_ones_56(gpp);
      ones_gsum = count_ones_128(gsum);
      total_ones = ones_gpp + ones_gsum;

      if (Y !== expected) begin
        $display("ERROR: a=%0d expected=%0d got=%0d", a, expected, Y);
        fails = fails + 1;
      end
    end

    if (fails == 0)
      $display("ALL TESTS PASSED!");
    else
      $display("FAILED with %0d errors", fails);

    $finish;
  end

endmodule
