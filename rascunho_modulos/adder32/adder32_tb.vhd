LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;           
 
ENTITY adder32_tb IS 
END adder32_tb; 
 
ARCHITECTURE tb_arch OF adder32_tb IS 
--signals
	SIGNAL a : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL b : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL ro : STD_LOGIC_VECTOR(31 downto 0);
	
	component adder32 
		port (
				a, b : in  std_logic_vector(31 downto 0);
				ro :   out std_logic_vector(31 downto 0));
	end component;
	
	begin i1 : adder32 PORT MAP (a => a, b => b, ro => ro);
	
	init : process
	BEGIN
		a <= X"0000000F"; b <= X"00000002"; 
		wait for 4 ps;  
		a <= X"F0000FF0"; b <= X"00000005"; 
		wait for 4 ps;  
		a <= X"F0000FF0"; b <= X"00000005";
		wait for 4 ps;
		a <= X"F0000001"; b <= X"00000001";
		wait for 4 ps;
		a <= X"F000000F"; b <= X"00000001";
		wait for 4 ps;
		a <= X"0000000F"; b <= X"0000000F";
		wait for 4 ps;
		a <= X"0000000F"; b <= X"0000000F";
		wait for 4 ps;
	END PROCESS init; 
end tb_arch; 