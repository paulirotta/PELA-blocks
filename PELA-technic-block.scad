/*
PELA Parametric Block with LEGO-compatible technic connectors and air vents

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

Import this into other design files:
    include <style.scad>
    use <technic.scad>
    
All modules have sensible defaults derived from <style.scad>. 
You can ignore values you are not tampering with and only need to pass a
parameter if you are overriding.

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <style.scad>
include <material.scad>
use <PELA-block.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Block] */

// Model length [blocks]
_l = 4; // [1:1:30]

// Model width [blocks]
_w = 2; // [1:1:30]

// Model height [blocks]
_h = 1; // [1:1:30]


/* [Block Features] */

// Presence of bottom connector sockets
_sockets = true;

// Presence of top connector knobs
_knobs = true;

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional knobs]

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Add short end holes spaced along the width for techic connectors
_end_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]


/* [Advanced] */

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
_bolt_hole_radius = 1.6; // [0.0:0.1:2.0]

// Add a wrapper around side holes (disable for extra ventilation but loose lock notches)
_side_sheaths = true;

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
_end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well
_knob_vent_radius = 0; // [0.0:0.1:3.9]

// Add interior fill for upper layers
_solid_upper_layers = true;

// Add interior fill for the base layer
_solid_first_layer = false;

// Width of a line etched in the side of multi-layer block sets (0 to disable)
_ridge_width = 0.15; // [0.1:0.05:4]

// Depth of a line etched in the side of multi-layer block sets
_ridge_depth = 0.3; // [0.1:0.05:4]



/////////////////////////////////////
// DISPLAY
/////////////////////////////////////

PELA_technic_block(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, knob_height=_knob_height, knob_flexture_height=_knob_flexture_height, sockets=_sockets, socket_insert_bevel=_socket_insert_bevel, knobs=_knobs, knob_vent_radius=_knob_vent_radius, skin=_skin, top_shell=_top_shell, bottom_stiffener_width=_bottom_stiffener_width, bottom_stiffener_height=_bottom_stiffener_height, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius, ridge_width=_ridge_width, ridge_depth=_ridge_depth, solid_upper_layers=_solid_upper_layers, top_vents=_top_vents, side_holes=_side_holes, side_sheaths=_side_sheaths, end_holes=_end_holes, end_sheaths=_end_sheaths, solid_first_layer=_solid_first_layer, block_height=_block_height, bottom_tweak=undef, top_tweak=undef, axle_hole_tweak=undef);


/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Indicates a solid cylinder around side hole connectors
function is_side_sheaths(side_sheaths=undef, side_holes=undef) = side_sheaths && side_holes > 1;

// Indicates a solid cylinder around end hole connectors
function is_end_sheaths(end_sheaths=undef, end_holes=undef) = end_holes > 1 && end_sheaths;

// Find the optimum enclosing horizontal dimension in block units
function fit_mm_to_blocks(i=undef, padding=undef) = ceil((i + block_width(padding+1))/block_width(1));

// Find the optimum enclosing vertical dimension in block units
function fit_mm_to_height_blocks(i=undef, padding=undef, block_height=undef) = ceil((i + block_height(padding+1, block_height=block_height))/block_height);




///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_technic_block(material, large_nozzle, cut_line, l, w, h, knob_height, knob_flexture_height=_knob_flexture_height, sockets, socket_insert_bevel=_socket_insert_bevel, knobs, knob_vent_radius, skin=_skin, top_shell=_top_shell, bottom_stiffener_width=_bottom_stiffener_width, bottom_stiffener_height=_bottom_stiffener_height, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius, ridge_width=_ridge_width, ridge_depth=_ridge_depth, top_vents, side_holes, side_sheaths, end_holes, end_sheaths, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, block_height, bottom_tweak, top_tweak, axle_hole_tweak) {

    assert(material != undef);
    assert(large_nozzle != undef);
    assert(cut_line != undef);
    assert(l != undef);
    assert(w != undef);
    assert(h != undef);
    assert(knobs != undef);
    assert(knob_height != undef);
    assert(knob_vent_radius != undef);
    assert(knob_flexture_height != undef);
    assert(sockets != undef);
    assert(socket_insert_bevel!=undef);
    assert(skin != undef);
    assert(top_shell != undef);
    assert(bottom_stiffener_width != undef);
    assert(bottom_stiffener_height != undef);
    assert(corner_bolt_holes != undef);
    assert(bolt_hole_radius != undef);
    assert(ridge_width != undef);
    assert(ridge_depth != undef);
    assert(top_vents != undef);
    assert(side_holes != undef);
    assert(side_sheaths != undef);
    assert(end_holes != undef);
    assert(end_sheaths != undef);
    assert(solid_first_layer != undef);
    assert(solid_upper_layers != undef);
    assert(block_height != undef);

    difference() {
        visual_cut_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, knob_height=knob_height, knob_flexture_height=knob_flexture_height, sockets=sockets, socket_insert_bevel=socket_insert_bevel, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, top_shell=top_shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, solid_first_layer=solid_first_layer, block_height=block_height, bottom_tweak=bottom_tweak, top_tweak=top_tweak, axle_hole_tweak=axle_hole_tweak);

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height, skin=skin);
    }
}


module visual_cut_technic_block(material, large_nozzle, cut_line=_cut_line, l, w, h, knob_height, knob_flexture_height, sockets, socket_insert_bevel, knobs, knob_vent_radius, skin, top_shell, bottom_stiffener_width, bottom_stiffener_height, corner_bolt_holes, bolt_hole_radius, ridge_width, ridge_depth, solid_upper_layers, top_vents, side_holes, side_sheaths, end_holes, end_sheaths, solid_first_layer, block_height, bottom_tweak, top_tweak, axle_hole_tweak) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(knob_height!=undef);
    assert(knob_flexture_height!=undef);
    assert(sockets!=undef);
    assert(socket_insert_bevel!=undef);
    assert(knobs!=undef);
    assert(knob_vent_radius!=undef);
    assert(skin!=undef);
    assert(top_shell!=undef);
    assert(bottom_stiffener_width!=undef);
    assert(bottom_stiffener_height!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);
    assert(ridge_width!=undef);
    assert(ridge_depth!=undef);
    assert(solid_upper_layers!=undef);
    assert(top_vents!=undef);
    assert(side_holes!=undef);
    assert(side_sheaths!=undef);
    assert(end_holes!=undef);
    assert(end_sheaths!=undef);
    assert(solid_first_layer!=undef);
    assert(block_height!=undef);

    difference() {
        union() {
            PELA_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, knob_height=knob_height, knob_flexture_height=knob_flexture_height, sockets=sockets, socket_insert_bevel=socket_insert_bevel, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, top_shell=top_shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, solid_first_layer=solid_first_layer, block_height=block_height, bottom_tweak=bottom_tweak, top_tweak=top_tweak);
            
            for (i = [0:h-1]) {
                translate([0, 0, block_height(i, block_height=block_height)]) {
                    if (is_side_sheaths(side_sheaths=side_sheaths, side_holes=side_holes)) {

                        double_side_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, side_holes=side_holes, skin=skin, block_height=block_height);
                    }
                    
                    if (is_end_sheaths(end_sheaths=end_sheaths, end_holes=end_holes)) {

                        double_end_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, end_holes=end_holes, skin=skin, block_height=block_height, peg_length=_peg_length, bearing_sheath_thickness=_bearing_sheath_thickness, axle_hole_tweak=axle_hole_tweak);
                    }
                }
            }
        }
        
        union() {
            if (side_holes || end_holes || top_vents) {
                length = _official_knob_height + skin;
                
                alternate_length = top_vents ? block_height(h+
                _defeather, block_height=block_height) + _defeather : block_height(h-0.5, block_height=block_height);

                bt = override_bottom_tweak(material=material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak);

                double_socket_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, length=length, alternate_length=alternate_length, bevel_socket=true, socket_insert_bevel=_socket_insert_bevel, bottom_tweak=bt);
            }

            ahr = override_axle_hole_radius(material=material, large_nozzle=large_nozzle, axle_hole_tweak=axle_hole_tweak);

            bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, sockets=sockets, skin=skin, block_height=block_height, axle_hole_radius=ahr);
            
            skin(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth, block_height=block_height);
        }
    }
}


// Holes cut into the sides for the block on layer 1 to allow technic pegs and axles to be inserted
module bottom_connector_negative_space(material, large_nozzle, l, w, h, side_holes, end_holes, hole_type, corner_bolt_holes, bolt_hole_radius, sockets, skin, block_height, axle_hole_radius) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(end_holes!=undef);
    assert(hole_type!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);
    assert(sockets!=undef);
    assert(skin!=undef);
    assert(block_height!=undef);
    assert(axle_hole_radius!=undef);

    for (i = [1:h]) {
        translate([0, 0, block_height(i-1, block_height)]) {
            if (side_holes > 0) {
                double_side_connector_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, hole_type=side_holes, block_height=block_height, axle_hole_radius=axle_hole_radius, skin=skin);
            }
            
            if (end_holes > 0) {
                double_end_connector_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, hole_type=end_holes, axle_hole_radius=axle_hole_radius, block_height=block_height, skin=skin);
            }
        }
    }
    
    if (corner_bolt_holes) {
        corner_corner_bolt_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius, block_height=block_height);
    }
}


module double_side_connector_sheath_set(material, large_nozzle, l, w, side_holes, peg_length=_peg_length, bearing_sheath_thickness=_bearing_sheath_thickness, skin, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(side_holes!=undef);
    assert(peg_length!=undef);
    assert(bearing_sheath_thickness!=undef);
    assert(skin!=undef);
    assert(block_height!=undef);

    side_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, side_holes=side_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, skin=skin, block_height=block_height);

    translate([block_width(l), block_width(w)]) {
        rotate([0, 0, 180]) {
            side_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, side_holes=side_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, skin=skin, block_height=block_height);
        }
    }
}


// A row of sheaths surrounding holes along the length
module side_connector_sheath_set(material, large_nozzle, l, w, side_holes, peg_length=_peg_length, bearing_sheath_thickness, skin, block_height, axle_hole_tweak) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(side_holes!=undef);
    assert(peg_length!=undef);
    assert(bearing_sheath_thickness!=undef);
    assert(skin!=undef);
    assert(block_height!=undef);

    sheath_radius = bearing_sheath_thickness + override_axle_hole_radius(material=material, large_nozzle=large_nozzle, axle_hole_tweak=axle_hole_tweak);

    sheath_length = side_holes == 2 ? block_width(w) : block_width(1);
    
    if (l == 1) {
        translate([block_width(0.5), 0, block_height(1, block_height=block_height)-block_width(0.5)]) {
            rotate([-90, 0, 0]) {
                sheath(material=material, large_nozzle=large_nozzle, sheath_radius=sheath_radius, sheath_length=sheath_length, skin=skin);
            }
        }
    } else {
        for (i = [1:l-1]) {
            translate([block_width(i), 0, block_height(1, block_height=block_height)-block_width(0.5)]) {
                rotate([-90, 0, 0]) {
                    sheath(material=material, large_nozzle=large_nozzle, sheath_radius=sheath_radius, sheath_length=sheath_length, skin=skin);
                }
            }
        }
    }
}


// Two rows of end connector enclosing cylinders
module double_end_connector_sheath_set(material, large_nozzle, l, w, end_holes, peg_length, bearing_sheath_thickness, skin, block_height, axle_hole_tweak) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(end_holes!=undef);
    assert(peg_length!=undef);
    assert(bearing_sheath_thickness!=undef);
    assert(skin!=undef);
    assert(block_height!=undef);

    end_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, end_holes=end_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, skin=skin, block_height=block_height, axle_hole_tweak=axle_hole_tweak);

    translate([block_width(l), block_width(w)]) {
        rotate([0, 0, 180]) {
            end_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, end_holes=end_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, skin=skin, block_height=block_height, axle_hole_tweak=axle_hole_tweak);
        }
    }
}


// A row of sheaths surrounding holes along the width
module end_connector_sheath_set(material, large_nozzle, l, w, end_holes, peg_length=_peg_length, bearing_sheath_thickness=_bearing_sheath_thickness, skin, block_height, axle_hole_tweak) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(end_holes!=undef);
    assert(peg_length!=undef);
    assert(bearing_sheath_thickness!=undef);
    assert(skin!=undef);
    assert(block_height!=undef);

    sheath_radius = bearing_sheath_thickness + override_axle_hole_radius(material=material, large_nozzle=large_nozzle, axle_hole_tweak=axle_hole_tweak);

    sheath_length = end_holes == 2 ? block_width(l) : block_width(1);

    if (w == 1) {
        translate([0, block_width(0.5), block_height(1, block_height)-block_width(0.5)]) {

            rotate([0, 90, 0]) {
                sheath(material=material, large_nozzle=large_nozzle, sheath_radius=sheath_radius, sheath_length=sheath_length, skin=skin);
            }
        }
    } else {
        for (j = [1:w-1]) {
            translate([0, block_width(j), block_height(1, block_height=block_height)-block_width(0.5)]) {
                rotate([0, 90, 0]) {
                    sheath(material=material, large_nozzle=large_nozzle, sheath_radius=sheath_radius, sheath_length=sheath_length, skin=skin);
                }
            }
        }
    }
}


// The solid cylinder around a bearing hole
module sheath(material, large_nozzle, sheath_radius, sheath_length, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(sheath_radius!=undef);
    assert(sheath_length!=undef);
    assert(skin!=undef);

    translate([0, 0, skin]) {  
        cylinder(r=sheath_radius, h=sheath_length - 2*skin);
    }
}


// For use by extension routines
module double_end_connector_hole_set(material, large_nozzle, l, w, hole_type, axle_hole_radius, block_height, skin) {
 
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(hole_type!=undef);
    assert(axle_hole_radius!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    translate([block_width(l), 0, 0]) {
        rotate([0, 0, 90]) {
            double_side_connector_hole_set(material=material, large_nozzle=large_nozzle, l=w, w=l, hole_type=hole_type, block_height=block_height, axle_hole_radius=axle_hole_radius, skin=skin);
        }
    }
}


// For use by extension routines
module double_side_connector_hole_set(material, large_nozzle, l, w, hole_type, block_height, axle_hole_radius, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(hole_type!=undef);
    assert(block_height!=undef);
    assert(axle_hole_radius!=undef);
    assert(skin!=undef);

    side_connector_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, hole_type=hole_type, block_height=block_height, axle_hole_radius=axle_hole_radius, skin=skin);
    
    translate([block_width(l), block_width(w)]) {

        rotate([0, 0, 180]) {
            side_connector_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, hole_type=hole_type, block_height=block_height, axle_hole_radius=axle_hole_radius, skin=skin);
        }
    }
}


// A row of knob-size holes around the sides of row 1
module side_connector_hole_set(material, large_nozzle, l, w, hole_type, block_height, axle_hole_radius, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(hole_type!=undef);
    assert(block_height!=undef);
    assert(axle_hole_radius!=undef);
    assert(skin!=undef);

    length = block_width();
    count = hole_type==3 ? w : 1;

    for (j = [1:w]) {
        if (l == 1) {
            translate([block_width(0.5) - skin, block_width(j-1), block_height(1, block_height=block_height)-block_width(0.5)]) {
                rotate([-90, 0, 0]) {                
                    axle_hole(material=material, large_nozzle=large_nozzle, hole_type=hole_type, radius=axle_hole_radius, length=length);
                }
            }        
        } else {
            for (i = [1:l-1]) {
                translate([block_width(i), block_width(j-1) - skin, block_height(1, block_height=block_height)-block_width(0.5)]) {
                    rotate([-90, 0, 0]) {
                        axle_hole(material=material, large_nozzle=large_nozzle, hole_type=hole_type, radius=axle_hole_radius, length=length);
                    }
                }
            }
        }
    }
}


// Hole for an axle
module rotation_hole(material, large_nozzle, radius, length) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(radius!=undef);
    assert(length!=undef);

    cylinder(r=radius, h=length, $fn=_axle_hole_fn);
}


// The rotation and connector hole for a technic connector
module axle_hole(material, large_nozzle, hole_type, radius, length) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(hole_type!=undef);
    assert(radius>=0);
    assert(length>=0);

    render(convexity=4) {
        rotation_hole(material=material, large_nozzle=large_nozzle, radius=radius, length=length);

        if (hole_type>1) {
            counterbore_inset(material=material, large_nozzle=large_nozzle, counterbore_inset_depth=_counterbore_inset_depth, counterbore_inset_radius=_counterbore_inset_radius);

            translate([0, 0, length]) {
                rotate([180, 0, 0]) {
                    counterbore_inset(material=material, large_nozzle=large_nozzle, counterbore_inset_depth=_counterbore_inset_depth, counterbore_inset_radius=_counterbore_inset_radius);
                }
            }
        }
    }
}


// The connector inset for a technic side connector
module counterbore_inset(material, large_nozzle, counterbore_inset_depth, counterbore_inset_radius) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(counterbore_inset_depth>=0);
    assert(counterbore_inset_radius>=0);

    translate([0, 0, -_defeather]) {
        cylinder(r=counterbore_inset_radius, h=counterbore_inset_depth + 2*_defeather);
    }
}


// A rectangle with optional 45 degree sloped roof for use as negative space with printable overhangs
module dome(dome, length, width, thickness) {

    assert(dome != undef);
    assert(length != undef);
    assert(width != undef);
    assert(thickness != undef);

    if (dome) {
        hull() {
            cube([length, width, thickness]);

            i = block_width(0.5);
            translate([i, i, 0]) {
                cube([length-2*i, width-2*i, 1.5*i]);
            }
        }
    } else {
        cube([length, width, thickness]);
    }
}
