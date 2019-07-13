library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity XREGS is
	generic (WSIZE : natural := 32);
	port (
			clk, wren, rst : in std_logic;
			rs1, rs2, rd : in std_logic_vector(4 downto 0);
			data : in std_logic_vector(WSIZE-1 downto 0);
			ro1, ro2 : out std_logic_vector(WSIZE-1 downto 0));
end XREGS; 

architecture behavioral of XREGS is
	type registradores is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal reg : registradores := (others=> (others => '0'));	
begin		

	ro1 <= X"00000000" when (rs1 = "00000") else reg(to_integer(unsigned(rs1)));
	ro2 <= X"00000000" when (rs2 = "00000") else reg(to_integer(unsigned(rs2)));

	proc_xregs: process (clk) begin
		if rising_edge(clk) then
			if (wren = '1') then
				reg(to_integer(unsigned(rd))) <= data;
			end if;
		end if;
	end process;
end architecture behavioral; 