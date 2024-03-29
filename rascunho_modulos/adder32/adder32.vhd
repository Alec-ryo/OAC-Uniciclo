library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity adder32 is
	port (
			a, b : in  std_logic_vector(31 downto 0);
			ro :   out std_logic_vector(31 downto 0));
end adder32;

architecture behavioral of adder32 is

begin

	ro <= std_logic_vector(signed(a) + signed(b));
	
end behavioral;