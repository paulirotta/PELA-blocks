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
use <PELA-technic-peg.scad>
use <PELA-simplified-technic-peg.scad>


/* [Technic Simplified Peg] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 8; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// An axle which fits loosely in a technic bearing hole
_axle_radius = 2.19; // [0.1:0.1:4]

// Size of the hollow inside a pin
_peg_center_radius=0.7; // [0.1:0.1:4]

// Size of the connector lock-in bump at the ends of a Pin
_peg_tip_length = 0.7; // [0.1:0.1:4]

// Width of the long vertical flexture slots in the side of a pin
_peg_slot_thickness = 0.0; // [0.1:0.1:4]

// Size of the flat bottom cut to make the pin more easily printable
_bottom_flatness = 0.2; // [0.0:0.1:5]

// Size of the end angle cuts to ease tip flex
_end_cut_length = 6; // [0.0:0.1:10]





///////////////////////////////
// DISPLAY
///////////////////////////////

simplified_peg(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, axle_radius=_axle_radius, peg_center_radius=_peg_center_radius, peg_length=_peg_length, peg_tip_length=_peg_tip_length, peg_slot_thickness=_peg_slot_thickness, bottom_flatness=_bottom_flatness, end_cut_length=_end_cut_length);
