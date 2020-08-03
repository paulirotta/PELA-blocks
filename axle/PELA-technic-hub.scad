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
use <PELA-technic-cross-axle.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:0.5:5]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 9; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = false;


/* [Technic Cross Axle Hub] */

// Axle length [blocks]
_hub_l = 1; // [1:1:20]

// The cylinder surrounding the axle hole [mm]
_hub_radius = 4; // [0.2:0.1:3.9]

// Outside radius of an axle which fits loosely in a technic bearing hole [mm]
_axle_radius = 2.3; // [0.1:1:20]

// Size of the axle solid center before rounding [mm]
_center_radius = 0.83; // [0.1:0.01:4]

// Cross axle inside rounding radius [mm]
_axle_rounding = 0.73; // [0.2:0.01:4.0]



///////////////////////////////
// DISPLAY
///////////////////////////////

hub(material=_material, large_nozzle=_large_nozzle, hub_l=_hub_l, hub_radius=_hub_radius, axle_rounding=_axle_rounding, axle_radius=_axle_radius, center_radius=_center_radius);
  



/////////////////////////////////////
// MODULES
/////////////////////////////////////

module hub(material, large_nozzle, hub_l, hub_radius, axle_rounding=_axle_rounding, axle_radius, center_radius) {
    
    echo("hub_radius: ", hub_radius);

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(hub_l!=undef);
    assert(hub_radius!=undef);
    assert(axle_radius!=undef);
    assert(center_radius!=undef);

    axle_length = block_width(hub_l);

    difference() {
        cylinder(r=hub_radius, h=axle_length-_defeather);

        translate([0, 0, -_defeather]) {
            rotate([-90, 0, 0]) {
                cross_axle(material=material, large_nozzle=large_nozzle, l=2*hub_l, axle_rounding=axle_rounding, axle_radius=axle_radius, center_radius=center_radius);
            }
        }
    }
}
