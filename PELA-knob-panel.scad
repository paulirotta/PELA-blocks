/*
PELA Parametric Knob Panel

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
    use <PELA-block.scad>
*/

include <material.scad>
include <style.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Knob Panel] */

// Length of the block [blocks]
_l = 8; // [1:1:20]

// Width of the block [blocks]
_w = 8; // [1:1:20]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = true;

// Size of corner holes for M3 mountings bolts
_bolt_hole_radius = 1.6; // [0.0:0.1:3.0]

// Presence of top connector knobs (vs flat)
_knobs = true;

// Height of traditional connectors [mm] (taller gives a stronger hold)
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob. Set 0 to disable for best flexture or enable for air circulation/aesthetics/drain resin
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Presence of bottom socket connectors (vs flat)
_sockets = true;

// How many outside rows and columns on all edges to omit before adding knobs
_skip_edge_knobs = 0; // [0:1:20]

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional knobs]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid
_skin = 0.1;


///////////////////////////////
// DISPLAY
///////////////////////////////

knob_panel(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, top_vents=_top_vents, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius, knobs=_knobs, knob_height=_knob_height, sockets=_sockets, skip_edge_knobs=_skip_edge_knobs, block_height=_block_height, knob_vent_radius=_knob_vent_radius, skin=_skin);




///////////////////////////////////
// MODULES
///////////////////////////////////

module knob_panel(material, large_nozzle, cut_line=_cut_line, l, w, top_vents, corner_bolt_holes, bolt_hole_radius, knobs, knob_height, sockets, skip_edge_knobs, block_height, knob_vent_radius, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(top_vents!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);
    assert(knobs!=undef);
    assert(knob_height!=undef);
    assert(sockets!=undef);
    assert(skip_edge_knobs!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(skin!=undef);

    hr=panel_height_ratio(block_height=block_height);

    if (skip_edge_knobs > 0) {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=hr, top_vents=top_vents, solid_first_layer=false, solid_upper_layers=false, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0, side_sheaths=false, end_holes=0, end_sheaths=false, knob_height=knob_height,  bottom_stiffener_height=0, knobs=false, sockets=sockets, block_height=block_height, knob_vent_radius=knob_vent_radius, skin=skin);

        echo("knob l", l);
        echo("knob w", w);
        if (l>2 && w>2) {
            translate([block_width(skip_edge_knobs), block_width(skip_edge_knobs), 0]) {
                
                top_knob_set(material=material, large_nozzle=large_nozzle, l=l-2*skip_edge_knobs, w=w-2*skip_edge_knobs, h=hr, corner_bolt_holes=false, block_height=block_height, knob_height=knob_height);
            }
        }
    } else {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=hr, top_vents=top_vents, solid_first_layer=false, solid_upper_layers=false, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0,  side_sheaths=0, end_holes=0, end_sheaths=0, bottom_stiffener_height=0, knobs=knobs, knob_height=knob_height, sockets=sockets, block_height=block_height, knob_vent_radius=knob_vent_radius, skin=skin);
    }
}
