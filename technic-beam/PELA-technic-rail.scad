/*
PELA Slot Mount - 3D Printed LEGO-compatible PCB mount, vertical slide-in

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    https://www.futurice.com

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <../PELA-knob-panel.scad>
use <PELA-technic-beam.scad>
use <PELA-technic-twist-beam.scad>
use <../technic-mount/PELA-technic-box.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Box] */

// Number of cells in a ladder
_step_count = 4; // [1:1:20]

// Total length [blocks]
_l = 6; // [2:1:20]

// Total width [blocks]
_w = 5; // [2:1:20]

// Distance from length ends of connector twist [blocks]
_twist_l = 3; // [1:18]

// Distance from width ends of connector twist [blocks]
_twist_w = 2; // [1:18]

// Height of the enclosure [blocks]
_h = 1; // [1:1:20]

// Interior fill style
_center = 0; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Text label
_text = "";



/* [Advanced] */
 
// Depth of text etching into top surface
_text_depth = 0.5; // [0.0:0.1:2]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]


/* [Hidden] */

// Select parts to render
_render_modules = 0; // [0:technic box, 1:technic cover, 2:technic box and cover]

// Text label
_cover_text = "Cover";

// Interior fill style
_cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]

// Include quarter-round corner hold-downs in the cover
_cover_corner_tabs = true;



///////////////////////////////////
// FUNCTIONS
///////////////////////////////////

function first_l(twist_l, l) = min(twist_l, ceil(l/2));

function mid_l(l, l1, l3) = max(0, l - l1 - l3);



///////////////////////////////
// DISPLAY
///////////////////////////////

cell_ladder(step_count=_step_count);

///////////////////////////////////
// MODULES
///////////////////////////////////

module cell_ladder(step_count) {

    assert(step_count>=1);

    for (i=[0:step_count-1]) {
        translate([i*block_width(_l-1), 0, 0])
            rail_cell();
    }
}


module rail_cell() {

    technic_box_and_cover(material=_material, large_nozzle=_large_nozzle, render_modules=_render_modules, cut_line=_cut_line, l=_l, w=_w, h=_h, cover_h=_cover_h, twist_l=_twist_l, twist_w=_twist_w, sockets=_sockets, knobs=_knobs, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, top_vents=_top_vents, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, cover_corner_tabs=_cover_corner_tabs);
}