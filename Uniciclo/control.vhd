library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity control is
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
end entity;

architecture behavioral of control is
begin   
	process (a) begin		  
		-- lui
		if a = "0110111" then
			branch 	<= '0'; --corrigir
			memRead  <= '0'; --corrigir
			memToReg	<= '0'; --corrigir
			ALUOp		<= "00"; --corrigir
			memWrite	<= '0'; --ok
			ALUSrc 	<= '1'; --ok
			regWrite	<= '1'; --ok
			jal		<= '0';
			jalr		<= '0';
			lui		<= '1';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
		
		-- jal	
		elsif a = "1101111" then 
			branch 	<= '1'; --ok
			memRead  <= '0'; --ok
			memToReg	<= '0'; --ok
			ALUOp		<= "00"; --corrigir
			memWrite	<= '0'; --ok
			ALUSrc 	<= '0'; --corrigir
			regWrite	<= '1'; --corrigir
			jal		<= '1';
			jalr		<= '0';
			lui		<= '0';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
			
		-- jalr
		elsif a = "1100111" then
			branch 	<= '1'; --ok
			memRead  <= '0'; --ok
			memToReg	<= '0'; --ok
			ALUOp		<= "00"; --corrigir
			memWrite	<= '0'; --ok
			ALUSrc 	<= '1'; --ok
			regWrite	<= '1'; --ok
			jal		<= '0';
			jalr		<= '1';
			lui		<= '0';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
			
		-- BType
		elsif a = "1100011" then
			branch 	<= '1';
			memRead  <= '0';
			memToReg	<= '0'; --dont care
			ALUOp		<= "01";
			memWrite	<= '0';
			ALUSrc 	<= '0';
			regWrite	<= '0';
			jal		<= '0';
			jalr		<= '0';
			lui		<= '0';
			if funct3 = "000" then
				bne<='0'; blt<='0'; bgt<='0';
			elsif funct3 = "001" then
				bne<='1'; blt<='0'; bgt<='0';
			elsif funct3 = "100" then
				bne<='0'; blt<='1'; bgt<='0';
			else --bgt
				bne<='0'; blt<='0'; bgt<='1';
			end if;
			
		-- lw ok
		elsif a = "0000011" then
			branch 	<= '0';
			memRead  <= '1';
			memToReg	<= '1';
			ALUOp		<= "00";
			memWrite	<= '0';
			ALUSrc 	<= '1';
			regWrite	<= '1';
			jal		<= '0';
			jalr		<= '0';
			lui		<= '0';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
		
		-- sw 
		elsif a = "0100011" then
			branch 	<= '0';
			memRead  <= '0';
			memToReg	<= '0'; --dont care
			ALUOp		<= "00";
			memWrite	<= '1';
			ALUSrc 	<= '1';
			regWrite	<= '0';
			jal		<= '0';
			jalr		<= '0';
			lui		<= '0';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
		
		-- I ok
		elsif a = "0010011" then
			branch 	<= '0';
			memRead  <= '0';
			memToReg	<= '0';
			ALUOp		<= "10";
			memWrite	<= '0';
			ALUSrc 	<= '1';
			regWrite	<= '1';
			jal		<= '0';
			jalr		<= '0';
			lui		<= '0';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
		
		-- R ok
		elsif a = "0110011" then
			branch 	<= '0';
			memRead 	<= '0';  --ok
			memToReg	<= '0';  --ok
			ALUOp		<= "10"; --ok
			memWrite	<= '0';  --ok
			ALUSrc 	<= '0';  --ok
			regWrite	<= '1';
			jal		<= '0';
			jalr		<= '0';
			lui		<= '0';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
			
		--others
		else 
			branch 		<= '0';
			memRead 	<= '0';
			memToReg	<= '0';
			ALUOp		<= "00";
			memWrite	<= '0';
			ALUSrc	 	<= '0';
			regWrite	<= '0';
			jal		<= '0';
			jalr		<= '0';
			lui		<= '0';
			bne		<= '0';
			blt		<= '0';
			bgt		<= '0';
		end if;
		
	end process;
end architecture behavioral; 