module frequency_divider(
    input clk_in,
    output reg clk_out
);

reg [26:0] counter = 0;
always @(posedge clk_in) begin
    if (counter == 15000000 - 1) begin
        counter <= 0;
        clk_out <= ~clk_out;
    end
    else begin
        counter <= counter + 1;
    end
end
endmodule

module bcd_to_7_seg(
    input [3:0] counter,
    output reg [6:0] seg
);

wire n3, n2, n1, n0;
    not (n3, B[3]), (n2, B[2]), (n1, B[1]), (n0, B[0]);

    // Segment a
    wire a_w1, a_w2;
    and (a_w1, B[2], B[0]);
    and (a_w2, n2, n0);
    or  (seg[6], B[3], B[1], a_w1, a_w2);

    // Segment b
    wire b_w1, b_w2;
    and (b_w1, n1, n0);
    and (b_w2, B[1], B[0]);
    or  (seg[5], n2, b_w1, b_w2);

    // Segment c
    or  (seg[4], B[2], n1, B[0]);

    // Segment d
    wire d_w1, d_w2, d_w3, d_w4;
    and (d_w1, n2, n0);
    and (d_w2, B[1], n0);
    and (d_w3, n2, B[1]);
    and (d_w4, B[2], n1, B[0]);
    or  (seg[3], B[3], d_w1, d_w2, d_w3, d_w4);

    // Segment e
    wire e_w1, e_w2;
    and (e_w1, n2, n0);
    and (e_w2, B[1], n0);
    or  (seg[2], e_w1, e_w2);

    // Segment f
    wire f_w1, f_w2, f_w3;
    and (f_w1, n1, n0);
    and (f_w2, B[2], n1);
    and (f_w3, B[2], n0);
    or  (seg[1], B[3], f_w1, f_w2, f_w3);

    // Segment g
    wire g_w1, g_w2, g_w3;
    and (g_w1, B[2], n1);
    and (g_w2, n2, B[1]);
    and (g_w3, B[1], n0);
    or  (seg[0], B[3], g_w1, g_w2, g_w3);
endmodule

module main(
    input clk,
    output [6:0] seg,
    output [7:0] anode
);

wire clk_new;
frequency_divider f1(.clk_in(clk), .clk_out(clk_new));
reg [3:0] counter;
always @(posedge clk_new) begin
    if (counter == 4'b9) begin
    counter <= 4'b0;
    end
    else begin
    counter <= counter + 1;
    end
end

bcd_to_7_seg s1(.counter(counter), .seg(seg));
assign anode = 8'b11111110;
endmodule




