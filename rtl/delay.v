module delay (
    input   	clk,    // Clock 10MHz
    input   	start,
    input   	response,
    output  reg	random,
    output  reg	early,
    output  reg	ready
);

reg [23:0]  counter;
reg [3:0]	cnt;
wire[3:0]	randNum;

random inst_random (.clk(clk), .en(start), .randNum(randNum));

always @(posedge clk or negedge start)
begin
    if(!start)
    begin
        random = 0;
        early = 0;
        ready = 0;
        cnt = 0;
    end
    else begin
		ready = 1;
        if (counter < 24'd10000000 - 1'b1)
        begin
            counter <= counter + 1'b1;
        end else
        begin
            counter <= 24'b0;
            cnt <= cnt + 1;
            if (cnt == randNum && response != 1 && early != 1)
            begin
				random = 1;
			end else
			begin
				if (random == 0 && response == 1)
				begin
					early = 1;
				end
			end
        end
    end
end

endmodule