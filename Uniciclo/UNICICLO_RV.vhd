library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use work.rv_pkg.all;
use work.imm_pkg.all;
use work.xregs_pkg.all;

entity UNICICLO_RV is
	port (
		clk		: in std_logic;
		clk_mem	: in std_logic;
		clr   	: in std_logic
		);
end UNICICLO_RV; 

architecture behavioral of UNICICLO_RV is
	
	--declaracao de sinais
	signal PCmais4 : std_logic_vector(31 downto 0) := X"00000000";
	signal PCfinal : std_logic_vector(31 downto 0) := X"00000000";
	signal PCend : std_logic_vector(31 downto 0) := X"00000000";
	signal pcout : std_logic_vector(31 downto 0);
	signal instrucao : std_logic_vector(31 downto 0);
	signal dado1 : std_logic_vector(31 downto 0);
	signal dado2 : std_logic_vector(31 downto 0);
	signal saida_ULA : std_logic_vector(31 downto 0);
	signal mem_to_reg : std_logic_vector(31 downto 0);
	signal saida_mem : std_logic_vector(31 downto 0);
	signal imediato : std_logic_vector(31 downto 0);
	signal endJump : std_logic_vector(31 downto 0);
	signal branch: std_logic;
	signal zero: std_logic;
	signal memRead: std_logic;
	signal memToReg: std_logic;
	signal ALUOp: std_logic_vector(1 downto 0);
	signal cntrULA_ULA: ULA_OP;
	signal memWrite: std_logic;
	signal ALUSrc: std_logic;
	signal regWrite: std_logic;
	signal soma4: std_logic_vector(31 downto 0);
	signal rd2OUimm: std_logic_vector(31 downto 0);
	signal memOUula: std_logic_vector(31 downto 0);
	signal jal: std_logic;
	signal jalr: std_logic;
	signal lui: std_logic;
	signal bne: std_logic;
	signal blt: std_logic;
	signal bgt: std_logic; 
	signal zero_and_branch: std_logic;
	signal faz_jump: std_logic;
	signal muxULAmem_OU_PCmais4: std_logic_vector(31 downto 0);
	signal saida_muxULAmem: std_logic_vector(31 downto 0);
	signal saida_branchOUPCmais4: std_logic_vector(31 downto 0);
	signal mux_jal_out: std_logic_vector(31 downto 0);
	signal vai_reg: std_logic_vector(31 downto 0);
	signal jal_or_jalr: std_logic;
	signal resultado_zero: std_logic;
	signal vai_MuxDataJal: std_logic_vector(31 downto 0);
	signal endJalr: std_logic_vector(31 downto 0);
	signal PCjalr: std_logic_vector(31 downto 0);
	
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
				funct3		: in  std_logic_vector(2 downto 0);
				branch   	: out std_logic;
				memRead		: out std_logic;
				memToReg		: out std_logic;
				ALUOp			: out std_logic_vector(1 downto 0);
				memWrite		: out std_logic;
				ALUSrc		: out std_logic;
				regWrite		: out std_logic;
				jal			: out std_logic;
				jalr			: out std_logic;
				lui			: out std_logic;
				bne			: out std_logic;
				blt			: out std_logic;
				bgt			: out std_logic
		);
	end component;
	
	component cntrULA is
		port (
			funct7 : in std_logic_vector(6 downto 0);
			funct3 : in std_logic_vector(2 downto 0);
			aluop  : in std_logic_vector(1 downto 0);
			aluctr : out ULA_OP
		);
	end component;
		
begin
	
--======================PC+4/BRANCH=======================--
	pcpath1 : PC PORT MAP (d => PCend, clr => clr, clk => clk, q => pcout);
	pcpath2 : adder32 PORT MAP (a => pcout, b => X"00000004", ro=>PCmais4);
	pcpath3 : memIns PORT MAP (address => pcout(9 downto 2), clock => clk_mem, data => X"00000000", wren => '0', q => instrucao);
	pcpath4 : control PORT MAP (a => instrucao(6 downto 0), funct3=>instrucao(14 downto 12), branch => branch, memRead => memRead, memToReg => memToReg, ALUOp => ALUOp, memWrite => memWrite, ALUSrc => ALUSrc, regWrite => regWrite, jal => jal, jalr => jalr, lui => lui, bne => bne, blt => blt, bgt => bgt);
	pcpath5 : genImm32 PORT MAP (instr => instrucao, imm32 => imediato);
	pcpath6 : adder32 PORT MAP (a => pcout, b => imediato, ro => endJump);
	pcpath7 : mux2x1 PORT MAP (a => PCmais4, b => endJump, e => faz_jump, ro => PCjalr);
	pcpath8 : adder32 PORT MAP (a => dado1, b => imediato, ro=>endJalr);
	pcpath9 : mux2x1 PORT MAP (a => PCjalr, b => endJalr, e => jalr, ro => PCend);
--========================================================--

--==================Caminho de instrucoes=================--
	i_cntrULA : cntrULA PORT MAP(funct7=>instrucao(31 downto 25) ,funct3=>instrucao(14 downto 12), aluop=>ALUOp, aluctr=>cntrULA_ULA);
	i_XREGS : XREGS PORT MAP(clk=>clk, wren=>regWrite, rst=>clr, rs1=>instrucao(19 downto 15), rs2=>instrucao(24 downto 20), rd=>instrucao(11 downto 7), data=>vai_reg, ro1=>dado1, ro2=>dado2);
	i_MuxULAB : mux2x1 PORT MAP(a=>dado2,b=>imediato,e=>ALUSrc,ro=>rd2OUimm);
	i_ULA : ULA_RV PORT MAP(opcode=>cntrULA_ULA, A=>dado1, B=>rd2OUimm, Z=>saida_ULA, zero=>zero);
	i_MD : memDados PORT MAP(address=>saida_ULA(9 downto 2), clock=>clk_mem, data=>dado2, wren=>memWrite, q=>saida_mem);
	i_MuxDataReg : mux2x1 PORT MAP(a=>saida_ULA,b=>saida_mem,e=>memToReg,ro=>vai_MuxDataJal);
	i_MuxDataJal : mux2x1 PORT MAP(a=>vai_MuxDataJal,b=>PCmais4,e=>jal,ro=>vai_reg);
--========================================================--

	process (jal, jalr, branch, zero, bne)
	BEGIN
		faz_jump <= jal or (branch and zero) or jalr or (not(zero) and bne);
	END PROCESS; 
	
end behavioral;

