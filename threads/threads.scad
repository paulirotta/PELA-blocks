/*
Thread library convenience wrapper for 


Published at https://PELAblocks.org







By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files to set baseline constants:
    use <threads.scad>
*/

use <Yet_another_thread_library_for_OpenSCAD/quickthread.scad>

extrusionNudge = 0.001;

/*
us_bolt_thread(dInch=0.25, hInch=1, tpi=20);

translate([10, 0]) {
    us_nut_thread(dInch=0.25, hInch=1, tpi=20);
}
*/

///////////////////////////////////
// MODULES
///////////////////////////////////

module us_bolt_thread(dInch, hInch, tpi) {
    
    assert(dInch!=undef);
    assert(hInch!=undef);
    assert(tpi!=undef);
    
    isoThread(dInch=dInch, hInch=hInch, tpi=tpi, internal=false);
}


// Negative space, the part to cutout to make a nut
module us_nut_thread() {
    
    assert(dInch!=undef);
    assert(hInch!=undef);
    assert(tpi!=undef);


    isoThread(dInch, hInch, tpi, internal=true);
}
