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
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Select parts to render
_render_modules = 2; // [0:technic box, 1:technic cover, 2:technic box and cover]


/* [Box] */

// Total length [blocks]
_l = 6; // [2:1:30]

// Total width [blocks]
_w = 4; // [2:1:30]

// Distance from length ends of connector twist [blocks]
_twist_l = 1; // [1:15]

// Distance from width ends of connector twist [blocks]
_twist_w = 2; // [1:15]

// Height of the enclosure [blocks]
_h = 2; // [1:1:30]

// Interior fill style
_center = 6; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Text label
_text = "Box";


/* [Cover] */

// Text label
_cover_text = "Cover";

// Interior fill style
_cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]

// Include quarter-round corner hold-downs in the cover
_cover_corner_tabs = true;


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



///////////////////////////////////
// FUNCTIONS
///////////////////////////////////

function first_l(twist_l, l) = min(twist_l, ceil(l/2));

function mid_l(l, l1, l3) = max(0, l - l1 - l3);



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_box_and_cover(material=_material, large_nozzle=_large_nozzle, render_modules=_render_modules, cut_line=_cut_line, l=_l, w=_w, h=_h, cover_h=_cover_h, twist_l=_twist_l, twist_w=_twist_w, sockets=_sockets, knobs=_knobs, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, top_vents=_top_vents, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, cover_corner_tabs=_cover_corner_tabs);


///////////////////////////////////
// MODULES
///////////////////////////////////


module technic_box_and_cover(material, large_nozzle, cut_line, render_modules, l, w, h, cover_h, twist_l, twist_w, sockets, knobs, knob_height, knob_vent_radius, top_vents, center, cover_center, text, cover_text, text_depth, horizontal_skin, vertical_skin, cover_corner_tabs) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(render_modules!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(cover_h!=undef);
    assert(twist_l!=undef);
    assert(twist_w!=undef);
    assert(sockets!=undef);
    assert(knobs!=undef);
    assert(knob_vent_radius!=undef);
    assert(top_vents!=undef);
    assert(center!=undef);
    assert(cover_center!=undef);
    assert(text!=undef);
    assert(cover_text!=undef);
    assert(text_depth!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    assert(cover_corner_tabs!=undef);

    if (render_modules != 0) {
        translate([0, -block_width(w + 1), 0]) {
            technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=cover_h, twist_l=twist_l, twist_w=twist_w, knob_height=_knob_height, knob_vent_radius=knob_vent_radius, top_vents=top_vents, center=cover_center, text=cover_text, text_depth=text_depth, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=cover_corner_tabs);
        }
    }

    if (render_modules != 1) {
        technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, knob_height=_knob_height, knob_vent_radius=knob_vent_radius, top_vents=top_vents, center=center, text=text, text_depth=text_depth, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=false);
    }
}

module technic_box(material, large_nozzle, cut_line=_cut_line, l, w, h, twist_l, twist_w, knob_height, knob_vent_radius, top_vents, center, text, text_depth, horizontal_skin, vertical_skin, cover_corner_tabs) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(h!=undef);
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(top_vents!=undef);
    assert(w >= 2);
    assert(twist_w > 0);
    assert(twist_l > 0);
    assert(l >= twist_w + twist_l);
    assert(center >= 0);
    assert(center <= 7);
    assert(text != undef);
    assert(text_depth != undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    assert(cover_corner_tabs!=undef);

    difference() {
        union() {
            technic_only_box(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, knob_height=knob_height, center=center, text=text, text_depth=text_depth, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
            
            lc = l - 2;
            wc = w - 2;

            if (center == 5 && lc > 0 && wc > 0) {
                translate([block_width(0.5), block_width(0.5), 0]) {
                    socket_panel(material=material, large_nozzle=large_nozzle, l=lc, w=wc, skin=-horizontal_skin, block_height=block_width(), sockets=true);
                }
            } else if (center >= 6 && lc > 0 && wc > 0) {
                knobs = center == 6;
                translate([block_width(0.5), block_width(0.5), 0]) {
                    knob_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=lc, w=wc, top_vents=top_vents, corner_bolt_holes=false, knobs=knobs, knob_height=knob_height, sockets=knobs, skip_edge_knobs=0, block_height=block_width(), knob_vent_radius=knob_vent_radius, skin=-horizontal_skin, bolt_hole_radius=0);
                }
            }
                                
            if (cover_corner_tabs) {
                corner_tabs(l=l, w=w, cover_h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
            }
        }

        translate([-block_width(0.5), -block_width(0.5), 0]) {
            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_width(), knob_height=knob_height, skin=horizontal_skin);
        }
    }
}


module technic_only_box(material, large_nozzle, cut_line=_cut_line, l, w, h, twist_l, twist_w, knob_height, center, text, text_depth, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(twist_l!=undef);
    assert(twist_w!=undef);
    assert(knob_height!=undef);
    assert(center!=undef);
    assert(text!=undef);
    assert(text_depth!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    tl = first_l(twist_l, l);
    l1 = tl;
    l2 = mid_l(l, l1, l1);
    l3 = l - l1 - l2;
    tw = first_l(twist_w, w);
    w1 = tw;
    w2 = mid_l(w, w1, w1);
    w3 = w - w1 - w2;
    vs = h > 1 ? 0 : vertical_skin;

    difference() {
        union() {
            for (i = [1:h]) {
                translate([0, 0, block_width(i-1)]) {
                    technic_rectangle(material=material, large_nozzle=large_nozzle, l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3, text=text, text_depth=text_depth, etch_top_text=(i==h), etch_bottom_text=(i==1), h=1, horizontal_skin=horizontal_skin, vertical_skin=vs);
               }
            }

            if (center > 0 && center < 5) {
                difference() {
                    translate([block_width(0.5)-horizontal_skin, block_width(0.5)-horizontal_skin, 0]) {
                        cube([block_width(l-2)+2*horizontal_skin, block_width(w-2)+2*horizontal_skin, block_width(h)-2*vs]);
                    }
                    
                    cheese_holes(material=material, large_nozzle=large_nozzle, center=center, l=l, w=w, h=h, l1=l1, l2=l2, w1=w1, w2=w2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                }
            }
        }
        
        translate([block_width(-0.5), block_width(-0.5), 0]) {
            
            cut_space(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, knob_height=knob_height, block_height=block_width(), skin=horizontal_skin);
        }
    }
}


module edge_text(l, w, h, text, text_depth) {

    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(text!=undef);
    assert(text_depth!=undef);

    translate([block_width((l-1)/2), block_width(w-1), block_width(h) - text_depth]) {
        font = "Liberation Sans";

        color("black") linear_extrude(height = text_depth + _defeather) {
            text(text, font = font, size = 4.8, valign = "center", halign = "center");
        }
    }
}


module technic_rectangle(material, large_nozzle, l1, l2, l3, w1, w2, w3, text, text_depth, etch_top_text, etch_bottom_text, h, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l1!=undef);
    assert(l2!=undef);
    assert(l3!=undef);
    assert(w1!=undef);
    assert(w2!=undef);
    assert(w3!=undef);
    assert(text!=undef);
    assert(text_depth!=undef);
    assert(l1 > 0, "increase first l section to 1");
    assert(l2 >= 0, "increase second l section to 0");
    assert(l3 > 0,"increase third l section to 1");
    assert(w1 > 0, "increase first w section to 1");
    assert(w2 >= 0, "increase second w section to 0");
    assert(w3 > 0, "increase third w section to at least 1");
    assert(h >= 1);
    assert(etch_top_text != undef);
    assert(etch_bottom_text != undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    ll = l1+l2+l3;
    ww = w1+w2+w3;

    difference() {
        union() {
            technic_twist_beam(material=material, large_nozzle=large_nozzle, cut_line=0, w_left=1, w_center=1, w_right=1, l_left=l1, l_center=l2, l_right=l3, h_left=h, h_center=h, h_right=h, side_holes=2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);

            rotate([0, 0, 90]) {
                technic_twist_beam(material=material, large_nozzle=large_nozzle, cut_line=0, w_left=1, w_center=1, w_right=1, l_left=w1, l_center=w2, l_right=w3, h_left=h, h_center=h, h_right=h, side_holes=2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
            }

            translate([0, block_width(ww-1), 0]) {
                technic_twist_beam(material=material, large_nozzle=large_nozzle, cut_line=0, w_left=1, w_center=1, w_right=1, l_left=l1, l_center=l2, l_right=l3, h_left=h, h_center=h, h_right=h, side_holes=2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
            }

            rotate([0, 0, 90]) {
                translate([0, -block_width(ll-1), 0]) {
                    technic_twist_beam(material=material, large_nozzle=large_nozzle, cut_line=0, w_left=1, w_center=1, w_right=1, l_left=w1, l_center=w2, l_right=w3, h_left=h, h_center=h, h_right=h, side_holes=2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                }
            }
        }
        
        union() {
            if (etch_top_text) {
                edge_text(l=ll, w=ww, h=1, text=text, text_depth=text_depth);
            }
            
            if (etch_bottom_text) {
                translate([block_width(ll-1), 0, block_width(h)]) {
                    rotate([180, 0, 180]) {
                        edge_text(l=ll, w=ww, h=h, text=text, text_depth=text_depth);
                    }
                }
            }
        }
    }
}


module cheese_holes(material, large_nozzle, center, l, w, h, l1, l2, w1, w2, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(h!=undef);
    assert(l1!=undef);
    assert(l2!=undef);
    assert(w1!=undef);
    assert(w2!=undef);
    assert(l >= l1+l2, "l must be at least l1+l2");
    assert(w >= w1+w2, "l must be at least l1+l2");
    assert(center >= 0, "center must be at least 0");
    assert(center <= 4, "center must be at most 4");
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    if (center > 1) {
        if (l2 > 0 && center != 3) {
            side_cheese_holes(material=material, large_nozzle=large_nozzle, w=w, l1=l1, l2=l2, h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }
        
        if (w2 > 0 && center != 3) {
            end_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w1=w1, w2=w2, h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }
        
        if (w > 2 && l > 2 && center !=2) {
            bottom_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
            
            top_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }
    }
}


module side_cheese_holes(material, large_nozzle, w, l1, l2, h, horizontal_skin, vertical_skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(w!=undef);
    assert(l1!=undef);
    assert(l2!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    for (i = [0:l2-1]) {
        for (j = [0:h-1]) {
            translate([block_width(l1+i)+horizontal_skin, block_width(-0.5)+horizontal_skin, block_width(0.5+j)-vertical_skin]) {
                rotate([-90, 0, 0]) {
                    axle_hole(material=material, large_nozzle=large_nozzle, hole_type=2, radius=material_axle_hole_radius(material=material, large_nozzle=large_nozzle), length=block_width(w));
                }
            }
        }
    }    
}


module end_cheese_holes(material, large_nozzle, l, w1, w2, h, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w1!=undef);
    assert(w2!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    translate([block_width(l-1), 0, 0]) {
        rotate([0, 0, 90]) {
            side_cheese_holes(material=material, large_nozzle=large_nozzle, w=l, l1=w1, l2=w2, h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }
    }
}


module bottom_cheese_holes(material, large_nozzle, w, l, h, horizontal_skin, vertical_skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(w!=undef);
    assert(l!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    for (i = [1:l-2]) {
        for (j = [1:w-2]) {
            translate([block_width(i)-horizontal_skin, block_width(j)-horizontal_skin, -vertical_skin]) {
                 axle_hole(material=material, large_nozzle=large_nozzle, hole_type=2, radius=material_axle_hole_radius(material=material, large_nozzle=large_nozzle), length=block_width(h)+2*_defeather);
            }
        }
    }    
}


module top_cheese_holes(material, large_nozzle, w, l, h, horizontal_skin, vertical_skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(w!=undef);
    assert(l!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    translate([block_width(0), block_width(w-1), block_width(h)]) {
        
        rotate([180, 0, 0]) {
            bottom_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }
    }
}


module corner_tabs(l, w, cover_h, horizontal_skin, vertical_skin) {
    assert(l!=undef);
    assert(w!=undef);
    assert(cover_h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    tab_h = block_width(cover_h-0.5)-(cover_h==1 ? 2*vertical_skin : 0);

    translate([block_width(0.5)-horizontal_skin, block_width(w-1.5)+horizontal_skin, tab_h])
        corner_tab(-90);
            
    translate([block_width(l-1.5)+horizontal_skin, block_width(w-1.5)+horizontal_skin, tab_h])
        corner_tab(180);
            
    translate([block_width(l-1.5)+horizontal_skin, block_width(0.5)-horizontal_skin, tab_h])
        corner_tab(90);
            
    translate([block_width(0.5)-horizontal_skin, block_width(0.5)-horizontal_skin, tab_h])
        corner_tab(0);
}


// A quarter round part sticking out from the side wall to hold down the board
module corner_tab(rotation) {
    assert(rotation!=undef);
    
    s = block_width(0.5);
    intersection() {
        cylinder(h=s, r1=0, r2=s);
        rotate([0, 0, rotation])
            cube([s, s, s]);
    }
}


// A half round part sticking out from the side wall to hold down the board
module half_tab(rotation) {
    assert(rotation!=undef);
    
    s = block_width(0.5);
    intersection() {
        cylinder(h=s, r1=0, r2=s);
        rotate([0, 0, rotation])
            translate([0, -s, 0])
                cube([s, 2*s, s]);
    }
}
