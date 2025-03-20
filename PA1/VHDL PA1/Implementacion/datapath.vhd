library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity datapath is
  port (
    reset, clk : in std_logic;
    comandos   : in std_logic_vector(7 downto 0);
    entradas   : in std_logic_vector(23 downto 0);
    salidas    : out std_logic_vector(23 downto 0);
    flags      : out std_logic_vector(7 downto 0));
end datapath;

architecture behavior of datapath is
  type State is
  (Idle, calcb1, calcb2, calcb3, calcb4, calcsalida, asignasalida, calcsv1, calcsv2, calcsv3, calcsv4);
  signal tmp0, reg1, reg2, reg3, reg4, reg5, reg6                         : signed(23 downto 0);
  signal reg1_next, reg2_next, reg3_next, reg4_next, reg5_next, reg6_next : signed(23 downto 0);
  signal m_reg1, m_reg2, m_reg3, m_reg4, m_reg5                           : signed(47 downto 0);
  signal current_state, next_state                                        : State;
  signal salidas_next, salidas_i                                          : std_logic_vector(23 downto 0);
  signal flags_next                                                       : std_logic_vector(7 downto 0);

  constant b1 : signed(23 downto 0) := "00000000" & "00000100" & "11000000"; --b1 > 0
  constant b2 : signed(23 downto 0) := "00000000" & "00010011" & "00000010"; --b2 > 0
  constant b3 : signed(23 downto 0) := "00000000" & "00011100" & "10000011"; --b3 > 0
  constant b4 : signed(23 downto 0) := "00000000" & "00010011" & "00000010"; --b4 > 0
  constant b5 : signed(23 downto 0) := "00000000" & "00000100" & "11000000"; --b5 > 0

  constant neg_a1 : signed(23 downto 0) := "00000001" & "00000000" & "00000000"; --neg_a1 > 0
  constant neg_a2 : signed(23 downto 0) := "00000001" & "10010010" & "00000101"; --neg_a2 > 0
  constant neg_a3 : signed(23 downto 0) := "11111110" & "10111001" & "01110010"; --neg_a3 < 0 
  constant neg_a4 : signed(23 downto 0) := "00000000" & "01111100" & "00000001"; --neg_a4 > 0
  constant neg_a5 : signed(23 downto 0) := "11111111" & "11101100" & "01111111"; --neg_a5 < 0

begin
  Proc_comb : process (reg1, reg2, reg3, reg4, reg5, comandos, tmp0, current_state, salidas_i)
  begin
    reg1_next    <= reg1;
    reg2_next    <= reg2;
    reg3_next    <= reg3;
    reg4_next    <= reg4;
    reg5_next    <= reg5;
    next_state   <= current_state;
    salidas_next <= salidas_i;
    flags_next   <= (others => '0');
    case current_state is
      when Idle =>
        if comandos(0) = '1' then
          next_state <= calcb1;
          m_reg1     <= tmp0 * b1;
          reg1_next  <= m_reg1(39 downto 16);
        end if;
      when calcb1 =>
        reg1_next  <= tmp0 * b2;
        reg2_next  <= reg1 + reg2;
        next_state <= calcb2;
      when calcb2 =>
        reg1_next  <= tmp0 * b3;
        reg3_next  <= reg1 + reg3;
        next_state <= calcb3;
      when calcb3 =>
        reg1_next  <= tmp0 * b4;
        reg4_next  <= reg1 + reg4;
        next_state <= calcb4;
      when calcb4 =>
        reg1_next  <= tmp0 * b5;
        reg5_next  <= reg1 + reg5;
        next_state <= calcsalida;
      when calcsalida =>
        reg6_next  <= reg2 * neg_a1;
        next_state <= asignasalida;
      when asignasalida =>
        reg2_next    <= reg6 * neg_a2;
        salidas_next <= std_logic_vector(reg6);
        next_state   <= calcsv1;
      when calcsv1 =>
        reg3_next  <= reg6 * neg_a3;
        reg2_next  <= reg2 + reg3;
        next_state <= calcsv2;
      when calcsv2 =>
        reg4_next  <= reg6 * neg_a4;
        reg3_next  <= reg3 + reg4;
        next_state <= calcsv3;
      when calcsv3 =>
        reg5_next  <= reg6 * neg_a5;
        reg4_next  <= reg4 + reg5;
        next_state <= calcsv4;
      when calcsv4 =>
        reg5_next     <= reg5 + reg1;
        flags_next(0) <= '1';
        next_state    <= Idle;
      when others =>
        next_state <= Idle;
    end case;
  end process;

  Proc_seq : process (reset, clk)
  begin
    if reset = '0' then
      reg1          <= (others => '0');
      reg2          <= (others => '0');
      reg3          <= (others => '0');
      reg4          <= (others => '0');
      reg5          <= (others => '0');
      reg6          <= (others => '0');
      current_state <= Idle;
      salidas_i     <= (others => '0');
      flags         <= (others => '0');
    elsif (clk'event and clk = '1') then
      reg1          <= reg1_next;
      reg2          <= reg2_next;
      reg3          <= reg3_next;
      reg4          <= reg4_next;
      reg5          <= reg5_next;
      reg6          <= reg6_next;
      current_state <= next_state;
      salidas_i     <= salidas_next;
      flags         <= flags_next;
    end if;
  end process;
  salidas <= salidas_i;
  tmp0    <= signed(entradas);
end behavior;
