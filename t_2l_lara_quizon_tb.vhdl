-- Filename: t_2l_lara_quizon_tb.vhdl
-- Module: Test Bench for a 4:2 Priority Encoder
-- Reference: Lee S. (2011). Introduction to VHDL. Singapore: Cengage: Learning Asia Pte Ltd

--Description: Test the priority encoder 4 2 module
--Library Statements

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Enityt Deifnition
entity t_2l_lara_quizon_tb is --constants are defined here
	constant MAX_COMB: integer := 64; --number of input combinations (4 bits)
	constant DELAY: time:= 10 ns; --delay value in testing
end entity t_2l_lara_quizon_tb;

architecture tb of t_2l_lara_quizon_tb is
  --inputs to UUT
	signal in0, in1, in2, out0, out1, out2: std_logic;
	signal alarm: std_logic;

	--Component Declarations
	component t_2l_lara_quizon is
		port(in0, in1, in2, out0, out1, out2: in std_logic; alarm: out std_logic);
	end component t_2l_lara_quizon;

begin -- begin main body of the tb architecture
	-- instantiates tyhe unit under test
	
	UUT: component t_2l_lara_quizon port map(in0, in1, in2, out0, out1, out2, alarm);

	--main process: generate test vectors and check results
	main: process is
		variable temp: unsigned(5 downto 0); --used in claculations
		variable expected_alarm: std_logic;
		variable error_count: integer := 0; --number of simulation errors
		
	begin
		report "Start simulation.";
		
		--generate all possible	imput value, since max=15
		for count in 0 to 63 loop
			temp := TO_UNSIGNED(count, 6);
				in0 <= std_logic(temp(5));
				in1 <= std_logic(temp(4));
				in2 <= std_logic(temp(3));
				out0 <= std_logic(temp(2));
				out1 <= std_logic(temp(1));
				out2 <= std_logic(temp(0));
				
				--compute expected values
				if( ( temp(5)='0' and temp(4)='0' and temp(3)='0' ) or ( temp(2)='0' and temp(1)='0' and temp(0)='0' ) )then
					expected_alarm := '0';
				else
					expected_alarm := '1';
				end if; -- of if (i=0) .. else
				
				wait for DELAY; -- wait, and then compare with UUT outputs
				
				--check if output of cicuit ids the same as the expected value
				assert (expected_alarm = alarm)
					report "ERROR: Expected alarm " &
						std_logic'image(expected_alarm) & " BUT " &
						std_logic'image(alarm) & " at time " & time'image(now);
					
				--increment number of errors
				if(expected_alarm/=alarm) then
					error_count := error_count +1;
				end if;
			end loop;
			
			wait for DELAY;
			
			--report errors
			assert(error_count=0)
				report "ERROR: There were " &
					integer'image(error_count) & " errors!";
			
			--there are no errors
			if(error_count = 0) then
				report "Simulation completed with NO errors!";
			end if;
			
			wait;
		end process;
end architecture tb;
