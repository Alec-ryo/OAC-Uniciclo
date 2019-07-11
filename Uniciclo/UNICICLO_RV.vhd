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
		saidainstrucao   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		saidaimediato   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		pcentrada   : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		pcmemIns : OUT std_logic_vector(31 downto 0);
		saidabranch: OUT std_logic;
		saidazero: OUT std_logic;
		saidamemRead: OUT std_logic;
		saidamemToReg: OUT std_logic;
		saidaALUOp: OUT std_logic_vector(1 downto 0);
		saidamemWrite: OUT std_logic;
		saidaALUSrc: OUT std_logic;
		saidaregWrite: OUT std_logic
		);
end UNICICLO_RV; 

architecture behavioral of UNICICLO_RV is
	
	--declaracao de sinais
	signal PCmais4 : std_logic_vector(31 downto 0);
	signal PCfinal : std_logic_vector(31 downto 0) := X"00000000";
	signal PCend : std_logic_vector(31 downto 0) := X"00000000";
	signal pcIN : std_logic_vector(31 downto 0);
	signal instrucao : std_logic_vector(31 downto 0);
	signal dado1 : std_logic_vector(31 downto 0);
	signal dado2 : std_logic_vector(31 downto 0);
	signal imm : std_logic_vector(31 downto 0);
	signal saida_ULA : std_logic_vector(31 downto 0);
	signal mem_to_write : std_logic_vector(31 downto 0);
	signal saida_mem : std_logic_vector(31 downto 0);
	signal imediato : std_logic_vector(31 downto 0);
	signal endJump : std_logic_vector(31 downto 0);
	signal branch: std_logic;
	signal zero: std_logic;
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
				 q: 	OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
	
	component adder32 
		port (
				a:			in STD_LOGIC_VECTOR(31 DOWNTO 0);
				b: 		in STD_LOGIC_VECTOR(31 DOWNTO 0);
				ro: 		OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
	
	component memIns
		port (
				address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
				clock		: IN STD_LOGIC;
				data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
				wren		: IN STD_LOGIC ;
				q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;
	
	component XREGS
		port (
				clk, wren, rst : in std_logic;
				rs1, rs2, rd : in std_logic_vector(4 downto 0);
				data : in std_logic_vector(31 downto 0);
				ro1, ro2 : out std_logic_vector(31 downto 0));
	end component;
	
	component mux2x1
		port (
				a, b : in  std_logic_vector(31 downto 0);
				e	  : in std_logic;
				ro   :   out std_logic_vector(31 downto 0));
	end component;
	
	component ULA_RV
		port (
				opcode:  in  ULA_OP;          
				A, B: 	in  std_logic_vector(31 downto 0);           
				Z: 		out std_logic_vector(31 downto 0);          
				zero: 	out std_logic);
	end component;
	
	component memDados
		port (
				address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
				clock		: IN STD_LOGIC  := '1';
				data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
				wren		: IN STD_LOGIC ;
				q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;
	
	component genImm32 is
		port (
				instr:   in  std_logic_vector(31 downto 0);
				imm32:	out std_logic_vector(31 downto 0)
				);
	end component; 
	
	component control is
		port (
				a 				: in  std_logic_vector(6 downto 0);
				branch   	: out std_logic;
				memRead		: out std_logic;
				memToReg		: out std_logic;
				ALUOp			: out std_logic_vector(1 downto 0);
				memWrite		: out std_logic;
				ALUSrc		: out std_logic;
				regWrite		: out std_logic
		);
	end component;

begin
	igh: 	PC PORT MAP (d => PCfinal, clr => '0', clk => clk, q => pcIN);
	i3:	adder32 PORT MAP (a => pcIN, b => X"00000001", ro=>PCmais4);
	i2:	memIns PORT MAP (address => pcIN(7 downto 0), clock => clk, data => X"0000FFFF", wren => '0', q => instrucao);
	i7:   control PORT MAP (a => instrucao(31 downto 25), branch => branch, memRead => memRead, memToReg => memToReg, ALUOp => ALUOp, memWrite => memWrite, ALUSrc => ALUSrc, regWrite => regWrite);
	i4:	genImm32 PORT MAP (instr => instrucao, imm32 => imediato);
	i5:	adder32 PORT MAP (a => PCmais4, b => imediato, ro => endJump);
	i6:	mux2x1 PORT MAP (a => PCmais4, b => endJump, e => branch, ro => PCend);
	process (clk)
	BEGIN
	if rising_edge(clk) then
		PCfinal <= PCend;
		saidaimediato <= imediato;
		saidapc <= PCfinal;
		saidainstrucao <= instrucao;
		pcmemIns <= pcIN;
		saidaALUOp <= ALUOp;
		saidaALUSrc <= ALUSrc;
		saidabranch <= branch;
		saidamemRead <= memRead;
		saidamemToReg <= memToReg;
		saidamemWrite <= memWrite;
		saidaregWrite <= regWrite;
		saidazero <= zero;
	end if;
	END PROCESS; 
	
end behavioral;

