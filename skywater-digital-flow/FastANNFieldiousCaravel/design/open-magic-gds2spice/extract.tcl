cif istyle sky130(vendor)
set ::env(MAGIC_EXT_USE_GDS) 1
foreach f [glob -directory inputs *.lef] {
    lef read $f
}
gds noduplicates true
gds order true

gds flatten true
gds read ./inputs/design_merged.gds
load $::env(design_name)
ext2spice short resistor
select top cell
extract no all
extract do local
extract unique
extract
ext2spice lvs
ext2spice $::env(design_name).ext
exit
