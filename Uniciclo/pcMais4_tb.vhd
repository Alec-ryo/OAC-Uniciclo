LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all; 
use work.rv_pkg.all;          
 
ENTITY pcMais4_tb IS 
END pcMais4_tb; 
 
ARCHITECTURE tb_arch OF pcMais4_tb IS 
--signals
	signal clk		: std_logic;
	signal clr  	: std_logic;
	signal clk_mem : std_logic;
	
	component UNICICLO_RV 
		port (
				clk :			in std_logic;
				clr :			in std_logic;
				clk_mem: 	in std_logic
				);
	end component;
	
	begin i1 : UNICICLO_RV PORT MAP (
		clk => clk,
		clr => clr,
		clk_mem => clk_mem
	);
	
	init : process
	BEGIN

		clr <= '1';
		wait for 10 ps;
		clr <= '0';
		
		WAIT;
	END PROCESS init; 
	
	clkgen: process
	begin
		clk <= '1';
		wait for 10 ps;
		clk <= '0';
		wait for 10 ps;
	end process;
	
	clkgenmem: process
	begin
		clk_mem <= '1';
		wait for 1 ps;
		clk_mem <= '0';
		wait for 1 ps;
	end process;
	
end tb_arch; 