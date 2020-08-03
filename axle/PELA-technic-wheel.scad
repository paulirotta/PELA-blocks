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
use <PELA-technic-hub.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:0.5:5]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = false;

// Make the wheel, or make a disc plate which can fit on the same hub
_render_part = 0; // [0:Wheel and hub, 1:Wheel plate]


/* [Wheel Plate] */

// The cylinder surrounding the axle hole [mm]
_plate_diameter = 52; // [0.2:0.1:200]

// The cylinder surrounding the axle hole [mm]
_plate_thickness = 1; // [0.1:0.1:200]




/* [Wheel] */

// Wheel side
_wheel_side = -1; // [1:Right, -1:Left]

// The number of facets to approximate a spoke curve
_count=128; // [1:1:256]

// The wheel outside diameter [mm]
_spoke_count=8; // [1:1:20]

// The wheel outside diameter [mm]
_wheel_diameter = 50; // [0.2:0.1:200]

// The wheel tread width [mm]
_wheel_width = 38; // [0.2:0.1:200]

// The rim thickness [mm]
_wheel_thickness = 3; // [0.2:0.1:200]

// The cylinder surrounding the axle hole [mm]
_spoke_twist = 90; // [0:1:360]


/* [Technic Hub] */

// Axle length [blocks]
_hub_l = 2; // [1:1:20]

// The cylinder surrounding the axle hole [mm]
_hub_radius = 4; // [0.2:0.1:3.9]

_hub_width = 4; // [0.2:0.1:3.9]

// Outside radius of an axle which fits loosely in a technic bearing hole [mm]
_axle_radius = 2.2; // [0.1:1:20]

// Size of the axle solid center before rounding [mm]
_center_radius = 0.73; // [0.1:0.01:4]

// Cross axle inside rounding radius [mm]
_axle_rounding = 0.63; // [0.2:0.01:4.0]



///////////////////////////////
// DISPLAY
///////////////////////////////

wheel_and_hub(material=_material, large_nozzle=_large_nozzle, render_part=_render_part, hub_l=_hub_l, hub_radius=_hub_radius, hub_width=_hub_width, axle_rounding=_axle_rounding, axle_radius=_axle_radius, center_radius=_center_radius, wheel_side=_wheel_side, count=_count, spoke_count=_spoke_count, spoke_twist=_spoke_twist, wheel_diameter=_wheel_diameter, wheel_width=_wheel_width, wheel_thickness=_wheel_thickness, plate_diameter=_plate_diameter, plate_thickness=_plate_thickness);
  


/////////////////////////////////////
// MODULES
/////////////////////////////////////

module wheel_and_hub(material, large_nozzle, render_part, hub_l, hub_radius, hub_width, axle_rounding, axle_radius, center_radius, wheel_side, count, spoke_twist, wheel_side, spoke_count, wheel_diameter, wheel_width, wheel_thickness, plate_diameter, plate_thickness) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(hub_l!=undef);
    assert(render_part!=undef);
    assert(hub_radius!=undef);
    assert(axle_radius!=undef);
    assert(center_radius!=undef);
    assert(wheel_side!=undef);
    assert(count!=undef);
    assert(spoke_count!=undef);
    assert(wheel_diameter!=undef);
    assert(wheel_width!=undef);
    assert(wheel_thickness!=undef);
    assert(plate_diameter!=undef);
    assert(plate_thickness!=undef);

    if (render_part == 0) {
        difference() {
            wheel(wheel_side=wheel_side, count=count, spoke_count=spoke_count, spoke_twist=spoke_twist, wheel_diameter=wheel_diameter, wheel_width=wheel_width, wheel_thickness=wheel_thickness, hub_width=hub_width, hub_l=hub_l);

            union () {
                hull() {
                    hub(material=material, large_nozzle=large_nozzle, hub_l=hub_l, hub_radius=hub_radius, axle_rounding=axle_rounding, axle_radius=axle_radius, center_radius=center_radius);
                }
                
                rotate([-90, 0, 0]) {
                    cross_axle(material=material, large_nozzle=large_nozzle, l=2*hub_l, axle_rounding=axle_rounding, axle_radius=axle_radius, center_radius=center_radius);
                }
            }
        }
    } else {
        difference() {
            cylinder(d=plate_diameter, h=plate_thickness, $fn=256);
            
            cylinder(r=hub_radius, h=plate_thickness*2);
        }
    }

    hub(material=material, large_nozzle=large_nozzle, hub_l=hub_l, hub_radius=hub_radius, axle_rounding=axle_rounding, axle_radius=axle_radius, center_radius=center_radius);
}


module wheel(wheel_side, count, spoke_count, spoke_twist, wheel_diameter, wheel_width, wheel_thickness, hub_width, hub_l) {

    assert(wheel_side!=undef);
    assert(count!=undef);
    assert(spoke_count!=undef);
    assert(wheel_diameter!=undef);
    assert(wheel_width!=undef);
    assert(wheel_thickness!=undef);
    assert(hub_width!=undef);
    assert(hub_l!=undef);

    spoke_diameter = wheel_diameter-wheel_thickness;
    spoke_width = 2;

    difference() {
        cylinder(d=wheel_diameter, h=wheel_width, $fn=256);

        translate([0, 0, -_defeather]) {
            cylinder(d=wheel_diameter-wheel_thickness, h=wheel_width+2*_skin);
        }
    }

    spoke_set(wheel_side=wheel_side, count=count, spoke_count=spoke_count, spoke_twist=spoke_twist, spoke_diameter=spoke_diameter, spoke_width=spoke_width, wheel_width=wheel_width, hub_width=hub_width, hub_l=hub_l);
}


module spoke_set(wheel_side, count, spoke_count, spoke_twist, spoke_diameter, spoke_width, wheel_width, hub_width, hub_l) {

    assert(count!=undef);
    assert(wheel_side!=undef);
    assert(spoke_count!=undef);
    assert(spoke_twist!=undef);
    assert(spoke_diameter!=undef);
    assert(spoke_width!=undef);
    assert(wheel_width!=undef);
    assert(hub_width!=undef);
    assert(hub_l!=undef);

    increment = 360/spoke_count;

    for (spoke_angle=[0:increment:360-increment]) {
        spoke(wheel_side=wheel_side, count=count, spoke_angle=spoke_angle, spoke_twist=spoke_twist, spoke_diameter=spoke_diameter, spoke_width=spoke_width, wheel_width=wheel_width, hub_width=hub_width, hub_l=hub_l);
    }
}


module spoke(wheel_side, count, spoke_angle, spoke_twist, spoke_diameter, spoke_width, wheel_width, hub_width, hub_l) {

    assert(wheel_side!=undef);
    assert(count!=undef);
    assert(spoke_angle!=undef);
    assert(spoke_twist!=undef);
    assert(spoke_diameter!=undef);
    assert(spoke_width!=undef);
    assert(wheel_width!=undef);
    assert(hub_width!=undef);
    assert(hub_l!=undef);

    diameter_increment = spoke_diameter/(2*count);
    spoke_increment = spoke_twist/count;
    height_increment = (wheel_width-block_width(hub_l))/count;

    for (i=[0:count-1]) {
        j = i+1;
        angle1 = spoke_angle + spoke_increment*i*wheel_side;
        angle2 = spoke_angle + spoke_increment*j*wheel_side;
        x1 = diameter_increment*i;
        x2 = diameter_increment*j;
        z1 = block_width(hub_l) + height_increment*i;
        z2 = block_width(hub_l) + height_increment*j;
        hull() {
            rotate([0, 0, angle1]) {
                translate([x1, 0 , 0]) {
                    cube([_defeather, spoke_width, z1]);
                }
            }
            rotate([0, 0, angle2]) {
                translate([x2, 0 , 0]) {
                    cube([_defeather, spoke_width, z2]);
                }
            }
        }
    }
}
