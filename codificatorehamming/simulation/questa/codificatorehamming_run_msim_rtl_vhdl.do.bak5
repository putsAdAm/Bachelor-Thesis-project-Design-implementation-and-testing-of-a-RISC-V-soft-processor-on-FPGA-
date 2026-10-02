transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/adria/OneDrive/Desktop/progetti Quartus/codificatorehamming/codificatorehamming.vhd}

vcom -93 -work work {C:/Users/adria/OneDrive/Desktop/progetti Quartus/codificatorehamming/testbench_coha.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L cyclonev_hssi -L rtl_work -L work -voptargs="+acc"  testbench_coha

add wave *
view structure
view signals
run 50 ns
