#reset
ghdl -a t_2l_lara_quizon.vhdl && ghdl -e t_2l_lara_quizon && ghdl -a t_2l_lara_quizon_tb.vhdl && ghdl -e t_2l_lara_quizon_tb && ghdl -r t_2l_lara_quizon_tb --vcd=t_2l_lara_quizon.vcd 	&& gtkwave t_2l_lara_quizon.vcd
