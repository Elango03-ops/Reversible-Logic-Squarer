    module partial_products_4bit (
        input  wire [3:0] a,
        output wire pp00,
        output wire pp01,
        output wire pp02,
        output wire pp03,
        output wire pp11,
        output wire pp12,
        output wire pp13,
        output wire pp22,
        output wire pp23,
        output wire pp33,
        output wire [19:0] garbage);
    
       
        wire m00, n00, o00;
        wire m01, n01, o01;
        wire m02, n02, o02;
        wire m03, n03, o03;
        wire m11, n11, o11;
        wire m12, n12, o12;
        wire m13, n13, o13;
        wire m22, n22, o22;
        wire m23, n23, o23;
        wire m33, n33, o33;
    
       
        peres_gate p00(.U(a[0]), .V(a[0]), .W(1'b0), .M(m00), .N(n00), .O(o00));
        peres_gate p01(.U(a[0]), .V(a[1]), .W(1'b0), .M(m01), .N(n01), .O(o01));
        peres_gate p02(.U(a[0]), .V(a[2]), .W(1'b0), .M(m02), .N(n02), .O(o02));
        peres_gate p03(.U(a[0]), .V(a[3]), .W(1'b0), .M(m03), .N(n03), .O(o03));
    
        peres_gate p11(.U(a[1]), .V(a[1]), .W(1'b0), .M(m11), .N(n11), .O(o11));
        peres_gate p12(.U(a[1]), .V(a[2]), .W(1'b0), .M(m12), .N(n12), .O(o12));
        peres_gate p13(.U(a[1]), .V(a[3]), .W(1'b0), .M(m13), .N(n13), .O(o13));
    
        peres_gate p22(.U(a[2]), .V(a[2]), .W(1'b0), .M(m22), .N(n22), .O(o22));
        peres_gate p23(.U(a[2]), .V(a[3]), .W(1'b0), .M(m23), .N(n23), .O(o23));
    
        peres_gate p33(.U(a[3]), .V(a[3]), .W(1'b0), .M(m33), .N(n33), .O(o33));
    
        
        assign pp00 = o00;
        assign pp01 = o01;
        assign pp02 = o02;
        assign pp03 = o03;
        assign pp11 = o11;
        assign pp12 = o12;
        assign pp13 = o13;
        assign pp22 = o22;
        assign pp23 = o23;
        assign pp33 = o33;
    
        
        assign garbage = {
            n00, m00,
            n01, m01,
            n02, m02,
            n03, m03,
            n11, m11,
            n12, m12,
            n13, m13,
            n22, m22,
            n23, m23,
            n33, m33};
    
    endmodule
