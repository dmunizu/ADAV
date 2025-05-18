library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity top is
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
end top;
architecture behavior of top is

  component datapath is
    port (
      reset, clk : in std_logic;
      estado     : in std_logic_vector(1 downto 0);
      entradas_0 : in std_logic_vector(23 downto 0);
      entradas_1 : in std_logic_vector(23 downto 0);
      entradas_2 : in std_logic_vector(23 downto 0);
      salidas_0  : out std_logic_vector(23 downto 0);
      salidas_1  : out std_logic_vector(23 downto 0);
      salidas_2  : out std_logic_vector(23 downto 0);
      flags      : out std_logic_vector(7 downto 0));
  end component;

  component control is
    port (
      reset, clk : in std_logic;
      validacion : in std_logic;
      flags      : in std_logic_vector(7 downto 0);
      estado     : out std_logic_vector(1 downto 0);
      fin        : out std_logic);
  end component;

  component interfaz_entrada is
    port (
      reset, clk : in std_logic;
      validacion : in std_logic;
      data_in_0  : in std_logic_vector(23 downto 0);
      data_in_1  : in std_logic_vector(23 downto 0);
      data_in_2  : in std_logic_vector(23 downto 0);
      entradas_0 : out std_logic_vector(23 downto 0);
      entradas_1 : out std_logic_vector(23 downto 0);
      entradas_2 : out std_logic_vector(23 downto 0));
  end component;

  component interfaz_salida is
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
  end component;
  signal entradas_0, entradas_1, entradas_2, salidas_0, salidas_1, salidas_2 : std_logic_vector(23 downto 0);
  signal flags                                                               : std_logic_vector(7 downto 0);
  signal estado                                                              : std_logic_vector(1 downto 0);
  signal fin                                                                 : std_logic;
begin
  U1 : datapath
  port map
  (
    reset => reset, clk => clk,
    estado => estado,
    entradas_0 => entradas_0, entradas_1 => entradas_1, entradas_2 => entradas_2,
    salidas_0 => salidas_0, salidas_1 => salidas_1, salidas_2 => salidas_2,
    flags  => flags);

  U2 : control
  port map
  (
    reset => reset, clk => clk,
    validacion => validacion, estado => estado, flags => flags, fin => fin);

  U3 : interfaz_entrada
  port map
  (
    reset => reset, clk => clk,
    validacion => validacion,
    data_in_0 => data_in_0, data_in_1 => data_in_1, data_in_2 => data_in_2,
    entradas_0 => entradas_0, entradas_1 => entradas_1, entradas_2 => entradas_2);

  U4 : interfaz_salida
  port map
  (
    reset => reset, clk => clk,
    fin       => fin,
    salidas_0 => salidas_0, salidas_1 => salidas_1, salidas_2 => salidas_2,
    data_out_0 => data_out_0, data_out_1 => data_out_1, data_out_2 => data_out_2,
    valid_out => valid_out);
end behavior;
