set psf [lindex $argv 0]
set pdb [lindex $argv 1]

echo "PSF is $psf"
echo "PDB is $pdb"

mol load psf $psf
animate read pdb $pdb beg 0 end -1 skip 1 waitfor all

set mol [mol new $psf type psf waitfor all]
mol addfile $pdb type pdb waitfor all molid $mol

set prot [atomselect top "water and name OH2"]
set index_list [$prot get index]
set index_list [lsort -unique -integer $index_list]

foreach atom $index_list {
    set temp_sel [atomselect top "water and index $atom"]
    set rez [$temp_sel get resid]
    echo $rez
    set sel [atomselect top "same residue as water and index $atom"]
    set rezid [expr $rez%3333]
    if {$rezid == 0 } {
        $sel set resid 3333
    } else {
        $sel set resid $rezid
    }
    set temp [expr ($rez-1)/3333]
    $sel set segid WT${temp}

    $sel delete
    $temp_sel delete
}

set sel [atomselect top all]

animate write pdb water_split.pdb sel $sel $mol
animate write psf water_split.psf sel $sel $mol

exit
