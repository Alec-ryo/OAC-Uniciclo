library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity genImm32 is
	port (
		instr:   in  std_logic_vector(31 downto 0);
		imm32:	out std_logic_vector(31 downto 0));
end genImm32; 

architecture behavioral of genImm32 is
	signal i32 		: std_logic_vector(31 downto 0);
	signal opcode	: std_logic_vector(6 downto 0);
begin
	proc_imm32: process (instr, i32, opcode) begin
	
	case instr(6 downto 0) is 
		--R_type
		when "0110011"  => imm32 <= X"00000000";
		--I_type
		when "0000011" | "1100111"  => imm32 <= std_logic_vector(resize(signed(instr(31 downto 20)), 32));
		when "0010011" => if (instr(14 downto 12) = "001" or instr(14 downto 12) = "101") --se for instrucao com shamt
								then imm32 <= std_logic_vector(resize(signed(instr(24 downto 20)), 32));
								else imm32 <= std_logic_vector(resize(signed(instr(31 downto 20)), 32));
								end if;
		--S_type
		when "0100011"  => imm32 <= std_logic_vector(resize(signed(instr(31 downto 25) & instr(11 downto 7)), 32));
		--SB_type
		when "1100011"  => imm32 <= std_logic_vector(resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32));
		--UJ_type
		when "1101111"  => imm32 <= std_logic_vector(resize(signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'), 32));
		--U_type
		when "0110111"  => imm32 <= std_logic_vector(resize(signed(instr(31 downto 12) & "000000000000"), 32));
		when others => imm32 <= X"00000000";
	end case;
		
	end process;
end architecture behavioral;