library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use work.rv_pkg.all;

entity cntrULA is
	port ( funct7 : in std_logic_vector(6 downto 0);
			 funct3 : in std_logic_vector(2 downto 0);
			 aluop : in std_logic_vector(1 downto 0);
			 aluctr : out ULA_OP);
end entity;

architecture arch of cntrULA is 
begin
process(funct7, funct3, aluop) begin
	case aluop is
	when "00" => aluctr <= ADD_OP; -- soma
	when "01" => aluctr <= SUB_OP; -- subtração
	when "10" =>if funct3 = "000" then 
						if (funct7(5)='1')
						then aluctr <= SUB_OP;
						else aluctr <= ADD_OP;
						end if;
					elsif funct3 = "001" then
						aluctr <= SLL_OP;
					elsif funct3 = "010" then 
						aluctr <= SLT_OP;
					elsif funct3 = "011" then 
						aluctr <= SLTU_OP;
					elsif funct3 = "100" then
						aluctr <= XOR_OP;
					elsif funct3 = "101" then
						if (funct7(5)='1')
					 	then aluctr <= SRA_OP;
					 	else aluctr <= SRL_OP;
						end if;
					elsif funct3 = "110" then 
						aluctr <= OR_OP;
					else 
						aluctr <= AND_OP;
					end if;
	when others => aluctr <= ADD_OP;
	end case;
end process;
end architecture;