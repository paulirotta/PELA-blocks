/*
PELA Square Servo End Mount - 3D Printed LEGO-compatible holder for a servo motor

Print two- one for each end of the motor

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

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../technic-beam/PELA-technic-beam.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:16]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Beam] */

// Beam length [blocks]
_l = 5; // [1:1:30]

// Beam width [blocks]
_w = 2; // [1:1:30]

// Beam height [blocks]
_h = 1; // [1:1:30]

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_skin = 0.1; // [0:0.02:0.5]


/* [Square Servo] */

// Number of technic connectors on either side of the ears [blocks]
_end_hole_count = 1; // [0:1:30]

// Distance between two technic end caps which have cutouts for the servo mount plate ears [blocks]
_end_piece_spacing = 7; // [2:1:30]

// Servo body length [mm]
_servo_body_length = 40.6; // [0:0.1:200]

// Servo mounting plate length [mm]
_servo_length_including_ears = 53.3; // [0:0.1:200]

// Servo body length [mm]
_servo_body_width = 19.6; // [0:0.1:200]

// Servo body length [mm]
_servo_body_height = 36.6; // [0:0.1:200]

// Servo mounting plate thickness [mm]
_servo_ear_thickness = 2.7; // [0:0.1:20]

// Servo mounting plate middle stiffener ridge height [mm]
_servo_ear_plus_center_ridge_thickness = 4.0; // [0:0.1:20]

// Servo mounting plate middle stiffener ridge height [mm]
_servo_ear_center_ridge_width = 2.0; // [0:0.1:20]

// Servo mounting plate middle stiffener ridge height [mm]
_servo_top_to_ear_top = 4.7; // [0:0.1:20]


///////////////////////////////
// DISPLAY
///////////////////////////////

square_servo_end_mount(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, end_hole_count=_end_hole_count, side_holes=_side_holes, skin=_skin, servo_body_length=_servo_body_length, servo_length_including_ears=_servo_length_including_ears, servo_body_width=_servo_body_width, servo_body_height=_servo_body_height, servo_ear_thickness= _servo_ear_thickness, servo_ear_plus_center_ridge_thickness=_servo_ear_plus_center_ridge_thickness, servo_ear_center_ridge_width=_servo_ear_center_ridge_width, servo_top_to_ear_top=_servo_top_to_ear_top, end_piece_spacing=_end_piece_spacing);


///////////////////////////////////
// MODULES
///////////////////////////////////

module square_servo_end_mount(material, large_nozzle, cut_line=_cut_line, l, w, h, end_hole_count, side_holes, skin, servo_body_length, servo_length_including_ears, servo_body_width, servo_body_height, servo_ear_thickness, servo_ear_plus_center_ridge_thickness, servo_ear_center_ridge_width, servo_top_to_ear_top, end_piece_spacing) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(end_hole_count!=undef);
    assert(side_holes!=undef);
    assert(skin!=undef);
    assert(servo_body_length!=undef);
    assert(servo_length_including_ears!=undef);
    assert(servo_body_width!=undef);
    assert(servo_body_height!=undef);
    assert(servo_ear_thickness!=undef);
    assert(servo_ear_plus_center_ridge_thickness!=undef);
    assert(servo_ear_center_ridge_width!=undef);
    assert(servo_top_to_ear_top!=undef);
    assert(end_piece_spacing!=undef);

    difference() {

        color("white") square_servo_end_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, end_hole_count=end_hole_count, side_holes=side_holes, skin=skin);

        # color("red") square_servo_space(l=l, w=w, servo_body_length=servo_body_length, servo_length_including_ears=servo_length_including_ears, servo_body_width=servo_body_width, servo_body_height=servo_body_height, servo_ear_thickness= servo_ear_thickness, servo_ear_plus_center_ridge_thickness=servo_ear_plus_center_ridge_thickness, servo_ear_center_ridge_width=servo_ear_center_ridge_width, servo_top_to_ear_top=servo_top_to_ear_top, end_piece_spacing=end_piece_spacing);
    }

    % translate([0, 0, block_width(end_piece_spacing-h)])
        square_servo_end_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, end_hole_count=end_hole_count, side_holes=side_holes, skin=skin);
}


module square_servo_end_beam(material, large_nozzle, cut_line=_cut_line, l, w, h, end_hole_count, side_holes, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(end_hole_count!=undef);
    assert(side_holes!=undef);
    assert(skin!=undef);

    technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, side_holes=side_holes, skin=skin);
    
    translate([block_width(end_hole_count-0.5), block_width(-0.5), skin])
        skinned_block(material=material, large_nozzle=large_nozzle, l=l-2*end_hole_count, w=w, h=h, ridge_width=0, ridge_depth=0, block_height=block_width()-2*skin, skin=skin);
}


module square_servo_space(l, w, servo_body_length, servo_length_including_ears, servo_body_width, servo_body_height, servo_ear_thickness, servo_ear_plus_center_ridge_thickness, servo_ear_center_ridge_width, servo_top_to_ear_top, end_piece_spacing) {

    assert(l!=undef);
    assert(w!=undef);
    assert(servo_body_length!=undef);
    assert(servo_length_including_ears!=undef);
    assert(servo_body_width!=undef);
    assert(servo_body_height!=undef);
    assert(servo_ear_thickness!=undef);
    assert(servo_ear_plus_center_ridge_thickness!=undef);
    assert(servo_top_to_ear_top!=undef);
    assert(end_piece_spacing!=undef);

    tx = (block_width(l-1) - servo_body_width)/2 + block_width(l/2);
    ty = -servo_top_to_ear_top + block_width(w/2-0.5) - servo_ear_thickness/2;
    tz = (block_width(end_piece_spacing) + servo_length_including_ears)/2;

    translate([tx, ty, tz]) {
        rotate([-90, 90, 0]) {
            translate([(servo_length_including_ears-servo_body_length)/2, 0, 0])
                cube([servo_body_length, servo_body_width, servo_body_height]);

            translate([0, 0, servo_top_to_ear_top]) 
                cube([servo_length_including_ears, servo_body_width, servo_ear_thickness]);
        }
    }
    
    translate([(tx-servo_body_width/2-servo_ear_center_ridge_width/2), -servo_ear_plus_center_ridge_thickness, 0])
        cube([servo_ear_center_ridge_width, servo_ear_plus_center_ridge_thickness, servo_length_including_ears]);
}