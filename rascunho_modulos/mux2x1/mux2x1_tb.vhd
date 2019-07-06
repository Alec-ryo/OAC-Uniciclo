LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;           
 
ENTITY mux2x1_tb IS 
END mux2x1_tb; 
 
ARCHITECTURE tb_arch OF mux2x1_tb IS 
--signals
	SIGNAL a : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL b : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL e : STD_LOGIC;
	SIGNAL ro: STD_LOGIC_VECTOR(31 downto 0);
	
	component mux2x1 
		port (a, b : in  std_logic_vector(31 downto 0);
				e	  : in std_logic;
				ro   : out std_logic_vector(31 downto 0));
	end component;
	
	begin i1 : mux2x1 PORT MAP (a => a, b => b, e => e, ro => ro);
	
	init : process
	BEGIN
		a <= X"F0000FF0"; b <= X"00000005"; e <= '0'; 
		wait for 4 ps;  
		a <= X"F0000FF0"; b <= X"00000005"; e <= '1'; 
		wait for 4 ps;
		a <= X"F0000001"; b <= X"00000001"; e <= '0'; 
		wait for 4 ps;
		a <= X"F000000F"; b <= X"00000001"; e <= '1'; 
		wait for 4 ps;
		a <= X"0000000F"; b <= X"0000000F"; e <= '0'; 
		wait for 4 ps;
		a <= X"0000000F"; b <= X"0000000F"; e <= '1'; 
		wait for 4 ps;
	END PROCESS init; 
end tb_arch; 