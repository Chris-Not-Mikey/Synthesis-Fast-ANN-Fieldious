# get_db base_cells -if {.num_base_pins == 1}
setAnalysisMode -analysisType onChipVariation -cppr both
setNanoRouteMode -quiet -drouteFixAntenna 1
setNanoRouteMode -quiet -routeInsertAntennaDiode 1
setNanoRouteMode -quiet -routeInsertDiodeForClockNets 1
setNanoRouteMode -quiet -routeAntennaCellName "sky130_fd_sc_hd__diode_2"
setNanoRouteMode -quiet -drouteEndIteration 500
editDelete -regular_wire_with_drc
ecoRoute
# need a second fix
verifyProcessAntenna
editDelete -regular_wire_with_drc
ecoRoute

deleteRouteBlk -layer {met5} -name "OpenlaneBLK"