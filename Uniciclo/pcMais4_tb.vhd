LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all; 
use work.rv_pkg.all;          
 
ENTITY pcMais4_tb IS 
END pcMais4_tb; 
 
ARCHITECTURE tb_arch OF pcMais4_tb IS 
--signals
	signal clk	: std_logic;
	signal clr  : std_logic;
--	signal saidapc   : STD_LOGIC_VECTOR(31 DOWNTO 0);
--	signal saidainstrucao   : STD_LOGIC_VECTOR(31 DOWNTO 0);
--	signal saidaimediato   : STD_LOGIC_VECTOR(31 DOWNTO 0);
--	signal pcentrada   : STD_LOGIC_VECTOR(31 DOWNTO 0);
--	signal pcmemIns : std_logic_vector(31 downto 0);
--	signal saidabranch: std_logic;
--	signal saidazero: std_logic;
--	signal saidamemRead: std_logic;
--	signal saidamemToReg: std_logic;
--	signal saidaALUOp: std_logic_vector(1 downto 0);
--	signal saidamemWrite: std_logic;
--	signal saidaALUSrc: std_logic;
--	signal saidaregWrite: std_logic;
	
	component UNICICLO_RV 
		port (
				clk :			in std_logic;
				clr :			in std_logic
--				saidapc: 		OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
--				saidainstrucao   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
--				saidaimediato   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
--				pcentrada:	in STD_LOGIC_VECTOR(31 DOWNTO 0);
--				pcmemIns : OUT std_logic_vector(31 downto 0);
--				saidabranch: OUT std_logic;
--				saidazero: OUT std_logic;
--				saidamemRead: OUT std_logic;
--				saidamemToReg: OUT std_logic;
--				saidaALUOp: OUT std_logic_vector(1 downto 0);
--				saidamemWrite: OUT std_logic;
--				saidaALUSrc: OUT std_logic;
--				saidaregWrite: OUT std_logic
				);
	end component;
	
	begin i1 : UNICICLO_RV PORT MAP (
		clk => clk,
		clr => clr
		
	);
--	saidapc => saidapc, 
--	saidainstrucao => saidainstrucao, 
--	saidaimediato => saidaimediato, 
--	pcentrada => pcentrada,
--	pcmemIns => pcmemIns,
--	saidabranch => saidabranch,
--	saidazero => saidazero,
--	saidamemRead => saidamemRead,
--	saidamemToReg => saidamemToReg,
--	saidaALUOp => saidaALUOp,
--	saidamemWrite => saidamemWrite,
--	saidaALUSrc => saidaALUSrc,
--	saidaregWrite => saidaregWrite);
	
	init : process
	BEGIN

		clr <= '1';
		wait for 10 ps;
		clr <= '0';
		
--		clk <= '0'; 
--		pcentrada <= X"00000001";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000002";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000003";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000001";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000004";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000005";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000006";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000007";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
--		clk <= '0'; 
--		pcentrada <= X"00000008";
--		wait for 4 ps;
--		clk <= '1';
--		wait for 4 ps;
WAIT;
	END PROCESS init; 
	
clkgen: process
begin
	clk <= '1';
	wait for 4 ps;
	clk <= '0';
	wait for 4 ps;
end process;
	
	
end tb_arch; 