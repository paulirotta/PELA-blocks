/*
Parametric PELA Print Tuning Parameters

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Imported automatically into other design files when you include parameters:
    include <style.scad>
 

INSTRUCTIONS
============
1. Print a calibration beam for your desired material.

2. Test fit the (a) top knobs, (b) bottom sockets, (c) technic holes on the side. Write down those three numbers.

3. Update those numbers in this file. Example: print a "PLA" calibration beam with your favorite PLA and slicer settings. After testing, your PELA top knob best fit to LEGO sockets is -0.08, PELA bottom socket best fit to LEGO knobs is 0.04, and PELA side hole best fit with a technic pin is 0.06. So you edit the "pla_m" material line 71 to look like:
    69:    // [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak];
    70:    pla = 0; // Polymaker Polylite
    71:    pla_m = ["PLA", false, -0.08, 0.04, 0.06];


SUGGESTIONS
===========
- Save yourself time- if a part is available commercially, buy it and use it. Print the part yourself when you need something special (shape, function, color, material..).

- Make sure set the material before you print the calibration block. These affect the label on the block and, if the material is flexible, also the size of some flexures.

- PELA are designed to print upright and need little or no post processing. Most models should be printed without supports or offer optional support pre-placed in the model.

- PELA parts do need good inter-layer adhesion. Consider reducing the fan speed if you get delamination.

- Turn down the bed heater on low temperature materials like PLA. This helps avoid "elephant foot" expansion of the bottom edges of sockets. Use an adhesive or turn on 'brim, outside only' if you need more adhesion with less heat.

- Most printing materials are slippery or stiff which is not ideal. Technic connectors are less tricky to calibrate and use in general but especially with slippery materials like Nylon or stiff materials like NGEN.

- Flexible materials are "tough" rather than stiff. TPU85, TPU95 and Nylon are ideal and virtually indistructable. Some brands of PLA are more flexible than others. Brittle materials will not have as good a fit or a long life- they may chip or crack.

- Printing fast and with tall layers is generally fine for PELA models.

- Smaller nozzles and resin printers allow you to print lighter, finer PELA blocks. If 'large_nozzle' (>= 0.5mm) is true, the models will adjust the bottom socket geometry to make some of the inner structures thicker. If you have a small nozzle but find printing small walls in bottom sockets with your material difficult, you can safely set 'large_nozzle' to true.
*/


/* [README] */

// Unfortunately the customizer does not yet support changing parameters which are then used in other files. Please 

/* [Hidden] */


// The following fields make up a simple data structure for each printing material
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak];
name_index = 0; // The "name" field is kept short for printing on calibration blocks
flex_index = 1;
top_tweak_index = 2;
bottom_tweak_index = 3;
axle_hole_tweak_index = 4;

// If you need to re-calibrate, update the numbers below based on tests with your printer and slicer 
// These reference numbers are tested on Taz 6, Ultimaker 2+, Ultimaker 3 and Mass Portal ED printers
// Tests were sliced with Simplify 3D, Cura and Lulzbot Cura
// If you add new materials below, do a global search and replace to update the customizer material list at the top of each file.
// (Yeah, we know.. This is not a real programming language. Don't shoot the messenger.)

pla = 0; // Polymaker Polylite
// PLA, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
pla_m = ["PLA", false, -0.08, 0.04, 0.07];
// PLA, large nozzle (>= 0.5mm) calibration settings
pla_lm = ["PLA", false, -0.08, 0.04, 0.07];

abs = 1; // Polymaker ABS
// ABS, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
abs_m = ["ABS", false, -0.18, 0.16, 0.14];
// ABS, large nozzle (>= 0.5mm) calibration settings
abs_lm = ["ABS", false, -0.06, 0.0, 0.08];

//TODO Polycarboniate large test technics- abs_lm = ["ABS", false, -0.06, 0.16, 0.14];


pet = 2; // Innoflil3D rPET
// PET, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
pet_m = ["PET", false, 0.04, 0.10, 0.04];
// PET, large nozzle (>= 0.5mm) calibration settings
pet_lm = ["PET", false, 0.04, 0.10, 0.04];

bio_silk = 3; // Biofila Silk
// BIO SILK, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
bio_silk_m = ["Silk", false, 0.0, 0.0, -0.04];
// BIO SILK, large nozzle (>= 0.5mm) calibration settings
bio_silk_lm = ["Silk", false, 0.0, 0.0, -0.04];

pro1 = 4; // Innofil3D Pro1
// PRO1, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
pro1_m = ["Pro1", false, -0.06, 0.08, 0.04];
// PRO1, large nozzle (>= 0.5mm) calibration settings
pro1_lm = ["Pro1", false, -0.06, 0.08, 0.04];

ngen = 5; // NGEN
// NGEN, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
ngen_m = ["NGEN", false, -0.04, 0.08, 0.08];
// NGEN, large nozzle (>= 0.5mm) calibration settings
ngen_lm = ["NGEN", false, -0.04, 0.08, 0.08];

ngen_flex = 6; // NGEN Flex
// NGEN FLEX, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
ngen_flex_m = ["NGEN-F", false, 0.02, 0.02, 0.0];
// NGEN FLEX, large nozzle (>= 0.5mm) calibration settings
ngen_flex_lm = ["NGEN-F", false, 0.02, 0.02, 0.0];

nylon = 7; // Taulman Bridge Nylon
// NYLON, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
nylon_m = ["Nylon", true, -0.02, 0.15, 0.06];
// NYLON, large nozzle (>= 0.5mm) calibration settings
nylon_lm = ["Nylon", true, -0.02, 0.15, 0.06];

tpu95 = 8; // Polymaker TPU95 and Ultimaker TPU95
// TPU95, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
tpu95_m = ["TPU95", true, -0.06, -0.02, -0.1];
// TPU95, large nozzle (>= 0.5mm) calibration settings
tpu95_lm = ["TPU95", true, -0.06, -0.02, -0.1];

tpu85 = 9; // Ninjaflex and Innoflex TPU85
// TPU85, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
tpu85_m = ["TPU85", true, 0.04, -0.08, -0.2];
// TPU85, large nozzle (>= 0.5mm) calibration settings
tpu85_lm = ["TPU85", true, 0.04, -0.06, 0.15];

pc = 10; // Polycarbonite
// PC, fine nozzle (< 0.5mm) calibration settings
// [name, flexible_material, top_tweak, bottom_tweak, axle_hole_tweak]
pc_m = ["PC", true, -0.08, 0.12, 0.14];
// TPU85, large nozzle (>= 0.5mm) calibration settings
pc_lm = ["PC", true, -0.08, 0.12, 0.14];

materials = [pla_m, abs_m, pet_m, bio_silk_m, pro1_m, ngen_m, ngen_flex_m, nylon_m, tpu95_m, tpu85_m, pc_m];
large_nozzle_materials = [pla_lm, abs_lm, pet_lm, bio_silk_lm, pro1_lm, ngen_lm, ngen_flex_lm, nylon_lm, tpu95_lm, tpu85_lm, pc_lm];

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// private function - get a named property from the materials data structure
function material_property(material, large_nozzle, property) = large_nozzle ? large_nozzle_materials[material][property] : materials[material][property];

// Return the short name string from the material
function material_name(material) = materials[material][name_index];

// Return true if this material is flexible
function is_flexible(material) = materials[material][flex_index];

// Return the bottom tweak from the material
function material_bottom_tweak(material, large_nozzle) = material_property(material=material, large_nozzle=large_nozzle, property=bottom_tweak_index);

// Return bottom tweak="bt" if provided for calibration, otherwise use the material value
function override_bottom_tweak(material, large_nozzle, bottom_tweak=undef) = (bottom_tweak == undef) ? material_bottom_tweak(material=material, large_nozzle=large_nozzle) : bottom_tweak;

// Return the axle hole tweak from the material
function material_axle_hole_tweak(material, large_nozzle) = material_property(material=material, large_nozzle=large_nozzle, property=axle_hole_tweak_index);

// Return axle hole tweak="at" if provided for calibration, otherwise use the material
function override_axle_hole_tweak(material, large_nozzle, axle_hole_tweak=undef) = (axle_hole_tweak == undef) ? material_axle_hole_tweak(material=material, large_nozzle=large_nozzle) : axle_hole_tweak;

// Private function, axle hole radius
function axle_hol_rad(at) = 2.45 + at;

// Return the axle hole radius based on the material
function material_axle_hole_radius(material, large_nozzle) = axle_hol_rad(material_axle_hole_tweak(material=material, large_nozzle=large_nozzle));

// Return axle hole radius based on the axle hole tweak (at) if provided, otherwise based on the material
function override_axle_hole_radius(material, large_nozzle, axle_hole_tweak=undef) = axle_hol_rad(override_axle_hole_tweak(material=material, large_nozzle=large_nozzle, axle_hole_tweak=axle_hole_tweak));

// Private function, knob radius
function knb_rad(top_tweak=undef) = 2.57 + top_tweak;

// Private function, knob radius
function rng_rad(bottom_tweak=undef) = 2.75 + bottom_tweak;

// Return top tweak from the material
function material_top_tweak(material, large_nozzle) = material_property(material=material, large_nozzle=large_nozzle, property=top_tweak_index);

// Return top tweak="tt" if provided for calibration, otherwise use the material value
function override_top_tweak(material, large_nozzle, top_tweak=undef) = (top_tweak == undef) ? material_top_tweak(material, large_nozzle) : top_tweak;

// Return knob radius based on top tweak (tt) if provided, otherwise based on the material
function override_knob_radius(material, large_nozzle, top_tweak) = knb_rad(override_top_tweak(material, large_nozzle, top_tweak));

// Bottom connector flexture ring wall thickness (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
function ring_thickness(large_nozzle=undef) = large_nozzle ? 1.2 : 0.8;

// Bottom connector flexture ring size (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
function override_ring_radius(material, large_nozzle, bottom_tweak=undef) = ring_thickness(large_nozzle) + rng_rad(bottom_tweak=(bottom_tweak==undef ? material_property(material=material, large_nozzle=large_nozzle, property=bottom_tweak_index) : bottom_tweak));

// Size of the small flexture cavity inside each knob (set to 0 for flexible materials, if the knobs delaminate and detach, or to avoid holes if the knobs are removed)
function knob_flexture_radius(material=undef) = is_flexible(material) ? 0.6 : 0.8;

// Height of the knob top slope to ease connections (helps compensate for top surface artifacts, 0 to disable)
function knob_bevel(material=undef) = is_flexible(material) ? 0.3 : 0.2;
