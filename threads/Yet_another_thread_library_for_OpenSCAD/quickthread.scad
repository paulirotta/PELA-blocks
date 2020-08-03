function _numSections(numTurns) = 1+numTurns*$fn;

extrusionNudge = 0.001;

function threadPoints(section,radius,numTurns,lead) =
    let (n=len(section),
        m=_numSections(numTurns)
        ) 
        [ for (i=[0:m-1]) for (j=[0:n-1]) 
            let (z=i/$fn*lead,
                angle=(i%$fn)/$fn*360,
                v=section[j])
            [ (radius+v[0])*cos(angle), (radius+v[0])*sin(angle),z+v[1]] ];
        
function mod(m,n) = let(mm = m%n) mm<0 ? n+mm : mm;
        
function extrusionPointIndex(pointsPerSection,sectionNumber,pointInSection) = pointsPerSection*sectionNumber + mod(pointInSection,pointsPerSection);
        
function _extrusionStartFace(pointsPerSection) = 
    [for (i=[0:pointsPerSection-1]) extrusionPointIndex(pointsPerSection,0,i)];
            
function _extrusionEndFace(pointsPerSection, numSections) = 
    [for (i=[pointsPerSection-1:-1:0]) extrusionPointIndex(pointsPerSection,numSections-1,i)];
                
function extrusionTubeFaces(pointsPerSection, numSections) =
            [for (i=[0:numSections-2]) for (j=[0:pointsPerSection-1]) for(tri=[0:1])
                tri==0 ? 
                    [extrusionPointIndex(pointsPerSection,i,j),extrusionPointIndex(pointsPerSection,i+1,j),extrusionPointIndex(pointsPerSection,i,j+1)] :
                    [extrusionPointIndex(pointsPerSection,i,j+1), extrusionPointIndex(pointsPerSection,i+1,j),
            extrusionPointIndex(pointsPerSection,i+1,j+1)]];
                
function extrusionFaces(pointsPerSection, numSections) = concat([_extrusionStartFace(pointsPerSection),_extrusionEndFace(pointsPerSection,numSections)],extrusionTubeFaces(pointsPerSection, numSections));

                    
module rawThread(profile, d=undef, h=10, lead=undef, $fn=72, adjustRadius=false, clip=true, includeCylinder=true) {
    radius = d/2;
    vSize = max([for(v1=profile) for(v2=profile) v2[1]-v1[1]]);
    vMin = min([for(v=profile) v[0]]);
    radiusAdjustment = adjustRadius ? vMin : 0;
    _lead = lead==undef ? vSize : lead;
    profileScale = vSize <= _lead-extrusionNudge ? 1 : (_lead-extrusionNudge)/vSize;
    adjProfile = [for(v=profile) [v[0]-radiusAdjustment,v[1]*profileScale]];
    adjRadius = radius + radiusAdjustment;
    hSize = 1+2*adjRadius + 2*max([for (v=adjProfile) v[0]]);
    numTurns = 2+ceil(h/_lead);
    render(convexity=10)
    union() {
        intersection() {
            if (clip)
                translate([-hSize/2,-hSize/2,0]) cube([hSize,hSize,h]);
            translate([0,0,-_lead]) polyhedron(faces=extrusionFaces(len(adjProfile), _numSections(numTurns)), points=threadPoints(
            adjProfile,adjRadius,numTurns,_lead));
        }
        if (includeCylinder) 
            cylinder(r=adjRadius+extrusionNudge,$fn=$fn,h=h);
    }
}

function inch_to_mm(x) = x * 25.4;

// internal = female
module isoThread(d=undef, dInch=undef, pitch=1, tpi=undef, h=1, hInch=undef, lead=undef, leadInch=undef, angle=30, internal=false, starts=1, $fn=72) {

    P = (tpi==undef) ? pitch : inch_to_mm(1/tpi);

    radius = dInch != undef ? inch_to_mm(dInch)/2 : d/2;    
    height = hInch != undef ? inch_to_mm(hInch) : h;
     
    Dmaj = 2*radius;
    H = P * cos(angle);
    
    _lead = leadInch != undef ? inch_to_mm(leadInch) : lead != undef ? lead : P;
    
    externalExtra=0.03;
    internalExtra=0.057;
    profile = !internal ? 
        [ [-H*externalExtra,(-3/8-externalExtra)*P], 
          [(5/8)*H,-P/16],[(5/8)*H,P/16], 
          [-H*externalExtra,(3/8+externalExtra)*pitch] ] :
        [ [0,-(3/8)*P], 
        [(5/8)*H,-P/16],[(5/8+internalExtra)*H,0],
        [(5/8)*H,P/16],[0,(3/8)*P] ];
    Dmin = Dmaj-2*5*H/8;
    myFN=$fn;
    for (i=[0:starts-1]) {
        rotate([0,0,360/starts*i]) rawThread(profile,d=Dmin,h=height,lead=_lead,$fn=myFN,adjustRadius=true);        
    }
}

//rawThread([[0,0],[1.5,1.5],[0,3]], d=50, h=91, pitch=3);
//rawThread([[0,0],[0,3],[3,3],[3,0]], d=50, h=50, pitch=6, $fn=80);
/*render(convexity=5)
difference() {
    isoThread(d=50,h=30,pitch=3,angle=40,internal=false,$fn=60);
    translate([0,0,-extrusionNudge]) isoThread(d=42,h=30+2*extrusionNudge,pitch=3,angle=40,internal=true,$fn=60);
}*/
//rawThread([[0,0],[1,0],[.5,.5],[1,1],[0,1]],r=20,h=10,lead=1.5);
