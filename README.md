# Split_Water_Segnames

Charmm-gui makes all the TIP3 waters the same segment. If there are more than 9999 molecules, the resids eventually become ****, which throws an error when the simulation is run. This tcl partitions the waters into segments of 3333 molecules, so the resid is always well defined. This script is a based on George's scripts for this process. 

To USE:

/path/to/vmd -dispdev text -e split_waters.tcl -args psf_name.psf pdb_name.pdb
