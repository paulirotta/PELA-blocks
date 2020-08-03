/*
PELA Technic Seeed Respeaker Core v2 Mount - 3D Printed LEGO-compatible PCB mount

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    https://www.futurice.com

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../peg/PELA-technic-peg.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
use <../PELA-knob-panel.scad>



/* [Models] */

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Show the case walls
_wall_model = true;

// Show where the board is mounted;
_board_model = true;

// Show the top (printed upside down)
_top_model = 1; // [0:disabled, 1:single material, 2:opaque material (1/2), 3:translucent material (2/2)]

// Show the center base piece
_interior_model = true;



/* [Respeaker Core v2 Technic Mount] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Hexagonal board width [mm]
_width = 88; // [1:0.1:200]

// Board thickness
_thickness = 1.8; // [0.0:0.1:10.0]

// Length of hexagonal model sides [blocks]
_side_length = 8; // [1:1:20]

// Mounting hole centers
_side = (width/2) / sin(60);

_top = side + side*sin(30);

// Diameter of the columns which hold the board in place at mount points [mm]
_mount_d = 5.5; // [0.0:0.1:15]

_mount_h = block_width(3) - 2;

// Include a small centering pin to go into board mount holes
_board_mount_pin = false;

// Diameter for board mount centering pin [mm]
_mount_peg_d = 2.4; // [0.0:0.1:3]

_top_height = 4;

// Top spokes to connect center and sides in single material prints
_spoke_width = 6; // [0.0:0.5:20]

// Origin for the board model and board mounting holes
_outer_width = 2*block_width(side_length + 0.25)*sin(30);

_board_spacing = (side + sin(30)*side - outer_width)/2;

_ox = _board_spacing*cos(30);

_oy = _board_spacing*sin(30);

_center_y = block_width(_side_length)/2 - block_width(0.5);

_center_x = block_width(_side_length - 0.5)*cos(30) - block_width(0.5)*cos(30);

// Orange
_x1 = width - 46 - 29.1;

_y1 = top - 20.8;

// Yellow
_x2 = _x1;

_y2 = top - 20.8 - 5.5 - 47.9 - 5.1;

// Pink
_x3 = _width - 29.1;

_y3 = _top - 20.8 - 5.5;

// Grey
_x4 = _width - 29.1;

_y4 = _y3 - 47.9;

// Base
_base_thickness = 1.0; // [0:0.1:8]



///////////////////////////////
// DISPLAY
///////////////////////////////

if (_wall_model && _top_model < 2) {
    rotate([180, 0, 0]) {
        respeaker_core_v2_technic_mount();
    }
}

if (_top_model > 0) {
    translate([block_width(10), block_width(3), block_width(-2)]) {

        two_color_print = top_model >= 2;
        top_ring = top_model == 3;

        if (top_ring) {
            color("white") clear_ring(material=_material, large_nozzle=_large_nozzle, two_color_print=_two_color_print);
        } else {
            respeaker_core_v2_technic_top(material=_material, large_nozzle=_large_nozzle, two_color_print=_two_color_print);
        }
    }
}

if (_interior_model && _top_model < 2) {
    rotate([180, 0, 0]) {
        
        respeaker_core_interior(material=_material, large_nozzle=_large_nozzle);
    }
}



///////////////////////////////////
// MODULES
///////////////////////////////////

module respeaker_core_v2_technic_top(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, two_color_print=undef) {
    
    difference() {
        union() {
            respeaker_core_v2_technic_top_edge(material=_material, large_nozzle=_large_nozzle);
            
            respeaker_core_v2_technic_top_center(material=_material, large_nozzle=_large_nozzle);
        }
        
        union() {
            clear_ring(material=_material, large_nozzle=_large_nozzle, two_color_print=_two_color_print);
            
            switch_access(material=_material, large_nozzle=_large_nozzle);
        }        
    }

    if (!_two_color_print) {
        board_mounts_top(material=_material, large_nozzle=_large_nozzle);
    }
}


module respeaker_core_interior(material=_material, large_nozzle=_large_nozzle) {
    
    m = 1.035;
    translate([2.7, 2.2, block_width(3) - _base_thickness]) {
        respeaker_board(material=_material, large_nozzle=_large_nozzle, width=_width*m, side=_side*m, thickness=_base_thickness);
    }

    translate([_ox, _oy]) {
            board_mounts(material=_material, large_nozzle=_large_nozzle);
    }
}


module board_mounts_top(material=material, large_nozzle=large_nozzle) {
    
    translate([ox, oy, -thickness - 0.1]) { 
        board_mounts(material=material, large_nozzle=large_nozzle, h=6, rot=180, pin=false);
    }
}


module clear_ring(material=material, large_nozzle=large_nozzle, top_height=top_height, two_color_print=undef) {
    r1 = side*0.87;
    r2 = r1 - 8;

    assert(two_color_print != undef);

    translate([center_x, center_y, -8]) {
        difference() {
            z = _defeather;
            translate([0, 0, -z]) {
                cylinder(r=r1, h=top_height+2*z, $fn=256);
            }

            union() {
                translate([0, 0, -2*z]) {
                    cylinder(r=r2, h=top_height+4*z, $fn=256);
                }

                if (!two_color_print) {
                    center_spokes(material=material, large_nozzle=large_nozzle);
                }
            }
        }
    }

    if (two_color_print) {
        board_mounts_top(material=material, large_nozzle=large_nozzle);
    }
}


module center_spokes(material=material, large_nozzle=large_nozzle) {
    for (i=[0:30:180]) {
        rotate([0, 0, 15+i]) {
            translate([-side, -spoke_width/2, 0]) {
                cube([width*1.1, spoke_width, top_height]);
            }
        }
    }
}


module switch_access(material=material, large_nozzle=large_nozzle) {
    translate([center_x - side + 29.85, center_y, -10]) {
        cylinder(r=4, h=15);
    }
}


module respeaker_board(material=material, large_nozzle=large_nozzle, width=width, side=side, thickness=thickness) {
    
    cube([width, side, thickness]);

    rotate([0, 0, -30]) {
        cube([side, width, thickness]);
    }
    
    translate([width, 0, 0]) {
        rotate([0, 0, 120]) {
            cube([width, side, thickness]);            
        }
    }
}


module respeaker_core_v2_technic_mount(material=material, large_nozzle=large_nozzle) {
    
    translate([ox, oy]) {
        if (board_model) {
            translate([0, 0, block_height(3) - mount_h - thickness]) {
                % respeaker_board(material=material, large_nozzle=large_nozzle);    
            }
        }
    }

    rotate([0, 0, -30]) {
        // Side 1
        color("red") {
            technic_beam(material=material, large_nozzle=large_nozzle, l=side_length, w=1, h=2);
            
            translate([0, 0, block_height(2, block_height=block_height)]) {
                technic_twist_beam(material=material, large_nozzle=large_nozzle, w_left=1, w_center=1, w_right=1, l_left=2, l_right=2, l_center=side_length-4, h_left=1, h_center=1, h_right=1);
                }
        }
        
        translate([block_width(side_length - 1), 0, 0]) {
            rotate([0, 0, 60]) {
                // Side 2
                color("green") {
                    technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=3);
                    translate([block_width(7), 0, 0]) {
                        technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=1);
                    }

                    translate([0, 0, block_height(1)]) {
                        technic_beam(material=material, large_nozzle=large_nozzle, l=side_length, w=1, h=1);

                    translate([0, 0, block_height(1)]) {
                        technic_twist_beam(material=material, large_nozzle=large_nozzle, w=1, left=2, right=2, center=side_length-4);
                    }
                    }
                }
                
                translate([block_width(side_length - 1), 0, 0]) {
                    rotate([0, 0, 60]) {
                        // Side 3
                        color("blue") {
                            translate([0, 0, block_height(2)]) {
                                technic_twist_beam(material=material, large_nozzle=large_nozzle, w=1, left=2, center=side_length-4, right=2, h_left=1, h_center=1, h_right=1);
                            }
                        }
                        
                        translate([block_width(side_length - 1), 0, 0]) {
                            rotate([0, 0, 60]) {
                                // Side 4
                                color("yellow") {
                                    technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=4);
                                    translate([0, 0, block_height()]) {
                                        technic_beam(material=material, large_nozzle=large_nozzle, l=side_length, w=1, h=1);

                                    translate([0, 0, block_height()]) {
                                        technic_twist_beam(material=material, large_nozzle=large_nozzle, w=1, center=side_length-4, left=2, right=2, h_left=1, h_center=1, h_right=1);
                                    }
                                    }
                                }
                                
                                translate([block_width(side_length - 1), 0, 0]) {
                                    rotate([0, 0, 60]) {
                                        // Side 5
                                        color("white") {
                                            technic_beam(material=material, large_nozzle=large_nozzle, l=side_length, w=1, h=2);
                                            
                                            translate([0, 0, block_height(2)]) {
                                                technic_twist_beam(material=material, large_nozzle=large_nozzle, w=1, center=side_length-4, left=2, right=2, h_left=1, h_center=1, h_right=1);
                                            }
                                        }
                                        
                                        translate([block_width(side_length - 1), 0, 0]) {
                                            rotate([0, 0, 60]) {
                                                // Side 6
                                                translate([0, 0, block_height()])
                                                color("orange") {
                                                    technic_beam(material=material, large_nozzle=large_nozzle, l=side_length, w=1, h=1);
                                                    
                                                    translate([0, 0, block_height()]) {
                                                        technic_twist_beam(material=material, large_nozzle=large_nozzle, w=1, center=side_length-4, left=2, right=2, h_left=1, h_center=1, h_right=1);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


module board_mounts(material=material, large_nozzle=large_nozzle, rot=0, h=mount_h, pin=true) {
        color("orange") knob_holder(material=material, large_nozzle=large_nozzle, x=x1, y=y1, h=h, rot=rot, pin=pin);
        color("yellow") knob_holder(material=material, large_nozzle=large_nozzle, x=x2, y=y2, h=h, rot=rot, pin=pin);
        color("pink") knob_holder(material=material, large_nozzle=large_nozzle, x=x3, y=y3, h=h, rot=rot, pin=pin);
        color("grey") knob_holder(material=material, large_nozzle=large_nozzle, x=x4, y=y4, h=h, rot=rot, pin=pin);
}


module knob_holder(material=material, large_nozzle=large_nozzle, x, y, h, rot, pin) {
    
    d_multiplier = 1.5;
    d2 = d_multiplier*mount_d;
    h2 = min(h, d2);

    translate([x, y, block_height(3) - mount_h]) {
        rotate([rot, 0, 0]) {
            cylinder(d1=mount_d, d2=d2, h=h2);
            
            translate([0, 0, h2]) {
                cylinder(d=d2, h=h-h2);
            }
            
            if (pin && board_mount_pin) {
                rotate([180, 0, 0]){
                    cylinder(d=mount_peg_d, h=thickness - 0.1);
                }
            }
        }
    }
}


module respeaker_core_v2_technic_top_edge(material=material, large_nozzle=large_nozzle, side_holes=2) {

    translate([0, 0, block_height(-1)]) rotate([0, 0, -30]) {
        // Side 1
        color("red") {
            translate([block_width(2), 0, 0]) {
                technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=4, side_holes=side_holes);
            }
        }
        
        translate([block_width(side_length - 1), 0, 0]) {
            rotate([0, 0, 60]) {
                // Side 2
                color("green") {
                    translate([block_width(2), 0, 0]) {
                        technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=1, side_holes=side_holes);
                    }
                }
                
                translate([block_width(side_length - 1), 0, 0]) {
                    rotate([0, 0, 60]) {
                        // Side 3
                        
                        translate([block_width(side_length - 1), 0, 0]) {
                            rotate([0, 0, 60]) {
                                // Side 4
                                color("yellow") {
                                    translate([block_width(2), 0, 0]) {
                                        technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=2, side_holes=side_holes);
                                    }
                                }
                                
                                translate([block_width(side_length - 1), 0, 0]) {
                                    rotate([0, 0, 60]) {
                                        // Side 5
                                        color("white") {
                                            translate([block_width(2), 0, 0]) {
                                                technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=4, side_holes=side_holes);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


module respeaker_core_v2_technic_top_center(material=material, large_nozzle=large_nozzle) {
    
    top_thickness = 0.5;
    difference() {
        union() {
            translate([0, 0, block_height(-1)]) rotate([0, 0, -30]) hull() {
                // Side 1
                color("red") {
                    technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=8, h=top_thickness);
                }
                
                translate([block_width(side_length - 1), 0, 0]) {
                    rotate([0, 0, 60]) {
                        // Side 2
                        color("green") {
                            technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=8, h=top_thickness);
                        }
                        
                        translate([block_width(side_length - 1), 0, 0]) {
                            rotate([0, 0, 60]) {
                                // Side 3
                                color("blue") {
                                    technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=8, h=top_thickness);
                                }
                                
                                translate([block_width(side_length - 1), 0, 0]) {
                                    rotate([0, 0, 60]) {
                                        // Side 4
                                        color("yellow") {
                                            technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=8, h=top_thickness);
                                        }
                                        
                                        translate([block_width(side_length - 1), 0, 0]) {
                                            rotate([0, 0, 60]) {
                                                // Side 5
                                                color("white") {
                                                    technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=8, h=top_thickness);
                                                }
                                                
                                                translate([block_width(side_length - 1), 0, 0]) {
                                                    rotate([0, 0, 60]) {
                                                        // Side 6
                                                        color("orange") {
                                                            technic_beam(material=material, large_nozzle=large_nozzle, w=1, l=8, h=top_thickness);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        translate([0, 0, -1]) {
            respeaker_core_v2_technic_top_edge(material=material, large_nozzle=large_nozzle, side_holes=0);
        }
    }
}

