/*-------------------------------------
Parametric PELA Box Enclosure Generator

Create a bottom and 4 walls of a rectangle for enclosing objects


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <style.scad>
include <material.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>
use <PELA-socket-panel.scad>
use <PELA-knob-panel.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;



/* [Enclosure] */

// Length of the enclosure including two for walls [blocks]
_l = 6; // [1:1:20]

// Width of the enclosure including two for walls [blocks]
_w = 4; // [1:1:20]

// Height of the enclosure [mm]
_h = 2; // [1:1:20]

// Basic unit vertical size of each block
_block_height = 9.6; // [8:technic, 9.6:traditional knobs]

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
_center_type = 0; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Presence of bottom connector sockets
_sockets = true;

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2;  // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Add short end holes spaced along the width for techic connectors
_end_holes = 3;  // [0:disabled, 1:short air vents, 2:full length connectors, 3:short connectors]



/* [Bottom Features] */

// Bottom of enclosure
_bottom_type = 3; // [0:open bottom, 1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Enable knobs in the bottom (if knob panel bottom)
_bottom_knobs = true;

// Number of knobs at the edge of a bottom panel to omit (this will leave space for example for a nearby top wall or technic connectors)
_skip_edge_knobs = 1;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type == 3, knob panel)
_bottom_vents = true;



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

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
_side_sheaths = true;

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
_end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// There is usually no need or room for corner mounting M3 bolt holes
_corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
_bolt_hole_radius = 1.6; // [0.0:0.1:3.0]

// Add interior fill for upper layers
_solid_upper_layers = true;

// Add interior fill for the base layer
_solid_first_layer = false;

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_skin = 0.1; // [0:0.02:0.5]



///////////////////////////////
// DISPLAY
///////////////////////////////

box_enclosure(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, bottom_type=_bottom_type, sockets=_sockets, bottom_vents=_bottom_vents, top_vents=_top_vents, side_holes=_side_holes, side_sheaths=_side_sheaths, end_holes=_end_holes, end_sheaths=_end_sheaths, skin=_skin, knob_height=_knob_height, bottom_knobs=_bottom_knobs, skip_edge_knobs=_skip_edge_knobs, left_wall_enabled=_left_wall_enabled, right_wall_enabled=_right_wall_enabled, front_wall_enabled=_front_wall_enabled, back_wall_enabled=_back_wall_enabled, left_wall_knobs=_left_wall_knobs, right_wall_knobs=_right_wall_knobs, front_wall_knobs=_front_wall_knobs, back_wall_knobs=_back_wall_knobs, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, center_type=_center_type, block_height=_block_height, knob_vent_radius=_knob_vent_radius, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius);



///////////////////////////////////
// MODULES
///////////////////////////////////

module box_enclosure(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, bottom_type=undef, sockets=undef, top_vents=undef, bottom_vents=undef, side_holes=undef, side_sheaths=undef, end_holes=undef, end_sheaths=undef, skin=undef, knob_height=undef, bottom_knobs=undef, skip_edge_knobs=undef, left_wall_enabled=undef, right_wall_enabled=undef, front_wall_enabled=undef, back_wall_enabled=undef, left_wall_knobs=undef, right_wall_knobs=undef, front_wall_knobs=undef, back_wall_knobs=undef, solid_first_layer=undef, solid_upper_layers=undef, center_type=undef, block_height=undef, knob_vent_radius=undef, left_enclosure_cutout_y=undef, left_enclosure_cutout_width=undef, left_enclosure_cutout_depth=undef, left_enclosure_cutout_z=undef, left_enclosure_cutout_height=undef, right_enclosure_cutout_y=undef, right_enclosure_cutout_width=undef, right_enclosure_cutout_depth=undef, right_enclosure_cutout_z=undef, right_enclosure_cutout_height=undef, front_enclosure_cutout_x=undef, front_enclosure_cutout_width=undef, front_enclosure_cutout_depth=undef, front_enclosure_cutout_z=undef, front_enclosure_cutout_height=undef, back_enclosure_cutout_x=undef, back_enclosure_cutout_width=undef, back_enclosure_cutout_depth=undef, back_enclosure_cutout_z=undef, back_enclosure_cutout_height=undef, corner_bolt_holes=undef, bolt_hole_radius=undef) {

    assert(material != undef);
    assert(large_nozzle != undef);
    assert(cut_line != undef);
    assert(l != undef);
    assert(w != undef);
    assert(h != undef);
    assert(bottom_type != undef);
    assert(sockets != undef);
    assert(top_vents != undef);
    assert(bottom_vents != undef);
    assert(side_holes != undef);
    assert(side_sheaths != undef);
    assert(end_holes != undef);
    assert(end_sheaths != undef);
    assert(skin != undef);
    assert(bottom_knobs != undef);
    assert(knob_height != undef);
    assert(skip_edge_knobs != undef);
    assert(left_wall_enabled != undef);
    assert(right_wall_enabled != undef);
    assert(front_wall_enabled != undef);
    assert(back_wall_enabled != undef);
    assert(left_wall_knobs != undef);
    assert(right_wall_knobs != undef);
    assert(front_wall_knobs != undef);
    assert(back_wall_knobs != undef);
    assert(solid_first_layer != undef);
    assert(solid_upper_layers != undef);
    assert(center_type != undef);
    assert(block_height != undef);
    assert(knob_vent_radius != undef);
    assert(corner_bolt_holes != undef);
    assert(bolt_hole_radius != undef);

    difference() {
        box_enclosure_positive_space(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, bottom_type=bottom_type, bottom_vents=bottom_vents, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, bottom_knobs=bottom_knobs, skip_edge_knobs=skip_edge_knobs, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius, knob_height=knob_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius);

        union() {
            axle_hole_radius = material_axle_hole_radius(material=material, large_nozzle=large_nozzle);
            
            bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, sockets=sockets, skin=skin, block_height=block_height, axle_hole_radius=axle_hole_radius);

            edge_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, bottom_type=bottom_type, side_holes=side_holes, end_holes=end_holes, hole_type=side_holes, block_height=block_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin);

            wall_cutouts(l=l, w=w, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height);

            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height, skin=skin);
        }
    }
}


module box_enclosure_positive_space(material, large_nozzle, cut_line, l, w, h, bottom_type, bottom_vents, sockets, top_vents, side_holes, side_sheaths, end_holes, end_sheaths, skin, bottom_knobs, skip_edge_knobs, left_wall_enabled, right_wall_enabled, front_wall_enabled, back_wall_enabled, left_wall_knobs, right_wall_knobs, front_wall_knobs, back_wall_knobs, solid_first_layer, solid_upper_layers, center_type, block_height, knob_vent_radius, knob_height, corner_bolt_holes, bolt_hole_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(bottom_type!=undef);
    assert(bottom_vents!=undef);
    assert(sockets!=undef);
    assert(top_vents!=undef);
    assert(side_holes!=undef);
    assert(side_sheaths!=undef);
    assert(end_holes!=undef);
    assert(end_sheaths!=undef);
    assert(skin!=undef);
    assert(bottom_knobs!=undef);
    assert(skip_edge_knobs!=undef);
    assert(left_wall_enabled!=undef);
    assert(right_wall_enabled!=undef);
    assert(front_wall_enabled!=undef);
    assert(back_wall_enabled!=undef);
    assert(left_wall_knobs!=undef);
    assert(right_wall_knobs!=undef);
    assert(front_wall_knobs!=undef);
    assert(back_wall_knobs!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(center_type!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(knob_height!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);

    walls(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bottom_type=bottom_type, bottom_vents=bottom_vents, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius, knob_height=knob_height);

    enclosure_bottom(material=material, large_nozzle=large_nozzle, l=l, w=w, bottom_type=bottom_type, bottom_vents=bottom_vents, sockets=sockets, skin=skin, knobs=bottom_knobs, skip_edge_knobs=skip_edge_knobs, solid_first_layer=solid_first_layer, block_height=block_height, knob_height=knob_height, knob_vent_radius=knob_vent_radius, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius);

    box_center(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, center_type=center_type, side_holes=side_holes, end_holes=end_holes, block_height=block_height, skin=skin);
}


module walls(material, large_nozzle, l, w, h, bottom_type, bottom_vents, sockets, top_vents, side_holes, side_sheaths, end_holes, end_sheaths, skin, left_wall_enabled, right_wall_enabled, front_wall_enabled, back_wall_enabled, left_wall_knobs, right_wall_knobs, front_wall_knobs, back_wall_knobs, solid_first_layer, solid_upper_layers, center_type, block_height, knob_vent_radius, knob_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(bottom_type!=undef);
    assert(bottom_vents!=undef);
    assert(sockets!=undef);
    assert(top_vents!=undef);
    assert(side_holes!=undef);
    assert(side_sheaths!=undef);
    assert(end_holes!=undef);
    assert(end_sheaths!=undef);
    assert(skin!=undef);
    assert(left_wall_enabled!=undef);
    assert(right_wall_enabled!=undef);
    assert(front_wall_enabled!=undef);
    assert(back_wall_enabled!=undef);
    assert(left_wall_knobs!=undef);
    assert(right_wall_knobs!=undef);
    assert(front_wall_knobs!=undef);
    assert(back_wall_knobs!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(center_type!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(knob_height!=undef);

    difference() {
        union() {
            if (left_wall_enabled) {
                left_wall(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=left_wall_knobs, block_height=block_height, knob_vent_radius=knob_vent_radius, knob_height=knob_height);
            }

            if (right_wall_enabled) {
                right_wall(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=right_wall_knobs, block_height=block_height, knob_vent_radius=knob_vent_radius, knob_height=knob_height);
            }

            if (front_wall_enabled) {
                front_wall(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=front_wall_knobs, block_height=block_height, knob_vent_radius=knob_vent_radius, knob_height=knob_height);
            }

            if (back_wall_enabled) {
                back_wall(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=back_wall_knobs, block_height=block_height, knob_vent_radius=knob_vent_radius, knob_height=knob_height);
            }
        }

        hull() {
            bottom_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, bottom_type=bottom_type, bottom_vents=bottom_vents, skin=0, solid_first_layer=solid_first_layer, block_height=block_height);
        }
    }
}


// Left side of the box with corner cuts
module left_wall(material, large_nozzle, cut_line, l, w, h, sockets, top_vents, end_holes, end_sheaths, skin, front_wall_enabled, back_wall_enabled, solid_first_layer, solid_upper_layers, knobs, knob_height, block_height, knob_vent_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(sockets!=undef);
    assert(top_vents!=undef);
    assert(end_holes!=undef);
    assert(end_sheaths!=undef);
    assert(skin!=undef);
    assert(front_wall_enabled!=undef);
    assert(back_wall_enabled!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(knobs!=undef);
    assert(knob_height!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);

    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=1, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=0, side_sheaths=0, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, knobs=knobs, knob_height=knob_height, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, block_height=block_height, knob_vent_radius=knob_vent_radius);

        union() {
            if (front_wall_enabled) {
                corner_cut(material=material, large_nozzle=large_nozzle, angle=-45, h=h, block_height=block_height);
            }

            if (back_wall_enabled) {
                translate([0, block_width(w), 0]) {
                    corner_cut(material=material, large_nozzle=large_nozzle, angle=-45, h=h, block_height=block_height);
                }
            }
        }
    }
}


// A slice removed so that two wall fit together as a single whole
module corner_cut(material, large_nozzle, angle, h, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(angle!=undef);
    assert(h!=undef);
    assert(block_height!=undef);

    translate([0, 0, -_defeather]) {
        rotate([0, 0, angle]) {
            cube([block_width(2), block_width(2), block_height(h, block_height) + _defeather]);
        }
    }
}


// Mirror image of the left side
module right_wall(material, large_nozzle, cut_line, l, w, h, sockets, top_vents, end_holes, end_sheaths, skin, front_wall_enabled, back_wall_enabled, solid_first_layer, solid_upper_layers, knobs, knob_height, block_height, knob_vent_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(sockets!=undef);
    assert(top_vents!=undef);
    assert(end_holes!=undef);
    assert(end_sheaths!=undef);
    assert(skin!=undef);
    assert(front_wall_enabled!=undef);
    assert(back_wall_enabled!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(knobs!=undef);
    assert(knob_height!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            left_wall(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=back_wall_enabled, back_wall_enabled=front_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=knobs, knob_height=knob_height, block_height=block_height, knob_vent_radius=knob_vent_radius);
        }
    }
}


// Front side of the box with corner cuts
module front_wall(material, large_nozzle, cut_line, l, w, h, sockets, top_vents, side_holes, side_sheaths, skin, left_wall_enabled, right_wall_enabled, solid_first_layer, solid_upper_layers, knobs, knob_height, block_height, knob_vent_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(sockets!=undef);
    assert(top_vents!=undef);
    assert(side_holes!=undef);
    assert(side_sheaths!=undef);
    assert(skin!=undef);
    assert(left_wall_enabled!=undef);
    assert(right_wall_enabled!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(knobs!=undef);
    assert(knob_height!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);

    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=1, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=0, end_sheaths=0, skin=skin, knobs=knobs, knob_height=knob_height, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, block_height=block_height, knob_vent_radius=knob_vent_radius);

        union() {
            if (left_wall_enabled) {
                corner_cut(material=material, large_nozzle=large_nozzle, angle=45, h=h, block_height=block_height);
            }

            if (right_wall_enabled) {
                translate([block_width(l), 0, 0]) {
                    corner_cut(material=material, large_nozzle=large_nozzle, angle=45, h=h, block_height=block_height);
                }
            }
        }
    }
}


// Mirror image of the front wall
module back_wall(material, large_nozzle, cut_line, l, w, h, sockets, top_vents, side_holes, side_sheaths, skin, left_wall_enabled, right_wall_enabled, solid_first_layer, solid_upper_layers, knobs, knob_height, block_height, knob_vent_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(sockets!=undef);
    assert(top_vents!=undef);
    assert(side_holes!=undef);
    assert(side_sheaths!=undef);
    assert(skin!=undef);
    assert(left_wall_enabled!=undef);
    assert(right_wall_enabled!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(knobs!=undef);
    assert(knob_height!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            front_wall(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=right_wall_enabled, right_wall_enabled=left_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=knobs, knob_height=knob_height, block_height=block_height, knob_vent_radius=knob_vent_radius);
        }
    }
}


// Cutout for the box bottom
module bottom_negative_space(material, large_nozzle, l, w, sockets, bottom_type, bottom_vents, skin, solid_first_layer, block_height) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(sockets!=undef);
    assert(bottom_type!=undef);
    assert(bottom_vents!=undef);
    assert(skin!=undef);
    assert(solid_first_layer!=undef);
    assert(block_height!=undef);
    
    if (bottom_type > 0) {
        enclosure_bottom(material=material, large_nozzle=large_nozzle, l=l, w=w, knobs=false, skip_edge_knobs=false, sockets=sockets, bottom_type=1, bottom_vents=bottom_vents, skin=skin, solid_first_layer=solid_first_layer, block_height=block_height, knob_height=0, knob_vent_radius=0, corner_bolt_holes=false, bolt_hole_radius=0);
    }
}


// Space for the edge connectors
module edge_connector_negative_space(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, sockets=undef, bottom_type=undef, side_holes=undef, end_holes=undef, hole_type=undef, corner_bolt_holes=undef, bolt_hole_radius=undef, block_height=undef, skin=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(sockets!=undef);
    assert(bottom_type!=undef);
    assert(side_holes!=undef);
    assert(end_holes!=undef);
    assert(hole_type!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    if (bottom_type > 0) {
        axle_hole_radius = material_axle_hole_radius(material=material, large_nozzle=large_nozzle);
        
        bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, sockets=sockets, skin=skin, block_height=block_height, axle_hole_radius=axle_hole_radius);
    }
}


// The optional bottom layer of the box
module enclosure_bottom(material, large_nozzle, l, w, bottom_type, sockets, bottom_vents, skin, knobs, skip_edge_knobs, solid_first_layer, block_height, knob_height, knob_vent_radius, corner_bolt_holes, bolt_hole_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(bottom_type!=undef);
    assert(sockets!=undef);
    assert(bottom_vents!=undef);
    assert(skin!=undef);
    assert(knobs!=undef);
    assert(skip_edge_knobs!=undef);
    assert(solid_first_layer!=undef);
    assert(block_height!=undef);
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);

    if (bottom_type == 1) {
        translate([block_width(1)-skin, block_width(1)-skin, 0]) {
            cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, panel_height(block_height=block_height)]);
        }
    } else if (bottom_type == 2) {
        socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin, block_height=block_height);
        
    } else if (bottom_type == 3) {
        knob_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, top_vents=bottom_vents, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, skin=skin, skip_edge_knobs=skip_edge_knobs, block_height=block_height, knob_height=knob_height, knob_vent_radius=knob_vent_radius);
   }
}


// The middle "cheese" from which enclosure supports are cut
module box_center(material, large_nozzle, l, w, h, center_type, side_holes, end_holes, block_height, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(center_type!=undef);
    assert(side_holes!=undef);
    assert(end_holes!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    if (center_type > 0 && l > 2 && w > 2) {
        l2 = block_width(l-2) + 2*skin;
        w2 = block_width(w-2) + 2*skin;

        translate([block_width(1) - skin, block_width(1) - skin, panel_height(block_height=block_height)]) {
            cube([l2, w2, block_height(h, block_height) - panel_height(block_height=block_height)]);
        }
    }
}


module wall_cutouts(l, w, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height) {

    assert(left_enclosure_cutout_y != undef);
    assert(left_enclosure_cutout_width != undef);
    assert(left_enclosure_cutout_depth != undef);
    assert(left_enclosure_cutout_z != undef);
    assert(left_enclosure_cutout_height != undef);
    assert(right_enclosure_cutout_y != undef);
    assert(right_enclosure_cutout_width != undef);
    assert(right_enclosure_cutout_depth != undef);
    assert(right_enclosure_cutout_z != undef);
    assert(right_enclosure_cutout_height != undef);
    assert(front_enclosure_cutout_x != undef);
    assert(front_enclosure_cutout_width != undef);
    assert(front_enclosure_cutout_depth != undef);
    assert(front_enclosure_cutout_z != undef);
    assert(front_enclosure_cutout_height != undef);
    assert(back_enclosure_cutout_x != undef);
    assert(back_enclosure_cutout_width != undef);
    assert(back_enclosure_cutout_depth != undef);
    assert(back_enclosure_cutout_z != undef);
    assert(back_enclosure_cutout_height != undef);

    color("yellow") left_cutout(l=l, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height);

    color("gold") right_cutout(l=l, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height);

    color("moccasin") front_cutout(w=w, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height);

    color("khaki") back_cutout(l=l, w=w, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height);
}


// Left side access hole
module left_cutout(l, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height) {
    
    assert(l!=undef);
    assert(left_enclosure_cutout_y!=undef);
    assert(left_enclosure_cutout_width!=undef);
    assert(left_enclosure_cutout_depth!=undef);
    assert(left_enclosure_cutout_z!=undef);
    assert(left_enclosure_cutout_height!=undef);

    if (left_enclosure_cutout_width > 0 && left_enclosure_cutout_depth > 0 && left_enclosure_cutout_height > 0) {
        translate([block_width(-0.5)-_defeather, left_enclosure_cutout_y, left_enclosure_cutout_z-_defeather]) {
            cube([left_enclosure_cutout_depth, left_enclosure_cutout_width, left_enclosure_cutout_height]);
        }
    }
}


// Right side access hole
module right_cutout(l, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height) {

    assert(l!=undef);
    assert(right_enclosure_cutout_y!=undef);
    assert(right_enclosure_cutout_width!=undef);
    assert(right_enclosure_cutout_depth!=undef);
    assert(right_enclosure_cutout_z!=undef);
    assert(right_enclosure_cutout_height!=undef);

    if (right_enclosure_cutout_width > 0 && right_enclosure_cutout_depth > 0 && right_enclosure_cutout_height > 0) {
        translate([block_width(l - 0.5) - right_enclosure_cutout_depth + _defeather, right_enclosure_cutout_y, right_enclosure_cutout_z-_defeather]) {
            cube([right_enclosure_cutout_depth, right_enclosure_cutout_width, right_enclosure_cutout_height]);
        }
    }
}


// Front access hole
module front_cutout(w, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height) {

    assert(w!=undef);
    assert(front_enclosure_cutout_width!=undef);
    assert(front_enclosure_cutout_depth!=undef);
    assert(front_enclosure_cutout_z!=undef);
    assert(front_enclosure_cutout_height!=undef);

    if (front_enclosure_cutout_width > 0 && front_enclosure_cutout_depth > 0 && front_enclosure_cutout_height > 0) {
        translate([front_enclosure_cutout_x, block_width(-0.5)-_defeather, front_enclosure_cutout_z-_defeather]) {
            cube([front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_height]);
        }
    }
}


// Back access hole
module back_cutout(l, w, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height) {

    assert(l!=undef);
    assert(w!=undef);
    assert(back_enclosure_cutout_width!=undef);
    assert(back_enclosure_cutout_depth!=undef);
    assert(back_enclosure_cutout_z!=undef);
    assert(back_enclosure_cutout_height!=undef);

    if (back_enclosure_cutout_width > 0 && back_enclosure_cutout_depth > 0 && back_enclosure_cutout_height > 0) {
        translate([back_enclosure_cutout_x, block_width(w - 0.5) - back_enclosure_cutout_depth + _defeather, back_enclosure_cutout_z-_defeather]) {
            cube([back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_height]);
        }
    }
}
