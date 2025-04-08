library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity interfaz_entrada is
  port (
    reset, clk : in std_logic;
    validacion : in std_logic;
    data_in    : in std_logic_vector(23 downto 0);
    entradas   : out std_logic_vector(23 downto 0);
    ack        : out std_logic);
end interfaz_entrada;

architecture behavior of interfaz_entrada is
begin
  Proc_Captura : process (reset, clk)
  begin
    if reset = '0' then
      entradas <= (others => '0');
      ack <= '0';
    elsif (clk'event and clk = '1') then
      if validacion = '0' then
        ack <= '0';
      else
        entradas <= data_in;
        ack <= '1';
      end if;
    end if;
  end process;
end behavior;
