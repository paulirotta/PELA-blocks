/*
PELA Electronic Speed Controller (ESC) Mount - 3D Printed LEGO-compatible holder for servo drive motor electronics

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
_l = 6; // [1:1:30]

// Beam width [blocks]
_w = 4; // [1:1:30]

// Beam height [blocks]
_h = 1; // [1:1:30]

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]


/* [ESC Size] */

// Speed controller cutout space length [mm]
_length = 30.3;; // [0.1:.1:200]

// Speed controller cutout space width [mm]
_width = 25.7;; // [0.1:.1:200]

// Speed controller cutout space height [mm]
_height = 6.0; // [0:0.02:200]



///////////////////////////////
// DISPLAY
///////////////////////////////

square_servo_end_mount(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, side_holes=_side_holes, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, length=_length, width=_width, height=_height);


///////////////////////////////////
// MODULES
///////////////////////////////////

module square_servo_end_mount(material, large_nozzle, cut_line=_cut_line, l, w, h, end_hole_count, side_holes, horizontal_skin, vertical_skin, length, width, height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(height!=undef);

    difference() {

    technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);

    x = (block_width(l-1)-length)/2;
    y = (block_width(w-1)-width)/2;
    z = (block_width(h)-height);
    # color("red") translate([x, y, z])
        cube([length, width, height]);
    }
}
