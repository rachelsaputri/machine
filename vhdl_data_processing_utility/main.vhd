-- VHDL Data Processing Utility
-- Main Entry Point
-- Description: Top-level module orchestrating data ingestion, transformation, validation, and reporting.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use std.textio.all;

entity vhdl_data_processing_utility is
    generic(
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 16
    );
    port(
        clk      : in  std_logic;
        rst      : in  std_logic;
        -- Control Signals
        start    : in  std_logic;
        busy     : out std_logic;
        done     : out std_logic;
        error    : out std_logic;
        -- Data Input Port (Simulated as external memory interface)
        data_in  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        addr_in  : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
        addr_en  : in  std_logic;
        -- Data Output Port
        data_out : out std_logic_vector(DATA_WIDTH-1 downto 0);
        addr_out : out std_logic_vector(ADDR_WIDTH-1 downto 0);
        addr_en_out : out std_logic;
        -- Status/Debug
        cycle_cnt : out std_logic_vector(15 downto 0)
    );
end vhdl_data_processing_utility;

architecture Behavioral of vhdl_data_processing_utility is

    -- FSM States
    type state_type is (IDLE, INGEST, PREPROCESS, VALIDATE, TRANSFORM, REPORT, HOLD_ERROR);
    signal current_state, next_state : state_type;
    
    -- Internal Registers
    signal addr_reg : std_logic_vector(ADDR_WIDTH-1 downto 0);
    signal data_buf : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal data_cnt : std_logic_vector(15 downto 0);
    signal error_reg : std_logic;
    
    -- Component: Validator
    -- In a real system, this would be a separate entity. For self-containment in a utility,
    -- we implement validation logic inline here. Validation checks: even/parity, non-zero.
    
    -- Component: Transformer
    -- Inline implementation for this utility context. Multiplies data by 2 (shift left by 1).
    
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                current_state <= IDLE;
                addr_reg <= (others => '0');
                data_cnt <= (others => '0');
                error_reg <= '0';
                data_buf <= (others => '0');
                busy <= '0';
                done <= '0';
                cycle_cnt <= (others => '0');
            else
                -- Update cycle counter (global clock cycle tracking)
                cycle_cnt <= std_logic_vector(unsigned(cycle_cnt) + 1);
                
                case current_state is
                    when IDLE =>
                        busy <= '0';
                        done <= '0';
                        error_reg <= '0';
                        if start = '1' then
                            addr_reg <= (others => '0');
                            data_cnt <= (others => '0');
                            current_state <= INGEST;
                            busy <= '1';
                        end if;

                    when INGEST =>
                        -- In a real FPGA, this would be reading from a FIFO or memory bus
                        -- Here, we simulate by capturing the input port data
                        data_buf <= data_in;
                        addr_reg <= addr_in;
                        current_state <= PREPROCESS;

                    when PREPROCESS =>
                        -- Simple data alignment/padding check or basic cleanup logic
                        -- Assume data is ready
                        current_state <= VALIDATE;

                    when VALIDATE =>
                        -- Validation Logic: Check for parity error or zero value
                        -- Parity check: odd number of 1s
                        if (data_buf = (others => '0')) then
                            -- Zero value is considered invalid for this utility
                            error_reg <= '1';
                            current_state <= HOLD_ERROR;
                        elsif (parity_check(data_buf) = '0') then
                            -- Even parity detected (assuming odd parity expected)
                            error_reg <= '1';
                            current_state <= HOLD_ERROR;
                        else
                            error_reg <= '0';
                            current_state <= TRANSFORM;
                        end if;

                    when HOLD_ERROR =>
                        error <= '1';
                        -- Wait for reset or external signal to clear error (simulated here by waiting for rst)
                        if rst = '1' then
                            current_state <= IDLE;
                        end if;

                    when TRANSFORM =>
                        -- Transformation Logic: Multiply by 2
                        -- Result stored temporarily, will be output in report phase
                        current_state <= REPORT;

                    when REPORT =>
                        -- Output the processed data
                        data_out <= std_logic_vector(to_unsigned(to_integer(unsigned(data_buf)) * 2, DATA_WIDTH));
                        addr_out <= addr_reg;
                        addr_en_out <= '1';
                        
                        -- Increment count for internal tracking
                        data_cnt <= std_logic_vector(unsigned(data_cnt) + 1);
                        
                        -- End of simulation sequence
                        done <= '1';
                        current_state <= IDLE;

                    when others =>
                        current_state <= IDLE;
                end case;
            end if;
        end if;
    end process;

    -- Output assignment
    error <= error_reg;
    
    -- Helper Function for Parity
    function parity_check(signal val : std_logic_vector) return std_logic is
        variable parity_val : std_logic := '0';
        variable i : integer;
    begin
        for i in val'range loop
            parity_val := parity_val xor val(i);
        end loop;
        return parity_val;
    end function;

end Behavioral;"}]} {
