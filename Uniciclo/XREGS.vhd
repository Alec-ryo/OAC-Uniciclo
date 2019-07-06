library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use work.xregs_pkg.all;

entity XREGS is
	generic (WSIZE : natural := 32);
	port (
			clk, wren, rst : in std_logic;
			rs1, rs2, rd : in std_logic_vector(4 downto 0);
			data : in std_logic_vector(WSIZE-1 downto 0);
			ro1, ro2 : out std_logic_vector(WSIZE-1 downto 0));
end XREGS; 

architecture behavioral of XREGS is
	signal reg : registradores;	
begin		
	proc_xregs: process (clk) begin
		if rising_edge(clk) then
			reg(0) <= X"00000000";
			if (rst = '0') then
				ro1 <= reg(to_integer(unsigned(rs1)));
				ro2 <= reg(to_integer(unsigned(rs2)));
			else 
				ro1 <= X"00000000";
				ro2 <= X"00000000";
			end if;
			
			if ((wren = '1') and (rd /= X"00000000")) then
				reg(to_integer(unsigned(rd))) <= data;
			end if;
			
		end if;
	end process;
end architecture behavioral; 