library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity top is
  port (
    reset, clk : in std_logic;
    validacion : in std_logic;
    ack_in     : in std_logic;
    data_in    : in std_logic_vector(23 downto 0);
    data_out   : out std_logic_vector(23 downto 0);
    valid_out  : out std_logic;
    ack_out    : out std_logic);
end top;
architecture behavior of top is

  component datapath is
    port (
      reset, clk : in std_logic;
      estado   : in std_logic_vector(3 downto 0);
      entradas   : in std_logic_vector(23 downto 0);
      salidas    : out std_logic_vector(23 downto 0));
  end component;

  component control is
    port (
      reset, clk : in std_logic;
      validacion : in std_logic;
      estado   : out std_logic_vector(3 downto 0);
      fin        : out std_logic);
  end component;

  component interfaz_entrada is
    port (
      reset, clk : in std_logic;
      validacion : in std_logic;
      data_in    : in std_logic_vector(23 downto 0);
      entradas   : out std_logic_vector(23 downto 0);
      ack        : out std_logic);
  end component;

  component interfaz_salida is
    port (
      reset, clk : in std_logic;
      fin        : in std_logic;
      salidas    : in std_logic_vector(23 downto 0);
      ack        : in std_logic;
      data_out   : out std_logic_vector(23 downto 0);
      valid_out  : out std_logic);
  end component;
  signal entradas, salidas : std_logic_vector(23 downto 0);
  signal estado  : std_logic_vector(3 downto 0);
  signal fin               : std_logic;
begin
  U1 : datapath
  port map
  (
    reset => reset, clk => clk,
    estado => estado, entradas => entradas, salidas => salidas);

  U2 : control
  port map
  (
    reset => reset, clk => clk,
    validacion => validacion, estado => estado, fin => fin);

  U3 : interfaz_entrada
  port map
  (
    reset => reset, clk => clk,
    validacion => validacion, data_in => data_in, entradas => entradas, ack => ack_out);

  U4 : interfaz_salida
  port map
  (
    reset => reset, clk => clk,
    fin => fin, salidas => salidas, ack => ack_in, data_out => data_out, valid_out => valid_out);
end behavior;
