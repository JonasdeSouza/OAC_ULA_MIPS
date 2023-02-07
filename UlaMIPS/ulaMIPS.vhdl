--12 operações em complemento de 2
--Operação 		Significado 																opULA		Feito?
--and  A, B 		Saída S recebe a operação lógica A and B, bit a bit 		0000			1
--or   A, B 		S recebe a operação lógica A or B, bit a bit 				0001			1
--add  A, B 		S recebe a soma das entradas A, B 								0010			1
--srl  A, B 		S <= B >> A, utiliza 5 bits de A, shift lógico 				0011			
--sra  A, B 		S <= B >> A, idem, shift aritmético 							0100			
--sll  A, B 		S <= B << A, utiliza 5 bits de A, shift lógico 				0101			
--sub  A, B 		S recebe A - B 														0110			
--slt  A, B 		S <= 1 se A < B, 0 caso contrário 								0111			
--not  A 			S recebe a entrada A invertida bit a bit 						1000			
--xor  A, B 		S recebe a operação lógica A xor B, bit a bit 				1001			
--nand A, B 		S recebe a operação lógica A nand B, bit a bit 				1100			
--nor  A, B 		S recebe a operação lógica A nor B, bit a bit 				1101			


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ulaMIPS is
	port (
		opULA			: in  std_logic_vector(3 downto 0);
		A,B			: in  std_logic_vector(31 downto 0);
		S				: out std_logic_vector(31 downto 0);
		zero, ovfl	: out std_logic);
end ulaMIPS;

architecture behavioral of ulaMIPS is
	signal tmp 		: std_logic_vector(31 downto 0);
	signal a32 		: std_logic_vector(31 downto 0);
	signal a5 		: std_logic_vector(4 downto 0);
begin
	tmp <= A - B;
	S <= a32;		
	a5 <= A(4 downto 0);
	proc_ula: process(A,B,opULA, a32) 
	begin
		--flag zero
      if (a32 = X"00000000") then 
			zero <= '1';  
		else 
			zero <= '0'; 
		end if;
		ovfl <= '0';
      case opULA is
			--and
			when  "0000" => a32 <= (A and B);
			--or
			when  "0001" => a32 <= (A or B);
			--add
			when  "0010" => a32 <= (A + B);
				--flag ovfl
				if ( (signed(A)<0 and signed(B)<0 and signed(a32)>0)  or (signed(A)>0 and signed(B)>0 and signed(a32)<0) ) then 
					ovfl <= '1';  
				else 
					ovfl <= '0'; 
				end if;


			--srl
			when 	"0011" => a32 <= to_stdlogicvector( to_bitvector(B) srl to_integer( unsigned( a5 ) ) );
			--sra
			when 	"0100" => a32 <= to_stdlogicvector( to_bitvector(B) sra to_integer( unsigned( a5 ) ) );
			--sll
			when 	"0101" => a32 <= to_stdlogicvector( to_bitvector(B) sll to_integer( unsigned( a5 ) ) );
										
			--sub
			when  "0110" => a32 <= A-B;
				--flag ovfl
				if ( ((signed(A) > signed(B)) and signed(a32)<=0) or ((signed(A) < signed(B)) and signed(a32)>=0)) then 
					ovfl <= '1';  
				else 
					ovfl <= '0'; 
				end if;
			
			
			--slt
			when  "0111" => a32 <= (0 => tmp(31), others => '0');
			--not
			when 	"1000" => a32 <= not A;
			--xor
			when 	"1001" => a32 <= (A xor B);
			--nand
			when 	"1100" => a32 <= (A nand B);
			--nor
			when  "1101" => a32 <= (A nor B);
	
			when others  => a32 <= (others => '0');
     
	  end case;
	end process proc_ula;
end architecture behavioral;







