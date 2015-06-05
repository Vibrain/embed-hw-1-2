module dotmatrix_test (clk, dot_d, dot_scan, nreset);
	input clk, nreset;
	output [6:0] dot_d;
	output [9:0] dot_scan;

	reg [6:0] dot_data [9:0];
	wire [6:0] data [43:0];
	
	reg [6:0] cnt_clk;
	reg [5:0] cnt_data;
	reg clk_20h;
	
	integer i;
	
	dot_disp b1(
		.clk(clk),
		.dot_data_00(dot_data[0]),
		.dot_data_01(dot_data[1]),
		.dot_data_02(dot_data[2]),
		.dot_data_03(dot_data[3]),
		.dot_data_04(dot_data[4]),
		.dot_data_05(dot_data[5]),
		.dot_data_06(dot_data[6]),
		.dot_data_07(dot_data[7]),
		.dot_data_08(dot_data[8]),
		.dot_data_09(dot_data[9]),
		.dot_d(dot_d),
		.dot_scan(dot_scan),
		.nreset(nreset));
		
	always @(posedge clk or negedge nreset) begin
		if (nreset == 1'b0) begin
			cnt_clk <= 0;
			clk_20h <= 1'b0;
		end else begin
			if (cnt_clk == 99) begin
				cnt_clk <= 0;
				clk_20h <= ~clk_20h;
			end else begin
				cnt_clk <= cnt_clk+1'b1;
				clk_20h <= clk_20h;
			end
		end
	end
	
	always @(posedge clk_20h or negedge nreset) begin
		if (nreset == 1'b0) begin
			cnt_data <= 0;
		end else begin
			if (cnt_data == 43) cnt_data <= 0;
			else                cnt_data <= cnt_data+1'b1;
		end
	end
	
	always @(posedge clk_20h or negedge nreset) begin
		if (nreset == 1'b0) begin
			for (i=0; i<10; i=i+1) begin
				dot_data[i] <= 0;
			end
		end else begin
			for (i=0; i<9; i=i+1) begin:copy
				dot_data[i] <= dot_data[i+1];
			end
			dot_data[9] <= data[cnt_data];
		end
	end

	assign data[0] = 7'b0111110;
	assign data[1] = 7'b0001000;
	assign data[2] = 7'b0001000;
	assign data[3] = 7'b0111110;
	assign data[4] = 7'b0000000;
	assign data[5] = 7'b0111100;
	assign data[6] = 7'b0001010;
	assign data[7] = 7'b0001010;
	assign data[8] = 7'b0111100;
	assign data[9] = 7'b0000000;
	assign data[10] = 7'b0111110;
	assign data[11] = 7'b0001100;
	assign data[12] = 7'b0011000;
	assign data[13] = 7'b0111110;
	assign data[14] = 7'b0000000;
	assign data[15] = 7'b0111110;
	assign data[16] = 7'b0101010;
	assign data[17] = 7'b0101010;
	assign data[18] = 7'b0010100;
	assign data[19] = 7'b0000000;
	assign data[20] = 7'b0111100;
	assign data[21] = 7'b0001010;
	assign data[22] = 7'b0001010;
	assign data[23] = 7'b0111100;
	assign data[24] = 7'b0000000;
	assign data[25] = 7'b0011100;
	assign data[26] = 7'b0100010;
	assign data[27] = 7'b0100010;
	assign data[28] = 7'b0100010;
	assign data[29] = 7'b0000000;
	assign data[30] = 7'b0111110;
	assign data[31] = 7'b0001000;
	assign data[32] = 7'b0010100;
	assign data[33] = 7'b0100010;
	assign data[34] = 7'b0000000;
	assign data[35] = 7'b0110000;
	assign data[36] = 7'b0110000;
	assign data[37] = 7'b0000000;
	assign data[38] = 7'b0000000;
	assign data[39] = 7'b0000000;
	assign data[40] = 7'b0000000;
	assign data[41] = 7'b0000000;
	assign data[42] = 7'b0000000;
	assign data[43] = 7'b0000000;
	
endmodule
			