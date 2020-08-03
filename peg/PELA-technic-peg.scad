/*
PELA Parametric LEGO-compatible Technic Connector Peg

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

/* [Technic Peg] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// An axle which fits loosely in a technic bearing hole
_axle_radius = 2.2; // [0.1:0.01:4]

// Size of the hollow inside a pin
_peg_center_radius=0.7; // [0.1:0.1:4]

// Size of the connector lock-in bump at the ends of a Pin
_peg_tip_length = 0.7; // [0.1:0.1:4]

// Width of the long vertical flexture slots in the side of a pin
_peg_slot_thickness = 0.4; // [0.1:0.1:4]





///////////////////////////////
// DISPLAY
///////////////////////////////

peg(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, axle_radius=_axle_radius, peg_center_radius=_peg_center_radius, peg_length=_peg_length, peg_tip_length=_peg_tip_length, peg_slot_thickness=_peg_slot_thickness);



//////////////////
// Functions
//////////////////

function technic_peg_length(peg_tip_length, peg_length, counterbore_holder_height) = (peg_length + peg_tip_length)*2 + counterbore_holder_height;

function cb_holder_height(counterbore_inset_depth, skin) = (counterbore_inset_depth-skin)*2;

function cb_holder_radius(counterbore_inset_radius, skin) = counterbore_inset_radius - skin;


//////////////////
// MODULES
//////////////////

// A connector pin between two sockets
module peg(material, large_nozzle, cut_line, axle_radius, peg_center_radius, peg_length, peg_tip_length, peg_slot_thickness) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(axle_radius!=undef);
    assert(peg_center_radius < axle_radius, "Technic pin center radius must be less than axle radius");
    assert(peg_length > 0);
    assert(peg_tip_length!=undef);
    assert(peg_slot_thickness!=undef);
    
    counterbore_holder_height = cb_holder_height(_counterbore_inset_depth, _skin);

    counterbore_holder_radius = cb_holder_radius(_counterbore_inset_radius, _skin);

    length = technic_peg_length(peg_tip_length=peg_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    slot_length=3*length/5;

    difference() {
        translate([0, 0, -length/2]) {
            rotate([0, 0, 90]) {
                difference() {
                    union() {
                        cylinder(r=axle_radius, h=length);
                        
                        translate([0, 0, peg_length+peg_tip_length]) {
                            cylinder(r=counterbore_holder_radius, h=counterbore_holder_height);
                        }
                        
                        tip(material=material, large_nozzle=large_nozzle, axle_radius=axle_radius, peg_tip_length=peg_tip_length);
                        
                        translate([0, 0, length-peg_tip_length]) {
                            tip(material=material, large_nozzle=large_nozzle, axle_radius=axle_radius, peg_tip_length=peg_tip_length);
                        }
                    }
                    
                    union() {
                        translate([0, 0, -_defeather]) {
                            if (peg_center_radius>0) {
                                cylinder(r=peg_center_radius, h=length+2*_defeather);
                            }
                        }

                        translate([0, 0, peg_slot_thickness]) {
                            rounded_slot(material=material, large_nozzle=large_nozzle, thickness=peg_slot_thickness, slot_length=slot_length);
                        }
                        
                        translate([0, 0, length-peg_slot_thickness]) {
                            rounded_slot(material=material, large_nozzle=large_nozzle, thickness=peg_slot_thickness, slot_length=slot_length);
                        }
                        
                        translate([0, 0, length/2]) {
                            rotate([0, 0, 90]) {
                                rounded_slot(material=material, large_nozzle=large_nozzle, thickness=peg_slot_thickness, slot_length=slot_length);
                            }
                        }

                        translate([-block_width(), -counterbore_holder_radius, 0]) {
                            cut_space(material=material, large_nozzle=large_nozzle, l=1, w=1, cut_line=cut_line, h=4, block_height=_block_height, knob_height=_knob_height, skin=0);
                        }
                    }
                }
            }
        }
    }
}


module axle_cross_negative_space(material, large_nozzle, axle_rounding, axle_radius, length) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(axle_rounding!=undef);
    assert(axle_radius!=undef);
    assert(length!=undef);

    for (rot=[0:90:270]) {
        rotate([0, 0, rot]) {
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -_defeather]) {
                    cylinder(r=axle_rounding, h=length+2*_defeather);

                    translate([axle_radius, 0, 0])
                        cylinder(r=axle_rounding, h=length+2*_defeather);

                    translate([0, axle_radius, 0])
                        cylinder(r=axle_rounding, h=length+2*_defeather);
                }
            }
        }
    }
}


// An end ridge to allow a Pin to lock in to a Technic-compatible block
module tip(material, large_nozzle, axle_radius, peg_tip_length) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(axle_radius!=undef);
    assert(peg_tip_length!=undef);
    
    rounded_disc(material=material, large_nozzle=large_nozzle, radius=axle_radius+peg_tip_length, thickness=peg_tip_length);
}


// A disc with rounded outer edge for pin tips
module rounded_disc(material, large_nozzle, radius, thickness) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(radius!=undef);
    assert(thickness!=undef);

    translate([0, 0, thickness/2])
        minkowski() {
            cylinder(r=radius-thickness, h=_defeather);
        
            sphere(r=thickness/2, $fn=16);
        }
}


// Side flexture slot with easement holes at each end
module rounded_slot(material, large_nozzle, thickness, slot_length) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(thickness!=undef);
    assert(slot_length!=undef);

    width = 10;
    
    if (thickness>0) { 
        hull() {
            translate([-width/2, 0, slot_length/2 - thickness]) {
                rotate([0, 90, 0]) {
                    cylinder(r=thickness/2, h=width);
                }
            }
            
            translate([-width/2, 0, -slot_length/2 + thickness]) {
                rotate([0, 90, 0]) {
                    cylinder(r=thickness/2, h=width);
                }
            }
        }
    
        circle_to_slot_ratio = 1.1;
    
        translate([-width/2, 0, slot_length/2 - thickness]) {
            rotate([0, 90, 0]) {
                cylinder(r=thickness/circle_to_slot_ratio, h=width);
            }
        }
            
        translate([-width/2, 0, -slot_length/2 + thickness]) {
            rotate([0, 90, 0]) {
                cylinder(r=thickness/circle_to_slot_ratio, h=width);
            }
        }
    }
}


// The cylindrical space which fully encloses one peg
module peg_envelope(material, large_nozzle, length, counterbore_holder_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(length>=0);
    assert(counterbore_holder_radius>=0);

    cylinder(r=counterbore_holder_radius, h=length);
}
