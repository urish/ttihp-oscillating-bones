set input_file [lindex $argv $argc-3]
set output_file [lindex $argv $argc-2]
set top_module [lindex $argv $argc-1]
box 0 0 0 0
gds readonly true
gds read $input_file
load $top_module
flatten tt_um_flat
load tt_um_flat
select top cell
cellname delete $top_module
cellname rename tt_um_flat ${top_module}
extract all
ext2sim labels on
ext2sim
extresist tolerance 1
extresist
ext2spice lvs
ext2spice cthresh 10
ext2spice extresist on
ext2spice -o $output_file
quit -noprompt
