module lcd_demo (clk, rst, cnt_1, cnt_10, sec_1,
 lcd_e, lcd_rs, lcd_rw, lcd_data, SRAM_nCS, SRAM_nOE, SRAM_nWE, SRAM_DATA, SRAM_ADDR );
 /* SRAM_nCS, SRAM_nOE, SRAM_nWE, SRAM_DATA, SRAM_ADDR*/
	parameter CNT_MAX = 4;
	parameter CNT_MAX_1000m = 1000;
	localparam CNT_CLK_HALF = CNT_MAX-1;
	parameter LCD_CHAR = 16;
	parameter STABLE_DELAY = 19;
	parameter DISPLAY_DELAY = 399;
	
	parameter DELAY_20M    = 0;
	parameter SRAM_WRITE_0x00 = 1;
	parameter SRAM_WRITE_0x01 = 2;
	parameter SRAM_WRITE_0x02 = 3;
	parameter SRAM_WRITE_0x03 = 4;
	parameter SRAM_WRITE_0x04 = 5;
	parameter FUNCTION_SET = 6;
	parameter ENTRY_MODE   = 7;
	parameter DISP_ON      = 8;
	parameter DISP_LINE1   = 9;
	parameter REST_1000m = 10;
	parameter DISP_LINE2   = 11;
	parameter DISP_LINE3   = 12;
	parameter DISP_LINE4   = 13;
	parameter DISP_LINE5   = 14;
		
	input clk, rst;
	input [7:0] cnt_1, cnt_10, sec_1;
	
	output reg lcd_e, lcd_rs;
	output lcd_rw;
	output reg [7:0] lcd_data;
	
	
	output reg SRAM_nCS, SRAM_nOE, SRAM_nWE;
	output reg [17:0] SRAM_ADDR;
	inout reg [15:0] SRAM_DATA;
	
	//reg [15:0] SRAM_DATA;
	
	reg [2:0] cnt_clk;
	reg [9:0] cnt_clk_1000m;
	reg [4:0] cnt_delay_20m;
	reg [7:0] cnt_delay_2s;
	reg [4:0] cnt_line;
	reg [1:0] cnt_brightness;
	reg [3:0] lcd_routine;
	
	reg [7:0] reg_lcd_data1 [LCD_CHAR:0];
	reg [7:0] reg_lcd_data2 [LCD_CHAR:0];
	
	assign lcd_rw = 1'b0;
	
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			cnt_clk <= 0;
			cnt_clk_1000m <= 10'd0;
		end else begin
			if (cnt_clk == CNT_MAX) cnt_clk <= 0;
			else                    cnt_clk <= cnt_clk+1'b1;
			
			if(cnt_clk_1000m == CNT_MAX_1000m) cnt_clk_1000m <= 10'd0;
			else							cnt_clk_1000m <= cnt_clk_1000m + 10'd1;
		end
	end
	
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			cnt_delay_20m <= 0;
		end else begin
			if (lcd_routine == DELAY_20M) begin
				if (cnt_clk == CNT_MAX) begin
					if (cnt_delay_20m == STABLE_DELAY) cnt_delay_20m <= 0;
					else                               cnt_delay_20m <= cnt_delay_20m+1'b1;
				end
			end else begin
				cnt_delay_20m <= 0;
			end
		end
	end
	

	
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			cnt_line <= 0;
		end else begin
			if (lcd_routine == DISP_LINE1 || lcd_routine == REST_1000m || lcd_routine == DISP_LINE2
			|| lcd_routine == DISP_LINE3 || lcd_routine == DISP_LINE4 || lcd_routine == DISP_LINE5) begin
				if (cnt_clk == CNT_MAX) begin
					if (cnt_line == LCD_CHAR) cnt_line <= 0;
					else                      cnt_line <= cnt_line+1'b1;
				end
			end else begin
				cnt_line <= 0;
			end
		end
	end
	
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			lcd_routine <= DELAY_20M;
		end else begin
			if (cnt_clk == CNT_MAX) begin
				case (lcd_routine)
				 DELAY_20M :
				   begin
				     if(cnt_clk == CNT_MAX && cnt_delay_20m == STABLE_DELAY)
					begin
					  lcd_routine <= SRAM_WRITE_0x00;
					end
				   end
				SRAM_WRITE_0x00 :
				  begin
				    if(cnt_clk == CNT_MAX)
				  begin
				    lcd_routine <= SRAM_WRITE_0x01;
				  end
				  end
				SRAM_WRITE_0x01 :
				  begin
				    if(cnt_clk == CNT_MAX)
				  begin
				    lcd_routine <= SRAM_WRITE_0x02;
				  end
				  end
				SRAM_WRITE_0x02 :
				  begin
				    if(cnt_clk == CNT_MAX)
				  begin
				    lcd_routine <= SRAM_WRITE_0x03;
				  end
				  end
				SRAM_WRITE_0x03 :
				  begin
				    if(cnt_clk == CNT_MAX)
				  begin
				    lcd_routine <= SRAM_WRITE_0x04;
				  end
				  end
				SRAM_WRITE_0x04 :
				  begin
				    if(cnt_clk == CNT_MAX)
				  begin
				    lcd_routine <= FUNCTION_SET;
				  end
				  end
				FUNCTION_SET :
				   begin
				     if(cnt_clk == CNT_MAX)
					begin
					  lcd_routine <= ENTRY_MODE;
					end
				   end
				ENTRY_MODE :
				   begin
				     if(cnt_clk == CNT_MAX)
					begin
					  lcd_routine <= DISP_ON;
					end
				   end
				 DISP_ON:
				   begin
				     if(cnt_clk == CNT_MAX)
					begin
					  lcd_routine <= DISP_LINE1;
					end
				   end
				DISP_LINE1:
				   begin
				     if(cnt_clk == CNT_MAX && cnt_line == LCD_CHAR)
					begin
					  lcd_routine <= REST_1000m;
					end
				   end
				REST_1000m:
				   begin
				     if(cnt_clk_1000m == CNT_MAX_1000m)
					begin
					  lcd_routine <= DISP_ON;
					end
				   end
				/*
				DISP_LINE2:
				   begin
				     if(cnt_clk == CNT_MAX && cnt_line == LCD_CHAR)
					begin
					  lcd_routine <= DISP_LINE3;
					end
				   end
				DISP_LINE3:
				   begin
				     if(cnt_clk == CNT_MAX && cnt_line == LCD_CHAR)
					begin
					  lcd_routine <= DISP_LINE4;
					end
				   end
				DISP_LINE4:
				   begin
				     if(cnt_clk == CNT_MAX && cnt_line == LCD_CHAR)
					begin
					  lcd_routine <= DISP_LINE5;
					end
				   end
				DISP_LINE5:
				   begin
				     if(cnt_clk == CNT_MAX && cnt_line == LCD_CHAR)
					begin
					  lcd_routine <= DISP_LINE1;
					end
				   end
				
*/
				endcase
			end
		end
	end
					
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			lcd_e <= 1'b0;
		end else begin
			case (lcd_routine)
				DELAY_20M: lcd_e <= 1'b0;
				default begin
					if (cnt_clk >= 1 && (cnt_clk <= CNT_CLK_HALF)) lcd_e <= 1'b1;
					else                                           lcd_e <= 1'b0;
				end
			endcase
		end
	end
	
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			lcd_rs <= 1'b0;
		end else begin
			if (lcd_routine == DISP_LINE1 || lcd_routine == REST_1000m || lcd_routine == DISP_LINE2 || lcd_routine == DISP_LINE3
			|| lcd_routine == DISP_LINE4 || lcd_routine == DISP_LINE5) begin
				if (cnt_line == 0) lcd_rs <= 1'b0;
				else               lcd_rs <= 1'b1;
			end else begin
				lcd_rs <= 1'b0;
			end
		end
	end
	
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			lcd_data <= 8'b00000000;
		end else begin
			case (lcd_routine)
			
				DELAY_20M :
				   begin
				     lcd_data <= 8'b00000000;
				   end
				SRAM_WRITE_0x00 :
				  begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b0;
					  SRAM_nOE <= 1'b1;
					  SRAM_ADDR <= 18'd0;
					  SRAM_DATA <= 16'hFFFF; 
				  end
				SRAM_WRITE_0x01 :
				  begin
				     SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b0;
					  SRAM_nOE <= 1'b1;
					  SRAM_ADDR <= 18'd1;
					  SRAM_DATA <= 16'h0000; 
				  end
				SRAM_WRITE_0x02 :
				  begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b0;
					  SRAM_nOE <= 1'b1;
					  SRAM_ADDR <= 18'd2;
					  SRAM_DATA <= 16'h1234; 
				  end
				SRAM_WRITE_0x03 :
				  begin
				     SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b0;
					  SRAM_nOE <= 1'b1;
					  SRAM_ADDR <= 18'd3;
					  SRAM_DATA <= 16'hABCD; 
				  end
				SRAM_WRITE_0x04 :
				  begin
				     SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b0;
					  SRAM_nOE <= 1'b1;
					  SRAM_ADDR <= 18'd4;
					  SRAM_DATA <= 16'hFFFF; 
				  end  
				FUNCTION_SET :
				   begin
					  SRAM_nWE <= 1'b1;
				     lcd_data <= 8'b00111000;
				   end
				ENTRY_MODE :
				   begin
					  SRAM_nWE <= 1'b1;
				     lcd_data <= 8'b00000110;
				   end
				 DISP_ON:
				   begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b1;
					  SRAM_nOE <= 1'b0;
					  SRAM_ADDR <= 18'd0;
					  
				     lcd_data <= 8'b00001100;
					  
				//	  if(cnt_clk_1000m >= CNT_MAX_1000m) begin
					  reg_lcd_data1[0] <= 8'b10000000;
				/*	  
					  if(SRAM_DATA[15:12] > 4'd9) 
						 begin	
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd48;
						 end
					  
					  if(SRAM_DATA[11:8] > 4'd9) 
						 begin	
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd48;
						 end
					
					  if(SRAM_DATA[7:4] > 4'd9) 
						 begin	
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd48;
						 end
						 
					   if(SRAM_DATA[3:0] > 4'd9) 
						 begin	
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd48;
						 end
					 */ 	
				
					  reg_lcd_data1[1] <= 8'h45;
					  reg_lcd_data1[2] <= 8'h44;
					  reg_lcd_data1[3] <= 8'h43;
					  reg_lcd_data1[4] <= 8'b10000000;
					  reg_lcd_data1[5] <= 8'b10000000;
					  reg_lcd_data1[6] <= 8'b10000000;
					  reg_lcd_data1[7] <= 8'b10000000;
					  reg_lcd_data1[8] <= 8'b10000000;
					  reg_lcd_data1[9] <= 8'b10000000;
					  reg_lcd_data1[10] <= 8'b10000000;
					  reg_lcd_data1[11] <= 8'b10000000;
					  reg_lcd_data1[12] <= 8'b10000000;
					  reg_lcd_data1[13] <= sec_1;
					  reg_lcd_data1[14] <= ":";
					  reg_lcd_data1[15] <= cnt_10;
					  reg_lcd_data1[16] <= cnt_1;
				//	  end
				   end
				DISP_LINE1:
				   begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b1;
					  SRAM_nOE <= 1'b0;
					  SRAM_ADDR <= 18'd1;
					
				     lcd_data <= reg_lcd_data1[cnt_line];
					  
				//	  if(cnt_clk_1000m == CNT_MAX_1000m) begin
					  reg_lcd_data2[0] <= 8'b11000000;
					/*	
					   if(SRAM_DATA[15:12] > 4'd9) 
						 begin	
							reg_lcd_data2[1] = {4'b0000, SRAM_DATA[15:12]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[1] = {4'b0000, SRAM_DATA[15:12]}+8'd48;
						 end
					  
					  if(SRAM_DATA[11:8] > 4'd9) 
						 begin	
							reg_lcd_data2[2] = {4'b0000, SRAM_DATA[11:8]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[2] = {4'b0000, SRAM_DATA[11:8]}+8'd48;
						 end
					
					  if(SRAM_DATA[7:4] > 4'd9) 
						 begin	
							reg_lcd_data2[3] = {4'b0000, SRAM_DATA[7:4]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[3] = {4'b0000, SRAM_DATA[7:4]}+8'd48;
						 end
						 
					   if(SRAM_DATA[3:0] > 4'd9) 
						 begin	
							reg_lcd_data2[4] = {4'b0000, SRAM_DATA[3:0]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[4] = {4'b0000, SRAM_DATA[3:0]}+8'd48;
						 end
						 
						 
					*/
					  reg_lcd_data2[1] <= 8'h46;
					  reg_lcd_data2[2] <= 8'h46;
					  reg_lcd_data2[3] <= 8'h47;
					  reg_lcd_data2[4] <= 8'b10000000;
					  reg_lcd_data2[5] <= 8'b10000000;
					  reg_lcd_data2[6] <= 8'b10000000;
					  reg_lcd_data2[7] <= 8'b10000000;
					  reg_lcd_data2[8] <= 8'b10000000;
					  reg_lcd_data2[9] <= 8'b10000000;
					  reg_lcd_data2[10] <= 8'b10000000;
					  reg_lcd_data2[11] <= 8'b10000000;
					  reg_lcd_data2[12] <= 8'b10000000;
					  reg_lcd_data2[13] <= sec_1;
					  reg_lcd_data2[14] <= ":";
					  reg_lcd_data2[15] <= cnt_10;
					  reg_lcd_data2[16] <= cnt_1;
				//	  end
				   end
				REST_1000m:
					begin
						lcd_data <= reg_lcd_data2[cnt_line];
						if(cnt_clk_1000m > 900) begin
							lcd_data <= 8'b00000001;
						end
						else begin end
						
					end
	/*			
				DISP_LINE2:
				   begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b1;
					  SRAM_nOE <= 1'b0;
					  SRAM_ADDR <= 8'd2;
					
				     lcd_data <= reg_lcd_data2[cnt_line];
			//		  if(cnt_clk_1000m == CNT_MAX_1000m) begin
					  reg_lcd_data1[0] <= 8'b10000000;
					 if(SRAM_DATA[15:12] > 4'd9) 
						 begin	
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd48;
						 end
					  
					  if(SRAM_DATA[11:8] > 4'd9) 
						 begin	
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd48;
						 end
					
					  if(SRAM_DATA[7:4] > 4'd9) 
						 begin	
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd48;
						 end
						 
					   if(SRAM_DATA[3:0] > 4'd9) 
						 begin	
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd48;
						 end
					  reg_lcd_data1[5] <= 8'b10000000;
					  reg_lcd_data1[6] <= 8'b10000000;
					  reg_lcd_data1[7] <= 8'b10000000;
					  reg_lcd_data1[8] <= 8'b10000000;
					  reg_lcd_data1[9] <= 8'b10000000;
					  reg_lcd_data1[10] <= 8'b10000000;
					  reg_lcd_data1[11] <= 8'b10000000;
					  reg_lcd_data1[12] <= 8'b10000000;
					  reg_lcd_data1[13] <= sec_1;
					  reg_lcd_data1[14] <= ":";
					  reg_lcd_data1[15] <= cnt_10;
					  reg_lcd_data1[16] <= cnt_1;
			//		  end
				   end
				DISP_LINE3:
				   begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b1;
					  SRAM_nOE <= 1'b0;
					  SRAM_ADDR <= 8'd3;
					
				     lcd_data <= reg_lcd_data1[cnt_line];
			//		  if(cnt_clk_1000m == CNT_MAX_1000m) begin
					  reg_lcd_data2[0] <= 8'b11000000;
					 if(SRAM_DATA[15:12] > 4'd9) 
						 begin	
							reg_lcd_data2[1] = {4'b0000, SRAM_DATA[15:12]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[1] = {4'b0000, SRAM_DATA[15:12]}+8'd48;
						 end
					  
					  if(SRAM_DATA[11:8] > 4'd9) 
						 begin	
							reg_lcd_data2[2] = {4'b0000, SRAM_DATA[11:8]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[2] = {4'b0000, SRAM_DATA[11:8]}+8'd48;
						 end
					
					  if(SRAM_DATA[7:4] > 4'd9) 
						 begin	
							reg_lcd_data2[3] = {4'b0000, SRAM_DATA[7:4]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[3] = {4'b0000, SRAM_DATA[7:4]}+8'd48;
						 end
						 
					   if(SRAM_DATA[3:0] > 4'd9) 
						 begin	
							reg_lcd_data2[4] = {4'b0000, SRAM_DATA[3:0]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data2[4] = {4'b0000, SRAM_DATA[3:0]}+8'd48;
						 end
					  reg_lcd_data2[5] <= 8'b10000000;
					  reg_lcd_data2[6] <= 8'b10000000;
					  reg_lcd_data2[7] <= 8'b10000000;
					  reg_lcd_data2[8] <= 8'b10000000;
					  reg_lcd_data2[9] <= 8'b10000000;
					  reg_lcd_data2[10] <= 8'b10000000;
					  reg_lcd_data2[11] <= 8'b10000000;
					  reg_lcd_data2[12] <= 8'b10000000;
					  reg_lcd_data2[13] <= sec_1;
					  reg_lcd_data2[14] <= ":";
					  reg_lcd_data2[15] <= cnt_10;
					  reg_lcd_data2[16] <= cnt_1;
			//		  end
				   end
				DISP_LINE4:
					begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b1;
					  SRAM_nOE <= 1'b0;
					  SRAM_ADDR <= 8'd4;
					  
				     lcd_data <= reg_lcd_data2[cnt_line];
			//		  if(cnt_clk_1000m == CNT_MAX_1000m) begin
					  reg_lcd_data1[0] <= 8'b10000000;
					 if(SRAM_DATA[15:12] > 4'd9) 
						 begin	
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd48;
						 end
					  
					  if(SRAM_DATA[11:8] > 4'd9) 
						 begin	
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd48;
						 end
					
					  if(SRAM_DATA[7:4] > 4'd9) 
						 begin	
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd48;
						 end
						 
					   if(SRAM_DATA[3:0] > 4'd9) 
						 begin	
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd48;
						 end
					  reg_lcd_data1[5] <= 8'b10000000;
					  reg_lcd_data1[6] <= 8'b10000000;
					  reg_lcd_data1[7] <= 8'b10000000;
					  reg_lcd_data1[8] <= 8'b10000000;
					  reg_lcd_data1[9] <= 8'b10000000;
					  reg_lcd_data1[10] <= 8'b10000000;
					  reg_lcd_data1[11] <= 8'b10000000;
					  reg_lcd_data1[12] <= 8'b10000000;
					  reg_lcd_data1[13] <= sec_1;
					  reg_lcd_data1[14] <= ":";
					  reg_lcd_data1[15] <= cnt_10;
					  reg_lcd_data1[16] <= cnt_1;
			//		  end
				   end
				DISP_LINE5:
				   begin
					  SRAM_nCS <= 1'b0;
					  SRAM_nWE <= 1'b1;
					  SRAM_nOE <= 1'b0;
					  SRAM_ADDR <= 8'd0;
					
				     lcd_data <= reg_lcd_data1[cnt_line];
			//		  if(cnt_clk_1000m == CNT_MAX_1000m) begin
					  reg_lcd_data1[0] <= 8'b10000000;
					 if(SRAM_DATA[15:12] > 4'd9) 
						 begin	
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[1] = {4'b0000, SRAM_DATA[15:12]}+8'd48;
						 end
					  
					  if(SRAM_DATA[11:8] > 4'd9) 
						 begin	
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[2] = {4'b0000, SRAM_DATA[11:8]}+8'd48;
						 end
					
					  if(SRAM_DATA[7:4] > 4'd9) 
						 begin	
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[3] = {4'b0000, SRAM_DATA[7:4]}+8'd48;
						 end
						 
					   if(SRAM_DATA[3:0] > 4'd9) 
						 begin	
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd55;
						 end
					  else
					    begin 
							reg_lcd_data1[4] = {4'b0000, SRAM_DATA[3:0]}+8'd48;
						 end
					  reg_lcd_data1[5] <= 8'b10000000;
					  reg_lcd_data1[6] <= 8'b10000000;
					  reg_lcd_data1[7] <= 8'b10000000;
					  reg_lcd_data1[8] <= 8'b10000000;
					  reg_lcd_data1[9] <= 8'b10000000;
					  reg_lcd_data1[10] <= 8'b10000000;
					  reg_lcd_data1[11] <= 8'b10000000;
					  reg_lcd_data1[12] <= 8'b10000000;
					  reg_lcd_data1[13] <= sec_1;
					  reg_lcd_data1[14] <= ":";
					  reg_lcd_data1[15] <= cnt_10;
					  reg_lcd_data1[16] <= cnt_1;
			//		  end
				   end
		*/	
			endcase
		end
	end
endmodule