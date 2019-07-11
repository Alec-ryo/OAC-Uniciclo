LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all; 
use work.rv_pkg.all;          
 
ENTITY imm_tb IS 
END imm_tb; 
 
ARCHITECTURE tb_arch OF imm_tb IS 
--signals
	signal clk	: std_logic;
	signal saidapc   : signed(31 DOWNTO 0);
	signal pcentrada   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	component UNICICLO_RV 
		port (
				clk:			in std_logic;
				saidapc: 		OUT signed(31 DOWNTO 0);
				pcentrada:	in STD_LOGIC_VECTOR(31 DOWNTO 0)
				);
	end component;
	
	begin i1 : UNICICLO_RV PORT MAP (clk => clk, saidapc => saidapc, pcentrada => pcentrada);
	
	init : process
	BEGIN
		clk <= '0'; pcentrada <= X"00000001";
		wait for 4 ps;
		clk <= '1'; pcentrada <= X"00000002";
		wait for 4 ps;
		clk <= '0'; pcentrada <= X"00000003";
		wait for 4 ps;
		clk <= '1'; pcentrada <= X"00000004";
		wait for 4 ps;

	END PROCESS init; 
end tb_arch; 