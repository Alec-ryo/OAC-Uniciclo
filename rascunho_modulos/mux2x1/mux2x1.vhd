library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity mux2x1 is
	port (a, b : in  std_logic_vector(31 downto 0);
			e	  : in std_logic;
			ro   :   out std_logic_vector(31 downto 0));
end mux2x1;

architecture behavioral of mux2x1 is
	signal saida : std_logic_vector(31 downto 0);
begin
	ro <= saida;
	proc_mux2x1: process (a, b, e, saida) begin
		case e is
			when '0' => saida <= a;
			when others => saida <= b;
		end case;
	end process;
end behavioral;