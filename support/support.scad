/*
PELA Robot Hand

Print Support

Published at http://robothand.PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <support/support.scad>
*/

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>




///////////////////////////////
// DISPLAY
///////////////////////////////

// support_set(material=material, large_nozzle=large_nozzle, l=4, w=3, height=10);


// Limit twisting to +/- 20 degrees so the support will be strong but not iminge on any nearby structures
/*translate([4, -4, 0]) {
    smr = 40;
    rotate([0, 0, -smr/2])
    support(support_side_length=3, support_max_rotation=smr, height=10);
}*/

// Show an example of limited twisting when support_max_rotation is >0 
/*translate([12, -4, 0]) {
    support(support_side_length=3, support_max_rotation=1, height=10);
}*/


////////////////////////////
// MODULES
///////////////////////////


// A twisted triangular column to aid in additive manufacturing print-time strength
module support(height=undef, support_side_length=_support_side_length, support_layer_height=_support_layer_height, support_layer_rotation=_support_layer_rotation, support_max_rotation=_support_max_rotation) {

    assert(height!=undef);
    assert(support_side_length!=undef);
    assert(support_layer_height!=undef);
    assert(support_layer_rotation!=undef);
    assert(support_max_rotation!=undef);

    layer_count = ceil(height/support_layer_height);

    translate([0, 0, height]) {
        intersection() {
            union() {
                for (i = [0:1:layer_count]) {
                    angle=support_max_rotation > 0 ? abs((i*support_layer_rotation % support_max_rotation)-support_max_rotation/2) : i*support_layer_rotation;
                    translate([0, 0, -i*support_layer_height]) {
                        support_triangle(support_side_length=support_side_length, support_layer_height=support_layer_height, angle=angle);
                    }
                }
            }

            translate([-support_side_length, -support_side_length, -height]) {
                cube([2*support_side_length, 2*support_side_length, height]);
            }
        }
    }
}


// One side of one layer of a support triangle
module support_line(support_side_length=undef, support_layer_height=undef) {

    assert(support_side_length!=undef);
    assert(support_layer_height!=undef);

    hull() {
        cylinder(d=support_line_width(), h=support_layer_height, $fn=6);

        translate([0, support_side_length, 0]) {
            cylinder(d=support_line_width(), h=support_layer_height, $fn=6);
        }
    }
}

// One layer of a support made up of three lines
module support_triangle(support_side_length=undef, support_layer_height=undef, angle=undef) {

    assert(support_side_length!=undef);
    assert(support_layer_height!=undef);
    assert(angle!=undef);

    support_side_length = support_side_length-support_line_width();

    translate([support_side_length/2*sin(30+angle), -support_side_length/2*cos(30+angle), -support_layer_height]) {
        rotate([0, 0, angle]) {
            support_line(support_side_length=support_side_length, support_layer_height=support_layer_height);
            rotate([0, 0, 60]) {
                support_line(support_side_length=support_side_length, support_layer_height=support_layer_height);
            }

            translate([0, support_side_length, 0]) {
                rotate([0, 0, 120]) {
                    support_line(support_side_length=support_side_length, support_layer_height=support_layer_height);
                }
            }
        }
    }
}


// Add support columns above each bottom socket to hold up the roof of a PELA block which has been hollowed out
module support_set(material=undef, large_nozzle=undef, corner_supports=true, l=undef, w=undef, height=undef, support_max_rotation=undef, support_side_length=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(corner_supports!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(height!=undef);
    assert(support_max_rotation!=undef);
    assert(support_side_length!=undef);

    if (h>0 && support_side_length>0) {
        support_side_length = 1.5*override_ring_radius(material=material, large_nozzle=large_nozzle);
        for (x=[0:1:l-1]) {
            for (y=[0:1:w-1]) {
                if (corner_supports || !((x==0 || x==l-1) && (y==0 || y==w-1))) {
                    translate([block_width(x+0.5), block_width(y+0.5), 0]) {
                        support(support_max_rotation=support_max_rotation, height=height, support_side_length=support_side_length);
                    }
                }
            }
        }
    }
}
