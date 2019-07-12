LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;         
 
ENTITY control_tb IS 
END control_tb; 
 
ARCHITECTURE tb_arch OF control_tb IS 
--signals
	SIGNAL 	a 				: std_logic_vector(6 downto 0);
	SIGNAL	funct3		: std_logic_vector(2 downto 0);
	SIGNAL 	branch   	: std_logic;
	SIGNAL 	memRead		: std_logic;
	SIGNAL	memToReg		: std_logic;
	SIGNAL	ALUOp			: std_logic_vector(1 downto 0);
	SIGNAL	memWrite		: std_logic;
	SIGNAL	ALUSrc		: std_logic;
	SIGNAL	regWrite		: std_logic;
	SIGNAL	jal			: std_logic;
	SIGNAL	jalr 			: std_logic;
	SIGNAL	lui			: std_logic;
	SIGNAL	bne			: std_logic;
	SIGNAL	blt			: std_logic;
	SIGNAL	bgt 			: std_logic;
	
	component control 
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
				jalr 			: out std_logic;
				lui			: out std_logic;
				bne			: out std_logic;
				blt			: out std_logic;
				bgt 			: out std_logic
				);
	end component;
	
	begin i1 : control PORT MAP (a=>a,funct3=>funct3,branch=>branch,memRead=>memRead,memToReg=>memToReg,ALUOp=>ALUOp,memWrite=>memWrite,ALUSrc=>ALUSrc,regWrite=>regWrite,jal=>jal,jalr=>jalr,lui=>lui,bne=>bne,blt=>blt,bgt=>bgt);
				
	init : process
	BEGIN
		a <= "1100011"; funct3 <= "000"; --beq
		wait for 4 ps;
		a <= "1100011"; funct3 <= "001"; --bne
		wait for 4 ps;
		a <= "1100011"; funct3 <= "100"; --blt
		wait for 4 ps;  
		a <= "1100011"; funct3 <= "101"; --bgt
		wait for 4 ps;
		a <= "0110011"; --add
		wait for 4 ps;
		a <= "0010011"; --addi
		wait for 4 ps;
		a <= "0000011"; --lw
		wait for 4 ps;
		a <= "0100011"; --sw
		wait for 4 ps;
		a <= "1101111"; --jal
		wait for 4 ps;
		a <= "1100111"; --jalr
		wait for 4 ps;
	END PROCESS init; 
end tb_arch; 