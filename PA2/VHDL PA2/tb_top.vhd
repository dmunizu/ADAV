library STD;
use STD.textio.all; -- basic I/O
library IEEE;
use IEEE.std_logic_1164.all; -- basic logic types
use IEEE.std_logic_textio.all; -- I/O for logic types

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity tb_top is
end tb_top;
architecture behavior of tb_top is

  component top is
    port (
      reset, clk : in std_logic;
      validacion : in std_logic;
      data_in_0  : in std_logic_vector(23 downto 0);
      data_in_1  : in std_logic_vector(23 downto 0);
      data_in_2  : in std_logic_vector(23 downto 0);
      data_out_0 : out std_logic_vector(23 downto 0);
      data_out_1 : out std_logic_vector(23 downto 0);
      data_out_2 : out std_logic_vector(23 downto 0);
      valid_out  : out std_logic);
  end component;

  signal reset, clk                         : std_logic;
  signal data_in_0, data_in_1, data_in_2    : std_logic_vector(23 downto 0);
  signal data_out_0, data_out_1, data_out_2 : std_logic_vector(23 downto 0);
  signal validacion                         : std_logic;
  signal valid_out, ack_out                 : std_logic;

  constant period : time := 10 ns;

  file f_out : TEXT is out "./f_out.txt"; -- ES PREFERIBLE PONER LA DIRECCCION COMPLETA!!

begin

  -- UNIT UNDER TEST
  UUT : top
  port map
  (
    reset => reset, clk => clk,
    validacion => validacion,
    data_in_0 => data_in_0, data_in_1 => data_in_1, data_in_2 => data_in_2,
    data_out_0 => data_out_0, data_out_1 => data_out_1, data_out_2 => data_out_2,
    valid_out  => valid_out);
  -- RESET
  Proc_reset : process
  begin
    reset <= '0', '1' after 302 ns;
    wait;
  end process;
  -- CLK
  Proc_clk : process
  begin
    clk <= '0', '1' after period/2;
    wait for period;
  end process;
  -- INPUT DATA
  Proc_gen_data : process
  begin
    data_in_0  <= (others => '0');
    data_in_1  <= (others => '0');
    data_in_2  <= (others => '0');
    validacion <= '0';
    wait for 100 * period;

    data_in_0  <= "00000001" & "00000000" & "00000000";
    validacion <= '1';
    wait for period;

    data_in_0  <= (others => '0');
    validacion <= '1';
    wait for 50 * period;

    data_in_0  <= (others => '0');
    validacion <= '0';
    wait for 50 * period;
    wait;
  end process;
  -- OUTPUT DATA
  Proc_save_data : process (clk)
    variable v_data_out_0, v_data_out_1, v_data_out_2 : bit_vector(23 downto 0);
    variable v_linea    : line;
  begin
    if (clk'event and clk = '1') then
      --ack_out <= '0' after 1 ns;
      if (valid_out = '1') then
        --ack_out <= '1' after 2 ns;
        v_data_out_0 := To_BitVector(data_out_0);
        v_data_out_1 := To_BitVector(data_out_1);
        v_data_out_2 := To_BitVector(data_out_2);
        WRITE(v_linea, v_data_out_0);
        WRITELINE(f_out, v_linea);
        WRITE(v_linea, v_data_out_1);
        WRITELINE(f_out, v_linea);
        WRITE(v_linea, v_data_out_2);
        WRITELINE(f_out, v_linea);
      end if;
    end if;
  end process;
end behavior;
