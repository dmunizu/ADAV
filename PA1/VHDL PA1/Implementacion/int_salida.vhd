library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity interfaz_salida is
  port (
    reset, clk : in std_logic;
    fin        : in std_logic;
    salidas    : in std_logic_vector(23 downto 0);
    ack        : in std_logic;
    data_out   : out std_logic_vector(23 downto 0);
    valid_out  : out std_logic);
end interfaz_salida;

architecture behavior of interfaz_salida is
begin
  Proc_Entrega : process (reset, clk)
  begin
    if reset = '0' then
      data_out  <= (others => '0');
      valid_out <= '0';
    elsif (clk'event and clk = '1') then
      if ack = '1' then
        data_out  <= (others => '0');
        valid_out <= '0';
      elsif fin = '1' then
        data_out  <= salidas;
        valid_out <= '1';
      end if;
    end if;
  end process;
end behavior;
