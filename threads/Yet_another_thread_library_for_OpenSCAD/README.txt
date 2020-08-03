                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


https://www.thingiverse.com/thing:2277141
Yet another thread library for OpenSCAD by arpruss is licensed under the Creative Commons - Attribution license.
http://creativecommons.org/licenses/by/3.0/

# Summary

This is yet another OpenSCAD thread library, and it was more fun to write it than to find a library that did exactly what I wanted. It's designed to be fairly fast: it generates the whole thread polyhedron as a single piece. 

Thread profile is completely flexible. You can specify a counterclockwise polygon of 2D points for the profile or you can use ISO thread profiles. 

There are two modules exposed:
`rawThread(profile, d=diameter, h=height[, lead=lead, $fn=segmentsPerRotation])`: draw thread with specified profile; if `lead` is omitted, it is calculated from the profile
`isoThread(d=majorDiameter, h=height, pitch=pitch[, angle=angle, internal=true/false, lead=lead, starts=starts, $fn=segmentsPerRotation])`: draw metric ISO thread; default angle is 30; default is external thread (male); internal thread is designed for subtraction
If you want to use UTS measurements, you can omit pitch and instead do `tpi=TPI`, and then use `hInch`, `dInch` and `leadInch` instead of the metric versions. I haven't tested the UTS stuff yet.

For left-handed-thread, just mirror things.

If for some reason you want access to the points/faces of the thread polyhedron, these are available from the `threadPoints()` and `extrusionFaces()` functions.

The `extrusionFaces(pointsPerSection, numSections)` function is useful for more general extrusions than threads. It generates a set of triangular faces that can be fed into the `faces=` argument of `polyhedron()` for a tube-like non-self-intersecting extrusion with two end-caps and constant number of points on each cross-section. For a demo of how `extrusionFaces()` can be used to do that, see `twisty.scad`. There is also `tubeFaces()` which omits the end-caps, to be used for closed knots and the like.

**Updates: ** 

* May 10, 2017: Add `starts` option for multi-start thread.
* May 16, 2017: Fix tpi bug. Thank you to AlexeyBobkov.
* May 31, 2017: Refactor functions, making for user-usable `extrusionFaces()` and `tubeFaces()`