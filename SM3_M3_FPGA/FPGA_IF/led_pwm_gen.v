module led_pwm_gen (clk, nreset, data_a, data_b, data_c, data_d, data_e, data_f, data_g, data_h, /*pwm,*/ led, fclk);
	input clk, nreset;
	input [7:0] data_a, data_b, data_c, data_d, data_e, data_f, data_g, data_h;
	//output [7:0] pwm;
	output [7:0] led;
	output reg fclk;
	
	reg [7:0] cnt;
	reg [7:0] shades;
	
	always @(posedge clk or negedge nreset) begin
		if (nreset == 1'b0) begin
			cnt <= 0;
			fclk <= 1'b0;
		end else begin
			if (cnt == 255) begin
				cnt <= 0;
				fclk <= 1'b1;
			end else begin
				cnt <= cnt+1'b1;
				fclk <= 1'b0;
			end
		end
	end
	
	always @(nreset or cnt) begin
		if (nreset == 1'b0) shades <= 8'b00000000;
		else if (cnt <   1) shades <= 8'b00000001;
		else if (cnt <   3) shades <= 8'b00000010;
		else if (cnt <   7) shades <= 8'b00000100;
		else if (cnt <  15) shades <= 8'b00001000;
		else if (cnt <  31) shades <= 8'b00010000;
		else if (cnt <  63) shades <= 8'b00100000;
		else if (cnt < 127) shades <= 8'b01000000;
		else                shades <= 8'b10000000;
	end
	
	//assign pwm = shades;
	assign led[7] = |(data_a & shades);
	assign led[6] = |(data_b & shades);
	assign led[5] = |(data_c & shades);
	assign led[4] = |(data_d & shades);
	assign led[3] = |(data_e & shades);
	assign led[2] = |(data_f & shades);
	assign led[1] = |(data_g & shades);
	assign led[0] = |(data_h & shades);

endmodule
