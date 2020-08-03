/*
PELA Parametric LEGO-compatible Technic Round Motor Enclosure

To add a simple beer-can heatsink, cut the beer can side with two flaps. The
left and right flaps should be motor_d apart and about 3*motor_d in length
to wrap around the motor). Each flap is about half the length of the motor.

Stick the front flap down the left side and right flap down the right side
such that pressure between the motor and the enclosure holds the beer can in
place to carry away motor heat and prevent overheating of the plastic enclosure.


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
use <../PELA-strap-mount.scad>
use <../technic-beam/PELA-technic-beam.scad>




/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

_render = 0; // [0:Mount, 1:Wall Holder]


/* [Strap Mount] */

// Model length [blocks]
_l = 5; // [1:1:20]

// Model width [blocks]
_w = 6; // [1:1:20]

// Model height [blocks]
_h = 3; // [1:1:20]

// Fraction of a normal panel height for the center section where a stap holds the block in place
_panel_height_ratio = 1.0; // [0.1:0.1:2.0]

// Add short end holes spaced along the width for techic connectors
_end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
_end_sheaths = false;

// Add full width through holes spaced along the length for techic connectors
_side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
_side_sheaths = true;


// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;



/* [Motor Options] */
// Diameter of the hole for the rounded part of the motor body (if no rounding, set length as appropriate and this to 1/2 the motor width) [mm]
_motor_d = 24; // [0.0:0.1:200]

// Motor body cutout space length [mm]
_motor_length = 30.3; // [0.0:0.1:200]

// Width of the motor shaft cutout [mm]
_motor_shaft_enclosure_cutout_d = 10.2; // [0.0:0.1:200]

// Motor offset on the Y axis [mm]
_motor_y = 36.9; // [0.1:0.1:200]

// Motor offset on the Y axis [mm]
_motor_z = 12; // [0.1:0.1:200]

// Motor mount wall thickness [mm]
_motor_wall_thickness = 4; // [0.0:0.1:200]

// Motor mount hole spacing
_motor_mount_hole_spacing = 16; // [0.0:0.1:200]

// Diameter of the motor mount holes
_motor_mount_hole_d = 3; // [0.0:0.1:20]

_bolt_hole_angle = 20;  // [0:1:360]

/* [Hidden] */
// Select if the top connections should be traditional knobs or technic holes
_style = 1; // [0:Knobs, 1:Technic]

// Presence of top connector knobs
_knobs = true;

// Presence of bottom connector sockets
_sockets = false;

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional knobs]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well
_knob_vent_radius = 0; // [0.0:0.1:3.9]


///////////////////////////////
// DISPLAY
///////////////////////////////

if (_render == 0) {
    motor_mount();
} else {
    motor_v_holder();
}

module motor_mount() {
    
    difference() {
        union() {
            strap_mount(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, style=_style, l=_l, w=_w, h=_h, panel_height_ratio=_panel_height_ratio, side_holes=_side_holes, end_holes=_end_holes, sockets=_sockets, knobs=_knobs, corner_bolt_holes=_corner_bolt_holes, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, top_vents=_top_vents, block_height=_block_height, side_sheaths=_side_sheaths, end_sheaths=_end_sheaths);

            color("green") motor_back_holder();

            color("yellow") motor_wall();
        }

        union() {
            color("pink") translate([0, block_width(_w-2.5), block_height(1-_h, _block_height)])
                cube([block_width(_l), block_width(_w), block_height(_h, _block_height)]);

            color("white") motor_body_insert_space();

            color("red") translate([0, -block_width(5), 0]) motor_mount_wall_bolt_holes(angle=_bolt_hole_angle);

            color("orange") motor_wall_v_cut(thickness=_motor_wall_thickness);

            color("red") motor_mount_wall_bolt_holes(angle=_bolt_hole_angle);
            
            translate([block_width((_w-1)/2), block_width(2), block_width(-1)])
                cylinder(d=_motor_d-block_width(1), h=_motor_length);

        }
    }
}


module motor_body_insert_space() {
    translate([block_width(_l/2), _motor_y, _motor_z])
        rotate([90, 0, 0])
            hull() {
                cylinder(d=_motor_d, h=_motor_length, $fn=128);

                translate([0, block_height(_h, _block_height), 0])
                    cylinder(d=_motor_d, h=_motor_length, $fn=128);                    
            }
}


module motor_mount_wall_bolt_holes(angle) {
    
    assert(angle!=undef);
    
    translate([block_width(_l/2), _motor_y-_defeather, panel_height()*_panel_height_ratio + _motor_d/2]) {
            rotate([-90, angle, 0]) {
                translate([_motor_mount_hole_spacing/2, 0, 0])
                    cylinder(d=_motor_mount_hole_d, h=_motor_length);

                translate([-_motor_mount_hole_spacing/2, 0, 0])
                        cylinder(d=_motor_mount_hole_d, h=_motor_length);
                }

            rotate([-90, 60+angle, 0]) {
                translate([_motor_mount_hole_spacing/2, 0, 0])
                    cylinder(d=_motor_mount_hole_d, h=_motor_length);

                translate([-_motor_mount_hole_spacing/2, 0, 0])
                        cylinder(d=_motor_mount_hole_d, h=_motor_length);
                }

            rotate([-90, 120+angle, 0]) {
                translate([_motor_mount_hole_spacing/2, 0, 0])
                    cylinder(d=_motor_mount_hole_d, h=_motor_length);

                translate([-_motor_mount_hole_spacing/2, 0, 0])
                        cylinder(d=_motor_mount_hole_d, h=_motor_length);
                }
            }
}


module motor_back_holder() {
    
    difference() {
        translate([block_width(), 0, 0])
            cube([block_width(_l-2), block_width(5), block_width(_h)]);
        
        translate([0, -block_width(5), 0])
            motor_wall_v_cut(thickness=block_width(_l-2));
    }
}


module motor_wall() {
    
    translate([block_width(), _motor_y, 0])
        cube([block_width(_l-2), _motor_wall_thickness, block_height(_h, _block_height)]);        
}


module motor_wall_v_cut(thickness) {
    
    assert(thickness!=undef);
    
    hull() {
        motor_shaft_cut(thickness);

        translate([block_width(_l/2 + 0.5)-_motor_d/2, _motor_y, panel_height()*_panel_height_ratio + _motor_d/2 + block_width()])
            cube([_motor_d - block_width(1), thickness, _defeather]);
    }
}


module motor_shaft_cut(thickness) {
    
    assert(thickness!=undef);

    translate([block_width(_l/2), _motor_y, panel_height()*_panel_height_ratio + _motor_d/2])
        rotate([-90, 0, 0])
            cylinder(d=_motor_shaft_enclosure_cutout_d, h=thickness);
}


module motor_v_holder() {
    
    difference() {
        union() {
            motor_wall_v_cut(thickness=_motor_wall_thickness);

            translate([block_width(0.5), block_width(_w-2), block_width(_h)])
                motor_v_holder_end();

            translate([block_width(_l-0.5), block_width(_w-2), block_width(_h)])
                motor_v_holder_end();
    
            translate([block_width(_l/2), _motor_y, panel_height()*_panel_height_ratio + _motor_d/2])
                hull() {

                    translate([-_motor_d/2, 0, _motor_d/2 - 5.5])
                        cube([_motor_d, _motor_wall_thickness, block_width()]);                    
                }
            }
            
            union () {
                color("blue") motor_shaft_cut();
                color("red") motor_mount_wall_bolt_holes();
            }
        }
}


module motor_v_holder_end() {
    
    technic_beam(material=_material, large_nozzle=_large_nozzle, cut_line=0, l=1, w=2, h=1, side_holes=_side_holes, horizontal_skin=0, vertical_skin=0);
}