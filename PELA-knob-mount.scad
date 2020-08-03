/*
PELA Board Holder - 3D Printed LEGO-compatible PCB mount

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

include <material.scad>
include <style.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>
use <PELA-box-enclosure.scad>

////////////////////
// Parameters
////////////////////


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;



/* [Board] */

// PCB length [mm]
_length = 30; // [0.1:0.1:300]

// PCB width [mm]
_width = 20; // [0.1:0.1:300]

// PCB thickness [mm]
_thickness = 1.8; // [0.1:0.1:300]



/* [Enclosure] */

// A number from 1 to 2. This is a ratio of 1 block width for the board surround. Smaller numbers mean less space horizontally around the board (it can eat into the surrounding wall knobs). Larger numbers may bump you up by 1 knob, resulting in a wider or longer enclosure.
_l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Board surround ratio
_w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Enclosure height
_h = 1; // [1:1:20]

// Create the left wall
_left_wall_enabled = true;

// Shoud there be knobs on top of the left wall
_left_wall_knobs = true;

// Create the right wall
_right_wall_enabled = true;

// Shoud there be knobs on top of the right wall
_right_wall_knobs = true;

// Create the front wall
_front_wall_enabled = true;

// Shoud there be knobs on top of the front wall
_front_wall_knobs = true;

// Create the back wall
_back_wall_enabled = true;

// Shoud there be knobs on top of the back wall
_back_wall_knobs = true;



/* [Enclosure Features] */

// Filler for the model center space
_center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Presence of bottom connector sockets
_sockets = true;

// How far below the bottom of the board to carve empty space 
_undercut = 7; // [0:0.1:20]

// How far in from the outside edges the board support can extend without hitting board bottom surface parts
_innercut = 0.8; // [0:0.1:100]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Add full width through holes spaced along the length for techic connectors
_side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add full width through holes spaced along the width for techic connectors
_end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
_side_sheaths = true;

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
_end_sheaths = true;

// Additional space added in every direction around the printed circuit board
_pcb_skin = 0.1; // [0:0.01:1]

// Add interior fill for the base layer
_solid_first_layer = false;

// Add interior fill for the upper layers
_solid_upper_layers = true;

// Shift the PCB board relative to the enclosure on the X axis [mm]
_board_x_offset = 0; // [-8:0.1:8]

// Shift the PCB board relative to the enclosure on the X axis [mm]
_board_y_offset = 0; // [-8:0.1:8]


/* [Bottom Features] */


// Bottom of enclosure
_bottom_type = 1; // [1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type == 3, knob panel)
_bottom_vents = true;

// Add knobs to the bottom surface  (only used with bottom_type == 3, knob panel)
_bottom_knobs = true;



/* [Enclosure Left Cut] */

// Distance of the front of left side hole [mm]
_left_enclosure_cutout_y = 4; // [0:0.1:200]

// Width of the left side hole [mm]
_left_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the left side hole [mm]
_left_enclosure_cutout_height = 8; // [0:0.1:200]



/* [Enclosure Right Cut] */

// Distance of the front of right side hole [mm]
_right_enclosure_cutout_y = 4; // [0:0.1:200]

// Width of the right side hole [mm]
_right_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the right side hole [mm]
_right_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
_right_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the right side hole [mm]
_right_enclosure_cutout_height = 8; // [0:0.1:200]



/* [Enclosure Front Cut] */

// Distance of the left of front side hole [mm]
_front_enclosure_cutout_x = 4; // [0:0.1:200]

// Width of the front side hole [mm]
_front_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the front side hole [mm]
_front_enclosure_cutout_height = 8; // [0:0.1:200]



/* [Enclosure Back Cut] */

// Distance of the left of back side hole [mm]
_back_enclosure_cutout_x = 4; // [0:0.1:200]

// Width of the back side hole [mm]
_back_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
_back_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
_back_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the back side hole [mm]
_back_enclosure_cutout_height = 8; // [0:0.1:200]



/* [Advanced] */

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = true;

// Number of knobs at the edge of a bottom panel to omit (this will leave space for example for a nearby top wall or technic connectors)
_skip_edge_knobs = 1;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well
_knob_vent_radius = 0; // [0.0:0.1:3.9]

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// There is usually no need or room for corner mounting M3 bolt holes
_corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
_bolt_hole_radius = 1.6; // [0.0:0.1:3.0]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_skin = 0.1; // [0:0.02:0.5]



///////////////////////////////
// DISPLAY
///////////////////////////////

knob_mount(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, h=_h, thickness=_thickness, innercut=_innercut, undercut=_undercut, center_type=_center_type, bottom_type=_bottom_type, sockets=_sockets, bottom_vents=_bottom_vents, bottom_knobs=_bottom_knobs, top_vents=_top_vents, side_holes=_side_holes, end_holes=_end_holes, side_sheaths=_side_sheaths, end_sheaths=_end_sheaths, left_wall_enabled=_left_wall_enabled, right_wall_enabled=_right_wall_enabled, front_wall_enabled=_front_wall_enabled, back_wall_enabled=_back_wall_enabled, board_x_offset=_board_x_offset, board_y_offset=_board_y_offset, left_wall_knobs=_left_wall_knobs, right_wall_knobs=_right_wall_knobs, front_wall_knobs=_front_wall_knobs, back_wall_knobs=_back_wall_knobs, dome=_dome, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, l_pad=_l_pad, w_pad=_w_pad, block_height=_block_height, skin=_skin, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, skip_edge_knobs=_skip_edge_knobs, knob_vent_radius=_knob_vent_radius, knob_height=_knob_height, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius);



///////////////////////////////////
// MODULES
///////////////////////////////////

module knob_mount(material, large_nozzle, cut_line, length, width, h, thickness, innercut, undercut, center_type, bottom_type, sockets, bottom_vents, bottom_knobs, top_vents, side_holes, end_holes, side_sheaths, end_sheaths, left_wall_enabled, right_wall_enabled, front_wall_enabled, back_wall_enabled, board_x_offset, board_y_offset, left_wall_knobs, right_wall_knobs, front_wall_knobs, back_wall_knobs, dome, solid_first_layer, solid_upper_layers, l_pad, w_pad, block_height, skin, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height, skip_edge_knobs, knob_vent_radius, knob_height, corner_bolt_holes, bolt_hole_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(h!=undef);
    assert(thickness!=undef);
    assert(innercut!=undef);
    assert(undercut!=undef);
    assert(center_type!=undef);
    assert(bottom_type!=undef);
    assert(bottom_type!=0);
    assert(sockets!=undef);
    assert(bottom_vents!=undef);
    assert(bottom_knobs!=undef);
    assert(top_vents!=undef);
    assert(side_holes!=undef);
    assert(end_holes!=undef);
    assert(side_sheaths!=undef);
    assert(end_sheaths!=undef);
    assert(left_wall_enabled!=undef);
    assert(right_wall_enabled!=undef);
    assert(front_wall_enabled!=undef);
    assert(back_wall_enabled!=undef);
    assert(board_x_offset!=undef);
    assert(board_y_offset!=undef);
    assert(left_wall_knobs!=undef);
    assert(right_wall_knobs!=undef);
    assert(front_wall_knobs!=undef);
    assert(back_wall_knobs!=undef);
    assert(dome!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(l_pad!=undef);
    assert(w_pad!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);
    assert(left_enclosure_cutout_y!=undef);
    assert(left_enclosure_cutout_width!=undef);
    assert(left_enclosure_cutout_depth!=undef);
    assert(left_enclosure_cutout_z!=undef);
    assert(left_enclosure_cutout_height!=undef);
    assert(right_enclosure_cutout_y!=undef);
    assert(right_enclosure_cutout_width!=undef);
    assert(right_enclosure_cutout_depth!=undef);
    assert(right_enclosure_cutout_z!=undef);
    assert(right_enclosure_cutout_height!=undef);
    assert(front_enclosure_cutout_x!=undef);
    assert(front_enclosure_cutout_width!=undef);
    assert(front_enclosure_cutout_depth!=undef);
    assert(front_enclosure_cutout_z!=undef);
    assert(front_enclosure_cutout_height!=undef);
    assert(back_enclosure_cutout_x!=undef);
    assert(back_enclosure_cutout_width!=undef);
    assert(back_enclosure_cutout_depth!=undef);
    assert(back_enclosure_cutout_z!=undef);
    assert(back_enclosure_cutout_height!=undef);
    assert(skip_edge_knobs!=undef);
    assert(knob_vent_radius!=undef);
    assert(knob_height!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);

    difference() {
        box_enclosure(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, bottom_type=bottom_type, sockets=sockets, bottom_vents=bottom_vents, bottom_knobs=bottom_knobs, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, skip_edge_knobs=skip_edge_knobs, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius, knob_height=knob_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height);

        z = block_height(h, block_height) - thickness;

        pcb_space_skinned(material=material, large_nozzle=large_nozzle, z=z, pcb_skin=skin, length=length, width=width, thickness=thickness, l=l, w=w, h=h, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, dome=dome, block_height=block_height);
    }
}


// Cutout for the board
module pcb_space(material, large_nozzle, z, length, width, l, w, h, thickness, undercut, innercut, board_x_offset, board_y_offset, dome, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(z!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(thickness!=undef);
    assert(undercut!=undef);
    assert(innercut!=undef);
    assert(board_x_offset!=undef);
    assert(board_y_offset!=undef);
    assert(dome!=undef);
    assert(block_height!=undef);

    x_inset = (block_width(l) - length)/2;
    y_inset = (block_width(w) - width)/2;

    translate([x_inset + board_x_offset, y_inset + board_y_offset, z]) {
        dome(dome=dome, length=length, width=width, thickness=thickness);
    }

    // Undercut space for board bottom
    xu_inset = x_inset + innercut;
    yu_inset = y_inset + innercut;

    if (undercut > 0) {
        translate([xu_inset + board_x_offset, yu_inset + board_y_offset, block_height(h, block_height) - thickness - undercut]) {
            cube([length - 2*innercut, width - 2*innercut, undercut]);
        }
    }
}


module pcb_space_skinned(material, large_nozzle, z, pcb_skin, length, width, thickness, l, w, h, undercut, innercut, board_x_offset, board_y_offset, dome, block_height, dome) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(z!=undef);
    assert(pcb_skin!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(thickness!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(undercut!=undef);
    assert(innercut!=undef);
    assert(board_x_offset!=undef);
    assert(board_y_offset!=undef);
    assert(dome!=undef);
    assert(block_height!=undef);
    assert(dome!=undef);

    minkowski() {
        pcb_space(material=material, large_nozzle=large_nozzle, z=z, length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, block_height=block_height, dome=dome);

        sphere(r=pcb_skin, $fn=16);
    }
}


// Optional inside cuts downward to allow headers on the board bottom not to rub on the insides of the enclosure. Used only by some models.
module bottom_header_space(material, large_nozzle, l, w, width, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(width!=undef);
    assert(block_height!=undef);

    down_cut_width = max(width, block_width(w-2));
    w2 = (block_width(w) - down_cut_width) / 2;

    translate([block_width(1.5), w2, 0]) {
        cube([block_width(l-3), down_cut_width, block_height(2, block_height=block_height)]);
    }
}
