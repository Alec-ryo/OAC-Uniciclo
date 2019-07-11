LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all; 
use work.rv_pkg.all;          
 
ENTITY pcMais4_tb IS 
END pcMais4_tb; 
 
ARCHITECTURE tb_arch OF pcMais4_tb IS 
--signals
	signal clk	: std_logic;
	signal saidapc   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal saidainstrucao   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal saidaimediato   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal pcmemIns : std_logic_vector(31 downto 0);
	
	component UNICICLO_RV 
		port (
				clk:			in std_logic;
				saidapc: 		OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				saidainstrucao   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				saidaimediato   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				pcmemIns : OUT std_logic_vector(31 downto 0)
				);
	end component;
	
	begin i1 : UNICICLO_RV PORT MAP (
	clk => clk, 
	saidapc => saidapc, 
	saidainstrucao => saidainstrucao, 
	saidaimediato => saidaimediato, 
	pcmemIns => pcmemIns);
	
	init : process
	BEGIN
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;
		clk <= '0'; 
		wait for 4 ps;
		clk <= '1';
		wait for 4 ps;

	END PROCESS init; 
end tb_arch; 