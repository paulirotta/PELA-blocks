/*
PELA Parametric Socket Panel Generator

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

include <style.scad>
include <material.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;



/* [Socket Panel] */

// Length of the block [blocks]
_l = 8; // [1:1:20]

// Width of the block [blocks]
_w = 8; // [1:1:20]

// Presence of sockets vs a plain panel
_sockets = true;

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional knobs]



/* [Hidden] */

_solid_first_layer = false;



///////////////////////////////
// DISPLAY
///////////////////////////////

socket_panel(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, sockets=_sockets, skin=_skin, block_height=_block_height);




///////////////////////////////////
// MODULES
///////////////////////////////////

module socket_panel(material, large_nozzle, cut_line=_cut_line, l, w, sockets, skin, block_height) {
    
    assert(material != undef);
    assert(large_nozzle != undef);
    assert(cut_line != undef);
    assert(l != undef);
    assert(w != undef);
    assert(sockets != undef);
    assert(skin != undef);
    assert(block_height != undef);

    difference() {
        union() {
            socket_panel_one_sided(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, skin=skin, block_height=block_height, half_height=true);

            translate([0, block_width(w), panel_height(block_height=block_height)]) {
                rotate([180, 0, 0]) {
                    socket_panel_one_sided(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, skin=skin, block_height=block_height, half_height=true);
                }
            }
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=1, block_height=block_height, knob_height=0, skin=skin);
    }
}


module socket_panel_one_sided(material, large_nozzle, l, w, sockets, skin, block_height, half_height=false) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(sockets!=undef);
    assert(skin!=undef);
    assert(block_height!=undef);
    
    denom = half_height ? 2 : 1;
            
    intersection() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=1, top_vents=false, solid_first_layer=_solid_first_layer, corner_bolt_holes=false, side_holes=0, end_holes=0, skin=skin, knobs=false, block_height=block_height, sockets=sockets, side_sheaths=false, end_sheaths=false, knob_height=0, knob_vent_radius=0);

        translate([skin, skin, 0])
            cube([block_width(l)-2*skin, block_width(w)-2*skin, panel_height(block_height=block_height)/denom]);
    }
}

