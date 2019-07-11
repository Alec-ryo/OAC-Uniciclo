library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity control is
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
		
		-- jal	
		elsif a = "1101111" then 
			branch 	<= '1'; --ok
			memRead  <= '0'; --ok
			memToReg	<= '0'; --ok
			ALUOp		<= "00"; --corrigir
			memWrite	<= '0'; --ok
			ALUSrc 	<= '0'; --corrigir
			regWrite	<= '1'; --corrigir
		
		-- jalr
		elsif a = "1100111" then
			branch 	<= '1'; --ok
			memRead  <= '0'; --ok
			memToReg	<= '0'; --ok
			ALUOp		<= "00"; --corrigir
			memWrite	<= '0'; --ok
			ALUSrc 	<= '1'; --ok
			regWrite	<= '1'; --ok
		
		-- BType
		elsif a = "1100011" then
			branch 	<= '1';
			memRead  <= '0';
			memToReg	<= '0'; --dont care
			ALUOp		<= "01";
			memWrite	<= '0';
			ALUSrc 	<= '0';
			regWrite	<= '0';
		
		-- lw ok
		elsif a = "0000011" then
			branch 	<= '0';
			memRead  <= '1';
			memToReg	<= '1';
			ALUOp		<= "00";
			memWrite	<= '0';
			ALUSrc 	<= '1';
			regWrite	<= '1';
		
		-- sw 
		elsif a = "0100011" then
			branch 	<= '0';
			memRead  <= '0';
			memToReg	<= '0'; --dont care
			ALUOp		<= "00";
			memWrite	<= '1';
			ALUSrc 	<= '1';
			regWrite	<= '0';
		
		-- I ok
		elsif a = "0010011" then
			branch 	<= '0';
			memRead  <= '0';
			memToReg	<= '0';
			ALUOp		<= "10";
			memWrite	<= '0';
			ALUSrc 	<= '1';
			regWrite	<= '1';
		
		-- R ok
		elsif a = "0110011" then
			branch 	<= '0';
			memRead 	<= '0';
			memToReg	<= '0';
			ALUOp		<= "10";
			memWrite	<= '0';
			ALUSrc 	<= '0';
			regWrite	<= '1';
			
		--others
		else 
			branch 		<= '0';
			memRead 	<= '0';
			memToReg	<= '0';
			ALUOp		<= "00";
			memWrite	<= '0';
			ALUSrc	 	<= '0';
			regWrite	<= '0';
		end if;
		
	end process;
end architecture behavioral; 