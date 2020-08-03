/*
PELA Raspberry Pi3 Technic Mount - 3D Printed LEGO-compatible PCB mount on which other technic and PELA parts can be stacked to create a complete case

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
use <../PELA-box-enclosure.scad>
use <../PELA-socket-panel.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
use <PELA-technic-box.scad>
use <PELA-technic-mount.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Select parts to render
_render_modules = 3; // [0:pi mount, 1:pi cover, 2:middle layer, 3:all]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Board] */

// Board space length [mm]
_length = 86.8; // Board space length [mm]

// Board space width [mm]
_width = 56.8; // Board space width [mm]

// Board space heilengthght [mm]
_thickness = 1.9; // [0:0.1:4]


/* [Enclosure] */

// Step in from bolengthard space edges to support the board [mm]
_innercut = 1.5; //length [0:0.1:8]

// Step down from board bottom to give room board components [mm]
_undercut = 4; // [0:0.1:100]

// Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
_l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
_w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// How many blocks in from length ends do the technic holes rotate 90 degrees
_twist_l = 5; // [1:18]

// How many blocks in from width ends do the technic holes rotate 90 degrees
_twist_w = 4; // [1:18]

// Interior fill style
_center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]


// Text label
_text = "Pi 4";



/* [Enclosure Left Cut] */

// Distance from the front of left side hole [mm]
_left_enclosure_cutout_y = 27.9; // [0:0.1:200]

// Width of the left side hole [mm]
_left_enclosure_cutout_width = 16.2; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_enclosure_cutout_depth = 13; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_enclosure_cutout_z = -1; // [0:0.1:200]

// Height of the left side hole [mm]
_left_enclosure_cutout_height = 24; // [0:0.1:200]



/* [Enclosure Right Cut] */

// Distance from the front of right side hole [mm]
_right_enclosure_cutout_y = 4; // [0:0.1:200]

// Width of the right side hole [mm]
_right_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the right side hole [mm]
_right_enclosure_cutout_depth = 16.1; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
_right_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the right side hole [mm]
_right_enclosure_cutout_height = 16; // [0:0.1:200]



/* [Enclosure Front Cut] */

// Distance from the left of front side hole [mm]
_front_enclosure_cutout_x = 8; // [0:0.1:200]

// Width of the front side hole [mm]
_front_enclosure_cutout_width = 60; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_enclosure_cutout_depth = 14; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the front side hole [mm]
_front_enclosure_cutout_height = 24; // [0:0.1:200]



/* [Enclosure Back Cut] */

// Distance from the left of back side hole [mm]
_back_enclosure_cutout_x = 4; // [0:0.1:200]

// Width of the back side hole [mm]
_back_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
_back_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
_back_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the back side hole [mm]
_back_enclosure_cutout_height = 8; // [0:0.1:200]



/* [Cover] */

// Text label
_cover_text = "Pi 4";

// Interior fill style
_cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]


/* [Advanced] */

// Depth of text etching into top surface
_text_depth = 0.5; // [0.0:0.1:2]

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Include quarter-round corner hold-downs in the cover
_cover_corner_tabs = false;



/* [Hidden] */

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.0; // [0:0.02:0.5]

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = true;

// Height of the enclosure [blocks]
_h = 1; // [1:1:20]




///////////////////////////////
// DISPLAY
///////////////////////////////

pi3_technic_mount_and_cover(render_modules=_render_modules, material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, thickness=_thickness, h=_h, cover_h=_cover_h, l_pad=_l_pad, w_pad=_w_pad, twist_l=_twist_l, twist_w=_twist_w, knob_vent_radius=_knob_vent_radius, innercut=_innercut, undercut=_undercut, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, dome=_dome, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, knob_height=_knob_height, top_vents=_top_vents, cover_corner_tabs=_cover_corner_tabs);



///////////////////////////////////
// MODULES
///////////////////////////////////

module pi3_technic_mount_and_cover(render_modules, material, large_nozzle, cut_line, length, width, thickness, h, cover_h, l_pad, w_pad, twist_l, twist_w, knob_vent_radius, innercut, undercut, center, cover_center, text, cover_text, text_depth, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height, dome, horizontal_skin, vertical_skin, knob_height, top_vents, cover_corner_tabs) {

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);
    assert(text != undef);

    difference() {
        union() {
            rm = render_modules == 3 ? 2 : render_modules == 2 ? 3 : render_modules;
            
            technic_mount_and_cover(render_modules=rm, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, knob_vent_radius=knob_vent_radius, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height, dome=dome, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, knob_height=knob_height, top_vents=top_vents, cover_corner_tabs=cover_corner_tabs);

            tl = min(twist_l, ceil(l/2));
            l1 = tl;
            l3 = l1;
            l2 = max(0, l - l1 - l3);
            tw = min(twist_w, ceil(w/2));
            w1 = tw;
            w3 = w1;
            w2 = max(0, w - w1 - w3);

            if (render_modules == 0 || render_modules == 3) {
                translate([0, 0, block_width(1)]) {

                    difference() {
                        technic_rectangle(material=material, large_nozzle=large_nozzle, l1=l1, l2=l2-1, l3=l3, w1=w1, w2=w2, w3=w3, text=text, text_depth=text_depth, etch_top_text=true, etch_bottom_text=false, h=1, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                        
                        translate([0, 0, block_width(-1)]) {
                            wall_cutouts(l=l, w=w, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height);
                        }
                    }
                }

                retaining_ridge_sd_card_side(material=material, large_nozzle=large_nozzle, l=l, w=w, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height);
            }
            
            if (render_modules == 2 || render_modules == 3) {
                translate([0, block_width(w+1), 0]) {

                    difference() {
                        technic_rectangle(material=material, large_nozzle=large_nozzle, l1=l1, l2=l2-1, l3=l3, w1=w1, w2=w2, w3=w3, text=text, text_depth=text_depth, etch_top_text=true, etch_bottom_text=true, h=1, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);

                        union() {
                            translate([block_width(w), block_width(1), -_defeather]) {
                                cube([block_width(2), block_width(7), block_width(2)]);
                            }
                        }
                    }
                }

                translate([block_width(-0.5), block_width(w+5), block_width(1.5)]) {
                    rotate([90, 0, 90]) {
                        square_end_beam(material=material, large_nozzle=large_nozzle, l=2, w=1, h=1, side_holes=2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                    }
                }
            }
        }
        
        union() {
            color("green") main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, dome=dome);

            ethernet_cutout(material=material, large_nozzle=large_nozzle);
            
            camera_cable_cutout();
        }
    }
}


module camera_cable_cutout() {
    translate([block_width(-1), block_width(-7.5), 7.4]) {
        cube([block_width(2), block_width(2), block_width()]);
    }
}


module retaining_ridge_sd_card_side(material, large_nozzle, l, w, left_enclosure_cutout, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height) {

    assert(material != undef);
    assert(large_nozzle != undef);
    assert(l != undef);
    assert(w != undef);

    difference() {
        translate([block_width(0.5), block_width(0.5), block_width()]) {
            cube([block_width(0.5), block_width(w-2), block_width()]);
        }

        color("yellow") left_cutout(l=l, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height);
    }
}


module ethernet_cutout(material, large_nozzle) {

    translate([block_width(10), block_width(1), block_width()]) {
        cube([block_width(3), block_width(7), block_width(4)]);
    }
}
