module count (
	input 				clk,    // Clock
	input				en,
	input				response,
	output 	reg [13:0]	rectTime,
	output	reg			overflow
);

reg [9:0]	counter;

always @(posedge clk or negedge en)
begin
    if(!en) begin
		counter <= 10'b0;
		rectTime <= 14'b0;
		overflow <= 1'b0;
	end else if (counter < 10'd999) begin
		counter <= counter + 1'b1;
	end else begin
		counter <= 10'b0;
		if (rectTime < 14'd9995 && overflow == 1'b0 && response == 1'b0) begin
			rectTime <= rectTime + 1'b1;
		end else begin
			if (response == 1'b0) begin
				overflow <= 1'b1;
			end
		end
	end
end

endmodule