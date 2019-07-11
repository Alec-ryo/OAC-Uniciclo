LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;           
 
ENTITY pc_tb IS 
END pc_tb; 
 
ARCHITECTURE tb_arch OF pc_tb IS 
--signals
	signal d   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal clr : STD_LOGIC; -- async. clear.
	signal clk : STD_LOGIC; -- clock.
	signal q   : STD_LOGIC_VECTOR(31 DOWNTO 0); -- output
	
	component PC 
		port (
				d   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				clr : IN STD_LOGIC; -- async. clear.
				clk : IN STD_LOGIC; -- clock.
				q   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)); -- output
	end component;
	
	begin i1 : PC PORT MAP (d=>d, clr=>clr, clk=>clk, q=>q);
	
	init : process
	BEGIN
	
		clk <= '0';
		clr <= '0';
		d <= X"0000FFFF";
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0';
		d <= X"FFFFF000";
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		
	END PROCESS init; 
end tb_arch; 