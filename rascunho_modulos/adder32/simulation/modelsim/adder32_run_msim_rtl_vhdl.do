transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Alec Ryo/Desktop/Trabalho_Final_OAC/m�dulos/adder32.vhd}

vcom -93 -work work {C:/Users/Alec Ryo/Desktop/Trabalho_Final_OAC/m�dulos/adder32_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  adder32_tb

add wave *
view structure
view signals
run 40 ps
