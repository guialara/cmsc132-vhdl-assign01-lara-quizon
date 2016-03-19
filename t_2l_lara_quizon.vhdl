library IEEE; use IEEE.std_logic_1164.all;
entity andGate is
	port(a, b: in std_logic; c: out std_logic);
end andGate;

architecture andGate of andGate is
begin
	c <= a AND b;
end andGate;

---------------------------------------------------------------------------------

library IEEE; use IEEE.std_logic_1164.all;
entity orGate is
	port(a, b, c: in std_logic; d: out std_logic);
end orGate;

architecture orGate of orGate is
begin
	d <= a OR b OR c;
end orGate;

---------------------------------------------------------------------------------
library IEEE; use IEEE.std_logic_1164.all;
entity t_2l_lara_quizon is
	port(in0, in1, in2, out0, out1, out2: in std_logic; alarm: out std_logic);
end t_2l_lara_quizon;

architecture structural of t_2l_lara_quizon is
	signal orOUT, andIn0, andIn1, andIn2, orIn0In1 :std_logic;
	
	component andGate is
		port(a,b: in std_logic; c: out std_logic);
	end component andGate;

	component orGate is
		port(a,b,c: in std_logic; d: out std_logic);
	end component orGate;

	
begin
	g0: component orGate port map(out0, out1, out2, orOUT);
	
	g1: component andGate port map(in0,orOUT, andIn0);
	g2: component andGate port map(in1,orOUT, andIn1);
	g3: component andGate port map(in2,orOUT, andIn2);
	
	g4: component orGate port map(andIn0, andIn1, andIn2, alarm);
	
end architecture structural;
