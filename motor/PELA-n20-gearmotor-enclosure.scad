/*
PELA Parametric LEGO-compatible Technic N20 Gearmotor Enclosure

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/
*/


include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Motor Enclosure Size] */

// Length of the motor enclosure [blocks]
_l = 4; // [1:1:20]

// Width of the motor enclosure [blocks]
_w = 2; // [1:1:20]

// Height of the bottom part of the motor enclosure (block count, the top part is always 1/3)
_h_bottom = 1; // [0:0.1:20]

// Height of the top part of the motor enclosure (block count, the top part is always 1/3)
_h_top = 1; // [0:0.1:20]


/* [Motor Options] */
// Diameter of the rounded part of the motor body (if no rounding, set length as appropriate and this to 1/2 the motor width)
_motor_radius = 6.2; // [0:0.1:100]

// Shaft-axis ditance of the rounded part of the motor body (motor_width may reduce this)
_motor_round_length = 15.6; // [0:0.1:100]

// Shaft-axis distance of the square part of the motor body (motor_width may reduce this)
_motor_square_length = 9.6; // [0:0.1:100]

// Width of the motor slot body (may reduce rounding, add space to more easily insert the motor)
_motor_width = 10.2; // [0:0.1:100]

// Vertical position of the motor inside the enclosure
_motor_offset = 3.0; // [0:0.1:20]

// Radius of the motor shaft cutout slot
_motor_shaft_radius = 1.9; // [0:0.1:20]

// Distance the motor shaft extends from the motor body
_motor_shaft_length = 9.4; // [0:0.1:100]

// Radius of motor end cutout slot for electrical connectors
_electric_radius = 1.9; // [0:0.1:20]

// Additional depth to the electrical cutout
_electric_vertical_displacement = -3.0; // [-20:0.1:20]

// Distance the electrical connector cutout extends from the body
_electric_length = 20.0; // [0:0.1:100]


/* [Block Features] */

// Presence of bottom connector sockets
_sockets = true;

// Presence of top connector knobs
_knobs = true;

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well
_knob_vent_radius = 1.8; // [0.0:0.1:3.9]

// Basic unit vertical size of each block
_block_height = 9.6; // [8:technic, 9.6:traditional knobs]

// Add interior fill for first layer
_solid_first_layer = true;

// Add interior fill for upper layers
_solid_upper_layers = true;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
_bottom_stiffener_height = 9.6; // [0:0.1:20]

// Heat ventilation holes in the sides
_side_holes = 1; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Heat ventilation holes in the ends
_end_holes = 1; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors] 

// Heat ventilation holes in the top surface
_top_vents = true;




///////////////////////////////
// DISPLAY
///////////////////////////////

n20_motor_enclosure();


module n20_motor_enclosure() {
    motor_enclosure_bottom();

    translate([0, block_width(_w + 0.5), 0]) {
        motor_enclosure_top();
    }
}


///////////////////////////////////
// MODULES
///////////////////////////////////

module motor_enclosure_bottom() {
    difference() {
        PELA_technic_block(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h_bottom, knobs=_knobs, knob_height=_knob_height, side_sheaths=true, end_sheaths=true, sockets=_sockets, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, top_vents=0, knob_vent_radius=_knob_vent_radius, side_holes=_side_holes, end_holes=_end_holes, corner_bolt_holes=_corner_bolt_holes, block_height=_block_height);
        
        motor_cutouts();
    }
}


module motor_enclosure_top() {
    difference() {
        PELA_technic_block(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h_top, knobs=_knobs, knob_height=_knob_height, sockets=_sockets, side_sheaths=true, end_sheaths=true, side_holes=_side_holes, end_holes=_end_holes, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, top_vents=_top_vents, knob_vent_radius=_knob_vent_radius, corner_bolt_holes=_corner_bolt_holes, block_height=_block_height);

        translate([0, 0, block_height(-_h_top)]) {
            motor_cutouts(ss=false);
        }
    }
}


// Space for the motor and connectors and shafts to be removed from the block
module motor_cutouts(ms=true, ss=true, es=true) {

    translate([(block_width(_l) - _motor_round_length - _motor_square_length)/2, (block_width(_w) - _motor_width)/2, _motor_offset]) {
        if (ms) {
            motor_slot();
        }
        if (es) {
            electric_slot();
        }
        if (ss) {
            shaft_slot();
        }
    }
}


// Shape of the motor body
module motor() {
    intersection() {
        union() {
            translate([0, _motor_radius, _motor_radius]) {
                rotate([0, 90, 0]) {
                    cylinder(r=_motor_radius, h=_motor_round_length);
                }
            }
    
            translate([_motor_round_length, 0, 0]) {
                cube([_motor_square_length, _motor_radius*2, _motor_radius*2]);
            }
        }
        
        translate([0, (2*_motor_radius - _motor_width)/2, 0]) {
            cube([_motor_round_length + _motor_square_length, _motor_width, _motor_radius*2]);
        }
    }    
    
    motor_shaft();
}


// Drive shaft sticking from one end of the motor
module motor_shaft() {
    translate([0, _motor_radius, _motor_radius]) {
        rotate([0, 90, 0]) {
            cylinder(r=_motor_shaft_radius, h=_motor_round_length + _motor_square_length + _motor_shaft_length);
        }
    }
}


// Electrical connections on the end opposite the shaft
module electric_cutout() {
    translate([0, _motor_radius, _motor_radius + _electric_vertical_displacement]) {
        rotate([0, -90, 0]) {
            cylinder(r=_electric_radius, h=_electric_length);    
        }
    }
}


// For inserting the motor from the top
module motor_slot() {
    translate([0, -(2*_motor_radius-_motor_width)/2, 0]) {
        motor();
    }

    translate([0, 0, _motor_radius]) {
        cube([_motor_square_length + _motor_round_length, _motor_width, _motor_radius]);    
    }
}


// For the shaft when the motor slides down into the bottom half of the enclosure
module shaft_slot() {
    hull() {
        translate([0, -(2*_motor_radius - _motor_width)/2, 0]) {
            motor_shaft();
        }

        translate([0, -(2*_motor_radius - _motor_width)/2, block_height(1, block_height=_block_height)]) {
            motor_shaft();
        }
    }    
}


// For the electrical connections when the motor slides down into the bottom half of the enclosure
module electric_slot() {
    hull() {
        translate([0, -(2*_motor_radius - _motor_width)/2, 0]) {
            electric_cutout();
        }

        translate([0, -(2*_motor_radius - _motor_width)/2, block_height(3/4, block_height=_block_height)]) {
            electric_cutout();
        }
    }    
}
