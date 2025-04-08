library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity datapath is
  port (
    reset, clk : in std_logic;
    estado     : in std_logic_vector(3 downto 0);
    entradas   : in std_logic_vector(23 downto 0);
    salidas    : out std_logic_vector(23 downto 0));
end datapath;

architecture behavior of datapath is
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
  signal estado_uns                                                       : unsigned(3 downto 0);
  signal tmp0, reg1, reg2, reg3, reg4, reg5, reg6                         : signed(23 downto 0);
  signal reg1_next, reg2_next, reg3_next, reg4_next, reg5_next, reg6_next : signed(23 downto 0);
  signal mul1, mul2, sum1, sum2, t_mul                                    : signed(23 downto 0);
  signal mul                                                              : signed(47 downto 0);
  signal sum                                                              : signed(23 downto 0);
  signal salidas_next, salidas_i                                          : std_logic_vector(23 downto 0);

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
  -- Asignación de entradas de sumador y multiplicador
  Assign : process (estado, reg1, reg2, reg3, reg4, reg5, reg6, tmp0, estado_uns)
  begin
    sum1 <= (others => '0');
    sum2 <= (others => '0');
    mul1 <= (others => '0');
    mul2 <= (others => '0');
    case estado_uns is
      when ck0 =>
        mul1 <= tmp0;
        mul2 <= b1;
      when ck1 =>
        mul1 <= tmp0;
        mul2 <= b2;
        sum1 <= reg1;
        sum2 <= reg2;
      when ck2 =>
        mul1 <= tmp0;
        mul2 <= b3;
        sum1 <= reg1;
        sum2 <= reg3;
      when ck3 =>
        mul1 <= tmp0;
        mul2 <= b4;
        sum1 <= reg1;
        sum2 <= reg4;
      when ck4 =>
        mul1 <= tmp0;
        mul2 <= b5;
        sum1 <= reg1;
        sum2 <= reg5;
      when ck5 =>
        mul1 <= reg2;
        mul2 <= neg_a1;
      when ck6 =>
        mul1 <= reg6;
        mul2 <= neg_a2;
      when ck7 =>
        mul1 <= reg6;
        mul2 <= neg_a3;
        sum1 <= reg3;
        sum2 <= reg2;
      when ck8 =>
        mul1 <= reg6;
        mul2 <= neg_a4;
        sum1 <= reg4;
        sum2 <= reg3;
      when ck9 =>
        mul1 <= reg6;
        mul2 <= neg_a5;
        sum1 <= reg5;
        sum2 <= reg4;
      when ck10 =>
        sum1 <= reg1;
        sum2 <= reg5;
      when others =>
    end case;
  end process;

  -- Sumador y Restador
  sum <= sum1 + sum2;
  mul <= mul1 * mul2;

  -- Asignación de salidas
  Assign_out : process (estado, sum, mul, t_mul, reg1, reg2, reg3, reg4, reg5, reg6, estado_uns)
  begin
    salidas_next <= salidas_i;
    reg1_next <= reg1;
    reg2_next <= reg2;
    reg3_next <= reg3;
    reg4_next <= reg4;
    reg5_next <= reg5;
    reg6_next <= reg6;
    t_mul     <= mul(39 downto 16);
    case estado_uns is
      when idle =>
        reg1_next <= (others => '0');
        reg2_next <= (others => '0');
        reg3_next <= (others => '0');
        reg4_next <= (others => '0');
        reg5_next <= (others => '0');
        reg6_next <= (others => '0');
      when ck0 =>
        reg1_next <= t_mul;
      when ck1 =>
        reg1_next <= t_mul;
        reg2_next <= sum;
      when ck2 =>
        reg1_next <= t_mul;
        reg3_next <= sum;
      when ck3 =>
        reg1_next <= t_mul;
        reg4_next <= sum;
      when ck4 =>
        reg1_next <= t_mul;
        reg5_next <= sum;
      when ck5 =>
        reg6_next    <= t_mul;
        salidas_next <= std_logic_vector(t_mul);
      when ck6 =>
        reg2_next <= t_mul;
      when ck7 =>
        reg3_next <= t_mul;
        reg2_next <= sum;
      when ck8 =>
        reg4_next <= t_mul;
        reg3_next <= sum;
      when ck9 =>
        reg5_next <= t_mul;
        reg4_next <= sum;
      when ck10 =>
        reg5_next <= sum;
      when others =>
    end case;
  end process;

  --Secuencial
  Proc_seq : process (reset, clk)
  begin
    if reset = '0' then
      reg1      <= (others => '0');
      reg2      <= (others => '0');
      reg3      <= (others => '0');
      reg4      <= (others => '0');
      reg5      <= (others => '0');
      reg6      <= (others => '0');
      salidas_i <= (others => '0');
    elsif (clk'event and clk = '1') then
      reg1      <= reg1_next;
      reg2      <= reg2_next;
      reg3      <= reg3_next;
      reg4      <= reg4_next;
      reg5      <= reg5_next;
      reg6      <= reg6_next;
      salidas_i <= salidas_next;
    end if;
  end process;
  salidas    <= salidas_i;
  tmp0       <= signed(entradas);
  estado_uns <= unsigned(estado);
end behavior;
