transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {codificatorehamming.vho}

vcom -93 -work work {C:/Users/adria/OneDrive/Desktop/progetti Quartus/codificatorehamming/testbench_coha.vhd}

vsim -t 1ps -L altera -L altera_lnsim -L cyclonev -L lpm -L sgate -L cyclonev_hssi -L gate_work -L work -voptargs="+acc"  testbench_coha

add wave *
view structure
view signals
run 50 ns
