library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity control is
  port (
    reset, clk : in std_logic;
    validacion : in std_logic;
    estado     : out std_logic;
    fin        : out std_logic);
end control;

architecture behavior of control is
begin
  Proc_Estado : process (reset, clk)
  begin
    if reset = '0' then
      estado <= '0';
    elsif (clk'event and clk = '1') then
      if validacion = '0' then
        estado <= '0';
        fin <= '0';
      else
        estado <= '1';
        fin <= '1';
      end if;
    end if;
  end process;
end behavior;