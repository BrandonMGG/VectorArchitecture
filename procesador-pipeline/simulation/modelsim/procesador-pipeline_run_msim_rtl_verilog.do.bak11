transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cyclonev_ver
vmap cyclonev_ver ./verilog_libs/cyclonev_ver
vlog -vlog01compat -work cyclonev_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/cyclonev_atoms.v}

vlib verilog_libs/cyclonev_hssi_ver
vmap cyclonev_hssi_ver ./verilog_libs/cyclonev_hssi_ver
vlog -vlog01compat -work cyclonev_hssi_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_hssi_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/cyclonev_hssi_atoms.v}

vlib verilog_libs/cyclonev_pcie_hip_ver
vmap cyclonev_pcie_hip_ver ./verilog_libs/cyclonev_pcie_hip_ver
vlog -vlog01compat -work cyclonev_pcie_hip_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_pcie_hip_ver {/home/guillen/intelFPGA_lite/22.1std/quartus/eda/sim_lib/cyclonev_pcie_hip_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/adder.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/sign_extend.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/jump_unit.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/memoryAccess.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/memoryController.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/dmem_ram.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/mux_2to1.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/mux_4to1.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/pc_register.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/segment_ex_mem.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/segment_id_ex.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/segment_if_id.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/segment_mem_wb.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/alu.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/control_unit.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/procesador_pipeline.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/register_file.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/dmem_rom.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/imem.sv}
vlog -sv -work work +incdir+/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline {/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/dmem_seno.sv}

