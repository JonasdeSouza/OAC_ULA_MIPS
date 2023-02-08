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
-- teste de add
    A_i <= X"00000001";
    B_i <= X"00000010";
    opcode_i <= "0000";
    wait for 10 ns;
    assert Z_o = X"00000011" report "Teste de add deu errado" severity error;

-- teste de sub
    A_i <= X"00000011";
    B_i <= X"00000010";
    opcode_i <= "0001";
    wait for 10 ns;
    assert Z_o = X"00000001" report "Teste de sub deu errado" severity error;

    -- teste de and
    A_i <= X"00000001";
    B_i <= X"00000001";
    opcode_i <= "0010";
    wait for 10 ns;
    assert Z_o = X"00000001" report "Teste de and deu errado" severity error;

    -- teste de or
    A_i <= X"00000010";
    B_i <= X"00000001";
    opcode_i <= "0011";
    wait for 10 ns;
    assert Z_o = X"00000011" report "Teste de or deu errado" severity error;

    -- teste de xor
    A_i <= X"00000101";
    B_i <= X"00000011";
    opcode_i <= "0100";
    wait for 10 ns;
    assert Z_o = X"00000110" report "Teste de xor deu errado" severity error;

    -- teste de sll
    A_i <= X"00000001";
    B_i <= X"00000001";
    opcode_i <= "0101";
    wait for 10 ns;
    assert Z_o = X"00000002" report "Teste de sll deu errado" severity error;

    -- teste de srl
    A_i <= X"00000010";
    B_i <= X"00000001";
    opcode_i <= "0110";
    wait for 10 ns;
    assert Z_o = X"00000008" report "Teste de srl deu errado" severity error;

    -- teste de sra
    A_i <= X"80000001";
    B_i <= X"00000001";
    opcode_i <= "0111";
    wait for 10 ns;
    assert Z_o = X"C0000000" report "Teste de sra deu errado" severity error;

    -- teste de slt
    A_i <= X"80000001";
    B_i <= X"00000010";
    opcode_i <= "1000";
    wait for 10 ns;
    assert Z_o = X"00000001" report "Teste de slt deu errado" severity error;

    -- teste de sltu
    A_i <= X"80000001";
    B_i <= X"00000010";
    opcode_i <= "1001";
    wait for 10 ns;
    assert Z_o = X"00000000" report "Teste de sltu deu errado" severity error;

    -- teste de sge
    A_i <= X"80000001";
    B_i <= X"00000010";
    opcode_i <= "1010";
    wait for 10 ns;
    assert Z_o = X"00000000" report "Teste de sge deu errado" severity error;

    -- teste de sgeu
    A_i <= X"80000001";
    B_i <= X"00000010";
    opcode_i <= "1011";
    wait for 10 ns;
    assert Z_o = X"00000001" report "Teste de sgeu deu errado" severity error;

    -- teste de seq     
    A_i <= X"00000001";
    B_i <= X"00000001";
    opcode_i <= "1100";
    wait for 10 ns;
    assert Z_o = X"00000001" report "Teste de seq deu errado" severity error;

    -- teste de sne
    A_i <= X"00000001";
    B_i <= X"00000010";
    opcode_i <= "1101";
    wait for 10 ns;
    assert Z_o = X"00000001" report "Teste de sne deu errado" severity error;

    wait;
    end process;
end tb_arch;
