
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY accel_spi IS
  PORT (

    clk, reset : IN STD_LOGIC; -- generic i/o

    CS : OUT STD_LOGIC := '1';
    SCK : OUT STD_LOGIC; -- spi i/o
    MOSI : OUT STD_LOGIC;
    MISO : IN STD_LOGIC;

    accel_output_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- to be forwarded to clive for outputs
    switch_arr : IN STD_LOGIC_VECTOR(15 DOWNTO 0)

  );
END accel_spi;

ARCHITECTURE behavioral OF accel_spi IS

  SIGNAL clkcount : INTEGER := 1;
  SIGNAL divClk : STD_LOGIC := '0'; -- clock divider
  SIGNAL x, y, z : STD_LOGIC;

  SIGNAL output_flag : STD_LOGIC := '0'; -- serialiser

  TYPE sigstate IS (command, address, recieve); -- fsm for SPI output
  SIGNAL spistate : sigstate;
  SIGNAL spicount : INTEGER := 1;

  SIGNAL inputbuffer : STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN

  PROCESS (clk, reset) -- clock divider

  BEGIN
    IF (reset = '1') THEN
      clkcount <= 1;
      divClk <= '0';
    ELSIF (clk'event AND clk = '1') THEN
      clkcount <= clkcount + 1;
      IF (clkcount = 50) THEN
        divCLK <= NOT divCLK;

        clkcount <= 1;

      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk, reset) -- SPI logic

    VARIABLE output_bits : STD_LOGIC_VECTOR(7 DOWNTO 0);
    VARIABLE temp : STD_LOGIC_VECTOR (15 DOWNTO 0);
  BEGIN
    IF (reset = '1') THEN
      spistate <= command;
      mosi <= '0';

    ELSIF (rising_edge(clk)) THEN
      CASE spistate IS

        WHEN command =>
          IF (spicount = 1) THEN
            cs <= '0';
            output_bits := x"0B";
          END IF;

          MOSI <= output_bits(7);
          output_bits := STD_LOGIC_VECTOR(shift_left(unsigned(output_bits), 1));
          IF (spicount = 8)
            THEN
            spistate <= address;
            spicount <= 1;
          ELSE
            spicount <= spicount + 1;
          END IF;
        WHEN address =>
          IF (spicount = 1) THEN

            IF (switch_arr(0) = '1') THEN
              output_bits := x"08";
            ELSIF (switch_arr(1) = '1') THEN
              output_bits := x"09";
            ELSIF (switch_arr(2) = '1') THEN
              output_bits := x"0A";
            ELSE
              output_bits := x"08";

            END IF;
          END IF;

          MOSI <= output_bits(7);
          output_bits := STD_LOGIC_VECTOR(shift_left(unsigned(output_bits), 1));

          IF (spicount = 8)
            THEN
            spistate <= recieve;
            spicount <= 1;
          ELSE
            spicount <= spicount + 1;
          END IF;
        WHEN recieve =>

          temp(7) := MISO;
          temp := STD_LOGIC_VECTOR(shift_right(unsigned(temp), 1));
          spicount <= spicount + 1;

          IF (spicount = 8) THEN
            CS <= '1';
            spicount <= 0;
            spistate <= command;
            accel_output_data <= temp(7 DOWNTO 0);
          END IF;
        WHEN OTHERS =>

      END CASE;
    END IF;
  END PROCESS;

  -- process(clk) -- serialised output process
  -- begin
  -- if output_flag = '1' then
  -- MOSI <= output_bits(0);
  -- output_bits <= std_logic_vector(shift_right(unsigned(output_bits),1));

  -- spicount <= spicount + 1;
  -- if(spicount = 😎 THEN
  -- output_flag <= '0';
  -- spicount <= 1;
  -- end if;
  -- end if; 
  -- end process;
END behavioral;