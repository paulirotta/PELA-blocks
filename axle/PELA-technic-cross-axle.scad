/*
Parametric PELA LEGO-compatible technic cross-shaped rotational drive Axle

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

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
use <PELA-technic-axle.scad>


/* [Render] */

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Cross Axle] */

// Axle length [blocks]
_l = 3; // [1:1:20]

// Outside radius of an axle which fits loosely in a technic bearing hole [mm]
_axle_radius = 2.2; // [0.1:1:20]

// Size of the axle solid center before rounding [mm]
_center_radius = 0.73; // [0.1:0.01:4]

// Cross axle inside rounding radius [mm]
_axle_rounding = 0.63; // [0.2:0.01:4.0]



///////////////////////////////
// DISPLAY
///////////////////////////////


cross_axle(material=_material, large_nozzle=_large_nozzle, l=_l, axle_rounding=_axle_rounding, axle_radius=_axle_radius, center_radius=_center_radius);
    




/////////////////////////////////////
// MODULES
/////////////////////////////////////

module cross_axle(material, large_nozzle, l, axle_rounding, axle_radius, center_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(axle_rounding!=undef);
    assert(axle_radius!=undef);
    assert(center_radius!=undef);

    axle_length = block_width(l);

    rotate([90, 45, 0]) {
        difference() {
            axle(material=material, cut_line=0, large_nozzle=large_nozzle, l=l, axle_radius=axle_radius, center_radius=0);
            
            axle_cross_negative_space(material=material, large_nozzle=large_nozzle, axle_length=axle_length, axle_rounding=axle_rounding, axle_radius=axle_radius);
        }
    }
}


// That which is cut away four times from a solid to create a cross axle
module axle_cross_negative_space(material, large_nozzle, axle_length, axle_rounding, axle_radius) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(axle_length!=undef);
    assert(axle_rounding!=undef);
    assert(axle_radius!=undef);

    for (rot=[0:90:270]) {
        rotate([0, 0, rot]) {
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -_defeather]) {
                    cylinder(r=axle_rounding, h=axle_length+2*_defeather);

                    translate([axle_radius, 0, 0]) {
                        cylinder(r=axle_rounding, h=axle_length+2*_defeather);
                    }

                    translate([0, axle_radius, 0]) {
                        cylinder(r=axle_rounding, h=axle_length+2*_defeather);
                    }
                }
            }
        }
    }
}
