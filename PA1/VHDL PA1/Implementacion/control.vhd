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
  constant idle                                                           : unsigned(3 downto 0) := "0000";
  constant ck0                                                            : unsigned(3 downto 0) := "0001";
  constant ck1                                                            : unsigned(3 downto 0) := "0010";
  constant ck2                                                            : unsigned(3 downto 0) := "0011";
  constant ck3                                                            : unsigned(3 downto 0) := "0100";
  constant ck4                                                            : unsigned(3 downto 0) := "0101";
  constant ck5                                                            : unsigned(3 downto 0) := "0110";
  constant ck6                                                            : unsigned(3 downto 0) := "0111";
  constant ck7                                                            : unsigned(3 downto 0) := "1000";
  constant ck8                                                            : unsigned(3 downto 0) := "1001";
  constant ck9                                                            : unsigned(3 downto 0) := "1010";
  constant ck10                                                           : unsigned(3 downto 0) := "1011";
  signal counter                                                          : unsigned(4 downto 0);
  signal estado_uns : unsigned(3 downto 0);
begin
  Proc_Estado : process (reset, clk)
  begin
    if reset = '0' then
      estado_uns <= idle;
      fin <= '0';
      counter <= (others => '0');
    elsif (clk'event and clk = '1') then
      fin <= '0';
      if (validacion = '1') then
        estado_uns <= ck0;
      else
          case estado_uns is
            when idle =>
                estado_uns <= idle;
            when ck10 =>
              estado_uns <= ck0;
              counter <= counter + 1;
              if (counter = 16) then
                fin <= '1';
                counter <= (others => '0');
                estado_uns <= idle;
              end if;
            when others =>
              estado_uns <= estado_uns + 1;
          end case;
      end if;
    end if;
  end process;
  estado <= std_logic_vector(estado_uns);
end behavior;