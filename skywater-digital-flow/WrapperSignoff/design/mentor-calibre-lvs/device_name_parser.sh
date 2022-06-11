echo "Parsing the device name of $1"

sed -i -r 's/X(.*sky130_fd_pr__cap_mim_m3.*)/C\1/g' $1
sed -i -r 's/([wl]=)([1-9]+)0*u/\10.\2/g' $1
sed -i -r 's/([wl]=)(\S+?)e\+06u/\1\2/g' $1
sed -i -r 's/^X([[:digit:]])/M\1/g' $1
sed -i -r 's/sky130_fd_pr__pfet_01v8/pmos/g' $1
sed -i -r 's/sky130_fd_pr__pfet_01v8/pmos/g' $1
sed -i -r 's/R0\sVGND\sLO\ssky130_fd_pr__res_generic_po\sw=0.48\sl=0.45/\.connect LO VGND/g' $1
sed -i -r 's/R1\sHI\sVPWR\ssky130_fd_pr__res_generic_po\sw=0.48\sl=0.45/\.connect HI VPWR/g' $1

sed -i -r 's/\//_/g' $1
