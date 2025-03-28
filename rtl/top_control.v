module top_control (
	input 				clk,    // Clock
	input 				start,
	input 				response,
	output 				testLed,
	output				readyLed,
	output 				earlyLed,
	output 				overflowLed,
	output				acom,
	output	 	[6:0]	seg,
	output		[1:0]	de
);

wire	[13:0]	rectTime;

delay inst_delay
	(
		.clk      (clk),
		.start    (start),
		.response (response),
		.random   (testLed),
		.early    (earlyLed),
		.ready    (readyLed)
	);

count inst_count (
		.clk      (clk),
		.en       (testLed),
		.response (response),
		.rectTime (rectTime),
		.overflow (overflowLed)
	);

display inst_display (.clk(clk), .en(1), .rectTime(rectTime + 3'd5), .seg(seg), .de(de));

assign acom = 1'b1;

endmodule