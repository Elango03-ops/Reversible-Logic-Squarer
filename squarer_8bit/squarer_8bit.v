`timescale 1ns / 1ps

module squarer_8bit (
    input  wire [7:0] a,
    output wire [15:0] Y,
    output wire [55:0] garbage_pp,
    output wire [127:0] garbage_sum
);

    // Partial Products Wires
    wire pp00, pp10, pp11, pp20, pp21, pp22, pp30, pp31, pp32, pp33;
    wire pp40, pp41, pp42, pp43, pp44, pp50, pp51, pp52, pp53, pp54, pp55;
    wire pp60, pp61, pp62, pp63, pp64, pp65, pp66;
    wire pp70, pp71, pp72, pp73, pp74, pp75, pp76, pp77;

    // Instantiate Partial Products Generator
    partial_products_8bit ppgen (
        .a(a),
        .pp00(pp00), .pp10(pp10), .pp11(pp11),
        .pp20(pp20), .pp21(pp21), .pp22(pp22),
        .pp30(pp30), .pp31(pp31), .pp32(pp32), .pp33(pp33),
        .pp40(pp40), .pp41(pp41), .pp42(pp42), .pp43(pp43), .pp44(pp44),
        .pp50(pp50), .pp51(pp51), .pp52(pp52), .pp53(pp53), .pp54(pp54), .pp55(pp55),
        .pp60(pp60), .pp61(pp61), .pp62(pp62), .pp63(pp63), .pp64(pp64), .pp65(pp65), .pp66(pp66),
        .pp70(pp70), .pp71(pp71), .pp72(pp72), .pp73(pp73), .pp74(pp74), .pp75(pp75), .pp76(pp76), .pp77(pp77),
        .garbage(garbage_pp)
    );

    // Instantiate Summation Network
    summation_network_8bit sumnet (
        .pp00(pp00), .pp10(pp10), .pp11(pp11),
        .pp20(pp20), .pp21(pp21), .pp22(pp22),
        .pp30(pp30), .pp31(pp31), .pp32(pp32), .pp33(pp33),
        .pp40(pp40), .pp41(pp41), .pp42(pp42), .pp43(pp43), .pp44(pp44),
        .pp50(pp50), .pp51(pp51), .pp52(pp52), .pp53(pp53), .pp54(pp54), .pp55(pp55),
        .pp60(pp60), .pp61(pp61), .pp62(pp62), .pp63(pp63), .pp64(pp64), .pp65(pp65), .pp66(pp66),
        .pp70(pp70), .pp71(pp71), .pp72(pp72), .pp73(pp73), .pp74(pp74), .pp75(pp75), .pp76(pp76), .pp77(pp77),
        .Y(Y),
        .garbage(garbage_sum)
    );

endmodule
