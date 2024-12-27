LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY slowrunninglights IS
    PORT (
        CLK100MHZ : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        AN : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        CA, CB, CC, CD, CE, CF, CG, DP : OUT STD_LOGIC;
        ACL_CSN, ACL_SCLK, ACL_MOSI : OUT STD_LOGIC;
        SW : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        
        ACL_MISO : IN STD_LOGIC
        
    );
END slowrunninglights;

ARCHITECTURE slowrunninglights_arch OF slowrunninglights IS
    COMPONENT runninglights IS
        PORT (
            CLK : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            Hund, Ten, ITS : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            AN : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            CA, CB, CC, CD, CE, CF, CG, DP : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT BCD IS
        PORT (
            CLK : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            HUN_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            TEN_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            NIT_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bin : IN STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    COMPONENT divider IS
        PORT (
            CLK_in : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            CLK_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT accel_spi
        PORT (
            clk, reset : IN STD_LOGIC; -- generic i/o

            CS : OUT STD_LOGIC;
            SCK : OUT STD_LOGIC; -- spi i/o
            MOSI : OUT STD_LOGIC;
            MISO : IN STD_LOGIC;

            switch_arr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            accel_output_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- to be forwarded to clive for outputs
        );
    END COMPONENT;

    SIGNAL slow_clk : STD_LOGIC;
    SIGNAL hund, ten, nit : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL test : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    runninglights_1 : runninglights
    PORT MAP(
        CLK => slow_clk,
        RST => RST,
        Hund => hund,
        Ten => ten,
        ITS => nit,
        AN => AN,
        CA => CA,
        CB => CB,
        CC => CC,
        CD => CD,
        CE => CE,
        CF => CF,
        CG => CG,
        DP => DP
    );

    BCD_1 : BCD
    PORT MAP(
        bin => test,
        RST => RST,
        CLK => slow_clk,
        HUN_OUT => hund,
        TEN_OUT => ten,
        NIT_OUT => nit

    );

    divider_1 : divider
    PORT MAP(
        CLK_in => CLK100MHZ,
        RST => RST,
        CLK_out => slow_clk
    );

    ACC_1 : accel_spi
    PORT MAP(
        clk => CLK100MHZ,
        reset => RST,
        miso => ACL_MISO,
        switch_arr => SW,
        accel_output_data => test,
        CS => ACL_CSN,
        SCK => ACL_SCLK,
        MOSI => ACL_MOSI
        
        
        
    );
END slowrunninglights_arch;