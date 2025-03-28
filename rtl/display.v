module display (
	input 				clk,
	input 				en,
	input 		[13:0]	rectTime,
	output	reg [6:0]	seg,
	output	reg	[1:0]	de
);

reg [19:0]	counter;

wire	[3:0]	data100;
wire	[3:0]	data10;
wire	[3:0]	data1;

wire	[6:0]	seg100;
wire	[6:0]	seg10;
wire	[6:0]	seg1;

assign 	data100 = rectTime / 10'd1000 % 4'd10;
assign 	data10 = rectTime / 7'd100 % 4'd10;
assign 	data1 = rectTime / 4'd10 % 4'd10;

bcd_to_segment inst_bcd_to_segment_100 (.bcd(data100), .segment(seg100));
bcd_to_segment inst_bcd_to_segment_10 (.bcd(data10), .segment(seg10));
bcd_to_segment inst_bcd_to_segment_1 (.bcd(data1), .segment(seg1));

always @(posedge clk or negedge en)
begin
    if(!en)
    begin
        de <= 2'b0;
    end
    else begin
        if (counter < 4'd10 - 1'b1)
        begin
            counter <= counter + 1'b1;
        end else
        begin
            counter <= 24'b0;
            if (de < 2'd2) begin
            	de <= de + 1'b1;
            end else begin
            	de <= 2'b0;
            end
        end
    end
end

always @(posedge clk or negedge en)
begin
    if(!en)
    begin
        seg <= 7'b0;
    end
    else begin
        case (de)
    		2'b00	: seg <= seg100;
    		2'b01	: seg <= seg10;
    		2'b10	: seg <= seg1;
        	default : seg <= 7'b0;
        endcase
    end
end

endmodule