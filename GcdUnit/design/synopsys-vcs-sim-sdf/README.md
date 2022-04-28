# Intro
 This is an example SDF gate-level simulationsof sky130.
 It uses a modified pdk, called `cvc-pdk`. At this point, we only have it ran on the GcdUnit example. Due to the size of the design, it does not covers all of the standard cells, please be prepared for bugs if your design invloves SRAM + more stdcells.

# Knobs
The sdf back-annotated the simulation passes the INTERCONNECT, CELL DELAY etc., to the simulator.

1. `max:${testbench_name}.${dut_name}:inputs/design.sdf` in the line 38 of `run.sh` file, the max can be change to min/typ/max which stands for different delay corners

# Known bug type (To be completed)

