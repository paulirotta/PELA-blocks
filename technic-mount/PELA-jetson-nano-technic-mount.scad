/*
PELA Jetson Nano Technic Mount - 3D Printed LEGO-compatible PCB mount with the board held in place by technic beams

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
use <PELA-technic-box.scad>
use <PELA-technic-mount.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Select parts to render
_render_modules = 2; // [0:mount, 1:cover, 2:mount and cover]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Jetson Nano] */

// Board space length [mm]
_length = 101; // [0:0.1:300]

// Board space width [mm]
_width = 80.6; // [0:0.1:300]

// Board space thickness [mm]
_thickness = 20; // [0:0.1:300]


/* [Enclosure] */

// Height of the enclosure [blocks]
_h = 3; // [1:1:20]

// Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
_l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
_w_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// 90 degree rotation from length ends [blocks]
_twist_l = 5; // [1:18]

// 90 degree rotation from width ends [blocks]
_twist_w = 4; // [1:18]

// Step in from board space edges to support the board [mm]
_innercut = 2; // [0:0.1:100]

// Step down from board bottom to give room board components [mm]
_undercut = 2.0; // [0:0.1:100]

// Interior fill style
_center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Text label
_text = "Jetson   Nano";


/* [Enclosure Left Cut] */

// Distance from the front of left side hole [mm]
_left_enclosure_cutout_y = 40; // [0:0.1:200]

// Width of the left side hole [mm]
_left_enclosure_cutout_width = 20; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_enclosure_cutout_z = 23.4; // [0:0.1:200]

// Height of the left side hole [mm]
_left_enclosure_cutout_height = 24; // [0:0.1:200]



/* [Enclosure Right Cut] */

// Distance from the front of right side hole [mm]
_right_enclosure_cutout_y = 4; // [0:0.1:200]

// Width of the right side hole [mm]
_right_enclosure_cutout_width = 80.2; // [0:0.1:200]

// Depth of the right side hole [mm]
_right_enclosure_cutout_depth = 16; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
_right_enclosure_cutout_z = 8; // [0:0.1:200]

// Height of the right side hole [mm]
_right_enclosure_cutout_height = 32; // [0:0.1:200]



/* [Enclosure Front Cut] */

// Distance from the left of front side hole [mm]
_front_enclosure_cutout_x = 5.6; // [0:0.1:200]

// Width of the front side hole [mm]
_front_enclosure_cutout_width = 102; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_enclosure_cutout_depth = 16; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_enclosure_cutout_z = 5.5; // [0:0.1:200]

// Height of the front side hole [mm]
_front_enclosure_cutout_height = 32; // [0:0.1:200]



/* [Enclosure Back Cut] */

// Distance from the left of back side hole [mm]
_back_enclosure_cutout_x = 36; // [0:0.1:200]

// Width of the back side hole [mm]
_back_enclosure_cutout_width = 24; // [0:0.1:200]

// Depth of the back side hole [mm]
_back_enclosure_cutout_depth = 16; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
_back_enclosure_cutout_z = 7.1; // [0:0.1:200]

// Height of the back side hole [mm]
_back_enclosure_cutout_height = 37; // [0:0.1:200]


/* [Cover] */

// Text label
_cover_text = "Jetson  Nano";

// Interior fill style
_cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]

// Include quarter-round corner hold-downs in the cover
_cover_corner_tabs = false;


/* [Advanced] */

// Depth of text etching into top surface
_text_depth = 0.8; // [0.0:0.1:2]

/// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = true;

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

// Add two hard points to mount wifi antennas on the back wall
_antenna_mounts = true;


///////////////////////////////
// DISPLAY
///////////////////////////////

jetson_nano_technic_mount(render_modules=_render_modules, material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, thickness=_thickness, h=_h, cover_h=_cover_h, l_pad=_l_pad, w_pad=_w_pad, twist_l=_twist_l, twist_w=_twist_w, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, top_vents=_top_vents, innercut=_innercut, undercut=_undercut, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, dome=_dome, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, cover_corner_tabs=_cover_corner_tabs, antenna_mounts=_antenna_mounts);

module jetson_nano_technic_mount(render_modules, material, large_nozzle, cut_line, length, width, thickness, h, cover_h, l_pad, w_pad, twist_l, twist_w, knob_height, knob_vent_radius, top_vents, innercut, undercut, center, cover_center, text, cover_text, text_depth, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height, dome, horizontal_skin, vertical_skin, cover_corner_tabs, antenna_mounts) {

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
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(top_vents!=undef);
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
    assert(dome!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    assert(cover_corner_tabs!=undef);
    assert(antenna_mounts!=undef);

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);    

    edge_thickness = 1.4;
        
    heatsink_cut_length = block_width(9) + horizontal_skin;
    heatsink_cut_width = block_width(5.95);
        
    heatsink_x = block_width(2.5) + horizontal_skin;
    heatsink_y = block_width(-2.5) - heatsink_cut_width + horizontal_skin;

    ribbon_cable_cut_length = block_width(2) + _defeather;
    ribbon_cable_cut_width = block_width(8);
        
    ribbon_cable_x = block_width(w-0.5) + 2*horizontal_skin;
    ribbon_cable_y = block_width(-2.5) - ribbon_cable_cut_width + horizontal_skin;

    antenna_cable_cut_length = block_width(1);
    antenna_cable_cut_width = block_width(3);
        
    antenna_cable_x = block_width(0.5) - horizontal_skin;
    antenna_cable_y = block_width(-2.5) - antenna_cable_cut_width + horizontal_skin;

    video_x = block_width(2);
    video_y = block_width(-1.5 - w);
    video_cut_length = block_width(3);
    video_cut_depth = block_width(2.9);

    cover_wall_height = 1+panel_height(block_width());

    difference() {
        union() {
            technic_mount_and_cover(render_modules=render_modules, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, knob_height=knob_height, knob_vent_radius=knob_vent_radius, top_vents=top_vents, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height, dome=dome, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=_cover_corner_tabs);
     
            if (render_modules > 0) {
                if (heatsink_cut_length > 0 && heatsink_cut_width)
                    color("orange") translate([heatsink_x - edge_thickness, heatsink_y - edge_thickness - horizontal_skin, 0])
                        cube([heatsink_cut_length + 2*edge_thickness, heatsink_cut_width + edge_thickness, cover_wall_height]);

                if (ribbon_cable_cut_length > 0 && ribbon_cable_cut_width)
                    color("pink") translate([ribbon_cable_x - edge_thickness, ribbon_cable_y - edge_thickness, 0])
                        cube([ribbon_cable_cut_length + edge_thickness - horizontal_skin, ribbon_cable_cut_width + edge_thickness, cover_wall_height]);
                
                if (antenna_cable_cut_length > 0 && antenna_cable_cut_width)
                    color("yellow") translate([antenna_cable_x, antenna_cable_y - edge_thickness, 0])
                        cube([antenna_cable_cut_length + edge_thickness, antenna_cable_cut_width + edge_thickness, cover_wall_height]);

                if (video_cut_length > 0 && (cover_center >= 1 && cover_center >= 4))
                    color("blue") translate([video_x - edge_thickness, video_y + block_width(), 0])
                        cube([video_cut_length + 2*edge_thickness, video_cut_depth + edge_thickness - block_width(), cover_wall_height]);
                
                color("purple") translate([block_width(4), block_width(-w)-horizontal_skin, 0]) {
                    translate([0, block_width(-0.5), 0])
                        cube([block_width(l-5), horizontal_skin, block_width()-2*vertical_skin]);
                    
                    technic_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l-4, w=1, h=cover_h, side_holes=1, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                }
            }
         
            if (render_modules == 0 || render_modules == 2) {
                color("red") back_tabs(w=w, l=l, h=h, thickness=thickness, board_h=1.8, vertical_skin=vertical_skin, horizontal_skin=horizontal_skin);

                if (antenna_mounts)
                    antenna_mount_solids(horizontal_skin);
            }
        }
        
        union() {
            color("blue") translate([video_x, video_y, -_defeather])
                cube([video_cut_length, video_cut_depth, block_width(2)]);

            color("orange") translate([heatsink_x, heatsink_y, -_defeather])
                cube([heatsink_cut_length, heatsink_cut_width, block_width(2)]);

            color("pink") translate([ribbon_cable_x - _defeather, ribbon_cable_y - _defeather, -vertical_skin])
                cube([ribbon_cable_cut_length, ribbon_cable_cut_width, block_width(2)]);

            color("yellow") translate([antenna_cable_x, antenna_cable_y, -vertical_skin])
                cube([antenna_cable_cut_length, antenna_cable_cut_width, block_width(2)]);

    translate([block_width(4), block_width(-w)-horizontal_skin, 0])
            color("purple") translate([0, block_width(-0.5), 0])            cut_space(material=material, large_nozzle=large_nozzle, cut_line=0, l=l-4, w=1, h=cover_h, block_height=block_width(), knob_height=0, skin=horizontal_skin);

            if (antenna_mounts) {
                antenna_mount_holes();
            }
            
            translate([block_width(4.5), block_width(-w-1.5), -_defeather]) {
                cube([block_width(l-8)+horizontal_skin, block_width(), block_width()]);
            }
        }
    }
}


module back_tabs(w, l, h, thickness, board_h, vertical_skin, horizontal_skin) {
    assert(w!=undef);
    assert(l!=undef);
    assert(h!=undef);
    assert(thickness!=undef);
    assert(board_h!=undef);
    assert(vertical_skin!=undef);
    assert(horizontal_skin!=undef);

    tab_h = block_width(h+0.5) - thickness + board_h;

    translate([block_width(0.8), block_width(w-1.4)+horizontal_skin, tab_h])
        rotate([180, 0, 0])
            half_tab(90);
            
    translate([block_width(l-3)+horizontal_skin, block_width(w-1.4)+horizontal_skin, tab_h])
        rotate([180, 0, 0])
            half_tab(90);
}


module antenna_mount_holes() {
    translate([block_width(1), block_width(9.5), block_width(1.5)]) 
        antenna_mount_hole();

    translate([block_width(11.5), block_width(9.5), block_width(1.5)]) 
        antenna_mount_hole();
}


module antenna_mount_hole() {
    translate([block_width(0.5), -_skin, block_width(0.5)]) {
        rotate([-90, 0, 0]) {
            cylinder(d=6.6, h=block_width(3));
            cylinder(d=9.35, h=block_width(1.5), $fn=6);
        }
    }
}


module antenna_mount_solids(horizontal_skin) {

    assert(horizontal_skin!=undef);
    
    translate([block_width(0.5), block_width(10.6), block_width(1.5)]) 
        antenna_mount_solid(horizontal_skin);

    translate([block_width(11), block_width(10.6), block_width(0.9)]) 
        antenna_mount_solid(horizontal_skin);
}


module antenna_mount_solid(horizontal_skin) {
    assert(horizontal_skin!=undef);
    
    color("black") translate([0, horizontal_skin, 0])
        cube([block_width(2), block_width(0.8), block_width()]);
}