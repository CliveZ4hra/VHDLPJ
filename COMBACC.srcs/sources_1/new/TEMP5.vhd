
lIbrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity accel_spi is
port ( 

clk,reset: in std_logic; -- generic i/o

 CS: out std_logic := '1';   
 SCK: out std_logic; -- spi i/o
 MOSI: out std_logic;
 MISO: in std_logic;

accel_output_data: out std_logic_vector(7 downto 0); -- to be forwarded to clive for outputs
switch_arr: in std_logic_vector(15 downto 0)



);


end accel_spi;
  
architecture behavioral of accel_spi is
  
signal clkcount: integer:=1;
signal divClk : std_logic := '0'; -- clock divider
signal x,y,z: std_logic;

signal output_flag : std_logic := '0'; -- serialiser



type sigstate is (command,address,recieve); -- fsm for SPI output
signal spistate: sigstate;
signal spicount: integer := 1;

signal inputbuffer: std_logic_vector (15 downto 0);

begin 

process(clk,reset) -- clock divider

begin
	if(reset='1') then
		clkcount<=1;
		divClk<='0';
		
		
	elsif(clk'event and clk='1') then
		clkcount <=clkcount +1;
		if (clkcount = 50) then
		divCLK <= NOT divCLK;
		
		clkcount <= 1;
		
		end if;
	end if;
end process;
  
  
process(clk,reset) -- SPI logic
 
variable  output_bits : std_logic_vector(7 downto 0);
variable temp: std_logic_vector (15 downto 0);  
  begin
  if (reset = '1') THEN 
  spistate <= command;
  mosi <= '0';
  
  elsif(rising_edge(clk)) THEN
  
  
  case spistate is
  
  when command =>
  if (spicount = 1) then 
  cs <= '0';
  output_bits := x"0B";
  end if;
  
  MOSI <= output_bits(7);
  output_bits := std_logic_vector(shift_left(unsigned(output_bits),1));
  
  
  if(spicount = 8)
  then 
  spistate <= address;
  spicount <= 1;
  else 
  spicount <= spicount + 1;
  end if;


  when address => 
   if (spicount = 1) then 
   
   if (switch_arr(0) = '1') then
   output_bits := x"08";
   elsif (y = '1') then
   output_bits := x"09";
   elsif (z = '1') then
   output_bits := x"0A";
    else    
   output_bits := x"3F"; 

   end if;
   
  
  end if;
  
  MOSI <= output_bits(7);
  output_bits := std_logic_vector(shift_left(unsigned(output_bits),1));
  
   if(spicount = 8)
  then 
  spistate <= recieve;
  spicount <= 1;
  else 
  spicount <= spicount + 1;
  end if;
  
  

  
  when recieve =>
  
  temp(7) := MISO;
  temp := std_logic_vector(shift_right(unsigned(temp),1));
  spicount <= spicount + 1;
  
  if(spicount = 8) then 
  CS <= '1';
  spicount <= 0;
  spistate <= command;
  accel_output_data <= temp(7 downto 0); 
  end if;
  when others =>
  
  
  
  end case;
  end if;
  end process;
  

  
 

  
  
  
  
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
end behavioral;