module random (
    input               clk,
    input               en,
    output  reg [3:0]   randNum
);

reg [3:0] counter;

always @(posedge clk)
begin
    if (counter == 4'd12)
        counter <= 4'd1;
    else
        counter <= counter + 4'd1;
end

always @(posedge en)
begin
    randNum <= counter;
end

endmodule