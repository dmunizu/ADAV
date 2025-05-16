LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;

ENTITY datapath IS 
  PORT (
     reset, clk    : in std_logic;
     comandos      : in std_logic_vector(7 downto 0);
     entradas      : in std_logic_vector(23 downto 0);  
     salidas       : out std_logic_vector(23 downto 0);  
     flags         : out std_logic_vector(7 downto 0) );
END datapath;

ARCHITECTURE behavior OF datapath IS
signal sv1, sv2, sv3, sv4 : signed(23 downto 0);
signal tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9 : signed(23 downto 0);
signal tmp10, tmp11, tmp12, tmp13, tmp14, tmp15, tmp16, tmp17, tmp18 : signed(23 downto 0);

signal m_tmp1, m_tmp2, m_tmp3, m_tmp4, m_tmp5 : signed(47 downto 0);
signal m_tmp10, m_tmp11, m_tmp12, m_tmp13, m_tmp14 : signed(47 downto 0);

constant b1: signed(23 downto 0) := "00000000" & "00000100" & "11000000"; --b1 > 0
constant b2: signed(23 downto 0) := "00000000" & "00010011" & "00000010"; --b2 > 0
constant b3: signed(23 downto 0) := "00000000" & "00011100" & "10000011"; --b3 > 0
constant b4: signed(23 downto 0) := "00000000" & "00010011" & "00000010"; --b4 > 0
constant b5: signed(23 downto 0) := "00000000" & "00000100" & "11000000"; --b5 > 0

constant neg_a1: signed(23 downto 0) := "00000001" & "00000000" & "00000000"; --neg_a1 > 0
constant neg_a2: signed(23 downto 0) := "00000001" & "10010010" & "00000101"; --neg_a2 > 0
constant neg_a3: signed(23 downto 0) := "11111110" & "10111001" & "01110010"; --neg_a3 < 0 
constant neg_a4: signed(23 downto 0) := "00000000" & "01111100" & "00000001"; --neg_a4 > 0
constant neg_a5: signed(23 downto 0) := "11111111" & "11101100" & "01111111"; --neg_a5 < 0

BEGIN  
      Proc_seq : PROCESS (reset, clk)
      BEGIN
           IF reset='0' THEN
                sv1 <= (others => '0');    
                sv2 <= (others => '0');
                sv3 <= (others => '0');
                sv4 <= (others => '0');
           ELSIF (clk'event AND clk='1') THEN
		     IF comandos(0)='1' THEN
                sv1 <= tmp15;   
                sv2 <= tmp16;
                sv3 <= tmp17;
                sv4 <= tmp18;
             END IF; 
           END IF; 
      END PROCESS;
	  
	  flags <= (others => '0');
-------------3. Operadores------------------
  tmp0 <= signed(entradas);
  tmp1 <= m_tmp1(39 downto 16);
  tmp2 <= m_tmp2(39 downto 16);
  tmp3 <= m_tmp3(39 downto 16);
  tmp4 <= m_tmp4(39 downto 16);
  tmp5 <= m_tmp5(39 downto 16);
  m_tmp1 <= tmp0 * b1;
  m_tmp2 <= tmp0 * b2;
  m_tmp3 <= tmp0 * b3;
  m_tmp4 <= tmp0 * b4;
  m_tmp5 <= tmp0 * b5;

  tmp6 <= tmp4 + sv4;
  tmp7 <= tmp3 + sv3;
  tmp8 <= tmp2 + sv2;
  tmp9 <= tmp1 + sv1;

  tmp10 <= m_tmp10(39 downto 16);
  tmp11 <= m_tmp11(39 downto 16);
  tmp12 <= m_tmp12(39 downto 16);
  tmp13 <= m_tmp13(39 downto 16);
  tmp14 <= m_tmp14(39 downto 16);
  m_tmp10 <= tmp9 * neg_a1;
  m_tmp11 <= tmp9 * neg_a2;
  m_tmp12 <= tmp9 * neg_a3;
  m_tmp13 <= tmp9 * neg_a4;
  m_tmp14 <= tmp9 * neg_a5;
  
  tmp15 <= tmp8 + tmp11;
  tmp16 <= tmp7 + tmp12;
  tmp17 <= tmp6 + tmp13;
  tmp18 <= tmp5 + tmp14;

  salidas <= std_logic_vector(tmp10);
--  sv4 <= tmp18;
--  sv3 <= tmp17;
--  sv2 <= tmp16;
--  sv1 <= tmp15;

--  out_sum <= in_sum1 + in_sum2;
--  out_mult <= in_mult1 * in_mult2;
END behavior;
