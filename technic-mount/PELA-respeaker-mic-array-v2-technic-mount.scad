/*
PELA Technic Board Mount - 3D Printed LEGO-compatible PCB mount used for including printed ciruit boards in technic models

This is a library module used by other models

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
use <../PELA-box-enclosure.scad>
use <PELA-technic-box.scad>
use <PELA-technic-mount.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Select parts to render
_render_modules = 2; // [0:mount, 1:cover, 2:mount and cover]



/* [Board] */

// Board space diameter [mm]
_diameter = 71.4; // [0:0.1:300]

// Board space height (1.7, 11.5 with one daughter board) [mm]
_thickness = 1.7; // [0:0.1:300]



/* [Enclosure] */

// Distance from length ends of connector twist [blocks]
_twist_l = 3; // [1:18]

// Distance from width ends of connector twist [blocks]
_twist_w = 3; // [1:18]

// Closeness of board fit lengthwise [blocks]
_l_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise [blocks]
_w_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// Height of the enclosure [blocks]
_h = 2; // [1:1:20]

// Interior fill style
_center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Step in from board space edges to support the board [mm]
_innercut = 4; // [0:0.1:100]

// Step down from board bottom to give room board components [mm]
_undercut = 0; // [0:0.1:100]

// Presence of sockets if center is "socket panel"
_center_sockets = true;

// Presence of knobs if center is "knob panel"
_center_knobs = true;

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Text label
_text = "Respeaker";

// Add surface texture to reduce echoes inside the enclosure
_anechoic = true;


/* [Enclosure Left Cut] */

// Distance from the front of left side hole [mm]
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

// Distance from the front of right side hole [mm]
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

// Distance from the left of front side hole [mm]
_front_enclosure_cutout_x = 20; // [0:0.1:200]

// Width of the front side hole [mm]
_front_enclosure_cutout_width = 32; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_enclosure_cutout_z = 8; // [0:0.1:200]

// Height of the front side hole [mm]
_front_enclosure_cutout_height = 16; // [0:0.1:200]



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
_cover_text = "Respeaker";

// Interior fill style
_cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]

// Presence of sockets if "cover center" is "socket panel"
_cover_sockets = true;

// Presence of knobs if "cover center" is "knob panel"
_cover_knobs = true;



/* [Advanced] */

// Depth of text etching into top surface
_text_depth = 0.5; // [0.0:0.1:2]

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = true;

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;





///////////////////////////////
// DISPLAY
///////////////////////////////

respeaker_mic_array_v2(render_modules=_render_modules, material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_diameter, width=_diameter, thickness=_thickness, h=_h, cover_h=_cover_h, l_pad=_l_pad, w_pad=_w_pad, twist_l=_twist_l, twist_w=_twist_w, knob_vent_radius=_knob_vent_radius, innercut=_innercut, undercut=_undercut, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, knob_height=_knob_height, top_vents=_top_vents, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, anechoic=_anechoic);



///////////////////////////////
// MODULES
///////////////////////////////

module respeaker_mic_array_v2(render_modules, material, large_nozzle, cut_line, length, width, thickness, h, cover_h, l_pad, w_pad, twist_l, twist_w, knob_vent_radius, innercut, undercut, center, cover_center, text, cover_text, text_depth, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height, knob_height, top_vents, horizontal_skin, vertical_skin, anechoic) {

    assert(render_modules!=undef);
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(thickness!=undef);
    assert(h!=undef);
    assert(cover_h!=undef);
    assert(l_pad!=undef);
    assert(w_pad!=undef);
    assert(twist_l!=undef);
    assert(twist_w!=undef);
    assert(knob_vent_radius!=undef);
    assert(innercut!=undef);
    assert(undercut!=undef);
    assert(center!=undef);
    assert(cover_center!=undef);
    assert(text!=undef);
    assert(cover_text!=undef);
    assert(text_depth!=undef);
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
    assert(knob_height!=undef);
    assert(top_vents!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    assert(anechoic!=undef);

    l = fit_mm_to_blocks(length, l_pad);

    difference() {
        technic_mount_and_cover(render_modules=render_modules, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=0, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, knob_vent_radius=knob_vent_radius, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height, knob_height=knob_height, top_vents=top_vents, dome=false, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=false);

        union() {
            translate([block_width(-0.5+l/2), block_width(-0.5+l/2), block_width(h)-thickness]) {
                cylinder(d=length, h=thickness+_defeather, $fn=256);
            }

            color("orange") translate([block_width(-0.5+l/2), block_width(-0.5+l/2), -horizontal_skin]) {
                anechoic_cylinder_negative_space(diameter=length, h=h, innercut=innercut, anechoic=anechoic, horizontal_skin=horizontal_skin);
            }

            color("pink") translate([block_width(-0.5+3), block_width(-1.5-10)-horizontal_skin, 2]) {
                cube([block_width(4), block_width(3), block_width(cover_h)]);
            }
        }
    }
    
    if (render_modules == 0 || render_modules == 2) {
        color("blue") translate([block_width(-0.5+l/2), block_width(-0.5+l/2), 0]) {
            cylinder(d=length-2*innercut, h=2, $fn=256);
        }
    }
}



module anechoic_cylinder_negative_space(diameter, h, innercut, anechoic, horizontal_skin) {
    
    d = diameter-2*innercut;
    ah = block_width(0.5);
    angle_increment = 360/45;
    
    if (anechoic) {
        difference() {
            cylinder(d=d, h=block_width(h)+2*horizontal_skin, $fn=256);

            for (i=[0:angle_increment:360]) {
                rotate([0, 0, i]) {
                    for (j=[0.5:0.5:h-0.5]) {
                        translate([0, (d-ah)/2, block_width(j)]) {
                            rotate([-90, 0, 0]) {
                                cylinder(h=ah/2, d1=0, d2=ah);
                            }
                        }
                    }
                }
            }
        }
    } else {
        cylinder(d=d, h=block_width(h)+2*skin, $fn=256);
    }
}
