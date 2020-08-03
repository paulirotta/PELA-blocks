/*
PELA HTC Vive Tracker Mount Screw

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

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../threads/threads.scad>



/* [Camera Mount Screw] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Screwhole border
_thumbscrew_head_diameter=11; // [0:0.1:30]

// Thumbscrew cut for finger tension [mm]
_cut = 0.8; // [0:0.1:4]

// Thumbscrew pitch [turns per inch]
_tpi = 20; // [1:1:60]

// Thumbscrew head height [mm]
_head_thickness = 1.9; // [0:0.1:8]

// Thumscrew diameter of shaft [inches]
_diameter_in = 0.25; // [0:0.05:4]

// Thumbscrew total height [inches]
_height_in = 0.25; // [0:0.05:4]



///////////////////////////////
// DISPLAY
///////////////////////////////

thumbscrew(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, thumbscrew_head_diameter=_thumbscrew_head_diameter, cut=_cut, tpi=_tpi, head_thickness=_head_thickness, diameter_in=_diameter_in, height_in=_height_in, block_height=_block_height, knob_height=_knob_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module thumbscrew(material, large_nozzle, cut_line=_cut_line, thumbscrew_head_diameter, cut, tpi, head_thickness, diameter_in, height_in, block_height, knob_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(thumbscrew_head_diameter!=undef);
    assert(cut!=undef);
    assert(tpi!=undef);
    assert(head_thickness!=undef);
    assert(diameter_in!=undef);
    assert(height_in!=undef);
    assert(block_height!=undef);
    assert(knob_height!=undef);

    difference() {
        union() {
            translate([0, 0, head_thickness]) {
                us_bolt_thread(dInch=diameter_in, hInch
            =height_in
            , tpi=tpi);
            }

            thumbscrew_head(material=material, large_nozzle=large_nozzle, head_thickness=head_thickness, thumbscrew_head_diameter=thumbscrew_head_diameter, cut=cut);
        }

        translate([-thumbscrew_head_diameter/2, -thumbscrew_head_diameter/2, 0]) {
            cut_space(material=material, large_nozzle=large_nozzle, l=2, w=1, h=2, cut_line=cut_line, block_height=block_height, knob_height=knob_height, skin=0);
        }
    }
}


module thumbscrew_head(material, large_nozzle, head_thickness, thumbscrew_head_diameter, cut) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(head_thickness!=undef);

    cylinder(d=thumbscrew_head_diameter/2, h=head_thickness);

    difference() {
        difference() {
            cylinder(d=thumbscrew_head_diameter-0.2, h=head_thickness);
            translate([-cut/2, 0, 0]) {
                cube([cut, thumbscrew_head_diameter, cut]);
            }            
        }

        union() {
            for (i = [30:30:360]) {
                rotate([0, 0, i]) {
                    translate([-cut/2, 0, -_defeather]) {
                        cube([cut, thumbscrew_head_diameter, cut]);
                    }
                }
            }
        }
    }
}
