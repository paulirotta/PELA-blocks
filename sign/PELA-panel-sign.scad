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



/* [Panel Sign] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Length of the sign (block count)
_l = 7;  // [1:1:20]

// Width of the sign (block count)
_w = 1; // [1:1:20]

// The top line of text. Set to "" to not have any top line
_line_1 = "";

// The second line of text
_line_2 = "PELAblocks.org";

// true=>text is pushing outward from the PELA block, false=>etch text into the block
_extrude = true;

// Presence of top connector knobs
_knobs = false;

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

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

// How deeply into the PELA block to etch/extrude the text
_text_depth = 0.5;

// Left text margin (mm)
_left_margin = 1.8;

// Top and bottom text margin (mm)
_vertical_margin = 0.3;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
_bolt_hole_radius = 1.6; // [0.0:0.1:3.0]

// Presence of bottom connector sockets
_sockets = true;



/* [Hidden] */

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;




///////////////////////////////
// DISPLAY
///////////////////////////////

// Enable these one at a time if a dual-color print

PELA_panel_sign(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, line_1=_line_1, line_2=_line_2, lang=_lang, extrude=_extrude,  text_depth=_text_depth, f1=_f1, f2=_f2, fs1=_fs1, fs2=_fs2, left_margin=_left_margin, vertical_margin=_vertical_margin, top_vents=_top_vents, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius, sockets=_sockets, knobs=_knobs, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, block_height=_block_height, skin=_skin);



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_panel_sign(material, large_nozzle, cut_line=_cut_line, l, w, line_1, line_2, lang, extrude,  text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin, top_vents, corner_bolt_holes, bolt_hole_radius, sockets, knobs, knob_height, knob_vent_radius, block_height, skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(line_1!=undef);
    assert(line_2!=undef);
    assert(lang!=undef);
    assert(extrude!=undef);
    assert(text_depth!=undef);
    assert(f1!=undef);
    assert(f2!=undef);
    assert(fs1!=undef);
    assert(fs2!=undef);
    assert(left_margin!=undef);
    assert(vertical_margin!=undef);
    assert(top_vents!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);
    assert(sockets!=undef);
    assert(knobs!=undef);
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    difference() {
        union() {
            if (extrude) {
                difference() {
                    knob_panel(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, top_vents=top_vents, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, knob_height=knob_height, skip_edge_knobs=false, knob_vent_radius=knob_vent_radius, sockets=sockets, block_height=block_height, skin=skin);

                    PELA_flat_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  text_depth=text_depth, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height, skin=skin);
                }
            } else {
                difference() {
                    knob_panel(material=material, large_nozzle=large_nozzle, l=l, w=w, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, knob_height=knob_height, sockets=sockets, block_height=block_height);
                    
                    translate([skin, 0, -text_depth])
                        PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth+skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height, skin=skin);
                }
            }

            color("blue") PELA_flat_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude, text_depth=text_depth, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height, skin=skin);
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=2, block_height=block_height, knob_height=knob_height, skin=skin);
    }
}


// A PELA block with text on the top
module PELA_flat_sign_extruded_text(material, large_nozzle, l, w, line_1, line_2, lang, extrude, text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin, top_vents, corner_bolt_holes, sockets, knobs, block_height, skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(line_1!=undef);
    assert(line_2!=undef);
    assert(lang!=undef);
    assert(extrude!=undef);
    assert(text_depth!=undef);
    assert(f1!=undef);
    assert(f2!=undef);
    assert(fs1!=undef);
    assert(fs2!=undef);
    assert(left_margin!=undef);
    assert(vertical_margin!=undef);
    assert(top_vents!=undef);
    assert(corner_bolt_holes!=undef);
    assert(sockets!=undef);
    assert(knobs!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);
    
    if (extrude) {
        translate([skin, skin, 0])
            PELA_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height, skin=skin);
    }
}


// Two lines of text extruded out from the surface
module PELA_sign_extruded_text(material, large_nozzle, l, w, line_1, line_2, lang, text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin, block_height, skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
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
    assert(block_height!=undef);
    assert(skin!=undef);

    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, panel_height(block_height=block_height)-text_depth]) {
        
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, font=f1, font_size=fs1, vertical_alignment="top", text_depth=text_depth*2);
    }

    translate([left_margin+skin, vertical_margin+skin, panel_height(block_height=block_height)-text_depth]) {
        
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, font=f2, font_size=fs2, vertical_alignment="bottom", text_depth=text_depth*2);
    }
}


// Two lines of text etched into the surface
module PELA_sign_etched_text(material, large_nozzle, l, w, h, line_1, line_2, lang, text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin, block_height, skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
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
    assert(block_height!=undef);
    assert(skin!=undef);

    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, panel_height(block_height=block_height)]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, text_depth=text_depth, font=f1, font_size=fs1, vertical_alignment="top");
    }
    
    translate([left_margin+skin, vertical_margin+skin, panel_height(block_height=block_height)]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, text_depth=text_depth, font=f2, font_size=fs2, vertical_alignment="bottom");
    }
}


// Text for the top of blocks
module PELA_text(material, large_nozzle, text, lang, text_depth, font, font_size, vertical_alignment) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(text!=undef);
    assert(lang!=undef);
    assert(text_depth!=undef);
    assert(font!=undef);
    assert(font_size!=undef);
    assert(vertical_alignment!=undef);

   linear_extrude(height=text_depth) {
        text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
   }
}
