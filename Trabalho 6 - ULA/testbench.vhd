LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY ula_tb IS
END ula_tb;

ARCHITECTURE tb_arch OF ula_tb IS

component ulaRV is
    generic (WSIZE : natural := 32);
        port (
            opcode : in std_logic_vector(3 downto 0);
            A, B : in std_logic_vector(WSIZE-1 downto 0);
            Z : out std_logic_vector(WSIZE-1 downto 0)
            );
    end component;

    signal opcode_i: std_logic_vector(3 downto 0);
    signal A_i, B_i: std_logic_vector(31 downto 0);
    signal Z_o: std_logic_vector(31 downto 0);
begin

    dut: ulaRV port map (
		opcode => opcode_i,
        A => A_i,
        B => B_i,
        Z => Z_o
		);

    drive: process begin
        A_i <= X"00000001";
        B_i <= X"00000010";
        opcode_i <= "0011";
        wait for 10 ns;
	
	wait;
    end process;
end tb_arch;
