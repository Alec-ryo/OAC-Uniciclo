library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use work.rv_pkg.all;

entity ULA_RV is
	port (
		opcode:  in  ULA_OP;          
		A, B: 	in  std_logic_vector(31 downto 0);           
		Z: 		out std_logic_vector(31 downto 0);          
		zero: 	out std_logic ); 
end ULA_RV; 

architecture behavioral of ULA_RV is
	signal a32 : std_logic_vector(31 downto 0); 
begin   
	Z <= a32;   
	proc_ula: process (A, B, opcode, a32) begin
		if (a32 = X"00000000") then zero <= '1'; else zero <= '0'; end if;  
		case opcode is
			when ADD_OP  => a32 <= std_logic_vector(signed(A) + signed(B));
			when SUB_OP  => a32 <= std_logic_vector(signed(A) - signed(B));
			when AND_OP  => a32 <= A and B; 
			when OR_OP   => a32 <= A or B;
			when XOR_OP  => a32 <= A xor B;
			when SLL_OP  => a32 <= std_logic_vector(unsigned(A) sll to_integer(unsigned(B)));
			when SRL_OP  => a32 <= std_logic_vector(unsigned(A) srl to_integer(unsigned(B)));
			when SRA_OP  => a32 <= to_stdlogicvector(to_bitvector(A) sra to_integer(unsigned(B)));
			when SLT_OP  => if (signed(A) < signed(B)) then
								   a32 <= X"00000001";
								 else 
									a32 <= X"00000000";
								 end if;
			when SLTU_OP => if (unsigned(A) < unsigned(B)) then
									a32 <= X"00000001";
								 else
									a32 <= X"00000000";
								 end if;
			when SGE_OP  => if ((signed(A) > signed(B)) or (signed(A) = signed(B))) then
									a32 <= X"00000001";
								 else
									a32 <= X"00000000";
								 end if;
			when SGEU_OP => if ((unsigned(A) > unsigned(B)) or (unsigned(A) = unsigned(B))) then
									a32 <= X"00000001";
								 else
									a32 <= X"00000000";
								 end if;
			when SEQ_OP  => if (unsigned(A) = unsigned(B)) then
									a32 <= X"00000001";
								 else
									a32 <= X"00000000";
								 end if;
			when SNE_OP  => if (unsigned(A) /= unsigned(B)) then
									a32 <= X"00000001";
								 else
									a32 <= X"00000000";
								 end if;
			when others  => a32 <= (others => '0'); 
		end case; 
	end process;
end architecture behavioral; 