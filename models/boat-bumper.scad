
// Size of storage hatch
//cube([1.2,1.2,.6]);

// Scale is meters

module bumper() {
//rotate([0,0,360*$t])
difference() {
translate([-.6,-.6,0]) cube([1.2,1.2,.6]);

translate([1.0,0,0])
scale([1.7,1,1])
rotate([0,0,45]) translate([-.6,-.6,-0.001]) cube([1.2,1.2,.3]);

translate([0,-.61,-.001]) cube([1.22,1.22,.3]);
}
}

// rough hull model
module rough_hull() {
    
    difference() 
    {
        
    color([.7,.7,.7])
    hull() 
    {
    // Top deck

    translate([0,0,0.6]) 
    linear_extrude(height = 0.01, center = true, convexity = 10, twist = 0)
//    scale([1,1,0.001])
    polygon(points=[[0,0],[-.55,-1],[-.85,-1.8],[-.85,-2.0],[.85,-2.0],[.85,-1.8],[.55,-1]]);

    // Halfway down
    translate([0,0,0.35]) 
    linear_extrude(height = 0.01, center = true, convexity = 10, twist = 0)
//    scale([1,1,0.001])
    polygon(points=[[0,-.35],[-.45,-1.1],[-.75,-1.8],[-.75,-2.0],[.75,-2.0],[.75,-1.8],[.45,-1.1]]);
    
    // Bottom
    translate([0,0,0.0]) 
    linear_extrude(height = 0.01, center = true, convexity = 10, twist = 0)
//    scale([1,1,0.001])
    polygon(points=[[0,-1.2],[-.25,-1.4],[-.45,-1.8],[-.45,-2.0],[.45,-2.0],[.45,-1.8],[.25,-1.4]]);
    }
    
    //translate([0,-1,0.45]) rotate([0,0,45]) cube([.28,.28,.3]);
}
    
    
 
}

scale(10)
{
rough_hull();
    //bumper();
}

