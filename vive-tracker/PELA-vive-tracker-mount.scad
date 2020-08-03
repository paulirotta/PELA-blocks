/*
PELA HTC Vive Tracker Mount Generator


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
use <../PELA-socket-panel.scad>
use <../threads/threads.scad>



/* [HTC Vive Tracker Mount] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100] // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Length of the block [blocks]
_l = 6; // [1:1:20]

// Distance between Vive connector pins
_peg_spacing = 3.5;



/* [Hidden] */

// Model width [blocks]
_w = 6; // [1:1:20]

// Vive pin dimensions
_d1 = 3.2;
_h1 = 0.5;
_h1_2 = 0.5;
_d2 = 1.75;
_h2 = 1.35;
_d3 = 2.55;
_h2_3 = 0.5;
_h3 = 0.5;
_d4 = 0.95;
_h4 = 2.75;
_peg_height=_h1+_h1_2+_h2+_h2_3+_h3+_h4;
_peg_vertical_offset=_h1+_h1_2+_h2+_h2_3+_h3;
_peg_holder_height=_h1+_h1_2+_h2+_h2_3;

// Vive cutout dimensions
_peg_skin=0.15;
_cd1 = 3.2+_peg_skin;
_ch1 = 0.5;
_ch1_2 = 0.5;
_cd2 = 1.75+_peg_skin;
_ch2 = 1.35;
_cd3 = 2.55+_peg_skin;
_ch2_3 = 0.5;
_ch3 = 0.5;
_cd4 = 0.95+_peg_skin;
_ch4 = 2.75;
_cd2b = 2.4+_peg_skin;
_cd2c = _cd2b+2.3+_peg_skin;
_cd2d = _cd2c-0.5+_peg_skin;
_slice_width = 0.6;


// Vive connector dimensions
_channel_d = 7;
_channel_l = 19;

// Knob disconnect from center region
_connector_holder_center_lift = 0.15;

// Screwhole and alignment pin
_thumscrew_offset_from_edge = block_width()+17.4;
_thumbscrew_hole_d=7;
_thumbscrew_border_d=11;
_alignment_peg_h = 5.5;
_alignment_peg_d = 4.8;
_alignment_peg_offset_from_screwhole = 13.9;
_cut = 0.8;

_skin = 0.1;


///////////////////////////////
// DISPLAY
///////////////////////////////

PELA_vive_tracker_mount(material=_material, large_nozzle=_large_nozzle, block_height=_block_height, l=_l, w=_w, skin=_skin);




///////////////////////////////////
// MODULES
///////////////////////////////////



module PELA_vive_tracker_mount(material, large_nozzle, l, w, block_height, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    difference() {
        union() {
            socket_panel(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, sockets=true, block_height=block_height, skin=skin);

            translate([block_width(), 2.4+block_width(1.5), panel_height()]) {
                vive_connector(material=material, l=l, w=w);
            }
            
            thumbscrew_hole_border(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w);
            
            alignment_pin(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w);

            hull() {
                translate([block_width(), block_width(1.81)]) {
                    cylinder(d=_channel_d, h=panel_height());
                }

                translate([block_width(), block_width(4.19)]) {
                    cylinder(d=_channel_d, h=panel_height());
                }
            }
        }
        
        union() {
            hull() {
                translate([block_width(), block_width(2)]) {
                    cylinder(d=block_width(0.6), h=panel_height());
                }

                translate([block_width(), block_width(4)]) {
                    cylinder(d=block_width(0.6), h=panel_height());
                }
            }
            
            thumbscrew_hole(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w);

            thumbscrew_head_hole(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w);

            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=2, block_height=block_height, knob_height=_knob_height, skin=skin);
        }
    }
}


module thumbscrew_hole(material, large_nozzle, block_height, l, w) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(block_height!=undef);
    assert(l!=undef);
    assert(w!=undef);

    translate([_thumscrew_offset_from_edge, block_width(w/2)]) {
        cylinder(d=_thumbscrew_hole_d, h=panel_height(block_height=block_height)+0.1);
    }
}


// The negative space to remove to make room for the thumbscrew head to flush mount inside the panel
module thumbscrew_head_hole(material, large_nozzle, block_height, l, w) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(block_height!=undef);
    assert(l!=undef);
    assert(w!=undef);

    translate([_thumscrew_offset_from_edge, block_width(w/2), -0.5*panel_height(block_height=block_height)+_skin]) {

        cylinder(d=_thumbscrew_border_d, h=panel_height(block_height=block_height));
    }
}


module thumbscrew_hole_border(material, large_nozzle, block_height, l, w) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(block_height!=undef);
    assert(l!=undef);
    assert(w!=undef);

    translate([_thumscrew_offset_from_edge, block_width(w/2)]) {
        cylinder(d=_thumbscrew_border_d, h=panel_height(block_height=block_height));
    }
}


module alignment_pin(material, large_nozzle, block_height, large_nozzle, l, w) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(block_height!=undef);
    assert(l!=undef);
    assert(w!=undef);

    translate([_thumscrew_offset_from_edge+_alignment_peg_offset_from_screwhole, block_width(w/2), panel_height(0.5)]) {
        cylinder(d=_alignment_peg_d, h=panel_height(0.5) + _alignment_peg_h);
    }

    translate([block_width(5), block_width(3), 0.5*panel_height(block_height=block_height)]) {

        r = override_ring_radius(material=material, large_nozzle=large_nozzle);
        
        cylinder(r=r, h=0.5*panel_height(block_height=block_height));
    }
}


// For display of interenal function and pin position
module vive_connector_left(material) {

    intersection() {
        vive_connector(material=material, l=l, w=w);
        translate([0, -_channel_d/2, 0]) {
            cube([_channel_d, _channel_l+_channel_d, _channel_d]);
        }
    }
    
%    vive_peg_array(material=material);    
}

// For display of interenal function and pin position
module vive_connector_right(material, l, w) {

    difference() {
        vive_connector(material=material, l=l, w=w);
        translate([0, -_channel_d/2, 0]) {
            cube([_channel_d, _channel_l+_channel_d, _channel_d]);
        }
    }
    
%    vive_peg_array(material=material, l=l, w=w);    
}


module vive_connector(material, l, w) {

    assert(material!=undef);
    assert(l!=undef);
    assert(w!=undef);

    difference() {
        channel(material=material);
        union () {
            vive_enclosure_cutout_array(material=material);
            
            translate([0, (_channel_l-5*_peg_spacing)/2, 0]) {
                hull() {
                    cylinder(d=_cd2c, h=2*_connector_holder_center_lift);
                    translate([0, _channel_l-_peg_spacing/2, 0]) {
                        cylinder(d=_cd2c, h=2*_connector_holder_center_lift);
                    }
                }
            }
        }
    }
}


// A set of pins
module vive_peg_array(material, large_nozzle, count=6) {

    for (i=[0:_peg_spacing:_peg_spacing*(count-1)]) {
        translate([0, i + (_channel_l-(count-1)*_peg_spacing)/2, _peg_vertical_offset]) {
            rotate([180, 0, 0]) {
                vive_pin(material=material);
            }
        }
    }
}


// A set of negative space for pins
module vive_enclosure_cutout_array(material, large_nozzle, count=6) {

    for (i=[0:_peg_spacing:_peg_spacing*(count-1)]) {
        translate([0, i + (_channel_l-(count-1)*_peg_spacing)/2, _peg_vertical_offset]) {
            rotate([180, 0, 0]) {
                vive_cutout(material=material);
            }
        }
    }
}

// A pin to connect to a Vive, slightly over actual size to create an associated negative space
module vive_pin(material) {

    $fn=32;
    
    cylinder(d=_d1, h=_h1);
    translate([0, 0, _h1]) {
        cylinder(d1=_d1, d2=_d2, h=_h1_2);
        translate([0, 0, _h1_2]) {
            cylinder(d=_d2, h=_h2);
            translate([0, 0, _h2]) {
                cylinder(d1=_d2, d2=_d3, h=_h2_3);
                translate([0, 0, _h2_3]) {
                    cylinder(d=_d3, h=_h3);
                    translate([0, 0, _h3]) {
                        cylinder(d=_d4, h=_h4);
                    } 
                } 
            } 
        } 
     }
}

// A pin to connect to a Vive, slightly over actual size to create an associated negative space
module vive_cutout(material) {

    $fn=32;
    
    cylinder(d=_cd1, h=_ch1);
    slice(material=material);
    translate([0, 0, _ch1]) {
        cylinder(d1=_cd1, d2=_cd2, h=_ch1_2);
        cylinder(d=_cd2b, h=_peg_height);
        
        translate([0, 0, _ch1_2]) {
            cylinder(d=_cd2, h=_ch2);

            translate([0, 0, _ch2]) {
                cylinder(d1=_cd2, d2=_cd3, h=_ch2_3);
                translate([0, 0, _ch2_3]) {
                    cylinder(d=_cd3, h=_ch3);
                    translate([0, 0, _ch3]) {
                        cylinder(d=_cd4, h=_ch4);
                    } 
                } 
            } 
        } 
     }
}

// A flexture cut through the ring around a pin to facilitate pin insertion
module slice(material) {
    
    translate([-_cd2d/2, -_slice_width/2]) {
        cube([_cd2d, _slice_width, _peg_height]);
    }
}

// The himisphical body into which pins are inserted
module channel(material) {
    
    intersection() {
        hull() {
            sphere(d=_channel_d);
        
            translate([0, _channel_l, 0]) {
                sphere(d=_channel_d);
            }
        }
            
        translate([-_channel_d/2, -_channel_d/2, 0]) {
            cube([_channel_d, _channel_l+_channel_d, _peg_holder_height]);
        }
    }
}