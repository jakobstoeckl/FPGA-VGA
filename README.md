# FPGA-VGA
This repo is about implementing a VGA graphics card inside an fpga. 
The fpga used in this design is Lattice ICE40UP5K on a iCEBreaker-bitsy dev board.
# VGA-CHARACTERISTICS
The resolution is hardcoded to 640*480 pixels and 75 Hz frame rate.
# RAM-CHARACTERISTICS
The ram gets written @ the sync pulse. The address of the ram depends on the actual pixel count.
If the horizontal_counter is inside the display area the address of the ram is set to the horizontal_counter.
If the horizontal_counter is outside the display area the address of the ram is set to the addr_counter of the top module.
