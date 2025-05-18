library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity control is
  port (
    reset, clk : in std_logic;
    validacion : in std_logic;
    flags      : in std_logic_vector(7 downto 0);
    estado     : out std_logic_vector(1 downto 0);
    fin        : out std_logic);
end control;

architecture behavior of control is
begin
  Proc_Estado : process (reset, clk)
  begin
    if reset = '0' then
      estado <= (others => '0');
    elsif (clk'event and clk = '1') then
      if validacion = '0' then
        estado <= (others => '0');
      else
        estado(0) <= '1';
      end if;
      if estado(0) = '1' then
        estado(1) <= '1';
      end if;
    end if;
  end process;
  fin <= estado(1);
end behavior;