
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
    -L uvm\
    -sv\
    -i $INC_DIR\
    --sourcelibdir $RTL_DIR\
    --sourcelibext .v\
    $sim_file ]
puts $ret

# elaboration
set ret [exec xelab \
    -L uvm\
  --debug all \
  --notimingchecks \
  $TOP_MODULE ]
puts $ret

# simulation
set ret [exec xsim $TOP_MODULE\
  --testplusarg TESTCASE=1\
	--runall]
puts $ret

set ret [exec xsim $TOP_MODULE\
  --testplusarg TESTCASE=2\
	--runall]
puts $ret

