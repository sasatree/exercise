
# test.tcl
set sim_file [lindex $argv 1]
puts "Test Scenario= $sim_file" 

# RTL directory
set RTL_DIR "../rtl"
set INC_DIR "../include"

# Top module
set TOP_MODULE "top"

# compile
set ret [exec xvlog\
    -sv\
    -i $INC_DIR\
    --sourcelibdir $RTL_DIR\
    --sourcelibext .v\
    $sim_file ]
puts $ret

# elaboration
set ret [exec xelab \
  --debug all \
  --notimingchecks \
  $TOP_MODULE ]
puts $ret

# simulation
set ret [exec xsim $TOP_MODULE\
	 --runall]
puts $ret
