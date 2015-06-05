module dot_disp (clk, dot_data_00, dot_data_01, dot_data_02, dot_data_03, dot_data_04, dot_data_05, dot_data_06, dot_data_07, dot_data_08, dot_data_09, dot_d, dot_scan, nreset);
	input clk, nreset;
	input [6:0] dot_data_00, dot_data_01, dot_data_02, dot_data_03, dot_data_04, dot_data_05, dot_data_06, dot_data_07, dot_data_08, dot_data_09;
	output reg [6:0] dot_d;
	output [9:0] dot_scan;
	
	reg [3:0] cnt_clk;
	reg [9:0] scan;
	
	assign dot_scan = scan;
	
	always @(posedge clk or negedge nreset) begin
		if (nreset == 1'b0) begin
			cnt_clk <= 0;
		end else begin
			if (cnt_clk == 9) cnt_clk <= 0;
			else              cnt_clk <= cnt_clk+1'b1;
		end
	end
	
	always @(posedge clk or negedge nreset) begin
		if (nreset == 1'b0) begin
			scan <= 10'b0000000001;
			dot_d <= 7'b0000000;
		end else begin
			if (cnt_clk == 9) scan <= 10'b0000000001;
			else              scan <= {scan[8:0], 1'b0};
			
			case (cnt_clk)
				4'd0: dot_d <= dot_data_01;
				4'd1: dot_d <= dot_data_02;
				4'd2: dot_d <= dot_data_03;
				4'd3: dot_d <= dot_data_04;
				4'd4: dot_d <= dot_data_05;
				4'd5: dot_d <= dot_data_06;
				4'd6: dot_d <= dot_data_07;
				4'd7: dot_d <= dot_data_08;
				4'd8: dot_d <= dot_data_09;
				4'd9: dot_d <= dot_data_00;
				default dot_d <= 'b0;
			endcase
		end
	end
	
endmodule
	