transcript on
if ![file isdirectory niosv_iputf_libs] {
	file mkdir niosv_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
vlib niosv_iputf_libs/error_adapter_0
vmap error_adapter_0 ./niosv_iputf_libs/error_adapter_0
vlib niosv_iputf_libs/niosv_reset_controller
vmap niosv_reset_controller ./niosv_iputf_libs/niosv_reset_controller
vlib niosv_iputf_libs/avalon_st_adapter
vmap avalon_st_adapter ./niosv_iputf_libs/avalon_st_adapter
vlib niosv_iputf_libs/rsp_mux_002
vmap rsp_mux_002 ./niosv_iputf_libs/rsp_mux_002
vlib niosv_iputf_libs/rsp_mux
vmap rsp_mux ./niosv_iputf_libs/rsp_mux
vlib niosv_iputf_libs/rsp_demux_001
vmap rsp_demux_001 ./niosv_iputf_libs/rsp_demux_001
vlib niosv_iputf_libs/cmd_mux_001
vmap cmd_mux_001 ./niosv_iputf_libs/cmd_mux_001
vlib niosv_iputf_libs/cmd_mux
vmap cmd_mux ./niosv_iputf_libs/cmd_mux
vlib niosv_iputf_libs/cmd_demux_002
vmap cmd_demux_002 ./niosv_iputf_libs/cmd_demux_002
vlib niosv_iputf_libs/cmd_demux
vmap cmd_demux ./niosv_iputf_libs/cmd_demux
vlib niosv_iputf_libs/intel_niosv_m_0_instruction_manager_wr_limiter
vmap intel_niosv_m_0_instruction_manager_wr_limiter ./niosv_iputf_libs/intel_niosv_m_0_instruction_manager_wr_limiter
vlib niosv_iputf_libs/router_005
vmap router_005 ./niosv_iputf_libs/router_005
vlib niosv_iputf_libs/router_004
vmap router_004 ./niosv_iputf_libs/router_004
vlib niosv_iputf_libs/router_002
vmap router_002 ./niosv_iputf_libs/router_002
vlib niosv_iputf_libs/router
vmap router ./niosv_iputf_libs/router
vlib niosv_iputf_libs/intel_niosv_m_0_dm_agent_agent_rsp_fifo
vmap intel_niosv_m_0_dm_agent_agent_rsp_fifo ./niosv_iputf_libs/intel_niosv_m_0_dm_agent_agent_rsp_fifo
vlib niosv_iputf_libs/intel_niosv_m_0_dm_agent_agent
vmap intel_niosv_m_0_dm_agent_agent ./niosv_iputf_libs/intel_niosv_m_0_dm_agent_agent
vlib niosv_iputf_libs/intel_niosv_m_0_data_manager_agent
vmap intel_niosv_m_0_data_manager_agent ./niosv_iputf_libs/intel_niosv_m_0_data_manager_agent
vlib niosv_iputf_libs/intel_niosv_m_0_dm_agent_translator
vmap intel_niosv_m_0_dm_agent_translator ./niosv_iputf_libs/intel_niosv_m_0_dm_agent_translator
vlib niosv_iputf_libs/irq_mapper
vmap irq_mapper ./niosv_iputf_libs/irq_mapper
vlib niosv_iputf_libs/dbg_mod
vmap dbg_mod ./niosv_iputf_libs/dbg_mod
vlib niosv_iputf_libs/timer_module
vmap timer_module ./niosv_iputf_libs/timer_module
vlib niosv_iputf_libs/hart
vmap hart ./niosv_iputf_libs/hart
vlib niosv_iputf_libs/rst_controller
vmap rst_controller ./niosv_iputf_libs/rst_controller
vlib niosv_iputf_libs/mm_interconnect_0
vmap mm_interconnect_0 ./niosv_iputf_libs/mm_interconnect_0
vlib niosv_iputf_libs/pio_0
vmap pio_0 ./niosv_iputf_libs/pio_0
vlib niosv_iputf_libs/onchip_memory2_0
vmap onchip_memory2_0 ./niosv_iputf_libs/onchip_memory2_0
vlib niosv_iputf_libs/intel_niosv_m_0
vmap intel_niosv_m_0 ./niosv_iputf_libs/intel_niosv_m_0
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 

file copy -force C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/csr_mlab.mif ./
file copy -force C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/debug_rom.mif ./

vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv" -work error_adapter_0                               
vcom     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_reset_controller.vhd"                                   -work niosv_reset_controller                        
vcom     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_avalon_st_adapter.vhd"                -work avalon_st_adapter                             
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_rsp_mux_002.sv"                       -work rsp_mux_002                                   
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_arbitrator.sv"                                  -work rsp_mux_002                                   
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_rsp_mux.sv"                           -work rsp_mux                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_arbitrator.sv"                                  -work rsp_mux                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_rsp_demux_001.sv"                     -work rsp_demux_001                                 
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_cmd_mux_001.sv"                       -work cmd_mux_001                                   
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_arbitrator.sv"                                  -work cmd_mux_001                                   
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_cmd_mux.sv"                           -work cmd_mux                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_arbitrator.sv"                                  -work cmd_mux                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_cmd_demux_002.sv"                     -work cmd_demux_002                                 
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_cmd_demux.sv"                         -work cmd_demux                                     
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_traffic_limiter.sv"                             -work intel_niosv_m_0_instruction_manager_wr_limiter
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_reorder_memory.sv"                              -work intel_niosv_m_0_instruction_manager_wr_limiter
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_avalon_sc_fifo.v"                                      -work intel_niosv_m_0_instruction_manager_wr_limiter
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_avalon_st_pipeline_base.v"                             -work intel_niosv_m_0_instruction_manager_wr_limiter
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_router_005.sv"                        -work router_005                                    
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_router_004.sv"                        -work router_004                                    
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_router_002.sv"                        -work router_002                                    
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0_router.sv"                            -work router                                        
vlog     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_avalon_sc_fifo.v"                                      -work intel_niosv_m_0_dm_agent_agent_rsp_fifo       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_slave_agent.sv"                                 -work intel_niosv_m_0_dm_agent_agent                
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_burst_uncompressor.sv"                          -work intel_niosv_m_0_dm_agent_agent                
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_axi_master_ni.sv"                               -work intel_niosv_m_0_data_manager_agent            
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_address_alignment.sv"                           -work intel_niosv_m_0_data_manager_agent            
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_merlin_slave_translator.sv"                            -work intel_niosv_m_0_dm_agent_translator           
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_intel_niosv_m_0_irq_mapper.sv"                          -work irq_mapper                                    
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_dm_def.sv"                                       -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_ram.sv"                                          -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_dm_jtag2mm.sv"                                   -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_dm_top.sv"                                       -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_debug_module.sv"                                 -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_debug_rom.sv"                                    -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_std_synchronizer_bundle.v"                             -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_std_synchronizer_nocut.v"                              -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_std_synchronizer.v"                                    -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_avalon_st_clock_crosser.v"                             -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_avalon_st_handshake_clock_crosser.v"                   -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_avalon_st_pipeline_base.v"                             -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_avalon_st_pipeline_stage.sv"                           -work dbg_mod                                       
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_timer_msip.sv"                                   -work timer_module                                  
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/riscv.pkg.sv"                                          -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_opcode_def.sv"                                   -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_clic_pkg.sv"                                     -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_mem_op_state.sv"                                 -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_ram.sv"                                          -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/ecc_enc.sv"                                            -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/ecc_dec.sv"                                            -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/altecc_enc.sv"                                         -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/altecc_dec.sv"                                         -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_reg_file.sv"                                     -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_csr.sv"                                          -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_csrind_if.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_csrind_host.sv"                                  -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_interrupt_handler.sv"                            -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_instr_buffer.sv"                                 -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_bus_req.sv"                                      -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_shift.sv"                                        -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_alu.sv"                                          -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_lsu.sv"                                          -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_c_decoder.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_c_core.sv"                                       -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_c_csr.sv"                                        -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_c_D_stage.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_c_E_stage.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_c_M0_stage.sv"                                   -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_m_decoder.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_m_core.sv"                                       -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_m_instr_prefetch.sv"                             -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_m_D_stage.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_m_E_stage.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_m_M0_stage.sv"                                   -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_m_W_stage.sv"                                    -work hart                                          
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/mentor/niosv_intel_niosv_m_0_hart.sv"                         -work hart                                          
vlog     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_reset_controller.v"                                    -work rst_controller                                
vlog     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/altera_reset_synchronizer.v"                                  -work rst_controller                                
vlog -sv "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_irq_mapper.sv"                                          -work irq_mapper                                    
vlog     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_mm_interconnect_0.v"                                    -work mm_interconnect_0                             
vcom     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_pio_0.vhd"                                              -work pio_0                                         
vcom     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_onchip_memory2_0.vhd"                                   -work onchip_memory2_0                              
vlog     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/submodules/niosv_intel_niosv_m_0.v"                                      -work intel_niosv_m_0                               
vcom     "C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/niosv/simulation/niosv.vhd"                                                                                                                   

vcom -93 -work work {C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/top_ent.vhd}

vcom -93 -work work {C:/Users/adria/OneDrive/Desktop/progettiQuartus/niosv/tb_top_ent.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L cyclonev_hssi -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L error_adapter_0 -L niosv_reset_controller -L avalon_st_adapter -L rsp_mux_002 -L rsp_mux -L rsp_demux_001 -L cmd_mux_001 -L cmd_mux -L cmd_demux_002 -L cmd_demux -L intel_niosv_m_0_instruction_manager_wr_limiter -L router_005 -L router_004 -L router_002 -L router -L intel_niosv_m_0_dm_agent_agent_rsp_fifo -L intel_niosv_m_0_dm_agent_agent -L intel_niosv_m_0_data_manager_agent -L intel_niosv_m_0_dm_agent_translator -L irq_mapper -L dbg_mod -L timer_module -L hart -L rst_controller -L mm_interconnect_0 -L pio_0 -L onchip_memory2_0 -L intel_niosv_m_0 -voptargs="+acc"  tb_top_ent

add wave *
view structure
view signals
run 2000 ns
