/*
PELA technic angle - 3D Printed LEGO-compatible 30 degree bend

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
use <PELA-technic-beam.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Twist Beam] */

// Beam width, left end [blocks]
_w_left = 1; // [1:1:30]

// Beam width, center [blocks]
_w_center = 1; // [1:1:30]

// Beam width, right end [blocks]
_w_right = 1; // [1:1:30]

// Left side length of upward facing connectors [blocks]
_l_left = 2; // [1:20]

// Center length of sideways facing connectors [blocks]
_l_center = 4; // [0:20]

// Right side length of upward facing connectors [blocks]
_l_right = 2; // [1:20]

// Beam height, left end [blocks]
_h_left = 1; // [0:1:30]

// Beam height, center [blocks]
_h_center = 1; // [1:1:30]

// Beam height, right end [blocks]
_h_right = 1; // [0:1:30]


/* [Advanced] */

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_twist_beam(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, w_left=_w_left, w_center=_w_center, w_right=_w_right, l_left=_l_left, l_center=_l_center, l_right=_l_right, h_left=_h_left, h_center=_h_center, h_right=_h_right, side_holes=_side_holes, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_twist_beam(material, large_nozzle, cut_line=_cut_line, w_left, w_center, w_right, l_left, l_center, l_right, h_left, h_center, h_right, side_holes, horizontal_skin, vertical_skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(w_left>0);
    assert(w_center>0);
    assert(w_right>0);
    assert(l_left>=0);
    assert(l_center>=0);
    assert(l_right>0);
    assert(h_left>=0);
    assert(h_center>0);
    assert(h_right>=0);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    if (l_center == 0) {
        technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l_left+l_right, side_holes=side_holes, w=w_left, h=h_left, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
    } else {
        difference() {
            union() {
                if (h_left>0) {
                    translate([0, 0, block_height(h_left-1, _block_height)-2*vertical_skin]) {
                        left_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l_left, w=w_left, h=h_left, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                    }
                }

                translate([block_width(l_left), 0, 0]) {
                    intersection() {
                        translate([block_width(-0.5), block_width(-0.5)+horizontal_skin, 0]) {
                            center_section_rounding(h_left=h_left, h_right=h_right, l_center=l_center, w_center=w_center, h_center=h_center, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                        }
                        
                        for (i=[0:1:h_center-1]) {
                            translate([0, block_width(-0.5+w_center)-horizontal_skin, block_width(0.5+i)-vertical_skin]) {
                                rotate([90, 0, 0]) {
                                    square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l_center, w=1, h=w_center, side_holes=side_holes, horizontal_skin=0, vertical_skin=horizontal_skin);
                                }
                            }
                        }
                    }

                    if (h_right>0) {
                        translate([block_width(l_center), 0, 0]) {
                            right_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l_right, w=w_right, h=h_right, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                        }
                    }
                }
            }

            translate([block_width(-0.5), block_width(-0.5), 0]) {
                h_max=max(h_left, max(h_center, h_right));

                cut_space(material=material, large_nozzle=large_nozzle, w=l_left+l_center+l_right, l=l_left+l_center+l_right, cut_line=cut_line, h=h_max, block_height=_block_height, knob_height=0, skin=horizontal_skin);
            }
        }
    }
}


module center_section_rounding(h_left, h_right, l_center, w_center, h_center, horizontal_skin, vertical_skin) {
    
    assert(h_left!=undef);
    assert(h_right!=undef);
    assert(l_center!=undef);
    assert(w_center!=undef);
    assert(h_center!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    left_h = (h_left<h_center) ? 0.1 : block_width(h_center)-2*vertical_skin; 
    right_h = (h_right<h_center) ? 0.1 : block_width(h_center)-2*vertical_skin; 
    
    hull() {
        cube([_defeather, block_width(w_center)-2*horizontal_skin, left_h]);    
        
        translate([block_width(l_center)-_defeather, 0, 0])
            cube([_defeather, block_width(w_center)-2*  horizontal_skin, right_h]);
        
        translate([block_width(0.5)-2*vertical_skin, 0, block_width(h_center-0.5)])
            rotate([-90, 0, 0])
                cylinder(r=block_width(0.5)-2*vertical_skin, h=block_width(w_center));
        
        translate([block_width(l_center-0.5)+2*vertical_skin, 0, block_width(h_center-0.5)])
            rotate([-90, 0, 0])
                cylinder(r=block_width(0.5)-2*vertical_skin, h=block_width(w_center));
    }
}


module square_end_beam(material, large_nozzle, cut_line=_cut_line, l, w, h, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l+2, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }

       beam_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, horizontal_skin=0, vertical_skin=vertical_skin);
    }
}


module right_square_end_beam(material, large_nozzle, cut_line=_cut_line, l, w, h, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l+1, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }

       beam_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, horizontal_skin=0, vertical_skin=0);
    }
}


module left_square_end_beam(material, large_nozzle, cut_line=_cut_line, l, w, h, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    translate([block_width(l-1), 0, block_width()]) {
        rotate([0, 180, 0]) {
            right_square_end_beam(material=material, large_nozzle=large_nozzle,cut_line=cut_line, l=l, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }
    }
}


module beam_space(material, large_nozzle, l, w, h, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    translate([block_width(-0.5)+horizontal_skin, block_width(-0.5)+horizontal_skin, 0]) {
        cube([block_width(l)-2*horizontal_skin, block_width(w)-2*horizontal_skin, block_width(h)-2*vertical_skin]);
    }
}
