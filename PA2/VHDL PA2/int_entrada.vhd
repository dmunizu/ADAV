library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity interfaz_entrada is
  port (
    reset, clk : in std_logic;
    validacion : in std_logic;
    data_in_0  : in std_logic_vector(23 downto 0);
    data_in_1  : in std_logic_vector(23 downto 0);
    data_in_2  : in std_logic_vector(23 downto 0);
    entradas_0 : out std_logic_vector(23 downto 0);
    entradas_1 : out std_logic_vector(23 downto 0);
    entradas_2 : out std_logic_vector(23 downto 0));
end interfaz_entrada;

architecture behavior of interfaz_entrada is
begin
  Proc_Captura : process (reset, clk)
  begin
    if reset = '0' then
      entradas_0 <= (others => '0');
      entradas_1 <= (others => '0');
      entradas_2 <= (others => '0');
    elsif (clk'event and clk = '1') then
      if validacion = '1' then
        entradas_0 <= data_in_0;
        entradas_1 <= data_in_1;
        entradas_2 <= data_in_2;
      end if;
    end if;
  end process;
end behavior;
