#=========================================================================
# make_path_groups.tcl
#=========================================================================
# Path groups help the timing engine prioritize which timing paths to
# spend more time fixing. Generally we create timing groups for
# register-to-register paths (Reg2Reg), input-to-register paths (In2Reg),
# and register-to-output paths (Reg2Out). However, other timing groups can
# also be very useful (e.g., macros).
#
# Author : Christopher Torng
# Date   : January 13, 2020

#-------------------------------------------------------------------------
# Set up path groups for timing
#-------------------------------------------------------------------------

# Reset all existing path groups, including basic path groups

reset_path_group -all

# Reset all options set on all path groups

resetPathGroupOptions

# Create collection for each category
set_interactive_constraint_modes [all_constraint_modes -active] 


# set_max_transition 0.04 [get_lib_pins *addr0*]
# set_max_transition 0.04 [get_lib_pins *mask*]





# set clock_period 5

# set wbclock_net  wb_clk_i
# set wbclock_new_name ideal_clock

# set ioclock_net io_in[0]
# set ioclock_new_name   ideal_clock_io

# set userclock2_net user_clock2
# set userclock2_new_name ideal_user_clock2

# # set userclockmux_new_name ideal_mux_user_clock
# # set clockmux_new_name   ideal_mux_clock

# create_clock -name ${wbclock_new_name}     -period 100 [get_ports "wb_clk_i"]
# create_clock -name ${ioclock_new_name}   -period ${clock_period} [get_ports "io_in[0]"]
# create_clock -name ${userclock2_new_name}   -period ${clock_period} [get_ports "user_clock2"]

# set_clock_groups -logically_exclusive \
#                  -group [get_clocks ${userclock2_new_name}] \
#                  -group [get_clocks ${ioclock_new_name}]

# set_clock_groups -asynchronous \
#                  -group [get_clocks ${wbclock_new_name}] \
#                  -group [get_clocks ${ioclock_new_name}]

# set_clock_groups -asynchronous \
#                  -group [get_clocks ${wbclock_new_name}] \
#                  -group [get_clocks ${userclock2_new_name}]




set inputs   [all_inputs -no_clocks]
set outputs  [all_outputs]
set icgs     [filter_collection [all_registers] "is_integrated_clock_gating_cell == true"]
set regs     [remove_from_collection [all_registers -edge_triggered] $icgs]
set allregs  [all_registers]

# Create collection for all macros

set blocks      [ dbGet top.insts.cell.baseClass block -p2 ]
set macro_refs  [ list ]
set macros      [ list ]

# If the list of blocks is non-empty, filter out non-physical blocks

set blocks_exist  [ expr [ lindex $blocks 0 ] != 0 ]

if { $blocks_exist } {
  foreach b $blocks {
    set cell    [ dbGet $b.cell ]
    set isBlock [ dbIsCellBlock $cell ]
    set isPhys  [ dbGet $b.isPhysOnly ]
    # Return all blocks that are _not_ physical-only (e.g., filter out IO bondpads)
    if { [ expr $isBlock && ! $isPhys ] } {
      puts [ dbGet $b.name ]
      lappend macro_refs $b
      lappend macros     [ dbGet $b.name ]
    }
  }
}

# Group paths (for any groups that exist)

group_path -name In2Out -from $inputs -to $outputs

if { $allregs != "" } {
  group_path -name In2Reg  -from $inputs  -to $allregs
  group_path -name Reg2Out -from $allregs -to $outputs
}

if { $regs != "" } {
  group_path -name Reg2Reg -from $regs -to $regs
}

if { $allregs != "" && $icgs != "" } {
  group_path -name Reg2ClkGate -from $allregs -to $icgs
}

if { $macros != "" } {
  group_path -name All2Macro -to   $macros
  group_path -name Macro2All -from $macros
}

# High-effort path groups

if { $macros != "" } {
  setPathGroupOptions All2Macro -effortLevel high
  setPathGroupOptions Macro2All -effortLevel high
}

if { $regs != "" } {
  setPathGroupOptions Reg2Reg -effortLevel high
}

if { $allregs != "" } {
  setPathGroupOptions Reg2Out -effortLevel high
}


# decalre again so Innovus won't add these cells
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__probec_p_8]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__probe_p_8]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkinvlp_2]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkinvlp_4]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__dlygate4sd1_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__dlygate4sd2_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__dlygate4sd3_1]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__dlymetal6s2s_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__dlymetal6s4s_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__dlymetal6s6s_1]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__buf_16]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__lpflow*]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkinv_16]


set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s15_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s15_2]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s18_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s18_2]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s25_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s25_2]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s50_1]
set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__clkdlybuf4s50_2]

set_dont_use [get_lib_cell -quiet sky130_fd_sc_hd__tt_025C_1v80/sky130_fd_sc_hd__and2_0]
