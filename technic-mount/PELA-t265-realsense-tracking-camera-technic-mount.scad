/*
Intel T265 Realsense Tracking Camera Mount - 3D Printed LEGO-compatible depth camera holder

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
use <../PELA-box-enclosure.scad>
use <../PELA-knob-mount.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
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

// Board space length [mm]
_length = 107.6; // [0:1:300] 

// Board space width [mm]
_width = 13; // [0:1:300]

// Board space thickness [mm]
_thickness = 25; // [0:0.1:8]


/* [Enclosure] */

_l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit lengthwise inside a ring of blocks [ratio - increase to make outer box slightly larger]

_w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit widthwise inside a ring of blocks [ratio - increase to make outer box slightly larger]

// Height of the enclosure [blocks]
_h = 4; // [1:20]

// How many blocks in from length ends do the technic holes rotate 90 degrees [blocks]
_twist_l = 6; // [1:18]

// How many blocks in from width ends do the technic holes rotate 90 degrees [blocks]
_twist_w = 2; // [1:18]

// Step in from board space edges to support the board [mm]
_innercut = 4; // [0:0.1:100]

// Step down from board bottom to give room board components [mm]
_undercut = 0.0; // [0:0.1:100]

// Interior fill style
_center = 4; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Text label
_text = "Intel T265";



/* [Enclosure Left Cut] */

// Distance of the front of left side hole [mm]
_left_enclosure_cutout_y = 4; // [0:0.1:200]

// Width of the left side hole [mm]
_left_enclosure_cutout_width = 12; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_enclosure_cutout_z = 8.9; // [0:0.1:200]

// Height of the left side hole [mm]
_left_enclosure_cutout_height = 48; // [0:0.1:200]



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
_front_enclosure_cutout_x = -4; // [-4:0.1:200]

// Width of the front side hole [mm]
_front_enclosure_cutout_width = 130; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_enclosure_cutout_depth = 16; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_enclosure_cutout_z = 8.9; // [0:0.1:200]

// Height of the front side hole [mm]
_front_enclosure_cutout_height = 48; // [0:0.1:200]

// Depth into the part of the front cut [mm]front_enclosure_cutout_depth = 16; // [0:0.1:200]



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



/* [Cover] */

// Text label
_cover_text = "Intel T265";

// Interior fill style
_cover_center = 4; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]

// Include quarter-round corner hold-downs in the cover
_cover_corner_tabs = false;


/* [Advanced] */

// Depth of text etching into top surface
_text_depth = 0.5; // [0.0:0.1:2]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = false;

// Amount of front to clip off to keep out view of the wide angle cameras [mm]
_front_face = 0.9; // [0.0:0.1:16]

// Module retaining wall thickness [mm]
_wall_thickness = 2.4; // [0.0:0.1:8]

// Module retaining wall height [mm]
_wall_height = 2.5; // [0.0:0.1:8]


///////////////////////////////
// DISPLAY
///////////////////////////////

intel_t2685_enclosure(render_modules=_render_modules, material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, thickness=_thickness, h=_h, cover_h=_cover_h, l_pad=_l_pad, w_pad=_w_pad, twist_l=_twist_l, twist_w=_twist_w, knob_vent_radius=_knob_vent_radius, innercut=_innercut, undercut=_undercut, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, knob_height=_knob_height, top_vents=_top_vents, dome=_dome, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, cover_corner_tabs=_cover_corner_tabs, front_face=_front_face, wall_thickness=_wall_thickness, wall_height=_wall_height);



///////////////////////////////
// MODULES
///////////////////////////////


module intel_t2685_enclosure(render_modules, material, large_nozzle, cut_line, length, width, thickness, h, cover_h, l_pad, w_pad, twist_l, twist_w, knob_vent_radius, innercut, undercut, center, cover_center, text, cover_text, text_depth, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height, knob_height, top_vents, dome, horizontal_skin, vertical_skin, cover_corner_tabs, front_face, wall_thickness, wall_height) {

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
    assert(dome!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    assert(cover_corner_tabs!=undef);
    assert(front_face!=undef);
    assert(wall_thickness!=undef);
    assert(wall_height!=undef);
    
    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);

    difference() {
        positive_space(render_modules=render_modules, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, knob_vent_radius=knob_vent_radius, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height, knob_height=knob_height, top_vents=top_vents, dome=dome, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=cover_corner_tabs, wall_thickness=wall_thickness, wall_height=wall_height, l=l, w=w);

        union() {
            if (thickness > 0) {
                main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, dome=dome);
                
            translate([0, block_width(-1-w), 0])
                main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=block_width(h-1)+2*vertical_skin, dome=dome);
            }
            
            color("pink") union() {
                
                front_face_cut(front_face=front_face, length=length);
                
                translate([0, block_width(-5), 0])
                    front_face_cut(front_face=front_face, length=length);
            }
        }
    }
}


module positive_space(render_modules, material, large_nozzle, cut_line, length, width, thickness, h, cover_h, l_pad, w_pad, twist_l, twist_w, knob_vent_radius, innercut, undercut, center, cover_center, text, cover_text, text_depth, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height, knob_height, top_vents, dome, horizontal_skin, vertical_skin, cover_corner_tabs, wall_thickness, wall_height, l, w) {

    technic_mount_and_cover(render_modules=render_modules, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, knob_vent_radius=knob_vent_radius, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height, knob_height=knob_height, top_vents=top_vents, dome=dome, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=cover_corner_tabs);

    y = (block_width(w-1)-width)/2 - wall_thickness;
    x = (block_width(l-1)-length)/2 - wall_thickness;
    z = block_width()-2*vertical_skin;
    
    if (render_modules!=1)
        color("orange") translate([x, y, z])
            cube([length+2*wall_thickness, width+wall_thickness, wall_height]);
    
    if (render_modules>0) {
        w2 = block_width(w-1);
        hw = w2/2 - width/2;
        
        color("blue") translate([x, block_width(-w)-hw, z])
            cube([length+2*wall_thickness, block_width(1), wall_height]);
    }
}


module front_face_cut(front_face, length) {

    assert(front_face!=undef);    
    assert(length!=undef);
    
    translate([block_width(-0.5), block_width(-1.5+front_face), -_defeather])
        cube([length*2, block_width(1), block_width(2)]);
}