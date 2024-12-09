library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity slowrunninglights is
    Port (
        CLK100MHZ :  in  STD_LOGIC;
        RST :  in  STD_LOGIC;
        AN : out  STD_LOGIC_VECTOR (7 downto 0);
        CA,CB,CC,CD,CE,CF,CG, DP: out STD_logic;
        ACL_CSN, ACL_SCLK, ACL_MOSI : out STD_LOGIC;
        SW : in std_logic_vector (15 downto 0);
        ACL_MISO : in STD_LOGIC
        );
end slowrunninglights;

architecture slowrunninglights_arch of slowrunninglights is
    component runninglights is
        Port (
            CLK :  in  STD_LOGIC;
            RST :  in  STD_LOGIC;
            Hund,Ten,ITS: in STD_LOGIC_VECTOR (3 downto 0);
            AN : out  STD_LOGIC_VECTOR (7 downto 0);
            CA,CB,CC,CD,CE,CF,CG, DP: out STD_logic);
    end component;
    component BCD is
    Port (
        CLK     : in  STD_LOGIC;
        RST     : in  STD_LOGIC;
        HUN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
        TEN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
        NIT_OUT : out STD_LOGIC_VECTOR(3 downto 0);
        bin : in STD_LOGIC_VECTOR(7 downto 0));
    end component;
            
    component divider is
        Port (
            CLK_in :  in  STD_LOGIC;
            RST :     in  STD_LOGIC;
            CLK_out : out  STD_LOGIC
            );
    end component;
    
    component accel_spi
        port ( 
        clk,reset: in std_logic; -- generic i/o
        
         CS: out std_logic;
         SCK: out std_logic; -- spi i/o
         MOSI: out std_logic;
         MISO: in std_logic;
         
         switch_arr: in std_logic_vector(15 downto 0);
        accel_output_data: out std_logic_vector(7 downto 0) -- to be forwarded to clive for outputs
        );
    end component;
    
    signal slow_clk : std_logic;
    signal hund, ten, nit: std_logic_vector(3 downto 0);
    signal test:  STD_LOGIC_VECTOR(7 downto 0);
begin
    
    runninglights_1 : runninglights
        port map(
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
    port map(
        bin => test,
        RST => RST,
        CLK => slow_clk,
        HUN_OUT => hund,
        TEN_OUT => ten,
        NIT_OUT => nit
        
    );

    divider_1 : divider
        port map(
            CLK_in => CLK100MHZ,
            RST => RST,
            CLK_out => slow_clk
            );
            
    ACC_1 : accel_spi
        port map(clk => CLK100MHZ,
        reset => RST,
        miso => ACL_MISO,
        switch_arr => SW,
        accel_output_data => test,
        CS => ACL_CSN,
        SCK => ACL_SCLK,
        MOSI => ACL_MOSI
        );
end slowrunninglights_arch;
