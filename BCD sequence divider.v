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

always @(*) begin
    case(counter)
            4'h0: seg = 7'b1111110;
            4'h1: seg = 7'b0110000;
            4'h2: seg = 7'b1101101;
            4'h3: seg = 7'b1111001;
            4'h4: seg = 7'b0110011;
            4'h5: seg = 7'b1011011;
            4'h6: seg = 7'b1011111;
            4'h7: seg = 7'b1110000;
            4'h8: seg = 7'b1111111;
            4'h9: seg = 7'b1111011;
            default: seg = 7'b0000000;
    endcase
end
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




