module counter(
    input clk,
    output reg [3:0] num
);

reg [3:0] counter;
always @(posedge clk) begin
    if (counter == 16) begin
    counter <= 0;
    end
    else begin
    counter <= counter + 1;
    end
end
endmodule

module 
reg [3:0] num;
always @(posedge clk) begin
    case 


