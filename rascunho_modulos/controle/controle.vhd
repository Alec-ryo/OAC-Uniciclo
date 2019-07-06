library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use work.rv_pkg.all;

entity control is
	port (
			a 				: in  std_logic_vector(6 downto 0);
			ext_ULA		: in 	std_logic_vector();
			branch   	: out std_logic;
			memRead		: out std_logic;
			memToReg		: out std_logic;
			ALUOp			: out ULAOp;
			memWrite		: out std_logic;
			ALUSrc		: out std_logic;
			regWrite		: out std_logic;
	);
end control;

architecture behavioral of control is
	--signal a32 : std_logic_vector(31 downto 0); 
begin   
	--Z <= a32;   
	proc_controle: process (a, branch, memRead, memToReg, ALUOp, memWrite, ALUSrc, regWrite) begin
		--if (a32 = X"00000000") then zero <= '1'; else zero <= '0'; end if;  
		case a is
			-- lui
			when '0110111' => branch 	<= '0';
									memRead  <= 
									memToReg	<=
									ALUOp		<=
									memWrite	<=
									ALUSrc 	<=
									regWrite	<=
			-- jal
			when '1101111' => branch 	<= '0';
									memRead  <= 
									memToReg	<=
									ALUOp		<=
									memWrite	<=
									ALUSrc 	<=
									regWrite	<= 
			-- jalr
			when '1100111' => branch 	<= '0';
									memRead  <= 
									memToReg	<=
									ALUOp		<=
									memWrite	<=
									ALUSrc 	<=
									regWrite	<=
			-- beq, bne, blt, bge, bltu, bgeu
			when '1100011' => branch 	<= '0';
									memRead  <= 
									memToReg	<=
									ALUOp		<=
									memWrite	<=
									ALUSrc 	<=
									regWrite	<=
			-- lw
			when '0000011' => branch 	<= '0';
									memRead  <= 
									memToReg	<=
									ALUOp		<=
									memWrite	<=
									ALUSrc 	<=
									regWrite	<= 
			-- sw
			when '0100011' => branch 	<= '0';
									memRead  <= 
									memToReg	<=
									ALUOp		<=
									memWrite	<=
									ALUSrc 	<=
									regWrite	<=
			-- I 
			when '0010011' => branch 	<= '0';
									memRead  <= 
									memToReg	<=
									ALUOp		<=
									memWrite	<=
									ALUSrc 	<=
									regWrite	<=
			-- R
			when '0110011' => branch 	<= '0';
									memRead 	<= 
									memToReg	<=
									ALUOp		<= 
									memWrite	<=
									ALUSrc 	<=
									regWrite	<=
			--others
			when others  => a32 <= (others => '0'); 
		end case; 
	end process;
end architecture behavioral; 