LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all; 
use work.rv_pkg.all;          
 
ENTITY cntrULA_tb IS 
END cntrULA_tb; 
 
ARCHITECTURE tb_arch OF cntrULA_tb IS 
--signals
	SIGNAL funct7 : std_logic_vector(6 downto 0);
	SIGNAL funct3 : std_logic_vector(2 downto 0);
	SIGNAL aluop  : std_logic_vector(1 downto 0);
	SIGNAL aluctr : ULA_OP;
	
	component cntrULA 
		port (funct7 : in std_logic_vector(6 downto 0);
			   funct3 : in std_logic_vector(2 downto 0);
			   aluop  : in std_logic_vector(1 downto 0);
			   aluctr : out ULA_OP);
	end component;
	
	begin i1 : cntrULA PORT MAP (funct7 => funct7, funct3 => funct3, aluop => aluop, aluctr => aluctr);
	
	init : process
	BEGIN
		funct7 <= "0000000"; funct3 <= "000"; aluop <= "10";
		wait for 4 ps;
		funct7 <= "0100000"; funct3 <= "000"; aluop <= "10";
		wait for 4 ps;
		funct7 <= "0000000"; funct3 <= "001"; aluop <= "10";
		wait for 4 ps;  
		funct7 <= "0100000"; funct3 <= "000"; aluop <= "10"; 
		wait for 4 ps;
		funct7 <= "0000000"; funct3 <= "000"; aluop <= "10";  
		wait for 4 ps;
		funct7 <= "0100000"; funct3 <= "000"; aluop <= "10";
		wait for 4 ps;
		funct7 <= "0000000"; funct3 <= "001"; aluop <= "10";
		wait for 4 ps;
	END PROCESS init; 
end tb_arch; 