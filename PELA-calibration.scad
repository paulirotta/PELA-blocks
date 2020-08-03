/*
PELA Blocks 3D Print Calibration Beam

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

include <style.scad>
include <material.scad>
use <PELA-technic-block.scad>
use <PELA-block.scad>



/* [Render] */

// Printing material. Set to label your calibration blocks and indicate if the material is flexible. Print to measure the best fit for knobs, sockets and axle holes and put those measures in "material.scad"
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Does that material have a Shore A durometer less than 90? (TPU etc need some flexure geometry modifications for a better knob and socket fit)
_flexible_material = false;



/* [Calibration] */

// Number of blocks in the calibration beam
_beam_length = 9; // [1:1:20]

// Length of each calibration block [blocks]
_l = 2; // [1:1:20]

// Width of each calibration block [blocks]
_w = 2; // [1:1:20]

// Height of the block (PELA unit count, use 1/3 for short calibration panel)
_h = 1; // [1:1:20]

// Height of traditional connectors [mm] (taller gives a stronger hold)
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob. Set 0 to disable for best flexture or enable for air circulation/aesthetics/drain resin
_knob_vent_radius = 0.0; // [0.0:0.1:4]

// Basic unit vertical size of each block
_block_height = 9.6; // [8:technic, 9.6:traditional knobs]

// Middle value of the calibration increment range
_calibration_center = 0.0;

// Size between calibration block test steps (0.04 if you need a wider size range, 0.02 for finer adjustment close to nomanal values)
_calibration_increment = 0.04;



/* [Hidden] */

// Depth of text labels on calibration blocks
_text_depth = 0.3;

// Inset from block edge for text (vertical and horizontal)
_vertical_text_margin = 3.8;

// Inset from block edge for text (vertical and horizontal)
_horizontal_text_margin = 1;

_side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Font for calibration block text labels
_font = "Arial";

// Text size on calibration blocks
_font_size = 4.8 - (_block_height < 9.6 ? 1.5 : 0);

// Text size on calibration blocks
_font_size2 = 3.8 - (_block_height < 9.6 ? 0.5 : 0);


///////////////////////////////
// DISPLAY
///////////////////////////////

PELA_calibration_beam(material=_material, large_nozzle=_large_nozzle, beam_length=_beam_length, l=_l, w=_w, h=_h, calibration_increment=_calibration_increment, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, block_height=_block_height, font=_font, font_size=_font_size, font_size2=_font_size2, horizontal_text_margin=_horizontal_text_margin, vertical_text_margin=_vertical_text_margin, text_depth=_text_depth);


///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_calibration_beam(material, large_nozzle, beam_length, l, w, h, calibration_increment, knob_height, knob_vent_radius, block_height, horizontal_text_margin, text_depth, font, font_size, font_size2, horizontal_text_margin, vertical_text_margin, text_depth) {

    assert(beam_length > 1, "Beam length must be at least 2");
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(calibration_increment!=undef);
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(block_height!=undef);
    assert(font!=undef);
    assert(font_size!=undef);
    assert(font_size2!=undef);
    assert(horizontal_text_margin!=undef);
    assert(vertical_text_margin!=undef);
    assert(text_depth!=undef);


    from = -floor((beam_length - 1)/2);
    to = ceil((beam_length - 1)/2);
    
    // Tighter top, looser bottom
    for (i = [from:to]) {
        cal = i*calibration_increment;
        
        translate([i*(block_width(l)-side_shell(large_nozzle)), 2*i, 0]) {

            PELA_calibration_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, knob_vent_radius=knob_vent_radius, side_holes=2, block_height=block_height, font=font, font_size=font_size, font_size2=font_size2, horizontal_text_margin=horizontal_text_margin, vertical_text_margin=vertical_text_margin, text_depth=text_depth);
        }
    }
}


// A block with the top and bottom connector tweak parameters etched on the side
module PELA_calibration_block(material, large_nozzle, l, w, h, top_tweak, bottom_tweak, axle_hole_tweak, knob_height, knob_vent_radius, side_holes, block_height, font, font_size, font_size2, horizontal_text_margin, vertical_text_margin, text_depth) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(top_tweak!=undef);
    assert(bottom_tweak!=undef);
    assert(axle_hole_tweak!=undef);
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(side_holes!=undef);
    assert(block_height!=undef);
    assert(font!=undef);
    assert(font_size!=undef);
    assert(font_size2!=undef);
    assert(horizontal_text_margin!=undef);
    assert(vertical_text_margin!=undef);
    assert(text_depth!=undef);

    difference() { 
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, sockets=true, knobs=true, knob_height=knob_height, knob_vent_radius=knob_vent_radius, corner_bolt_holes=false, side_holes=side_holes, side_sheaths=true, end_holes=0, end_sheaths=false, top_vents=false, block_height=block_height, bottom_tweak=bottom_tweak, top_tweak=top_tweak, axle_hole_tweak=axle_hole_tweak);

        union() {
            translate([_skin+horizontal_text_margin, _skin+text_depth, _skin+block_height(h, block_height)-vertical_text_margin]) {

                rotate([90 ,0, 0]) {
                    translate([0, -0.5, 0]) {
                        calibration_text(txt=material_name(material), halign="left", 
                        valign="bottom", font=font, font_size=font_size2);
                    }

                    translate([0, -0.8, 0]) {
                        calibration_text(txt=str(top_tweak), halign="left", valign="top", font=font, font_size=font_size);
                    }
                }
            }
            
            translate([block_width(w)-_skin-horizontal_text_margin, block_width(w)-text_depth-_skin, _skin+vertical_text_margin]) {
                
                rotate([90, 0, 180]) {
                    translate([0, 0.5, 0]) {
                        calibration_text(txt=str(bottom_tweak), halign="left", valign="bottom", font=font, font_size=font_size, text_depth=text_depth);
                    }

                    translate([0, 0, 0]) {
                        calibration_text(txt=material_name(material), halign="left", valign="top", font=font, font_size=font_size2, text_depth=text_depth);
                    }
                }
            }
        }
    }
}


// Text for the front side of calibration block prints
module calibration_text(txt, halign, valign, font, font_size, text_depth) {
    
    assert(txt!=undef);
    assert(halign!=undef);
    assert(valign!=undef);
    assert(font_size!=undef);

    linear_extrude(height=text_depth*2) {        
        text(text=txt, font=font, size=font_size, halign=halign, valign=valign);
    }
}
