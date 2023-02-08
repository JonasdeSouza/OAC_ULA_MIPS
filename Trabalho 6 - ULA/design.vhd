library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ulaRV is
generic (WSIZE : natural := 32);
	port (
		opcode : in std_logic_vector(3 downto 0);
		A, B : in std_logic_vector(WSIZE-1 downto 0);
		Z : out std_logic_vector(WSIZE-1 downto 0)
		);
end ulaRV;
---------------------------------------------

ARCHITECTURE behavior OF ulaRV IS
	signal Z_sig : std_logic_vector(31 downto 0);
	signal temp, tempU: std_logic_vector(31 downto 0);
	
BEGIN
	Z <= Z_sig;
	temp <= std_logic_vector(signed(A) - signed(B));
	tempU <= std_logic_vector(unsigned(A) - unsigned(B));
	ULA_p: process(opcode, A, B)
	begin
		case opcode is
			when "0000" => 
				Z_sig <= std_logic_vector(signed(A) + signed(B));
			when "0001" => 
				Z_sig <= std_logic_vector(signed(A) - signed(B));
			when "0010" => 
				Z_sig <= A AND B;
			when "0011" => 
				Z_sig <= A OR B;
			when "0100" => 
				Z_sig <= A XOR B;
			when "0101" => 
				Z_sig <= to_stdlogicvector( to_bitvector(A) sll to_integer( unsigned( B ) ) );
			when "0110" => 
				Z_sig <= to_stdlogicvector( to_bitvector(A) srl to_integer( unsigned( B ) ) );
			when "0111" => 
				Z_sig <= to_stdlogicvector( to_bitvector(A) sra to_integer( signed( B ) ) );
			when "1000" => 
				Z_sig <= (0 => temp(31), others => '0');
			when "1001" => 
				Z_sig <= (0 => tempU(31), others => '0');
			when "1010" =>
				if signed(A) >= signed(B) then
					Z_sig <= (0 => '1', others => '0');
				else
					Z_sig <= (0 => '0', others => '0');
				end if;
			when "1011" => 
				if unsigned(A) >= unsigned(B) then
					Z_sig <= (0 => '1', others => '0');
				else
					Z_sig <= (0 => '0', others => '0');
				end if;
			when "1100" => 
				if signed(A) = signed(B) then
					Z_sig <= (0 => '1', others => '0');
				else
					Z_sig <= (0 => '0', others => '0');
				end if;
			when "1101" => 
				if signed(A) /= signed(B) then
					Z_sig <= (0 => '1', others => '0');
				else
					Z_sig <= (0 => '0', others => '0');
				end if;
			when others =>
				Z_sig <= X"00000000";
		end case;
	end process ULA_p;
END architecture behavior;
