library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity control is
  port (
    reset, clk : in std_logic;
    validacion : in std_logic;
    estado     : out std_logic_vector(3 downto 0);
    fin        : out std_logic);
end control;

architecture behavior of control is
  constant ck0      : unsigned(3 downto 0) := "0000";
  constant ck1      : unsigned(3 downto 0) := "0001";
  constant ck10     : unsigned(3 downto 0) := "1010";
  signal validacion_i : std_logic;
  signal estado_uns : unsigned(3 downto 0);
begin
  Proc_Estado : process (reset, clk)
  begin
    if reset = '0' then
      estado_uns <= (others => '0');
      validacion_i <= '0';
      fin <= '0';
    elsif (clk'event and clk = '1') then
      fin <= '0';
      validacion_i <= validacion;
      case estado_uns is
        when ck0 =>
          if (validacion_i = '0') then
            estado_uns <= ck0;
          else
            estado_uns <= ck1;
          end if;
        when ck10 =>
          estado_uns <= ck0;
          fin        <= '1';
        when others =>
          estado_uns <= estado_uns + 1;
      end case;
    end if;
  end process;
  estado <= std_logic_vector(estado_uns);
end behavior;