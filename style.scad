/*
PELA Parametric Block Style

Alter the baseline style of all designs. Many designs will locally override some but not all of these parameters.

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files to set baseline constants:
    include <style.scad>

If the nozzle you normally use on your printer is 0.5mm or less, edit line 31 to read:
    31:     large_nozzle = false; // [true:nozzle >= 0.5mm, false:nozzle < 0.5mm]

There are many other parameters here which affect all generated PELA models. Any changes you make here affect all models unless that parameter is locally updated in a given model. Where models duplicate these settings, the local value will appear in the "Customizer" view of OpenSCAD. Think of those local overrides of these default style settings as a design decision: changing that parameter for that particular model is likely to be useful to you.

*/

include <material.scad>


/* [Block] */

// Presence of bottom connector sockets
_sockets = true;

// Presence of top connector knobs
_knobs = true;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
_bolt_hole_radius = 1.6; // [0.0:0.1:3.0]

// Add interior fill for the base layer
_solid_first_layer = false;

// Add interior fill for upper layers
_solid_upper_layers = true;


/* [Knob] */

// Knob top surface strength
_knob_top_thickness = 1.0;

// Height of traditional connectors [mm] (taller gives a stronger hold)
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob. Set 0 to disable for best flexture or enable for air circulation/aesthetics/drain resin
_knob_vent_radius = 0.0; // [0.0:0.1:4]

// Ease insertion by slightly widening the socket entry
_bevel_socket = true;

// Height of a small bottom knob insert easement, flaring the bottom edges to make assembly easier
_socket_insert_bevel = 0.1;




/* [Technic] */

// Technic connector hole
//axle_hole_radius = 2.45 + axle_hole_tweak;

// Add full width through holes spaced along the length for techic connectors
_side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around side holes (disable for extra ventilation but loose lock notches)
_side_sheaths = true;

// Add short end holes spaced along the width for techic connectors
_end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
_end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;


/* [Shell] */

// Thickness of the solid top surface of the block
_top_shell = 1;


/* [Advanced Block] */

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional knobs]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_skin = 0.1; // [0:0.02:0.5]

// Height of the hole beneath each knob which facilitates click lock in low-flex materials by variable side pressure on any block above
_knob_flexture_height = 4.5;

// Width of horizontal surface strengthening slats between the bottom rings
_bottom_stiffener_width = 2.6;

// Height of horizontal surface strengthening slats (appears between the bottom rings, default is material.scad:knob_height)
_bottom_stiffener_height = _knob_height;


/* [Advanced Technic] */

// Technic connector hole inset radius
_counterbore_inset_radius = 3.1; // [0.1:0.1:4]

// Technic connector hole inset depth
_counterbore_inset_depth = 0.95; // [0.1:0.1:4]

// Contact length of axle to block (not including inset length and end snap fit flexture in peg connectors)
_peg_length = 6.5; // [0.1:0.1:16]

// Size of the cylinder wrapped around the technic holes
_bearing_sheath_thickness = 0.9; // [0.1:0.1:4]


/* [Block Aesthetics] */

// Width of a line etched in the side of multi-layer block sets (0 to disable)
_ridge_width = 0.15; // [0.1:0.05:4]

// Depth of a line etched in the side of multi-layer block sets
_ridge_depth = 0.3; // [0.1:0.05:4]


/* [Baked Print Supports] */

// Generate print-time support aid structures for models which offer this. Turn this off if you will use slicer-generated print supports, but be aware that these may make the bottom connectors difficult to post process.
_print_supports = true;

// Space between support/support.scad and the part)
_support_offset_from_part = 0.1; // [0.0:0.01:1]

// Thickness of each rotating layer in a twisting support [mm]
_support_layer_height = 2; // [0.1:0.1:8]

// Thickness of a base panel for holding supports together [mm]
_support_connection_height = 0.5; // [0.1:0.1:8]

// Length of sides of a support equilateral triangle [mm]
_support_side_length = 4; // [0.1:0.1:16]

// Per layer support rotation for strength [degrees]
_support_layer_rotation = 6; // [1:179]

// Reverse direction of support rotation periodically to constrain size [degrees] (0 to disable)
_support_max_rotation = 0; // [0:360]


/* [Hidden] */

// Basic unit horizontal size of each block
_block_width = 8; // [8:technic and traditional blocks]

// Height of the connectors commercial blocks use [mm]
_official_knob_height = 1.8; // [1.8:traditional blocks]

// Slight visual offset to work around prevent goldfeather rendering bugs in OpenSCAD (visual, not affecting final print geometry) [mm]
_defeather = 0.01;

// Roundness of bottom connector rings (Use 8 for octagonal sockets- many parts of the geomoetry must be adjusted if you change this)
_ring_fn=8;

// Roundness of bottom connector rings (Use 8 for octagonal sockets- many parts of the geomoetry must be adjusted if you change this)
_axle_hole_fn=32;

// Minimum angle to approximate a circle
$fa = 15;

// Minimum segment length to approximate a circle
$fs = 0.5;


/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Horizontal size
function block_width(i=1) = i*_block_width;

// Vertical size [mm]
function block_height(h=1, block_height) = h*block_height;

// Test if this is a corner block
function is_corner(x, y, l, w) = (x==0 || x==l-1) && (y==0 || y==w-1);

// Ratio of a flat panel thickness to a regular block thickness (1/2 for PELA 8mm tall blocks, 1/3 for LEGO 9.6mm block_height blocks)
function panel_height_ratio(block_height) = block_height < 9.6 ? 1/2 : 1/3;

// Thickness of a flat panel [mm]
function panel_height(block_height) = block_height(1, block_height=_block_height)*panel_height_ratio(block_height=_block_height);

// Bottom connector additional distance from outside lock and connector rings which small flexture-fit rims protrude inwards to grab the base of knobs for asymmetric side pressure to assist with snap fit [mm]
function side_lock_thickness(material) = is_flexible(_material) ? 0.06 : 0.02;

// Horizontal width of each side of a support triangle [mm]
function support_line_width(large_nozzle) = large_nozzle ? 0.7 : 0.5;

// Force the cut visual line for seeing inside parts to be between 0 and 1mm short of the part width [mm]
function visual_cut(cut_line, w) = max(min(cut_line, block_width(w)), 0);

// Thickness of the solid outside surface of the block [mm]
function side_shell(large_nozzle) = large_nozzle ? 1.2 : 1.0;
