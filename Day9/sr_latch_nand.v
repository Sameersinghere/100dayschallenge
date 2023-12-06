module sr_latch_nand(
    input S,
    input R,
    output Q,
    output Qbar
);
    nand (Q, R, Qbar);
    nand (Qbar, S, Q);

endmodule
