# netgen option to exclude fill and tap from source
export MAGIC_EXT_USE_GDS=1
netgen -batch lvs "inputs/design_extracted.spice "$design_name"" "inputs/design.lvs.v "$design_name"" netgen_blackbox_setup.tcl outputs/lvs_results.log