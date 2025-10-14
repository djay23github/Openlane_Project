# This module, we will learn about basics of STA and Delay of Cells
# Timing Arcs, Develop constraints/SDC format.
# Analyze a .lib file where you find a LUT of delay model, unateness, power and area of different cells
# Common TCL scripts to be performed on lib files


#  Delay Model LUT --> function of (input transition , output capacitance)

# Command used in DC_SHELL for lib files

list_lib

foreach_in_collection <loop variable: my_lib_cell> [get_lib_cells */*and] {
    set lib_cell_name [get_object_name $my_lib_cell];
    echo $lib_cell_name;
}

get_lib_pins <path/to/library/cell/frompreviouscommand/*>
foreach_in_collection <variable: my_pins> [get_lib_pins <path/libcellname/*>] {
set my_pin_name [get_object_name $my_pins]
set pin_direction [get_lib_attribute $my_pin_name <attribute_name: direction>];
echo $my_pin_name $pin_direction
}

get_lib_attribute my_pin_name function
get_lib_attribute lib_cell_name area
get_lib_attribute lib_pin capacitance
get_lib_attribute lib_pin clock

set my_list [list <path/to/lib/cellname>]
foreach my_cell $my_list {
    foreach_in_collection my_lib_pin [get_lib_pins $(my_cell)/*] {
        set my_lib_pin_name [get_object_name $my_lib_pin];
        set a [get_lib_attribute $my_lib_pin_name direction];
        if { $a > 1}{
            set function_name [get_lib_attribute $my_lib_pin function];
            echo $my_lib_pin_name $a $function_name
        } 

    }
}

get_lib_cells */* -filter "is_sequential == true"

get_lib_cells */* -filter "is_sequential == true"

