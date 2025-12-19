`timescale 1ns / 1ps

module partial_products_8bit (
    input  wire [7:0] a,
    output wire pp00,
    output wire pp10,
    output wire pp11,
    output wire pp20,
    output wire pp21,
    output wire pp22,
    output wire pp30,
    output wire pp31,
    output wire pp32,
    output wire pp33,
    output wire pp40,
    output wire pp41,
    output wire pp42,
    output wire pp43,
    output wire pp44,
    output wire pp50,
    output wire pp51,
    output wire pp52,
    output wire pp53,
    output wire pp54,
    output wire pp55,
    output wire pp60,
    output wire pp61,
    output wire pp62,
    output wire pp63,
    output wire pp64,
    output wire pp65,
    output wire pp66,
    output wire pp70,
    output wire pp71,
    output wire pp72,
    output wire pp73,
    output wire pp74,
    output wire pp75,
    output wire pp76,
    output wire pp77,
    output wire [55:0] garbage
);

    // Diagonal elements (weight 2^(2i)) - No Logic Needed
    assign pp00 = a[0];
    assign pp11 = a[1];
    assign pp22 = a[2];
    assign pp33 = a[3];
    assign pp44 = a[4];
    assign pp55 = a[5];
    assign pp66 = a[6];
    assign pp77 = a[7];

    // Off-diagonal elements (weight 2^(i+j+1)) - Uses Peres Gates
    wire g_10_1, g_10_2;
    peres_gate p10 (.U(a[0]), .V(a[1]), .W(1'b0), .M(g_10_1), .N(g_10_2), .O(pp10));

    wire g_20_1, g_20_2;
    peres_gate p20 (.U(a[0]), .V(a[2]), .W(1'b0), .M(g_20_1), .N(g_20_2), .O(pp20));
    wire g_21_1, g_21_2;
    peres_gate p21 (.U(a[1]), .V(a[2]), .W(1'b0), .M(g_21_1), .N(g_21_2), .O(pp21));

    wire g_30_1, g_30_2;
    peres_gate p30 (.U(a[0]), .V(a[3]), .W(1'b0), .M(g_30_1), .N(g_30_2), .O(pp30));
    wire g_31_1, g_31_2;
    peres_gate p31 (.U(a[1]), .V(a[3]), .W(1'b0), .M(g_31_1), .N(g_31_2), .O(pp31));
    wire g_32_1, g_32_2;
    peres_gate p32 (.U(a[2]), .V(a[3]), .W(1'b0), .M(g_32_1), .N(g_32_2), .O(pp32));

    wire g_40_1, g_40_2;
    peres_gate p40 (.U(a[0]), .V(a[4]), .W(1'b0), .M(g_40_1), .N(g_40_2), .O(pp40));
    wire g_41_1, g_41_2;
    peres_gate p41 (.U(a[1]), .V(a[4]), .W(1'b0), .M(g_41_1), .N(g_41_2), .O(pp41));
    wire g_42_1, g_42_2;
    peres_gate p42 (.U(a[2]), .V(a[4]), .W(1'b0), .M(g_42_1), .N(g_42_2), .O(pp42));
    wire g_43_1, g_43_2;
    peres_gate p43 (.U(a[3]), .V(a[4]), .W(1'b0), .M(g_43_1), .N(g_43_2), .O(pp43));

    wire g_50_1, g_50_2;
    peres_gate p50 (.U(a[0]), .V(a[5]), .W(1'b0), .M(g_50_1), .N(g_50_2), .O(pp50));
    wire g_51_1, g_51_2;
    peres_gate p51 (.U(a[1]), .V(a[5]), .W(1'b0), .M(g_51_1), .N(g_51_2), .O(pp51));
    wire g_52_1, g_52_2;
    peres_gate p52 (.U(a[2]), .V(a[5]), .W(1'b0), .M(g_52_1), .N(g_52_2), .O(pp52));
    wire g_53_1, g_53_2;
    peres_gate p53 (.U(a[3]), .V(a[5]), .W(1'b0), .M(g_53_1), .N(g_53_2), .O(pp53));
    wire g_54_1, g_54_2;
    peres_gate p54 (.U(a[4]), .V(a[5]), .W(1'b0), .M(g_54_1), .N(g_54_2), .O(pp54));

    wire g_60_1, g_60_2;
    peres_gate p60 (.U(a[0]), .V(a[6]), .W(1'b0), .M(g_60_1), .N(g_60_2), .O(pp60));
    wire g_61_1, g_61_2;
    peres_gate p61 (.U(a[1]), .V(a[6]), .W(1'b0), .M(g_61_1), .N(g_61_2), .O(pp61));
    wire g_62_1, g_62_2;
    peres_gate p62 (.U(a[2]), .V(a[6]), .W(1'b0), .M(g_62_1), .N(g_62_2), .O(pp62));
    wire g_63_1, g_63_2;
    peres_gate p63 (.U(a[3]), .V(a[6]), .W(1'b0), .M(g_63_1), .N(g_63_2), .O(pp63));
    wire g_64_1, g_64_2;
    peres_gate p64 (.U(a[4]), .V(a[6]), .W(1'b0), .M(g_64_1), .N(g_64_2), .O(pp64));
    wire g_65_1, g_65_2;
    peres_gate p65 (.U(a[5]), .V(a[6]), .W(1'b0), .M(g_65_1), .N(g_65_2), .O(pp65));

    wire g_70_1, g_70_2;
    peres_gate p70 (.U(a[0]), .V(a[7]), .W(1'b0), .M(g_70_1), .N(g_70_2), .O(pp70));
    wire g_71_1, g_71_2;
    peres_gate p71 (.U(a[1]), .V(a[7]), .W(1'b0), .M(g_71_1), .N(g_71_2), .O(pp71));
    wire g_72_1, g_72_2;
    peres_gate p72 (.U(a[2]), .V(a[7]), .W(1'b0), .M(g_72_1), .N(g_72_2), .O(pp72));
    wire g_73_1, g_73_2;
    peres_gate p73 (.U(a[3]), .V(a[7]), .W(1'b0), .M(g_73_1), .N(g_73_2), .O(pp73));
    wire g_74_1, g_74_2;
    peres_gate p74 (.U(a[4]), .V(a[7]), .W(1'b0), .M(g_74_1), .N(g_74_2), .O(pp74));
    wire g_75_1, g_75_2;
    peres_gate p75 (.U(a[5]), .V(a[7]), .W(1'b0), .M(g_75_1), .N(g_75_2), .O(pp75));
    wire g_76_1, g_76_2;
    peres_gate p76 (.U(a[6]), .V(a[7]), .W(1'b0), .M(g_76_1), .N(g_76_2), .O(pp76));

    assign garbage = {g_76_1, g_76_2, g_75_1, g_75_2, g_74_1, g_74_2, g_73_1, g_73_2, g_72_1, g_72_2, g_71_1, g_71_2, g_70_1, g_70_2, g_65_1, g_65_2, g_64_1, g_64_2, g_63_1, g_63_2, g_62_1, g_62_2, g_61_1, g_61_2, g_60_1, g_60_2, g_54_1, g_54_2, g_53_1, g_53_2, g_52_1, g_52_2, g_51_1, g_51_2, g_50_1, g_50_2, g_43_1, g_43_2, g_42_1, g_42_2, g_41_1, g_41_2, g_40_1, g_40_2, g_32_1, g_32_2, g_31_1, g_31_2, g_30_1, g_30_2, g_21_1, g_21_2, g_20_1, g_20_2, g_10_1, g_10_2};
endmodule
