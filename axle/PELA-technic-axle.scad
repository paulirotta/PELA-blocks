/*
PELA Parametric LEGO-compatible Technic Axle

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:0.5:5]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Axle] */

// Axle length [blocks]
_l = 3; // [1:1:20]

// An axle which fits loosely in a technic bearing hole [mm]
_axle_radius = 2.2; // [0.2:0.1:3.9]

// Size of the hollow inside an axle [mm]
_center_radius = 1.1; // [0.0:0.1:3.8]


/* [Technic Axle] */
_defeather = 0.001;


///////////////////////////////
// DISPLAY
///////////////////////////////

axle(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, axle_radius=_axle_radius, center_radius=_center_radius);
  



/////////////////////////////////////
// MODULES
/////////////////////////////////////

module axle(material, large_nozzle, cut_line=_cut_line, l, axle_radius, center_radius) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l>=0);
    assert(axle_radius>=0);
    assert(center_radius>=0);

    axle_length = block_width(l);

    difference() {
        cylinder(r=axle_radius, h=axle_length);

        union() {
            translate([0, 0, -_defeather]) {
                if (center_radius > 0 && axle_length > 0)
                    cylinder(r=center_radius, h=axle_length + 2*_defeather);
            }

            translate([-axle_radius, -axle_radius, 0]) {
                cut_space(material=material, large_nozzle=large_nozzle, l=l, w=1, cut_line=cut_line, h=l, block_height=_block_height, knob_height=_knob_height, skin=0);
            }
        }
    }
}
