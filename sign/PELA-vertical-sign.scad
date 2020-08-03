/*
PELA Parametric Sign Generator

Create 2 symmetric end pieces which can support a solid object with PELA-compatible attachment points on top and bottom. By printing only the end pieces instead of a complele enclosure, the print is minimized



Based on
    https://www.thingiverse.com/thing:2303714



By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <PELA-vertical-sign.scad>
    use <../PELA-block.scad>
    use <../PELA-technic-block.scad>
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;



/* [Vertical Sign] */

// Length of the sign (block count)
_l = 9; // [1:1:20]

// Width of the sign (block count)
_w = 1; // [1:1:20]

// Height of the sign (PELA block layers)
_h = 2; // [1:1:20]


/* [Text] */

// The top line of text. Set to "" to not have any top line
_line_1 = "Rapid Prototyping";

// The second line of text
_line_2 = "PELAblocks.org";

// Extruded text pushs outward, vs text extched into the block
_extrude = true;

// Language of the text
_lang = "en";

// The font to use for text on the top line
_f1 = "Liberation Sans:style=Bold Italic";

// The font to use for text on the bottom line
_f2 = "Arial";

// The font size (points) of the top line
_fs1 = 5.8;

// The font size (points) of the bottom line
_fs2 = 5;

// How deeply into the PELA block to etch/extrude the text
_text_depth = 0.5;

// Left text margin (mm)
_left_margin = 1.2;

// Top and bottom text margin (mm)
_vertical_margin = 1;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;


/* [Advanced] */

// Place the text on both sides
_copy_to_back = true;

// Add a wrapper around side holes (disable for extra ventilation but loose lock notches)
_side_sheaths = true;

// Add short end holes spaced along the width for techic connectors
_end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
_end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = true;

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well
_knob_vent_radius = 0; // [0.0:0.1:3.9]

// Presence of bottom connector sockets
_sockets = true;

// Basic unit vertical size of each block
_block_height = 9.6; // [8:technic, 9.6:traditional knobs]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]




///////////////////////////////
// DISPLAY
///////////////////////////////

PELA_vertical_sign(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, line_1=_line_1, line_2=_line_2, lang=_lang, extrude=_extrude,  text_depth=_text_depth, f1=_f1, f2=_f2, fs1=_fs1, fs2=_fs2, left_margin=_left_margin, vertical_margin=_vertical_margin, top_vents=_top_vents, end_holes=_end_holes, end_sheaths=_end_sheaths, corner_bolt_holes=_corner_bolt_holes, knobs=_knobs, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, sockets=_sockets, block_height=_block_height, horizontal_skin=_horizontal_skin, copy_to_back=_copy_to_back);



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_vertical_sign(material, large_nozzle, cut_line, l, w, h, line_1, line_2, lang, extrude,  text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin, top_vents, side_holes, side_sheaths, end_holes, end_sheaths, corner_bolt_holes, knobs, knob_height, knob_vent_radius, sockets, block_height, horizontal_skin, copy_to_back) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
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
    assert(end_holes!=undef);
    assert(end_sheaths!=undef);
    assert(corner_bolt_holes!=undef);
    assert(knobs!=undef);
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(sockets!=undef);
    assert(block_height!=undef);
    assert(horizontal_skin!=undef);
    assert(copy_to_back!=undef);

    difference() {
        if (extrude) {
            PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, ridge_width=0, ridge_depth=0, top_vents=top_vents, side_holes=false, side_sheaths=0, end_holes=end_holes, end_sheaths=end_sheaths, corner_bolt_holes=corner_bolt_holes, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, sockets=sockets, block_height=block_height, skin=horizontal_skin);
            
            color("green") translate([horizontal_skin, horizontal_skin, 0]) {
                PELA_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height);
            }

            if (copy_to_back) {
                color("green") translate([block_width(l), block_width(w)-horizontal_skin, 0]) {
                    rotate([0, 0, 180]) {
                        PELA_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height);
                    }
                }
            }
        } else {
            difference() {
                PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, ridge_width=ridge_width, ridge_depth=ridge_depth, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, corner_bolt_holes=corner_bolt_holes);
                
                color("green") union() {
                    translate([horizontal_skin, 0, 0])
                        PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth+horizontal_skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);

                    if (copy_to_back) {
                        translate([block_width(l)-horizontal_skin, block_width(w)-horizontal_skin, 0]) {
                            rotate([0, 0, 180]) {
                                PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth+horizontal_skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);
                            }
                        }
                    }
                }
            }
        }

        translate([0, -text_depth, 0]) {
            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height, skin=horizontal_skin);
        }
    }
}


// Two lines of text extruded out from the surface
module PELA_sign_extruded_text(material, large_nozzle, l, w, h, line_1, line_2, lang, text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin, block_height) {
    
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

    translate([left_margin, 0, block_height(h, block_height)-vertical_margin]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, font=f1, font_size=fs1, text_depth=text_depth, vertical_alignment="top");
    }
    
    translate([left_margin, 0, vertical_margin]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, font=f2, font_size=fs2, text_depth=text_depth, vertical_alignment="bottom");
    }
}


// Two lines of text etched into the surface
module PELA_sign_etched_text(material, large_nozzle, l, w, h, line_1, line_2, lang,  text_depth, f1, f2, fs1, fs2, left_margin, vertical_margin) {
    
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

    translate([left_margin, text_depth, block_height(h, block_height)-vertical_margin]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, text_depth=text_depth, font=f1, font_size=fs1, vertical_alignment="top");
    }
    
    translate([left_margin, text_depth, vertical_margin]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, text_depth=text_depth, font=f2, font_size=fs2, vertical_alignment="baseline");
    }
}


// Text for the side of blocks
module PELA_text(material, large_nozzle, text, lang, text_depth, font, font_size, vertical_alignment) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(text!=undef);
    assert(lang!=undef);
    assert(text_depth!=undef);
    assert(font!=undef);
    assert(font_size!=undef);
    assert(vertical_alignment!=undef);

    rotate([90,0,0]) {
        linear_extrude(height=text_depth) {
            text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
        }
    }
}
