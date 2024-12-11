LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY divider IS
    PORT (
        CLK_in : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        CLK_out : OUT STD_LOGIC
    );
END divider;

ARCHITECTURE Behavioral OF divider IS
BEGIN
    PROCESS (CLK_in, RST)
        VARIABLE count : INTEGER;
        VARIABLE count2 : INTEGER;
        VARIABLE countout : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        IF RST = '1' THEN
            count := 0;
            count2 := 0;
            CLK_out <= '0';
            countout := "00000000";

        ELSIF rising_edge(CLK_in) THEN
            IF count >= 0 AND count < 50000 THEN
                CLK_out <= '1';

            ELSIF count >= 50000 AND count < 100000 THEN
                CLK_out <= '0';
            ELSIF count = 100000 THEN
                count := 0;
                count2 := count2 + 1;

            END IF;
            count := count + 1;
        END IF;
    END PROCESS;
END Behavioral;