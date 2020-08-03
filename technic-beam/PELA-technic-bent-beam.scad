/*
PELA Technic Bent Beam - 3D Printed LEGO-compatible beam with an angle

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


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Corner] */

// Length of the first beam [blocks]
_l1 = 4; // [1:20]

// Length of the second beam [blocks]
_l2 = 6; // [1:20]

// Beam width [blocks]
_w = 1; // [1:1:30]

// Left beam height [blocks]
_h1 = 1; // [1:1:30]

// Right beam height [blocks]
_h2 = 1; // [1:1:30]

// Angle between the two beams
_angle = 30; // [0:180]


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

bent_beam(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l1=_l1, l2=_l2, angle=_angle, w=_w, h1=_h1, h2=_h2, side_holes=_side_holes, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin);




///////////////////////////////////
// MODULES
///////////////////////////////////

module bent_beam(material, large_nozzle, cut_line=_cut_line, l1, l2, angle, w, h1, h2, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l1!=undef);
    assert(l2!=undef);
    assert(w!=undef);
    assert(angle >= 0, "Angle must be at least 180 degrees");
    assert(angle <= 180, "Angle must be at most 360 degrees");
    assert(h1!=undef);
    assert(h2!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    
    rotate([90, 0, 0]) {
        difference() {
            union() {
                translate([block_width(0.5), 0, 0]) {
                    right_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l1, w=w, h=h1, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                }

                rotate([0, 180-angle, 0]) {
                    translate([block_width(0.5), 0, block_height(-1, _block_height)]) {
                        translate([0, 0, block_width(-h2+1)+2*vertical_skin]) {
                            right_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l2, w=w, h=h2, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                        }

                        if (angle < 180) translate([block_width(-0.5), horizontal_skin,  block_width(1)]) {
                            increment = 1;
                            for (n = [0:increment:angle]) {
                                rotate([0, 90+n, 0]) {
                                    hull() {
                                        translate([0, block_width(-0.5), 0]) {
                                            cube([block_width(1)-2*vertical_skin, block_width(w)-2*horizontal_skin, _defeather]);

                                            rotate([0, increment, 0]) {
                                                cube([block_width(1)-2*vertical_skin, block_width(w)-2*horizontal_skin, _defeather]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            translate([block_width(-0.5) - cos(angle)*block_width(h2+2), block_width(-0.5), 0]) {
                cut_space(material=material, large_nozzle=large_nozzle, w=w, l=l1+l2+h2, cut_line=cut_line, h=max(h1, h2), block_height=_block_height, knob_height=0, skin=horizontal_skin);
            }
        }
    }
}