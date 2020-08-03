/*
Base PELA Parametric Block

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
    include <style.scad>
    use <PELA-block.scad>

All modules have sensible defaults derived from <style.scad>. 
You can ignore values you are not tampering with and only need to pass a
parameter if you are overriding.

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <style.scad>
include <material.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;



/* [Block] */

// Model length [blocks]
_l = 4; // [1:1:20]

// Model width [blocks]
_w = 2; // [1:1:20]

// Model height [blocks]
_h = 1; // [1:1:20]

// Add interior fill for the base layer
_solid_first_layer = false;

// Add interior fill for upper layers
_solid_upper_layers = false;

// Presence of top connector knobs
_knobs = true;

// How tall are top connectors [mm]
_knob_height = 1.8; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Add connectors to the bottom of the block
_sockets = true;


/////////////////////////////////////
// PELA display
/////////////////////////////////////

PELA_block(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, knob_height=_knob_height, knob_flexture_height=_knob_flexture_height, sockets=_sockets, knobs=_knobs, knob_vent_radius=_knob_vent_radius, skin=_skin, top_shell=_top_shell, bottom_stiffener_width=_bottom_stiffener_width, bottom_stiffener_height=_bottom_stiffener_height, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius, ridge_width=_ridge_width, ridge_depth=_ridge_depth, solid_upper_layers=_solid_upper_layers, solid_first_layer=_solid_first_layer, block_height=_block_height, socket_insert_bevel=_socket_insert_bevel);



/////////////////////////////////////
// MODULES
/////////////////////////////////////

module PELA_block(material, large_nozzle, cut_line=_cut_line, l, w, h, knob_height, knob_flexture_height, sockets, knobs, knob_vent_radius, skin, top_shell, bottom_stiffener_width, bottom_stiffener_height, corner_bolt_holes, bolt_hole_radius, ridge_width, ridge_depth, solid_upper_layers, solid_first_layer, block_height, socket_insert_bevel, bottom_tweak, top_tweak) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(sockets!=undef);
    assert(knobs!=undef);
    if (knobs) {
        assert(knob_vent_radius!=undef);
        assert(knob_height!=undef);
        assert(knob_flexture_height!=undef);
    }
    assert(skin!=undef);
    assert(top_shell!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);
    assert(ridge_width!=undef);
    assert(ridge_depth!=undef);
    assert(solid_upper_layers!=undef);
    assert(solid_first_layer!=undef);
    assert(block_height!=undef);
    assert(socket_insert_bevel!=undef);
    
    difference() {
        block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, knob_height=knob_height, knob_flexture_height=knob_flexture_height, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, top_shell=top_shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, solid_first_layer=solid_first_layer, block_height=block_height, socket_insert_bevel=socket_insert_bevel, bottom_tweak=bottom_tweak, top_tweak=top_tweak);

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height, skin=skin);
    }
}


// Negative space used to display the interior of a model
module cut_space(material, large_nozzle, cut_line=_cut_line, l, w, h, block_height, knob_height, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(block_height!=undef);
    assert(knob_height!=undef);
    assert(skin!=undef);

    vc = visual_cut(cut_line=cut_line, w=w);
    
    if (vc > 0) {
        cw = block_width(l) ;
        ch = block_height(h, block_height) + knob_height;
    
        color("red") translate([skin-_defeather, skin-_defeather, -_defeather]) {
            cube([cw - 2*skin + 2*_defeather, vc - 2*skin + _defeather, ch + 2*_defeather]);
        }
    }
}


module block(material, large_nozzle, l, w, h, knob_height, knob_flexture_height, sockets, knobs, knob_vent_radius, skin, top_shell, bottom_stiffener_width, bottom_stiffener_height, corner_bolt_holes, bolt_hole_radius, ridge_width, ridge_depth, solid_upper_layers, solid_first_layer, block_height, socket_insert_bevel, bottom_tweak, top_tweak) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l > 0);
    assert(w > 0);
    assert(h > 0);
    assert(knob_height!=undef);
    assert(knob_flexture_height!=undef);
    assert(sockets!=undef);
    assert(knobs!=undef);
    assert(knob_vent_radius!=undef);
    assert(skin!=undef);
    assert(top_shell!=undef);
    assert(bottom_stiffener_width!=undef);
    assert(bottom_stiffener_height!=undef);
    assert(corner_bolt_holes!=undef);
    assert(bolt_hole_radius!=undef);
    assert(ridge_width!=undef);
    assert(ridge_depth!=undef);
    assert(solid_upper_layers!=undef);
    assert(solid_first_layer!=undef);
    assert(block_height!=undef);
    assert(socket_insert_bevel!=undef);

    bt = override_bottom_tweak(material=material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak);
    
    difference() {
        union() {
            outer_side_shell(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_shell=top_shell, block_height=block_height, skin=skin);

            if (knobs) {
                top_knob_set(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, knob_height=knob_height, corner_bolt_holes=corner_bolt_holes, block_height=block_height, top_tweak=top_tweak);
            }

            beam_h = h > 1 ? 1 : h;

            if (h >= block_height(2/3, block_height=block_height)) {
                translate([0, 0, block_height(h-1, block_height=block_height)])
                    bottom_stiffener_beam_set(material=material, large_nozzle=large_nozzle, l=l, w=w, h=beam_h, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height, skin=skin);
            }

            if (sockets) {
                length = block_height(min(1, h), block_height=block_height);

                socket_set(material=material, large_nozzle=large_nozzle, l=l, w=w, length=length, sockets=sockets, bottom_tweak=bt);

                translate([block_width(-0.5), block_width(-0.5)])
                    intersection() {
                        cube([block_width(l+1), block_width(w+1), length]);

                        socket_set(material=material, large_nozzle=large_nozzle, l=l+1, w=w+1, length=length, sockets=sockets, bottom_tweak=bt);
                    }
            }

            if (corner_bolt_holes) {
                corner_bolt_hole_supports(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
            }

            if (solid_first_layer || !sockets) {
                fill_first_layer(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height, skin=skin);
            } else if (h>1) {
                bottom_stiffener_beam_set(material=material, large_nozzle=large_nozzle, l=l, w=w, h=beam_h, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height, skin=skin);
            }
            
            if (h>1 && solid_upper_layers) {
                fill_upper_layers(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height, skin=skin);
            }
        }

        union() {
            skin(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth,block_height=block_height);
            
            if (knobs) {
                knob_flexture_set(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius, corner_bolt_holes=corner_bolt_holes, block_height=block_height);
            }
                
            length = block_height(h, block_height)-top_shell;

            double_socket_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, length=length, alternate_length=length, bevel_socket=true, socket_insert_bevel=socket_insert_bevel, bottom_tweak=bt);
            
            if (corner_bolt_holes) {
                corner_corner_bolt_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius, block_height=block_height);
            }
        }
    }
}


module double_socket_hole_set(material, large_nozzle, l, w, sockets, alternate_length, length, bevel_socket, socket_insert_bevel, bottom_tweak) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l>=1);
    assert(w>=1);
    assert(sockets!=undef);
    assert(alternate_length>=_official_knob_height/2);
    assert(length>=_official_knob_height/2);
    assert(bevel_socket!=undef);
    assert(socket_insert_bevel!=undef);
    assert(bottom_tweak!=undef);

    if (sockets) {
        rr = override_ring_radius(material=material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak);
        rt = ring_thickness(large_nozzle=large_nozzle);

        alternating_radius = 2/3*(rr-rt);
        alternating_fn = _axle_hole_fn;
        alternating_length = alternate_length+2*_defeather;

        if (l > 1 && w > 1) {
            translate([block_width(), block_width(), -_defeather]) {
                socket_hole_set(material=material, large_nozzle=large_nozzle, sockets=sockets, is_socket=false, l=l-1, w=w-1, radius=alternating_radius, length=alternating_length, bevel_socket=bevel_socket, ring_fn=alternating_fn, socket_insert_bevel=socket_insert_bevel);
            }
        }

        translate([block_width(0.5), block_width(0.5), -_defeather]) {
            socket_hole_set(material=material, large_nozzle=large_nozzle, sockets=sockets, is_socket=true, l=l, w=w, radius=rr-rt, length=length+2*_defeather, bevel_socket=bevel_socket, ring_fn=_ring_fn, socket_insert_bevel=socket_insert_bevel);
        }
    }
}


// Make the bottom layer be solid instead of mostly open space
module fill_first_layer(material, large_nozzle, l, w, h, block_height, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    fill_height = block_height(min(1, h), block_height=block_height);

    translate([skin, skin, 0]) {
        cube([block_width(l)-2*skin, block_width(w)-2*skin, fill_height]);
    }
}


// Make layers above the bottom layer be solid instead of mostly open space
module fill_upper_layers(material, large_nozzle, l, w, h, block_height, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    translate([skin, skin, block_height(1, block_height=block_height)]) {
        cube([block_width(l)-2*skin, block_width(w)-2*skin, block_height(h-1, block_height=block_height)]);
    }
}


// Several blocks in a grid, one knob per block
module top_knob_set(material, large_nozzle, l, w, h, knob_height, corner_bolt_holes, block_height, top_tweak) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(knob_height!=undef);
    assert(corner_bolt_holes!=undef);
    assert(block_height!=undef);

    for (i = [0:1:l-1]) {
        for (j = [0:1:w-1]) {
            if (!(corner_bolt_holes && is_corner(x=i, y=j, l=l, w=w))) {
                translate([block_width(i), block_width(j), 0]) {
                    top_knob(material=material, large_nozzle=large_nozzle, h=h, knob_height=knob_height, block_height=block_height, top_tweak=top_tweak);
                }
            }
        }
    }
}


// The connector cylinder
module top_knob(material, large_nozzle, h, knob_height, block_height, top_tweak) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(h!=undef);
    assert(knob_height!=undef);
    assert(block_height!=undef);

    translate([block_width(0.5), block_width(0.5), block_height(h, block_height)]) {
        knob(material=material, large_nozzle=large_nozzle, knob_height=knob_height, top_tweak=top_tweak);
    }
}


// The cylinder on top of a PELA block
module knob(material, large_nozzle, knob_height, top_tweak) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(knob_height>=0);

    if (knob_height > 0) {
        bevel = knob_bevel(material=material);
        knob_radius = override_knob_radius(material=material, large_nozzle=large_nozzle, top_tweak=top_tweak);

        cylinder(r=knob_radius, h=knob_height-bevel);

        if (bevel > 0) {
            translate([0, 0, knob_height-bevel]) {
                intersection() {
                    cylinder(r=knob_radius, h=bevel);
                    cylinder(r1=knob_radius, r2=0, h=1.5*(knob_radius));
                }
            }
        }
    }
}

// An array of empty cylinders to fit inside a knob_set()
module knob_flexture_set(material, large_nozzle, l, w, h, knob_height, knob_flexture_height, knob_vent_radius, corner_bolt_holes, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(knob_height!=undef);
    assert(knob_flexture_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(corner_bolt_holes!=undef);
    assert(block_height!=undef);

    for (i = [0:l-1]) {
        for (j = [0:w-1]) {
            if (!corner_bolt_holes || !is_corner(x=i, y=j, l=l, w=w)) {
                translate([block_width(i+0.5), block_width(j+0.5), block_height(h, block_height)]) {
                    
                    knob_flexture(material=material, large_nozzle=large_nozzle, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius);
                }
            }
        }
    }
}


// The negative space flexture inside a single knob
module knob_flexture(material, large_nozzle, knob_height, knob_flexture_height, knob_vent_radius) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(knob_height!=undef);
    assert(knob_flexture_height!=undef);
    assert(knob_vent_radius!=undef);

    if (knob_vent_radius > 0) {
        translate([0, 0, -2*knob_height]) {
            cylinder(r=knob_vent_radius, h=3*knob_height+_defeather);
        }
    } else if (knob_flexture_height > 0) {
        translate([0, 0, knob_height-_knob_top_thickness-knob_flexture_height]) {
            cylinder(r=knob_flexture_radius(material=material), h=knob_flexture_height);
        }
    }
}


// That solid outer skin of a block set
module outer_side_shell(material, large_nozzle, l, w, h, top_shell, block_height, skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(top_shell!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    ss = side_shell(large_nozzle);

    difference() {
        translate([skin, skin, 0]) {
            cube([block_width(l)-2*skin, block_width(w)-2*skin, block_height(h, block_height)]);
        }

        translate([ss+skin, ss+skin, -top_shell]) {
            cube([block_width(l)-2*skin - 2*ss, block_width(w)-2*skin - 2*ss, block_height(h, block_height)]);
        }
    }
}


// A solid block, no knobs or connectors. This is provided as a convenience for constructive solid geometry designs based on this block
module skinned_block(material, large_nozzle, l, w, h, ridge_width, ridge_depth, block_height, skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(ridge_width!=undef);
    assert(ridge_depth!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    difference() {
        hull() {
            outer_side_shell(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_shell=1, block_height=block_height, skin=skin);
        }

        skin(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth, block_height=block_height);
    }
}


// Bars layed below a horizontal surface to make it stronger
module bottom_stiffener_beam_set(material, large_nozzle, l, w, h, start_l, end_l, start_w, end_w, bottom_stiffener_width, bottom_stiffener_height, block_height, skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(start_l!=undef);
    assert(end_l!=undef);
    assert(start_w!=undef);
    assert(end_w!=undef);
    assert(bottom_stiffener_width!=undef);
    assert(bottom_stiffener_height!=undef);
    assert(block_height!=undef);
    assert(skin!=undef);

    cut_width = bottom_stiffener_width/6;
    translate([0, 0, block_height(h, block_height)-bottom_stiffener_height]) {
        if (end_l >= start_l) {
            for (i = [start_l:end_l]) {            
                translate([block_width(i)-(bottom_stiffener_width)/2, skin, 0]) {
                    difference() {
                        cube([bottom_stiffener_width, block_width(w)-2*skin, bottom_stiffener_height]);
                    
                        translate([(bottom_stiffener_width-cut_width)/2, 0, -_defeather]) {
                            cube([cut_width, block_width(w)-2*skin, bottom_stiffener_height+_defeather]);
                        }
                    }
                }
            }
        }
        
        if (end_w >= start_w) {
            for (j = [start_w:end_w]) {
                translate([skin, block_width(j)-(bottom_stiffener_width)/2, 0]) {
                    difference() {
                        cube([block_width(l)-2*skin, bottom_stiffener_width, bottom_stiffener_height]);
                    
                        translate([0, (bottom_stiffener_width-cut_width)/2, -_defeather]) {
                            cube([block_width(l)-2*skin, cut_width, bottom_stiffener_height+_defeather]);
                        }
                    }
                }
            }
        }
    }
}


// Bottom connector rings positive space for multiple blocks
module socket_set(material, large_nozzle, l, w, length, sockets, bottom_tweak) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(length!=undef);
    assert(sockets!=undef);
    assert(bottom_tweak!=undef);

    if (sockets && (l>1 && w>1)) {
        for (i = [1:l-1]) {
            for (j = [1:w-1]) {
                translate([block_width(i), block_width(j), 0]) {
                    socket_ring(material=material, large_nozzle=large_nozzle, length=length, bottom_tweak=bottom_tweak);
                }
            }
        }
    }
}


// The circular bottom insert for attaching knobs
module socket_ring(material, large_nozzle, length, bottom_tweak) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(length!=undef);
    assert(bottom_tweak!=undef);

    render(convexity=2) {
        rotate([0, 0, 180/_ring_fn]) {
            r = override_ring_radius(material=material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak);

            cylinder(r=r, h=length, $fn=_ring_fn);
        }
    }
}


// Bottom connector- negative flexture space inside bottom rings for multiple blocks
module socket_hole_set(material, large_nozzle, sockets, is_socket=true, l, w, radius, length, bevel_socket=_bevel_socket, socket_insert_bevel=_socket_insert_bevel, ring_fn=_ring_fn) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(sockets!=undef);
    assert(is_socket!=undef);
    assert(l>=1);
    assert(w>=1);
    assert(radius!=undef);
    assert(length>=_official_knob_height/2);
    assert(bevel_socket!=undef);
    assert(socket_insert_bevel!=undef);
    assert(ring_fn!=undef);

    if (sockets && l>0 && w>0) {
        for (i = [0:l-1]) {
            for (j = [0:w-1]) {
                translate([block_width(i), block_width(j), 0]) {
                    render(convexity=2) {
                        socket_hole(material=material, large_nozzle=large_nozzle, is_socket=is_socket, radius=radius, length=length, bevel_socket=bevel_socket, socket_insert_bevel=socket_insert_bevel, ring_fn=ring_fn);
                    }
                }
            }
        }
    }
}


// Hole with side grip ridge flexture to grab any knob on a block inserted from below
module socket_hole(material, large_nozzle, is_socket=true, radius, length, bevel_socket=_bevel_socket, ring_fn, socket_insert_bevel=_socket_insert_bevel) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(is_socket!=undef);
    assert(radius!=undef);
    assert(length>=_official_knob_height/2);
    assert(bevel_socket!=undef);
    assert(ring_fn!=undef);
    assert(socket_insert_bevel!=undef);

    h2 = is_socket ? _official_knob_height/2 : 0;
    h3 = h2 + 2*_defeather + socket_insert_bevel;
    h4 = length - h2 + 2*_defeather;
    bevel_h = bevel_socket ? socket_insert_bevel : 0;

    rotate([0, 0, 180/ring_fn]) {
        cylinder(r=radius, h=bevel_h + _defeather, $fn=ring_fn);

        translate([0, 0, bevel_h - _defeather]) {
            cylinder(r=radius - side_lock_thickness(material=material), h=h3, $fn=ring_fn);
        }

        translate([0, 0, h2]) {
            cylinder(r=radius, h=h4, $fn=ring_fn);
        }
    }
}


// The thin negative space surrounding a PELA block so that two blocks can fit next to each other easily in a tight grid
module skin(material, large_nozzle, l, w, h, skin, ridge_width, ridge_depth, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(skin!=undef);
    assert(ridge_width!=undef);
    assert(ridge_depth!=undef);
    assert(block_height!=undef);

    if (skin > 0) {
        // Front skin
        translate([0, -_defeather, -_defeather]) {
            cube([block_width(l), skin, block_height(h, block_height)+2*_defeather]);
        }

        // Back skin
        translate([0, block_width(w)-skin+_defeather, -_defeather]) {
            cube([block_width(l), skin, block_height(h, block_height)+2*_defeather]);
        }

        // Left skin
        translate([-_defeather, 0, -_defeather]) {
            cube([skin, block_width(w), block_height(h, block_height)+2*_defeather]);
        }
        
        // Right skin
        translate([block_width(l)-skin+_defeather, 0, -_defeather]) {
            cube([skin, block_width(w), block_height(h, block_height)+2*_defeather]);
        }
    }    
    if (ridge_width>0 && ridge_depth>0 && h>1) {
        for (i = [block_height(1, block_height=block_height):block_height():block_height(h, block_height)]) {
            // Front layer ridge
            translate([0, 0, i]) {
                cube([block_width(l), ridge_depth, ridge_width]);
            }
                
            // Back layer ridge
            translate([0, block_width(w)-skin-ridge_depth, i]) {
                cube([block_width(l), ridge_depth, ridge_width]);
            }

            // Left layer ridge
            translate([skin, 0, i]) {
                cube([ridge_depth, block_width(w), ridge_width]);
            }

            // Right layer ridge
            translate([block_width(l) - skin - ridge_depth, 0, i]) {
                cube([ridge_depth, block_width(w), ridge_width]);
            }
        }
    }
}


// Mounting hole support blocks
module corner_corner_bolt_holes(material, large_nozzle, l, w, h, bolt_hole_radius, block_height) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(bolt_hole_radius!=undef);
    assert(block_height!=undef);

    bolt_hole(material=material, large_nozzle=large_nozzle, x=1, y=1, bolt_hole_radius=bolt_hole_radius, h=h, block_height=block_height);
    bolt_hole(material=material, large_nozzle=large_nozzle, x=1, y=w, bolt_hole_radius=bolt_hole_radius, h=h, block_height=block_height);
    bolt_hole(material=material, large_nozzle=large_nozzle, x=l, y=1, bolt_hole_radius=bolt_hole_radius, h=h, block_height=block_height);
    bolt_hole(material=material, large_nozzle=large_nozzle, x=l, y=w, bolt_hole_radius=bolt_hole_radius, h=h, block_height=block_height);
}


// A hole for a mounting bolt in the corners of a panel or block
module bolt_hole(material, large_nozzle, x, y, bolt_hole_radius, h, block_height) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(x!=undef);
    assert(y!=undef);
    assert(bolt_hole_radius!=undef);
    assert(h!=undef);
    assert(block_height!=undef);

    translate([block_width(x-0.5), block_width(y-0.5), 0]) {
        cylinder(r=bolt_hole_radius, h=block_height(h, block_height) + _defeather);
    }
}
    

// Mounting hole support blocks
module corner_bolt_hole_supports(material, large_nozzle, l, w, h, top_shell, bottom_stiffener_height, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(top_shell!=undef);
    assert(bottom_stiffener_height!=undef);
    assert(block_height!=undef);

    bolt_hole_support(material=material, large_nozzle=large_nozzle, x=1, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
    bolt_hole_support(material=material, large_nozzle=large_nozzle, x=1, y=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
    bolt_hole_support(material=material, large_nozzle=large_nozzle, x=l, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
    bolt_hole_support(material=material, large_nozzle=large_nozzle, x=l, y=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
}


// A solid block under the bolt hole to give extra support to the bolt head
module bolt_hole_support(material, large_nozzle, x, y, h, top_shell, bottom_stiffener_height, block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(x!=undef);
    assert(y!=undef);
    assert(h!=undef);
    assert(top_shell!=undef);
    assert(bottom_stiffener_height!=undef);
    assert(block_height!=undef);

    depth = top_shell+bottom_stiffener_height;
    
    translate([block_width(x-1), block_width(y-1), block_height(h, block_height)-depth]) {
        cube([block_width(), block_width(), depth]);
    }
}
