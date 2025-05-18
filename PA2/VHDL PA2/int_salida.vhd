library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity interfaz_salida is
  port (
    reset, clk : in std_logic;
    fin        : in std_logic;
    salidas_0  : in std_logic_vector(23 downto 0);
    salidas_1  : in std_logic_vector(23 downto 0);
    salidas_2  : in std_logic_vector(23 downto 0);
    data_out_0 : out std_logic_vector(23 downto 0);
    data_out_1 : out std_logic_vector(23 downto 0);
    data_out_2 : out std_logic_vector(23 downto 0);
    valid_out  : out std_logic);
end interfaz_salida;

architecture behavior of interfaz_salida is
begin
  Proc_Entrega : process (reset, clk)
  begin
    if reset = '0' then
      data_out_0  <= (others => '0');
      data_out_1  <= (others => '0');
      data_out_2  <= (others => '0');
      valid_out <= '0';
    elsif (clk'event and clk = '1') then
      data_out_0  <= salidas_0;
      data_out_1  <= salidas_1;
      data_out_2  <= salidas_2;
      valid_out <= '0';
      if fin = '1' then
        valid_out <= '1';
      end if;
    end if;
  end process;
end behavior;
