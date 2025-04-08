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
      ack_in     : in std_logic;
      data_in    : in std_logic_vector(23 downto 0);
      data_out   : out std_logic_vector(23 downto 0);
      valid_out  : out std_logic;
      ack_out    : out std_logic);
  end component;

  signal reset, clk                 : std_logic;
  signal data_in, data_out          : std_logic_vector(23 downto 0);
  signal validacion                 : std_logic;
  signal valid_out, ack_out, ack_in : std_logic;

  constant period : time := 10 ns;

  file f_out : TEXT is out "./f_out.txt"; -- ES PREFERIBLE PONER LA DIRECCCION COMPLETA!!

begin

  -- UNIT UNDER TEST
  UUT : top
  port map
  (
    reset => reset, clk => clk,
    validacion => validacion, ack_in => ack_in, data_in => data_in, data_out => data_out, valid_out => valid_out, ack_out => ack_out);
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
    data_in    <= (others => '0');
    validacion <= '0';
    ack_in <= '0';
    wait for 100 * period;

    -- Dato 1
    data_in    <= "00000001" & "00000000" & "00000000";
    validacion <= '1';
    wait until ack_out = '1';
    wait for period;

    data_in    <= (others => '0');
    validacion <= '0';
    wait until valid_out = '1';
    wait for period;
    ack_in <= '1';
    wait until valid_out = '0';
    wait for period;
    ack_in <= '0';
    wait for 50 * period;
    
    -- Dato 2
    data_in    <= "00000011" & "00000000" & "00000000";
    validacion <= '1';
    wait until ack_out = '1';
    wait for period;

    data_in    <= (others => '0');
    validacion <= '0';
    wait until valid_out = '1';
    wait for period;
    ack_in <= '1';
    wait until valid_out = '0';
    wait for period;
    ack_in <= '0';
    wait for 50 * period;
    wait;
  end process;
  -- OUTPUT DATA
  Proc_save_data : process (clk)
    variable v_data_out : bit_vector(23 downto 0);
    variable v_linea    : line;
  begin
    if (clk'event and clk = '1') then
      --ack_out <= '0' after 1 ns;
      if (valid_out = '1' and ack_in = '1') then
        --ack_out <= '1' after 2 ns;
        v_data_out := To_BitVector(data_out);
        WRITE(v_linea, v_data_out);
        WRITELINE(f_out, v_linea);
      end if;
    end if;
  end process;
end behavior;
