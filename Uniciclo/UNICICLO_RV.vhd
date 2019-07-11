library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use work.rv_pkg.all;
use work.imm_pkg.all;
use work.xregs_pkg.all;

entity UNICICLO_RV is
	port (
		clk	: in std_logic;
		saidapc   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		pcentrada   : in STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
end UNICICLO_RV; 

architecture behavioral of UNICICLO_RV is
	
	--declaracao de sinais
	signal PCmais4 : std_logic_vector(31 downto 0);
	signal pcIN : std_logic_vector(31 downto 0);
	signal instrucao : std_logic_vector(31 downto 0);
	signal dado1 : std_logic_vector(31 downto 0);
	signal dado2 : std_logic_vector(31 downto 0);
	signal imm : std_logic_vector(31 downto 0);
	signal saida_ULA : std_logic_vector(31 downto 0);
	signal mem_to_write : std_logic_vector(31 downto 0);
	signal saida_mem : std_logic_vector(31 downto 0);
	signal branch: std_logic;
	signal memRead: std_logic;
	signal memToReg: std_logic;
	signal ALUOp: std_logic_vector(1 downto 0);
	signal memWrite: std_logic;
	signal ALUSrc: std_logic;
	signal regWrite: std_logic;
	signal soma4: std_logic_vector(31 downto 0);
	
	component PC 
		port (
				 d: 	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				 clr: IN STD_LOGIC; -- clear.
				 clk: IN STD_LOGIC; -- clock.
				 q: 	OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
				);
	end component;
	
	component adder32 
		port (
				a:			in STD_LOGIC_VECTOR(31 DOWNTO 0);
				b: 		in STD_LOGIC_VECTOR(31 DOWNTO 0);
				ro: 		OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
				);
	end component;
	
	component memIns
		port (
				address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
				clock		: IN STD_LOGIC;
				data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
				wren		: IN STD_LOGIC ;
				q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
				);
	end component;

begin
	igh : PC PORT MAP (d => pcentrada, clr => '0', clk => clk, q => PCin);
	i2  : memIns PORT MAP (address => pcIN(9 downto 2), clock => clk, data => X"00000000", wren => '0', q => saidapc);
	--i3 : adder32 PORT MAP (a => pcIN, b => X"00000004", ro=>saidapc);
	
end behavioral;

