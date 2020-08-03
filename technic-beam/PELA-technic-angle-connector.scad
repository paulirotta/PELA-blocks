/*
PELA technic angle - 3D Printed LEGO-compatible 30 degree bend

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

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-technic-beam.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Angle Connector] */

// Angle between the top and bottom parts of the connector [degrees]
_angle = 30; // [0:180]

// Length of the beam [blocks]
_l = 7; // [1:1:20]

// Width of the beam [blocks]
_w_top = 1; // [1:1:20]

// Width of the beam [blocks]
_w_bottom = 1; // [1:1:20]

// Top beam height [blocks]
_h_top = 1; // [1:1:30]

// Bottom beam height [blocks]
_h_bottom = 1; // [1:1:30]



/* [Advanced] */

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_angle_connector(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, angle=_angle, l=_l, w_top=_w_top, w_bottom=_w_bottom, h_top=_h_top, h_bottom=_h_bottom, side_holes=_side_holes, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_angle_connector(material, large_nozzle, cut_line=_cut_line,angle, l, w_top, w_bottom, h_top, h_bottom, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(angle >= 0, "Angle connector must be 0-180 degrees")
    assert(angle <= 180, "Angle connector must be 0-180 degrees")
    assert(l!=undef);
    assert(w_top!=undef);
    assert(w_bottom!=undef);
    assert(h_top!=undef);
    assert(h_bottom!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    difference() {
        union() {
            translate([0, 0, block_width(h_bottom)-2*vertical_skin]) {
                rotate([angle, 0, 0]) {
                    translate([0, block_width(0.5), 0]) {
                        technic_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w_top, h=h_top, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                    }
                }
            }

            translate([0, block_width(0.5), 0]) {
                    technic_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w_bottom, h=h_bottom, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
            }

            increment = 1;
            for (theta = [0 : increment : angle]) {
                translate([0, 0, -2*vertical_skin]) {
                    pie_slice(material=material, large_nozzle=large_nozzle, theta=theta, increment=increment, l=l, w=1, h=h_bottom, horizontal_skin=horizontal_skin);
                }
            }
        }

        translate([block_width(-0.5), -sin(angle)*block_width(h_top+1), 0]) {
           cut_space(material=material, large_nozzle=large_nozzle, w=l, l=max(w_top, w_bottom), cut_line=cut_line, h=h_bottom+1, block_height=_block_height, knob_height=_knob_height, skin=horizontal_skin);
        }
    }
}



// theta-degree spacer between the two segments
module pie_slice(material, large_nozzle, theta, increment, l, w, h, horizontal_skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(theta!=undef);
    assert(increment!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    
    translate([0, 0, block_width(h)]) {
        rotate([theta, 0 , 0]) {
            difference() {
                hull() {
                    technic_beam_slice(material=material, large_nozzle=large_nozzle, l=l, horizontal_skin=horizontal_skin);

                    rotate([increment, 0, 0]) {
                        technic_beam_slice(material=material, large_nozzle=large_nozzle, l=l, horizontal_skin=horizontal_skin);
                    }
                }

                for (n = [0:1:l-1]) {
                    translate([block_width(n), 0, 0]) {
                        hull() {
                            translate([0, 0, -_defeather]) {
                                technic_beam_slice_negative(material=material, large_nozzle=large_nozzle, w=w, l=0);
                            }

                            rotate([increment, 0, 0]) {
                                translate([0, 0, _defeather]) {
                                    technic_beam_slice_negative(material=material, large_nozzle=large_nozzle, w=w, l=0);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}