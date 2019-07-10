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
	when "10" => case funct3 is
					 when "000" => if (funct7(6)='1')
										then aluctr <= SUB_OP;
										else aluctr <= ADD_OP;
										end if;
					 when "001" => aluctr <= SLL_OP;
					 when "010" => aluctr <= SLT_OP;
					 when "011" => aluctr <= SLTU_OP;
					 when "100" => aluctr <= XOR_OP;
					 when "101" => if (funct7(6)='1')
					 			   then aluctr <= SRA_OP;
					 			   else aluctr <= SRL_OP;
								   end if;
					 when "110" => aluctr <= OR_OP;
					 when "111" => aluctr <= AND_OP;
				 end case;
	 when others => aluctr <= ADD_OP;
	end case;
end process;
end architecture;