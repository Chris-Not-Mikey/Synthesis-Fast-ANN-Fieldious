#=========================================================================
# floorplan.tcl
#=========================================================================
# Author : Christopher Torng
# Modified: Chris Calloway
# Date   : March 26, 2018

#-------------------------------------------------------------------------
# Floorplan variables
#-------------------------------------------------------------------------

# Set the floorplan to target a reasonable placement density with a good
# aspect ratio (height:width). An aspect ratio of 2.0 here will make a
# rectangular chip with a height that is twice the width.

# set core_aspect_ratio   1.00; # Aspect ratio 1.0 for a square chip
# set core_density_target 0.60; # Placement density of 70% is reasonable

set core_width  2860;  # Based on 372 lecture (slight increase from before)
set core_height 3460;  # Based on 372 lecture (slight increase from before)

# Make room in the floorplan for the core power ring

set pwr_net_list {VDD VSS}; # List of power nets in the core power ring

set M1_min_width   [dbGet [dbGetLayerByZ 1].minWidth]
set M1_min_spacing [dbGet [dbGetLayerByZ 1].minSpacing]

set savedvars(p_ring_width)   [expr 48 * $M1_min_width];   # Arbitrary!
set savedvars(p_ring_spacing) [expr 24 * $M1_min_spacing]; # Arbitrary!

# Core bounding box margins

set core_margin_t [expr ([llength $pwr_net_list] * ($savedvars(p_ring_width) + $savedvars(p_ring_spacing))) + $savedvars(p_ring_spacing)]
set core_margin_b [expr ([llength $pwr_net_list] * ($savedvars(p_ring_width) + $savedvars(p_ring_spacing))) + $savedvars(p_ring_spacing)]
set core_margin_r [expr ([llength $pwr_net_list] * ($savedvars(p_ring_width) + $savedvars(p_ring_spacing))) + $savedvars(p_ring_spacing)]
set core_margin_l [expr ([llength $pwr_net_list] * ($savedvars(p_ring_width) + $savedvars(p_ring_spacing))) + $savedvars(p_ring_spacing)]

#-------------------------------------------------------------------------
# Floorplan
#-------------------------------------------------------------------------

# Calling floorPlan with the "-r" flag sizes the floorplan according to
# the core aspect ratio and a density target (70% is a reasonable
# density).
#

floorPlan -s $core_width $core_height \
             $core_margin_l $core_margin_b $core_margin_r $core_margin_t

# setFlipping s

# Use automatic floorplan synthesis to pack macros (e.g., SRAMs) together

#planDesign



# # Somehow when li1 blockage is over the entire chip area, no cell can be placed
# # Have to only block the sram area.

# createRouteBlk -layer {li1} -inst sram -cover

# Try blocking metal 5 over full chip
selectModule acc_inst
set box "0 0 $core_width $core_height"

createRouteBlk -box $box -layer {met5}
deselectAll







placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_0__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro  983.5200 3042.0450 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_0__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro  973.6050 2034.8150 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_1__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro  969.2650 2548.7850 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_1__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro  956.6850 1311.1100 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_2__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro  930.2400 775.2300 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_2__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro  933.7750 254.9600 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_3__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro 1635.7700 3032.5150 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_3__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro  1638.9050 2554.6200 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_4__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro  2299.1400 2549.5950 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_4__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro 2289.2700 3035.7400 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_5__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro 303.4100 1313.5250  R0
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_5__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro 331.5050 2021.5850 R0
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_6__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro  1626.6800 2002.9400 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_6__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro  2296.4200 2021.2000 R0
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_7__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro 2287.0450 1322.8600 R180
placeInstance acc_inst/leaf_mem_inst/loop_ram_patch_gen_7__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro 1622.4850 1317.1150  R180


placeInstance acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro  1611.8550 253.6950 R180
placeInstance acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro  1621.0600 790.3350 R180
placeInstance acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_1__loop_width_gen_0__genblk1_sram_macro  2287.1000 255.0650 R180
placeInstance acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_1__loop_width_gen_1__genblk1_sram_macro  2284.1900 796.0400 R180


placeInstance acc_inst/k_best_array_inst/loop_best_array_gen_0__best_dist_array_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro  318.4650 3046.1100 R180
placeInstance acc_inst/k_best_array_inst/loop_best_array_gen_0__best_dist_array_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro  319.3650 2534.7300 R180





addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_0__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_0__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_1__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_1__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_2__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_2__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_3__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_3__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_4__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_4__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_5__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_5__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_6__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_6__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro 
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_7__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/leaf_mem_inst/loop_ram_patch_gen_7__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_1__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_1__loop_width_gen_1__genblk1_sram_macro 
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/k_best_array_inst/loop_best_array_gen_0__best_dist_array_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
addHaloToBlock 5.00  5.00  5.00  5.00 acc_inst/k_best_array_inst/loop_best_array_gen_0__best_dist_array_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro




deleteFiller -prefix WELLTAP


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_0__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_0__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_1__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_1__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_2__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_2__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_3__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_3__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_4__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_4__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll



selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_5__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_5__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_6__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll

selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_6__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro 
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_7__ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll

selectInst acc_inst/leaf_mem_inst/loop_ram_patch_gen_7__ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll

selectInst acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll

selectInst acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll

selectInst acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_1__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll


selectInst acc_inst/qp_mem_inst/ram_patch_inst/loop_depth_gen_1__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll

selectInst acc_inst/k_best_array_inst/loop_best_array_gen_0__best_dist_array_inst/loop_depth_gen_0__loop_width_gen_0__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll

selectInst acc_inst/k_best_array_inst/loop_best_array_gen_0__best_dist_array_inst/loop_depth_gen_0__loop_width_gen_1__genblk1_sram_macro
set llx [dbGet selected.box_llx]
set lly [dbGet selected.box_lly]
set urx [dbGet selected.box_urx]
set ury [dbGet selected.box_ury]
set box "$llx $lly $urx $ury"

createRouteBlk -box $box -layer {li1}
deselectAll




