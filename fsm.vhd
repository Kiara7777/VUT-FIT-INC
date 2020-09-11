-- fsm.vhd: Finite State Machine
-- Author(s): 
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (TEST_1, TEST_2A, TEST_3A, TEST_4A, TEST_5A, TEST_6A, TEST_7A,  TEST_8A, TEST_9A, TEST_10A,
							TEST_2B, TEST_3B, TEST_4B, TEST_5B, TEST_7B, TEST_6B, TEST_8B, TEST_9B, TEST_10B, TEST_11B, 
							PRINT_MESSAGE_OK, PRINT_MESSAGE_ERR, FINAL_ERR, FINAL);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST_1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
	-- 920980722 A
	-- 1381471083 B
   when TEST_1 =>
      next_state <= TEST_1;
      if (KEY(9) = '1') then
			next_state <= TEST_2A;
		elsif (KEY(1) = '1') then
			next_state <= TEST_2B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_2A =>
      next_state <= TEST_2A;
      if (KEY(2) = '1') then
			next_state <= TEST_3A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - - 
	when TEST_3A =>
      next_state <= TEST_3A;
      if (KEY(0) = '1') then
			next_state <= TEST_4A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - - 
	when TEST_4A =>
      next_state <= TEST_4A;
      if (KEY(9) = '1') then
			next_state <= TEST_5A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_5A =>
      next_state <= TEST_5A;
      if (KEY(8) = '1') then
			next_state <= TEST_6A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;	
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_6A =>
      next_state <= TEST_6A;
      if (KEY(0) = '1') then
			next_state <= TEST_7A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_7A =>
      next_state <= TEST_7A;
      if (KEY(7) = '1') then
			next_state <= TEST_8A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;	
	-- - - - - - - - - - - - - - - - - - - - - - - 
	when TEST_8A =>
      next_state <= TEST_8A;
      if (KEY(2) = '1') then
			next_state <= TEST_9A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - - 
	when TEST_9A =>
      next_state <= TEST_9A;
      if (KEY(2) = '1') then
			next_state <= TEST_10A;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - - 
	when TEST_10A =>
      next_state <= TEST_10A;
		if (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_OK; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_2B =>
      next_state <= TEST_2B;
      if (KEY(3) = '1') then
			next_state <= TEST_3B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_3B =>
      next_state <= TEST_3B;
      if (KEY(8) = '1') then
			next_state <= TEST_4B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_4B =>
      next_state <= TEST_4B;
      if (KEY(1) = '1') then
			next_state <= TEST_5B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_5B =>
      next_state <= TEST_5B;
      if (KEY(4) = '1') then
			next_state <= TEST_6B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_6B =>
      next_state <= TEST_6B;
      if (KEY(7) = '1') then
			next_state <= TEST_7B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_7B =>
      next_state <= TEST_7B;
      if (KEY(1) = '1') then
			next_state <= TEST_8B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_8B =>
      next_state <= TEST_8B;
      if (KEY(0) = '1') then
			next_state <= TEST_9B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_9B =>
      next_state <= TEST_9B;
      if (KEY(8) = '1') then
			next_state <= TEST_10B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_10B =>
      next_state <= TEST_10B;
      if (KEY(3) = '1') then
			next_state <= TEST_11B;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
		elsif (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_11B =>
      next_state <= TEST_11B;
      if (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_OK;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= FINAL_ERR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	-- - - - - - - - - - - - - - - - - - - - - - -
	when FINAL_ERR => 
		next_state <= FINAL_ERR;
		if (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_ERR;
		end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_MESSAGE_OK =>
		next_state <= PRINT_MESSAGE_OK;
		if (CNT_OF = '1') then 
			next_state <= FINAL;
		end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_ERR =>
		next_state <= PRINT_MESSAGE_ERR;
		if (CNT_OF = '1') then
			next_state <= FINAL;
		end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINAL =>
      next_state <= FINAL;
      if (KEY(15) = '1') then
         next_state <= TEST_1; 
      end if;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is

	
 
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_ERR =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_MESSAGE_OK =>
		FSM_MX_MEM     <= '1';
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
	-- - - - - - - - - - - - - - - - - - - - - - - 	
   when FINAL =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR  <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
when others =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
	end case;
end process output_logic;
end architecture behavioral;

