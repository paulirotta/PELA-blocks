/*
PELA Parametric Flat Sign Generator

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
    use <PELA-flat-sign.scad>
    use <../PELA-block.scad>
    use <../PELA-technic-block.scad>
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-knob-panel.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
use <../technic-mount/PELA-technic-box.scad>
use <PELA-panel-sign.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;



/* [Panel Sign] */

// Length of the sign (block count)
_l = 4;  // [1:1:20]

// Width of the sign (block count)
_w = 4; // [1:1:20]

// Width of the sign (block count)
_h = 1; // [1:1:20]

// Distance from length ends of connector twist [blocks]
_twist_l = 1; // [1:18]

// Distance from width ends of connector twist [blocks]
_twist_w = 2; // [1:18]

// Interior fill style
_center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// The first line of text
_edge_text = "Hki";

// The first line of text
_line_1 = "Jee!";

// The second line of text
_line_2 = "001";
 
// Depth of text etching into top surface
_text_depth = 1; // [0.0:0.1:2]

// Language of the text
_lang = "en";

// The font to use for text on the top line
_f1 = "Liberation Sans:style=Bold Italic";

// The font to use for text on the bottom line
_f2 = "Arial:style=Bold";

// The font size (points) of the top line
_fs1 = 4.8;

// The font size (points) of the bottom line
_fs2 = 5;

// Left text margin (mm)
_left_margin = 1.8;

// Top and bottom text margin (mm)
_vertical_margin = 0.3;

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]




///////////////////////////////
// DISPLAY
///////////////////////////////

// Enable these one at a time if a dual-color print

PELA_technic_sign(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, twist_l=_twist_l, twist_w=_twist_w, center=_center, edge_text=_edge_text, line_1=_line_1, line_2=_line_2, lang=_lang, text_depth=_text_depth, f1=_f1, f2=_f2, fs1=_fs1, fs2=_fs2, left_margin=_left_margin, vertical_margin=_vertical_margin, top_vents=_top_vents, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin);



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_technic_sign(material, large_nozzle, cut_line=_cut_line, l, w, h, twist_l, twist_w, center, line_1, line_2, lang, edge_text,  text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin, top_vents, horizontal_skin, vertical_skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(twist_l!=undef);
    assert(twist_w!=undef);
    assert(center!=undef);
    assert(edge_text!=undef);
    assert(line_1!=undef);
    assert(line_2!=undef);
    assert(lang!=undef);
    assert(text_depth!=undef);
    assert(f1!=undef);
    assert(f2!=undef);
    assert(fs1!=undef);
    assert(fs2!=undef);
    assert(left_margin!=undef);
    assert(vertical_margin!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    difference() {
        union() {
            difference() {
                technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, center=center, knob_height=0, knob_vent_radius=0, top_vents=false, text=edge_text, text_depth=text_depth, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=false);
                
                translate([3, 4, block_width(h-0.5)-text_depth])
                    PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=2, h=h, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth+vertical_skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, skin=vertical_skin, block_height=block_width());
            }

            PELA_flat_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, corner_bolt_holes=false, sockets=false, knobs=false, block_height=block_width(), extrude=false, skin=vertical_skin);
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_width(), knob_height=0, skin=vertical_skin);
    }
}
