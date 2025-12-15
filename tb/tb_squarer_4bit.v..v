`timescale 1ns/1ps
module tb_squarer_4bit;

  reg  [3:0] a;
  wire [7:0] Y;
  wire [31:0] gpp;
  wire [31:0] gsum;

  integer i;
  integer fails;
  reg [7:0] expected;

  // these counters must be declared here (NOT inside the for-loop) in Verilog-2001
  integer ones_gpp;
  integer ones_gsum;
  integer total_ones;

  // Count ones in a 32-bit bus
  function integer count_ones;
    input [31:0] bus;
    integer k;
    begin
      count_ones = 0;
      for (k = 0; k < 32; k = k + 1)
        if (bus[k]) count_ones = count_ones + 1;
    end
  endfunction

  squarer_4bit dut (
    .a(a),
    .Y(Y),
    .garbage_pp(gpp),
    .garbage_sum(gsum)
  );

  initial begin
    $display("Starting 4-bit reversible squarer test");
    $display("a,Y,expected,garbage_pp_hex,garbage_sum_hex,ones_gpp,ones_gsum,total_garbage_ones");

    fails = 0;

    for (i = 0; i < 16; i = i + 1) begin
      a = i;
      #5;
      expected = a * a;

      // compute counts (now using variables declared above)
      ones_gpp  = count_ones(gpp);
      ones_gsum = count_ones(gsum);
      total_ones = ones_gpp + ones_gsum;

      if (Y !== expected) begin
        $display("ERROR: a=%0d expected=%0d got=%0d", a, expected, Y);
        fails = fails + 1;
      end

      // CSV LINE OUTPUT
      $display("%0d,%0d,%0d,0x%08h,0x%08h,%0d,%0d,%0d",
               a, Y, expected,
               gpp, gsum,
               ones_gpp, ones_gsum, total_ones);

      #5;
    end

    $display("Test finished. fails = %0d", fails);
    $finish;
  end

endmodule
