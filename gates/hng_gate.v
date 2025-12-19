module hng_gate (
    input  wire U,
    input  wire V,
    input  wire W,
    input  wire X,
    output wire M,
    output wire N,
    output wire O,
    output wire P
);

    wire uv_xor;
    wire u_and_v;
    wire uvx_and_w;

    assign M = U;
    assign N = V;
    assign uv_xor = U ^ V;
    assign u_and_v = U & V;
    assign O = uv_xor ^ W;
    assign uvx_and_w = uv_xor & W;
    assign P = uvx_and_w ^ u_and_v ^ X;

endmodule
