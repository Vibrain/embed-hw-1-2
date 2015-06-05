module led_clk_gen (clk, nreset, fclk, led_clk, led1, led2, led3, led4, led5, led6, led7, led8);
	input clk, nreset, fclk;
	output reg led_clk;
	output reg [7:0] led1, led2, led3, led4, led5, led6, led7, led8;
	
	reg [7:0] clk_cnt;
	reg iclk;
	reg [3:0] cnt, cnt_a, cnt_b;
	
	always @(posedge clk or negedge nreset) begin
		if (nreset == 1'b0) begin
			clk_cnt <= 0;
		end else begin
			clk_cnt <= clk_cnt+1'b1;
		end
	end
	
	always @(posedge clk_cnt[1] or negedge nreset) begin
		if (nreset == 1'b0) begin
			cnt_a <= 0;
			led_clk <= 1'b0;
		end else begin
			if (cnt_a == 6) begin
				cnt_a <= 0;
				led_clk <= 1'b1;
			end else begin
				cnt_a <= cnt_a+1'b1;
				led_clk <= 1'b0;
			end
		end
	end
	
	always @(posedge fclk or negedge nreset) begin
		if (nreset == 1'b0) begin
			cnt_b <= 0;
			iclk <= 1'b1;
		end else begin
			if (cnt_b == 11) begin
				cnt_b <= 0;
				iclk <= 1'b1;
			end else begin
				cnt_b <= cnt_b+1'b1;
				iclk <= 1'b0;
			end
		end
	end
	
	always @(posedge iclk or negedge nreset) begin
		if (nreset == 1'b0) begin
			cnt <= 0;
		end else begin
			if (cnt == 13) cnt <= 0;
			else           cnt <= cnt+1'b1;
		end
	end
	
	always @(posedge iclk or negedge nreset) begin
		if (nreset == 1'b0) begin
			led1 <= 0;
			led2 <= 0;
			led3 <= 0;
			led4 <= 0;
			led5 <= 0;
			led6 <= 0;
			led7 <= 0;
			led8 <= 0;
		end else begin
			if (cnt == 0) begin
				led1 <= 8'b11111111;
				led2 <= 8'b01111111;
				led3 <= 8'b00111111;
				led4 <= 8'b00011111;
				led5 <= 8'b00001111;
				led6 <= 8'b00000111;
				led7 <= 8'b00000011;
				led8 <= 8'b00000001;
			end else if (cnt == 1) begin
				led1 <= 8'b01111111;
				led2 <= 8'b11111111;
				led3 <= 8'b00011111;
				led4 <= 8'b00001111;
				led5 <= 8'b00000111;
				led6 <= 8'b00000011;
				led7 <= 8'b00000001;
				led8 <= 8'b00000000;
			end else if (cnt == 2) begin
				led1 <= 8'b00111111;
				led2 <= 8'b01111111;
				led3 <= 8'b11111111;
				led4 <= 8'b00000111;
				led5 <= 8'b00000011;
				led6 <= 8'b00000001;
				led7 <= 8'b00000000;
				led8 <= 8'b00000000;
			end else if (cnt == 3) begin
				led1 <= 8'b00011111;
				led2 <= 8'b00111111;
				led3 <= 8'b01111111;
				led4 <= 8'b11111111;
				led5 <= 8'b00000001;
				led6 <= 8'b00000000;
				led7 <= 8'b00000000;
				led8 <= 8'b00000000;
			end else if (cnt == 4) begin
				led1 <= 8'b00001111;
				led2 <= 8'b00011111;
				led3 <= 8'b00111111;
				led4 <= 8'b01111111;
				led5 <= 8'b11111111;
				led6 <= 8'b00000000;
				led7 <= 8'b00000000;
				led8 <= 8'b00000000;
			end else if (cnt == 5) begin
				led1 <= 8'b00000111;
				led2 <= 8'b00001111;
				led3 <= 8'b00011111;
				led4 <= 8'b00111111;
				led5 <= 8'b01111111;
				led6 <= 8'b11111111;
				led7 <= 8'b00000000;
				led8 <= 8'b00000000;
			end else if (cnt == 6) begin
				led1 <= 8'b00000011;
				led2 <= 8'b00000111;
				led3 <= 8'b00001111;
				led4 <= 8'b00011111;
				led5 <= 8'b00111111;
				led6 <= 8'b01111111;
				led7 <= 8'b11111111;
				led8 <= 8'b00000000;
			end else if (cnt == 7) begin
				led1 <= 8'b00000001;
				led2 <= 8'b00000011;
				led3 <= 8'b00000111;
				led4 <= 8'b00001111;
				led5 <= 8'b00011111;
				led6 <= 8'b00111111;
				led7 <= 8'b01111111;
				led8 <= 8'b11111111;
			end else if (cnt == 8) begin
				led1 <= 8'b00000000;
				led2 <= 8'b00000001;
				led3 <= 8'b00000011;
				led4 <= 8'b00000111;
				led5 <= 8'b00001111;
				led6 <= 8'b00011111;
				led7 <= 8'b11111111;
				led8 <= 8'b11111111;
			end else if (cnt == 9) begin
				led1 <= 8'b00000000;
				led2 <= 8'b00000000;
				led3 <= 8'b00000001;
				led4 <= 8'b00000011;
				led5 <= 8'b00000111;
				led6 <= 8'b11111111;
				led7 <= 8'b01111111;
				led8 <= 8'b00111111;
			end else if (cnt == 10) begin
				led1 <= 8'b00000000;
				led2 <= 8'b00000000;
				led3 <= 8'b00000000;
				led4 <= 8'b00000001;
				led5 <= 8'b11111111;
				led6 <= 8'b01111111;
				led7 <= 8'b00111111;
				led8 <= 8'b00011111;
			end else if (cnt == 11) begin
				led1 <= 8'b00000000;
				led2 <= 8'b00000000;
				led3 <= 8'b00000000;
				led4 <= 8'b11111111;
				led5 <= 8'b01111111;
				led6 <= 8'b00111111;
				led7 <= 8'b00011111;
				led8 <= 8'b00001111;
			end else if (cnt == 12) begin
				led1 <= 8'b00000000;
				led2 <= 8'b00000000;
				led3 <= 8'b11111111;
				led4 <= 8'b01111111;
				led5 <= 8'b00111111;
				led6 <= 8'b00011111;
				led7 <= 8'b00001111;
				led8 <= 8'b00000111;
			end else if (cnt == 13) begin
				led1 <= 8'b00000000;
				led2 <= 8'b11111111;
				led3 <= 8'b01111111;
				led4 <= 8'b00111111;
				led5 <= 8'b00011111;
				led6 <= 8'b00001111;
				led7 <= 8'b00000111;
				led8 <= 8'b00000011;
			end
		end
	end
endmodule			
			