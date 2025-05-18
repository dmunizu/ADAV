library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity datapath is
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
end datapath;

architecture behavior of datapath is
  -- Circuit 0 signals
  signal sv1_0, sv2_0, sv3_0, sv4_0                                                      : signed(23 downto 0);
  signal tmp0_0, tmp1_0, tmp2_0, tmp3_0, tmp4_0, tmp5_0, tmp6_0, tmp7_0, tmp8_0, tmp9_0  : signed(23 downto 0);
  signal tmp10_0, tmp11_0, tmp12_0, tmp13_0, tmp14_0, tmp15_0, tmp16_0, tmp17_0, tmp18_0 : signed(23 downto 0);
  signal m_tmp1_0, m_tmp2_0, m_tmp3_0, m_tmp4_0, m_tmp5_0                                : signed(47 downto 0);
  signal m_tmp10_0, m_tmp11_0, m_tmp12_0, m_tmp13_0, m_tmp14_0                           : signed(47 downto 0);

  -- Circuit 1 signals
  signal sv1_1, sv2_1, sv3_1, sv4_1                                                      : signed(23 downto 0);
  signal tmp0_1, tmp1_1, tmp2_1, tmp3_1, tmp4_1, tmp5_1, tmp6_1, tmp7_1, tmp8_1, tmp9_1  : signed(23 downto 0);
  signal tmp10_1, tmp11_1, tmp12_1, tmp13_1, tmp14_1, tmp15_1, tmp16_1, tmp17_1, tmp18_1 : signed(23 downto 0);
  signal m_tmp1_1, m_tmp2_1, m_tmp3_1, m_tmp4_1, m_tmp5_1                                : signed(47 downto 0);
  signal m_tmp10_1, m_tmp11_1, m_tmp12_1, m_tmp13_1, m_tmp14_1                           : signed(47 downto 0);

  -- Circuit 2 signals
  signal sv1_2, sv2_2, sv3_2, sv4_2                                                      : signed(23 downto 0);
  signal tmp0_2, tmp1_2, tmp2_2, tmp3_2, tmp4_2, tmp5_2, tmp6_2, tmp7_2, tmp8_2, tmp9_2  : signed(23 downto 0);
  signal tmp10_2, tmp11_2, tmp12_2, tmp13_2, tmp14_2, tmp15_2, tmp16_2, tmp17_2, tmp18_2 : signed(23 downto 0);
  signal m_tmp1_2, m_tmp2_2, m_tmp3_2, m_tmp4_2, m_tmp5_2                                : signed(47 downto 0);
  signal m_tmp10_2, m_tmp11_2, m_tmp12_2, m_tmp13_2, m_tmp14_2                           : signed(47 downto 0);

  -- Constants
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

  ------------ Parte secuencial ------------
  -- Pipeline
  Proc_pipeline : process (reset, clk)
  begin
    if reset = '0' then
      m_tmp1_0 <= (others => '0');
      m_tmp2_0 <= (others => '0');
      m_tmp3_0 <= (others => '0');
      m_tmp4_0 <= (others => '0');
      m_tmp5_0 <= (others => '0');
    elsif (clk'event and clk = '1') then
      if estado(0) = '1' then
        m_tmp1_0 <= tmp0_2 * b1;
        m_tmp2_0 <= tmp0_2 * b2;
        m_tmp3_0 <= tmp0_2 * b3;
        m_tmp4_0 <= tmp0_2 * b4;
        m_tmp5_0 <= tmp0_2 * b5;
      end if;
    end if;
  end process;
  -- SV
  Proc_seq : process (reset, clk)
  begin
    if reset = '0' then
      sv4_0 <= (others => '0');
      sv3_0 <= (others => '0');
      sv2_0 <= (others => '0');
      sv1_0 <= (others => '0');
    elsif (clk'event and clk = '1') then
      if estado(1) = '1' then
        sv4_0 <= tmp18_2;
        sv3_0 <= tmp17_2;
        sv2_0 <= tmp16_2;
        sv1_0 <= tmp15_2;
      end if;
    end if;
  end process;

  ------------ Parte combinacional del pipeline original ------------
  m_tmp1_1 <= tmp0_0 * b1;
  m_tmp2_1 <= tmp0_0 * b2;
  m_tmp3_1 <= tmp0_0 * b3;
  m_tmp4_1 <= tmp0_0 * b4;
  m_tmp5_1 <= tmp0_0 * b5;
  m_tmp1_2 <= tmp0_1 * b1;
  m_tmp2_2 <= tmp0_1 * b2;
  m_tmp3_2 <= tmp0_1 * b3;
  m_tmp4_2 <= tmp0_1 * b4;
  m_tmp5_2 <= tmp0_1 * b5;

  ------------ Parte combinacional de la suma original ------------
  sv4_1 <= tmp18_0;
  sv3_1 <= tmp17_0;
  sv2_1 <= tmp16_0;
  sv1_1 <= tmp15_0;
  sv4_2 <= tmp18_1;
  sv3_2 <= tmp17_1;
  sv2_2 <= tmp16_1;
  sv1_2 <= tmp15_1;

  ------------ Parte completamente combinacional ------------
  tmp0_0    <= signed(entradas_0);
  tmp1_0    <= m_tmp1_0(39 downto 16);
  tmp2_0    <= m_tmp2_0(39 downto 16);
  tmp3_0    <= m_tmp3_0(39 downto 16);
  tmp4_0    <= m_tmp4_0(39 downto 16);
  tmp5_0    <= m_tmp5_0(39 downto 16);
  tmp10_0   <= m_tmp10_0(39 downto 16);
  tmp11_0   <= m_tmp11_0(39 downto 16);
  tmp12_0   <= m_tmp12_0(39 downto 16);
  tmp13_0   <= m_tmp13_0(39 downto 16);
  tmp14_0   <= m_tmp14_0(39 downto 16);
  m_tmp10_0 <= tmp9_0 * neg_a1;
  m_tmp11_0 <= tmp9_0 * neg_a2;
  m_tmp12_0 <= tmp9_0 * neg_a3;
  m_tmp13_0 <= tmp9_0 * neg_a4;
  m_tmp14_0 <= tmp9_0 * neg_a5;
  tmp6_0    <= tmp4_0 + sv4_0;
  tmp7_0    <= tmp3_0 + sv3_0;
  tmp8_0    <= tmp2_0 + sv2_0;
  tmp9_0    <= tmp1_0 + sv1_0;
  tmp15_0   <= tmp8_0 + tmp11_0;
  tmp16_0   <= tmp7_0 + tmp12_0;
  tmp17_0   <= tmp6_0 + tmp13_0;
  tmp18_0   <= tmp5_0 + tmp14_0;

  tmp0_1    <= signed(entradas_1);
  tmp1_1    <= m_tmp1_1(39 downto 16);
  tmp2_1    <= m_tmp2_1(39 downto 16);
  tmp3_1    <= m_tmp3_1(39 downto 16);
  tmp4_1    <= m_tmp4_1(39 downto 16);
  tmp5_1    <= m_tmp5_1(39 downto 16);
  tmp10_1   <= m_tmp10_1(39 downto 16);
  tmp11_1   <= m_tmp11_1(39 downto 16);
  tmp12_1   <= m_tmp12_1(39 downto 16);
  tmp13_1   <= m_tmp13_1(39 downto 16);
  tmp14_1   <= m_tmp14_1(39 downto 16);
  m_tmp10_1 <= tmp9_1 * neg_a1;
  m_tmp11_1 <= tmp9_1 * neg_a2;
  m_tmp12_1 <= tmp9_1 * neg_a3;
  m_tmp13_1 <= tmp9_1 * neg_a4;
  m_tmp14_1 <= tmp9_1 * neg_a5;
  tmp6_1    <= tmp4_1 + sv4_1;
  tmp7_1    <= tmp3_1 + sv3_1;
  tmp8_1    <= tmp2_1 + sv2_1;
  tmp9_1    <= tmp1_1 + sv1_1;
  tmp15_1   <= tmp8_1 + tmp11_1;
  tmp16_1   <= tmp7_1 + tmp12_1;
  tmp17_1   <= tmp6_1 + tmp13_1;
  tmp18_1   <= tmp5_1 + tmp14_1;

  tmp0_2    <= signed(entradas_2);
  tmp1_2    <= m_tmp1_2(39 downto 16);
  tmp2_2    <= m_tmp2_2(39 downto 16);
  tmp3_2    <= m_tmp3_2(39 downto 16);
  tmp4_2    <= m_tmp4_2(39 downto 16);
  tmp5_2    <= m_tmp5_2(39 downto 16);
  tmp10_2   <= m_tmp10_2(39 downto 16);
  tmp11_2   <= m_tmp11_2(39 downto 16);
  tmp12_2   <= m_tmp12_2(39 downto 16);
  tmp13_2   <= m_tmp13_2(39 downto 16);
  tmp14_2   <= m_tmp14_2(39 downto 16);
  m_tmp10_2 <= tmp9_2 * neg_a1;
  m_tmp11_2 <= tmp9_2 * neg_a2;
  m_tmp12_2 <= tmp9_2 * neg_a3;
  m_tmp13_2 <= tmp9_2 * neg_a4;
  m_tmp14_2 <= tmp9_2 * neg_a5;
  tmp6_2    <= tmp4_2 + sv4_2;
  tmp7_2    <= tmp3_2 + sv3_2;
  tmp8_2    <= tmp2_2 + sv2_2;
  tmp9_2    <= tmp1_2 + sv1_2;
  tmp15_2   <= tmp8_2 + tmp11_2;
  tmp16_2   <= tmp7_2 + tmp12_2;
  tmp17_2   <= tmp6_2 + tmp13_2;
  tmp18_2   <= tmp5_2 + tmp14_2;

  flags <= (others => '0');

  salidas_0 <= std_logic_vector(tmp10_0);
  salidas_1 <= std_logic_vector(tmp10_1);
  salidas_2 <= std_logic_vector(tmp10_2);
end behavior;
