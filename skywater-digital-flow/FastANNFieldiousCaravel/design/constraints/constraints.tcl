#=========================================================================
# Design Constraints File
#=========================================================================

# This constraint sets the target clock period for the chip in
# nanoseconds. Note that the first parameter is the name of the clock
# signal in your verlog design. If you called it something different than
# clk you will need to change this. You should set this constraint
# carefully. If the period is unrealistically small then the tools will
# spend forever trying to meet timing and ultimately fail. If the period
# is too large the tools will have no trouble but you will get a very
# conservative implementation.

set wbclock_net  wb_clk_i
set wbclock_name ideal_clock

set ioclock_net io_in[0]
set ioclock_name   ideal_clock_io

set userclock2_net user_clock2
set userclock2_name ideal_user_clock2

set userclockmux_name ideal_mux_user_clock
set clockmux_name   ideal_mux_clock


create_clock -name ${wbclock_name}     -period 100 [get_ports "wb_clk_i"]
create_clock -name ${ioclock_name}   -period ${clock_period} [get_ports "io_in[0]"]
create_clock -name ${userclock2_name}   -period ${clock_period} [get_ports "user_clock2"]
# create_generated_clock -name ${userclockmux_name} [get_pins usrclockmux_inst/out_clk]
# create_generated_clock -name ${clockmux_name} [get_pins clockmux_inst/out_clk]

set_clock_groups -logically_exclusive \
                 -group [get_clocks ${userclock2_name}] \
                 -group [get_clocks ${ioclock_name}]

set_clock_groups -asynchronous \
                 -group [get_clocks ${wbclock_name}] \
                 -group [get_clocks ${ioclock_name}]

set_clock_groups -asynchronous \
                 -group [get_clocks ${wbclock_name}] \
                 -group [get_clocks ${userclock2_name}]

# create_clock -name ${wbclock_name} \
#              -period ${clock_period} \
#              [get_ports ${clock_net}]

# This constraint sets the load capacitance in picofarads of the
# output pins of your design.

set_load -pin_load $ADK_TYPICAL_ON_CHIP_LOAD [all_outputs]

# This constraint sets the input drive strength of the input pins of
# your design. We specify a specific standard cell which models what
# would be driving the inputs. This should usually be a small inverter
# which is reasonable if another block of on-chip logic is driving
# your inputs.

set_driving_cell -no_design_rule \
    -lib_cell $ADK_DRIVING_CELL [all_inputs]

# set_input_delay constraints for input ports
# Make this non-zero to avoid hold buffers on input-registered designs

set_input_delay -clock ${wbclock_name} [expr ${clock_period}/2.0] [remove_from_collection [get_ports "wb*"] [get_ports $wbclock_net]]
set_input_delay -clock ${ioclock_name} [expr ${clock_period}/2.0] [remove_from_collection [get_ports "io*"] [get_ports $ioclock_net]]
# set_input_delay -clock ${userclock2_name} [expr ${clock_period}/2.0] [remove_from_collection [all_inputs] [get_ports $userclock2_net]]

# set_output_delay constraints for output ports

set_output_delay -clock ${wbclock_name} [expr ${clock_period} * 0.2] [get_ports "wb*"]
set_output_delay -clock ${ioclock_name} [expr ${clock_period} * 0.2] [get_ports "io*"]
# set_output_delay -clock ${userclock2_name} [expr ${clock_period} * 0.2] [all_outputs]

# Make all signals limit their fanout

set_max_fanout 20 $dc_design_name

# Make all signals meet good slew

set_max_transition [expr 0.25*${clock_period}] $dc_design_name

#set_input_transition 1 [all_inputs]
#set_max_transition 10 [all_outputs]

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







