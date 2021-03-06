library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity host_io1 is
	port(
			CLK 	: in std_logic;
			nCS		: in std_logic;
			nOE 	: in std_logic;
			nWE		: in std_logic;
			Hdo 	: in std_logic_vector(15 downto 0);
			Hdi 	: out std_logic_vector(15 downto 0);
			Hdata	: inout std_logic_vector(15 downto 0)
		);
end host_io1;


architecture behav of host_io1 is

signal re_dly,re_dly1 : std_logic;
 
begin


cdly: process(CLK)
	begin
	if CLK'event and CLK = '1' then
		re_dly <= nOE;
		re_dly1 <= re_dly;
	end if;
	end process cdly;
	
write: process(nCS)
	begin
		if falling_edge(nCS) then
			Hdi <= Hdata;
		end if;
	end process write;

read: process(nCS,nOE,re_dly1,Hdo)
	begin
		if nCS = '0' then
			if(nOE and re_dly1) = '0'then
				Hdata <= Hdo;
			else
				Hdata <= (others=>'Z');
			end if;
		else
			Hdata <= (others=>'Z');
		end if;
	end process read;
	


end behav;

		