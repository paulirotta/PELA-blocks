/*
PELA Parametric LEGO-compatible Technic Connector Peg Set

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
use <PELA-technic-peg.scad>
use <PELA-simplified-technic-peg.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Create the simplified model (note: specifying a flex material changes the shape)
_simplified = true;


/* [Technic Peg] */

// An axle which fits loosely in a technic bearing hole
_axle_radius = 2.19; // [0.1:0.1:4]

// Size of the hollow inside a peg
_peg_center_radius = 0.7; // [0:0.1:4]

// Size of the connector lock-in bump at the ends of a Pin
_peg_tip_length = 0.7; // [0.1:0.1:4]

// Width of the long vertical flexture slots in the side of a peg
_peg_slot_thickness = 0.4; // [0.1:0.1:4]


/* [Technic Pin Array] */

// The number of half-pegs in an array supported by as base
_array_count = 2; // [2:1:20]

 // The thickness of the base below an array of half-pegs
 _base_thickness = 4; // [0:0.1:20]

// Distance between pegs
_array_spacing = 8;

// Trim the base connecting a peg array to the minimum rounded shape
_minimum_base = true;


/* [Simplified Peg] */
// Size of the flat bottom cut to make the peg more easily printable
_bottom_flatness = 0.2; // [0.0:0.1:5]

// Size of the end angle cuts to ease tip flex
_end_cut_length = 6; // [0.0:0.1:10]

/* [Hidden] */
_skin = 0.1;


///////////////////////////////
// DISPLAY
///////////////////////////////
technic_peg_array(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, simplified=_simplified, peg_tip_length=_peg_tip_length, peg_length=_peg_length, array_count=_array_count, array_spacing=_array_spacing, base_thichness=_base_thickness, axle_radius=_axle_radius, peg_center_radius=_peg_center_radius, peg_slot_thickness=_peg_slot_thickness, minimum_base=_minimum_base, base_thickness=_base_thickness, block_height=_block_height,  bottom_flatness=_bottom_flatness, end_cut_length=_end_cut_length, skin=_skin);

module technic_peg_array(material, large_nozzle, cut_line, simplified, peg_tip_length, peg_length, array_count, array_spacing, base_thichness, axle_radius, peg_center_radius, peg_slot_thickness, minimum_base, base_thickness, block_height, bottom_flatness, end_cut_length, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(simplified!=undef);
    assert(peg_tip_length!=undef);
    assert(peg_length!=undef);
    assert(array_count!=undef);
    assert(array_spacing!=undef);
    assert(base_thichness!=undef);
    assert(axle_radius!=undef);
    assert(peg_center_radius!=undef);
    assert(peg_slot_thickness!=undef);
    assert(minimum_base!=undef);
    assert(base_thickness!=undef);
    assert(block_height!=undef);
    assert(bottom_flatness!=undef);
    assert(end_cut_length!=undef);
    assert(skin!=undef);

    counterbore_holder_height = cb_holder_height(_counterbore_inset_depth, _skin);

    counterbore_holder_radius = cb_holder_radius(_counterbore_inset_radius, _skin);

    x_rotation = simplified ? 90 : 0;

    rotate([x_rotation, 0, 0]) {
        peg_array(material=material, large_nozzle=large_nozzle, cut_line=cut_line, simplified=_simplified, array_count=array_count, array_spacing=_array_spacing, base_thichness=base_thickness, axle_radius=axle_radius, peg_center_radius=peg_center_radius, peg_length=peg_length, peg_tip_length=peg_tip_length, peg_slot_thickness=peg_slot_thickness, minimum_base=minimum_base, base_thickness=base_thickness, block_height=block_height, counterbore_holder_radius=counterbore_holder_radius, counterbore_holder_height=counterbore_holder_height, bottom_flatness=bottom_flatness, end_cut_length=end_cut_length, skin=skin);
    }
}




// A set of half-pegs connected by at the base
module peg_array(material, large_nozzle, cut_line, simplified, array_count, array_spacing, base_thichness, axle_radius, peg_center_radius, peg_length, peg_tip_length, peg_slot_thickness, minimum_base, base_thickness, block_height, counterbore_holder_radius, counterbore_holder_height, bottom_flatness, end_cut_length, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(simplified!=undef);
    assert(array_count!=undef);
    assert(array_spacing!=undef);
    assert(base_thichness!=undef);
    assert(axle_radius!=undef);
    assert(peg_center_radius!=undef);
    assert(peg_length!=undef);
    assert(peg_tip_length!=undef);
    assert(peg_slot_thickness!=undef);
    assert(minimum_base!=undef);
    assert(base_thickness!=undef);
    assert(block_height!=undef);
    assert(counterbore_holder_radius!=undef);
    assert(counterbore_holder_height!=undef);
    assert(bottom_flatness!=undef);
    assert(end_cut_length!=undef);
    assert(skin!=undef);

    length = technic_peg_length(peg_tip_length=peg_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);
    assert(length!=undef);

    difference() {
        intersection() {
            translate([block_width(1/2), block_width(1/2), base_thickness]) {
                difference() {
                    for (i = [0 : array_count-1]) {
                        translate([i*array_spacing, 0, 0]) {
                            if (simplified) {
                                rotate([0, 90, 90]) {
                                    simplified_peg(material=material, large_nozzle=large_nozzle, cut_line=cut_line, axle_radius=axle_radius, peg_center_radius=peg_center_radius, peg_length=peg_length, peg_tip_length=peg_tip_length, peg_slot_thickness=0, bottom_flatness=bottom_flatness, end_cut_length=end_cut_length);
                                }
                            } else {
                                peg(material=material, large_nozzle=large_nozzle, cut_line=cut_line, axle_radius=axle_radius, peg_center_radius=peg_center_radius, peg_length=peg_length, peg_tip_length=peg_tip_length, peg_slot_thickness=peg_slot_thickness);
                            }
                        }
                    }
                    
                    translate([-block_width(), -block_width(), -block_height(1, block_height=block_height)-skin]) {
                        cube([block_width(array_count+1), block_width(2), block_height(1, block_height=block_height)]);
                    }
                }
                
                peg_base(material=material, large_nozzle=large_nozzle, length=length, array_count=array_count, array_spacing=array_spacing, base_thickness=base_thickness, minimum_base=minimum_base, peg_length=peg_length, axle_radius=axle_radius, peg_slot_thickness=peg_slot_thickness, simplified=simplified, bottom_flatness=bottom_flatness, skin=skin);
            }

            if (minimum_base) {
                translate([0, block_width(1/2), 0]) {
                    peg_array_envelope(material=material, large_nozzle=large_nozzle, length=length, array_count=array_count, array_spacing=array_spacing, peg_length=peg_length, peg_tip_length=peg_tip_length, counterbore_holder_radius=counterbore_holder_radius, counterbore_holder_height=counterbore_holder_height);
                }
            } else {
                cube([block_width(array_count), block_width(), length]);
            }
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=4, w=1, cut_line=cut_line, h=2, block_height=block_height, knob_height=_knob_height, skin=skin);
    }
}


// The rounded space which just encloses the peg array but not the rest of the array base
module peg_array_envelope(material, large_nozzle, length, array_count, array_spacing, peg_length, peg_tip_length, counterbore_holder_radius, counterbore_holder_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(length!=undef);
    assert(array_count!=undef);
    assert(array_spacing!=undef);
    assert(peg_length!=undef);
    assert(peg_tip_length!=undef);
    assert(counterbore_holder_radius!=undef);
    assert(counterbore_holder_height!=undef);

    length = technic_peg_length(peg_tip_length=peg_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    translate([block_width(0.5), 0, 0]) {
        hull() {
            peg_envelope(material=material, large_nozzle=large_nozzle, length=length, counterbore_holder_radius=counterbore_holder_radius);

            translate([(array_count-1)*array_spacing, 0, 0]) {
                peg_envelope(material=material, large_nozzle=large_nozzle, length=length, counterbore_holder_radius=counterbore_holder_radius);
            }
        }
    }
}


// The connector between pegs in an array
module peg_base(material, large_nozzle, length, array_count, array_spacing, base_thickness, minimum_base, peg_length, axle_radius, peg_slot_thickness, simplified, bottom_flatness, skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(length!=undef);
    assert(array_count!=undef);
    assert(array_spacing!=undef);
    assert(base_thickness!=undef);
    assert(minimum_base!=undef);
    assert(peg_length!=undef);
    assert(axle_radius!=undef);
    assert(peg_slot_thickness!=undef);
    assert(simplified!=undef);
    assert(bottom_flatness!=undef);
    assert(skin!=undef);
    
    translate([-block_width(1/2), -block_width(1/2), -base_thickness-skin]) {
        difference() {
            cube([array_count*array_spacing, block_width(1), base_thickness]);
        
            if (simplified) {
                translate([0, block_width(-0.5), 0]) {
                    cube([array_count*array_spacing, block_width() - axle_radius + bottom_flatness, base_thickness+_defeather]);
                }
            } else {
                translate([0, block_width(0,5)- peg_slot_thickness/2, 0]) {
                cube([array_count*array_spacing, peg_slot_thickness, base_thickness]);
                }
            }
        }
    }
}

