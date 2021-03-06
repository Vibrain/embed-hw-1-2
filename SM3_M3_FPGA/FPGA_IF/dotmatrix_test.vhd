library ieee;
use ieee.std_logic_1164.all;

entity dotmatrix_test1 is
port (
	clk 		: in std_logic;
		
	dot_d 		: out std_logic_vector ( 6 downto 0);
	dot_scan 	: out std_logic_vector ( 9 downto 0);
	nreset		: in std_logic);
end dotmatrix_test1;

architecture hb of dotmatrix_test1 is

component dot_disp
port (
	clk 		: in std_logic;
	dot_data_00 : in std_logic_vector (6 downto 0);
	dot_data_01 : in std_logic_vector (6 downto 0);
	dot_data_02 : in std_logic_vector (6 downto 0);
	dot_data_03 : in std_logic_vector (6 downto 0);
	dot_data_04 : in std_logic_vector (6 downto 0);
	dot_data_05 : in std_logic_vector (6 downto 0);
	dot_data_06 : in std_logic_vector (6 downto 0);
	dot_data_07 : in std_logic_vector (6 downto 0);
	dot_data_08 : in std_logic_vector (6 downto 0);
	dot_data_09 : in std_logic_vector (6 downto 0);	
	dot_d : out std_logic_vector (6 downto 0);
	dot_scan : out std_logic_vector (9 downto 0);
	nreset : in std_logic);
end component;

signal dot_data_00 : std_logic_vector (6 downto 0);
signal dot_data_01 : std_logic_vector (6 downto 0);
signal dot_data_02 : std_logic_vector (6 downto 0);
signal dot_data_03 : std_logic_vector (6 downto 0);
signal dot_data_04 : std_logic_vector (6 downto 0);
signal dot_data_05 : std_logic_vector (6 downto 0);
signal dot_data_06 : std_logic_vector (6 downto 0);
signal dot_data_07 : std_logic_vector (6 downto 0);
signal dot_data_08 : std_logic_vector (6 downto 0);
signal dot_data_09 : std_logic_vector (6 downto 0);

signal data_00 : std_logic_vector (6 downto 0);
signal data_01 : std_logic_vector (6 downto 0);
signal data_02 : std_logic_vector (6 downto 0);
signal data_03 : std_logic_vector (6 downto 0);
signal data_04 : std_logic_vector (6 downto 0);
signal data_05 : std_logic_vector (6 downto 0);
signal data_06 : std_logic_vector (6 downto 0);
signal data_07 : std_logic_vector (6 downto 0);
signal data_08 : std_logic_vector (6 downto 0);
signal data_09 : std_logic_vector (6 downto 0);
signal data_10 : std_logic_vector (6 downto 0);
signal data_11 : std_logic_vector (6 downto 0);
signal data_12 : std_logic_vector (6 downto 0);
signal data_13 : std_logic_vector (6 downto 0);
signal data_14 : std_logic_vector (6 downto 0);
signal data_15 : std_logic_vector (6 downto 0);
signal data_16 : std_logic_vector (6 downto 0);
signal data_17 : std_logic_vector (6 downto 0);
signal data_18 : std_logic_vector (6 downto 0);
signal data_19 : std_logic_vector (6 downto 0);
signal data_20 : std_logic_vector (6 downto 0);
signal data_21 : std_logic_vector (6 downto 0);
signal data_22 : std_logic_vector (6 downto 0);
signal data_23 : std_logic_vector (6 downto 0);
signal data_24 : std_logic_vector (6 downto 0);
signal data_25 : std_logic_vector (6 downto 0);
signal data_26 : std_logic_vector (6 downto 0);
signal data_27 : std_logic_vector (6 downto 0);
signal data_28 : std_logic_vector (6 downto 0);
signal data_29 : std_logic_vector (6 downto 0);
signal data_30 : std_logic_vector (6 downto 0);
signal data_31 : std_logic_vector (6 downto 0);
signal data_32 : std_logic_vector (6 downto 0);
signal data_33 : std_logic_vector (6 downto 0);
signal data_34 : std_logic_vector (6 downto 0);
signal data_35 : std_logic_vector (6 downto 0);
signal data_36 : std_logic_vector (6 downto 0);
signal data_37 : std_logic_vector (6 downto 0);
signal data_38 : std_logic_vector (6 downto 0);
signal data_39 : std_logic_vector (6 downto 0);
signal data_40 : std_logic_vector (6 downto 0);
signal data_41 : std_logic_vector (6 downto 0);
signal data_42 : std_logic_vector (6 downto 0);
signal data_43 : std_logic_vector (6 downto 0);



signal cnt_clk : integer range 99 downto 0;
signal cnt_data : integer range 43 downto 0;
signal clk_20h : std_logic;

begin

data_00 <= "0111110";
data_01 <= "0001000";
data_02 <= "0001000";
data_03 <= "0111110";
data_04 <= "0000000";
data_05 <= "0111100";
data_06 <= "0001010";
data_07 <= "0001010";
data_08 <= "0111100";
data_09 <= "0000000";
data_10 <= "0111110";
data_11 <= "0001100";
data_12 <= "0011000";
data_13 <= "0111110";
data_14 <= "0000000";
data_15 <= "0111110";
data_16 <= "0101010";
data_17 <= "0101010";
data_18 <= "0010100";
data_19 <= "0000000";
data_20 <= "0111100";
data_21 <= "0001010";
data_22 <= "0001010";
data_23 <= "0111100";
data_24 <= "0000000";
data_25 <= "0011100";
data_26 <= "0100010";
data_27 <= "0100010";
data_28 <= "0100010";
data_29 <= "0000000";
data_30 <= "0111110";
data_31 <= "0001000";
data_32 <= "0010100";
data_33 <= "0100010";
data_34 <= "0000000";
data_35 <= "0110000";
data_36 <= "0110000";
data_37 <= "0000000";
data_38 <= "0000000";
data_39 <= "0000000";
data_40 <= "0000000";
data_41 <= "0000000";
data_42 <= "0000000";
data_43 <= "0000000";


process (clk)
begin
	if clk'event and clk = '1' then
		if cnt_clk = 99 then
			cnt_clk <= 0;
			clk_20h <= not clk_20h;
		else
			cnt_clk <= cnt_clk + 1;
			clk_20h <= clk_20h;
		end if;
	end if;
end process;

process (nreset, clk_20h)
begin
	if nreset = '0' then
		cnt_data <= 0;
	elsif clk_20h'event and clk_20h = '1' then
		if cnt_data = 43 then
			cnt_data <= 0;
		else
			cnt_data <= cnt_data + 1;
		end if;
	end if;
end process;

process (nreset, clk_20h)
begin
	if nreset = '0' then
		dot_data_00 <= (others => '0');
		dot_data_01 <= (others => '0');
		dot_data_02 <= (others => '0');
		dot_data_03 <= (others => '0');
		dot_data_04 <= (others => '0');
		dot_data_05 <= (others => '0');
		dot_data_06 <= (others => '0');
		dot_data_07 <= (others => '0');
		dot_data_08 <= (others => '0');
		dot_data_09 <= (others => '0');
	elsif clk_20h'event and clk_20h = '1' then
		dot_data_00 <= dot_data_01;
		dot_data_01 <= dot_data_02;
		dot_data_02 <= dot_data_03;
		dot_data_03 <= dot_data_04;
		dot_data_04 <= dot_data_05;
		dot_data_05 <= dot_data_06;
		dot_data_06 <= dot_data_07;
		dot_data_07 <= dot_data_08;
		dot_data_08 <= dot_data_09;
		case cnt_data is
			when 0 =>
				dot_data_09 <= data_00;
			when 1 =>
				dot_data_09 <= data_01;
			when 2 =>
				dot_data_09 <= data_02;
			when 3 =>
				dot_data_09 <= data_03;
			when 4 =>
				dot_data_09 <= data_04;
			when 5 =>
				dot_data_09 <= data_05;
			when 6 =>
				dot_data_09 <= data_06;
			when 7 =>
				dot_data_09 <= data_07;
			when 8 =>
				dot_data_09 <= data_08;
			when 9 =>
				dot_data_09 <= data_09;
			when 10 =>
				dot_data_09 <= data_10;
			when 11 =>
				dot_data_09 <= data_11;
			when 12 =>
				dot_data_09 <= data_12;
			when 13 =>
				dot_data_09 <= data_13;
			when 14 =>
				dot_data_09 <= data_14;
			when 15 =>
				dot_data_09 <= data_15;
			when 16 =>
				dot_data_09 <= data_16;
			when 17 =>
				dot_data_09 <= data_17;		
			when 18 =>
				dot_data_09 <= data_18;
			when 19 =>
				dot_data_09 <= data_19;		
			when 20 =>
				dot_data_09 <= data_20;
			when 21 =>
				dot_data_09 <= data_21;		
			when 22 =>
				dot_data_09 <= data_22;
			when 23 =>
				dot_data_09 <= data_23;		
			when 24 =>
				dot_data_09 <= data_24;
			when 25 =>
				dot_data_09 <= data_25;
			when 26 =>
				dot_data_09 <= data_26;
			when 27 =>
				dot_data_09 <= data_27;
			when 28 =>
				dot_data_09 <= data_28;
			when 29 =>
				dot_data_09 <= data_29;
			when 30 =>
				dot_data_09 <= data_30;
			when 31 =>
				dot_data_09 <= data_31;
			when 32 =>
				dot_data_09 <= data_32;	
			when 33 =>
				dot_data_09 <= data_33;	
			when 34 =>
				dot_data_09 <= data_34;
			when 35 =>
				dot_data_09 <= data_35;
			when 36 =>
				dot_data_09 <= data_36;
			when 37 =>
				dot_data_09 <= data_37;
			when 38 =>
				dot_data_09 <= data_38;
			when 39 =>
				dot_data_09 <= data_39;
			when 40 =>
				dot_data_09 <= data_40;
			when 41 =>
				dot_data_09 <= data_41;
			when 42 =>
				dot_data_09 <= data_42;
			when 43 =>
				dot_data_09 <= data_43;
			when others => null;									
		end case;
	end if;
end process;

u0 : dot_disp
port map (
	clk => clk,
	dot_data_00 => dot_data_00,
	dot_data_01 => dot_data_01,
	dot_data_02 => dot_data_02,
	dot_data_03 => dot_data_03,
	dot_data_04 => dot_data_04,
	dot_data_05 => dot_data_05,
	dot_data_06 => dot_data_06,
	dot_data_07 => dot_data_07,
	dot_data_08 => dot_data_08,
	dot_data_09 => dot_data_09,
	dot_d => dot_d,
	dot_scan => dot_scan,
	nreset => nreset
);
end hb;