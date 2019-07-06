library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity PC is
	port (a  : in  std_logic_vector(31 downto 0);
			ro : out std_logic_vector(31 downto 0));
end PC;

architecture behavioral of PC is

begin

	ro <= std_logic_vector(signed(a) + signed(b));
	
end behavioral;