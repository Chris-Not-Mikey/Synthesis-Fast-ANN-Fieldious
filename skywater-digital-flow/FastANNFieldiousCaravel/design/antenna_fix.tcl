################################################################################
#  DISCLAIMER: The following code is provided for Cadence customers to use at  #
#   their own risk. The code may require modification to satisfy the           #
#   requirements of any user. The code and any modifications to the code may   #
#   not be compatible with current or future versions of Cadence products.     #
#   THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING WITHOUT     #
#   LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES OF MERCHANTABILITY #
#   OR FITNESS FOR A PARTICULAR USE.                                           #
################################################################################

# This script attaches diodes to the pins with violations in $antennaFile.
# The antenna violation report can be generated using verifyProcessAntenna.
#
proc addDiode {antennaFile antennaCell} {
  unlogCommand dbGet
  if [catch {open $antennaFile r} fileId] {
    puts stderr "Cannot open $antennaFile: $fileId"
  } else {
    foreach line [split [read $fileId] \n] {
      # Search for lines matching "instName (cellName) pinName" that have violations
      if {[regexp {^  (\S+)  (\S+) (\S+)} $line] == 1} {
        # Remove extra white space
        regsub -all -- {[[:space:]]+} $line " " line
        set line [string trimlef $line]
        # Store instance and pin name to insert diodes on
        set instName [lindex [split $line] 0]
        # Modify instance name if it contains escaped characters:
        set escapedInstName ""
        foreach hier [split $instName /] {
          if {[regexp {\[|\]|\.} $hier] == 1} {
            set hier "\\$hier "
          }
          set escapedInstName "$escapedInstName$hier/"
          set instName $escapedInstName
        }
        regsub {/$} $instName {} instName
        set pinName [lindex [split $line] 2]
        set instPtr [dbGet -p top.insts.name $instName]
        set instLoc [lindex [dbGet $instPtr.pt] 0]
        if {$instName != ""} {
          # Attach diode and place at location of instance
          attachDiode -diodeCell $antennaCell -pin $instName $pinName -loc $instLoc
        }
      }
    }
  }
  close $fileId
  # Legalize placement of diodes and run ecoRoute to route them
  refinePlace -preserveRouting true
  ecoRoute
  logCommand dbGet
}

# create_diode_cui script #
#====================================================================================
proc create_diode_cui {antenna_viols_rpt diodeCellName} {
## Getting all the instances in the design
set all_insts [get_db insts .name]
## Opening the Antenna Violation File created by check_process_antenna
set fpr [open $antenna_viols_rpt r]
      foreach line [split [read $fpr] \n] {
        if {[regexp {\s*[0-9a-zA-Z\/\(\)\s]*} $line match]} {
                    if {[lsearch $all_insts [lindex $line 0]] >= 0} {
              set instName [lindex $line 0]
              set instPin [lindex $line 2]
              set inst_llx [get_db inst:$instName .bbox.ll.x]
              set inst_lly [get_db inst:$instName .bbox.ll.y]
              create_diode -prefix user_diode\
                                 -diode_cell $diodeCellName\
                                 -pin $instName $instPin\
                                 -loc ${inst_llx} ${inst_lly}
            }
        }
    }
close $fpr
set_db eco_refine_place true
set_db place_detail_preserve_routing true
place_detail ; route_eco
puts "User Added Diodes Are:"
set user_diodes [get_db [get_db insts -if {.name==*user_diode*}] .name]
      foreach user_diode $user_diodes {
           puts "$user_diode ([get_db inst:$user_diode .base_cell.name]) is added at [get_db inst:$user_d
      }    
}
#End of the Script
#======================================================================================
