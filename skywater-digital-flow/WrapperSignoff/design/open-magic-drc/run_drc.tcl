# To treat SRAM as a blackbox
#  foreach f [glob -directory inputs *.lef] {
#     lef read $f
#  }
lef read /farmshare/home/classes/ee/372/PDKs/sky130_sram_macros/sky130_sram_1kbyte_1rw1r_32x256_8/sky130_sram_1kbyte_1rw1r_32x256_8.lef

gds noduplicates true
gds ordering true

# Read design
gds read inputs/design_merged.gds
load $::env(design_name)

select top cell
expand
drc euclidean on
drc style drc(full)
drc check
set drcresult [drc listall why]


# Count number of DRC errors
drc catchup
drc count

quit


