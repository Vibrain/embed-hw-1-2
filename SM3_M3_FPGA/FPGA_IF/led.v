module led_demo (clk, nreset, led_data);
	input clk;
	input nreset;
	output [7:0] led_data;
	
	wire [7:0] led1, led2, led3, led4, led5, led6, led7, led8, led_b;
	wire [7:0] data_a, data_b, data_c, data_d, data_e, data_f, data_g, data_h;
	wire led_clk, pwm_clk, fclk_in, fclk_out;
	
	led_clk_gen b1(
		.clk(clk),
		.nreset(nreset),
		.fclk(fclk_in),
		.led_clk(led_clk),
		.led1(led1),
		.led2(led2),
		.led3(led3),
		.led4(led4),
		.led5(led5),
		.led6(led6),
		.led7(led7),
		.led8(led8));

	led_pwm_gen b2(
		.clk(pwm_clk),
		.nreset(nreset),
		.data_a(data_h),
		.data_b(data_g),
		.data_c(data_f),
		.data_d(data_e),
		.data_e(data_d),
		.data_f(data_c),
		.data_g(data_b),
		.data_h(data_a),
		.led(led_b),
		.fclk(fclk_out));
	
	assign fclk_in = fclk_out;
	assign pwm_clk = led_clk;
	assign data_a = led1;
	assign data_b = led2;
	assign data_c = led3;
	assign data_d = led4;
	assign data_e = led5;
	assign data_f = led6;
	assign data_g = led7;
	assign data_h = led8;
	
	assign led_data = led_b;
	
endmodule
