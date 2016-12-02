
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

    translate([0,0,0.65]) 
    linear_extrude(height = 0.01, center = true, convexity = 10, twist = 0)
//    scale([1,1,0.001])
    polygon(points=[[0,0],[-.42,-.6],[-.65,-1.1],[-.85,-1.7],[-.85,-2.0],[.85,-2.0],[.85,-1.7],[.42,-.6],[.65,-1.1]]);

    // Halfway down
    translate([0,0,0.35]) 
    linear_extrude(height = 0.01, center = true, convexity = 10, twist = 0)
//    scale([1,1,0.001])
    polygon(points=[[0,-.35],[-.45,-1.1],[-.75,-1.8],[-.75,-2.0],[.75,-2.0],[.75,-1.8],[.45,-1.1]]);
    
    // Bottom
    translate([0,0,0.0]) 
    linear_extrude(height = 0.01, center = true, convexity = 10, twist = 0)
//    scale([1,1,0.001])
    polygon(points=[[0,-1.2],[-.25,-1.5],[-.45,-1.9],[-.45,-2.0],[.45,-2.0],[.45,-1.9],[.25,-1.5]]);
    }
    
    // Cutout for hatch
    translate([0,-1,0.62]) rotate([0,0,45]) cube([.28,.28,.5]);

    // tie-downs
    translate([-0.8,-1.9,0.55]) cube([.05,.1,.3]);
    translate([0.75,-1.9,0.55]) cube([.05,.1,.3]);

}
   
    
 
}


module w_bumper() {
color([.35,.35,.35])
scale(0.001)
    linear_extrude(height = 600, center = false, convexity = 10, twist = 0)

polygon(points=[[0,0],[30,150],[105,150],[135,30],[165,30],[195,150],[270,150],[300,0], 
[30,30],[50,120],[90,120],[110,30],
[190,30],[210,120],[250,120],[270,30]

],

paths=[[0,1,2,3,4,5,6,7],[8,9,10,11],[12,13,14,15]]
);
}

module plate_rear() {
        color([0.8,0.8,0.8])

    translate([-.6,-.25,0]) cube([1.2,.5,0.025]);
}

module plate_front() {
    color([0.8,0.8,0.8])
    {
    translate([-.6,-.25,0]) cube([1.2,.5,0.025]);
    
        // bracket
        difference() {
    translate([-.5,-.05,-.2])
        cube([0.02,0.3,0.2]);
            
    translate([-.51,-.30,-.34])
    rotate([-30,0,0])
        cube([0.04,0.5,0.4]);

        }

        // bracket
        difference() {
    translate([.5,-.05,-.2])
        cube([0.02,0.3,0.2]);
            
    translate([.49,-.30,-.34])
    rotate([-30,0,0])
        cube([0.04,0.5,0.4]);

        }
        
    }
    
    color("blue")
    translate([-.2,-.05,-.2])    cube([.4,.3,.2]);
}

module bumper_plate() {
    color([0.8,0.8,0.8])


    translate([-.6,.025,0]) 
    rotate([90,0,0])
    cube([1.2,.5,0.025]);
    
    
    color("grey")
        //translate([0,.25+.025,.18])   
    translate([0,.15+.025,0])   
    scale([1,1,0.83])
    rotate([0,0,180])
    w_bumper();

    color("grey")
        //translate([0,.25+.025,.18])   
    translate([-0.302,.15+.025,0])   
    scale([1,1,0.83])
    rotate([0,0,180])
    w_bumper();

    color("grey")
        //translate([0,.25+.025,.18])   
    translate([0.302,.15+.025,0])   
    scale([1,1,0.83])
    rotate([0,0,180])
    w_bumper();

    color("grey")
        //translate([0,.25+.025,.18])   
    translate([0.604,.15+.025,0])   
    scale([1,1,0.83])
    rotate([0,0,180])
    w_bumper();

}

module straps() {
    color("red")
    {
    translate([0.76,-1.85,.66])
    rotate([0,0,12])
    cube([.03,1.3,.001]);

    translate([-0.79,-1.85,.66])
    rotate([0,0,-12])
    cube([.03,1.3,.001]);
    }
}


module bumper_final_position() {
    deck_height = 0.65;
    translate([0,-.65,deck_height]) plate_rear();
    translate([0,-0.15,deck_height]) plate_front();
    translate([0, .10,deck_height - .5+.025]) bumper_plate();
 //   straps();
}


module bumper_for_printing() {
    deck_height = 0.65;
    
    translate([0,-.65,deck_height-.02]) plate_rear();
    translate([0,-0.15,deck_height-.02]) plate_front();
    translate([0, .10,deck_height - .5+.0]) bumper_plate();
    //straps();
}


module bumper_animate() {
    deck_height = 0.65;
    
    //$t = .4;
    
    if ( $t < 0.1 ) {
        // drop rear plate
        translate([0,0,3*(.1-$t)])
        translate([0,-.65,deck_height]) plate_rear();
    } else if ( $t < 0.2 ) {
        // drop front plate
        translate([0,0,0.25+5*(.2-$t)])
        translate([0,-0.38,deck_height])  rotate([90,0,0]) plate_front();

        translate([0,-.65,deck_height]) plate_rear();
    } else if ( $t < 0.3 ) {
        // rotate front plate
        translate([0,-0.38,deck_height])  
        rotate([90*(.3-$t)/0.1,0,0]) 
        translate([0,.25,0])
        plate_front();

        translate([0,-.65,deck_height]) plate_rear();
    } else if ( $t < 0.4 ) {
        // straps
        translate([0,-10*(.4-$t),0]) scale([1,1-10*(.4-$t),1]) straps();
        
        translate([0,-0.15,deck_height]) plate_front();
        translate([0,-.65,deck_height]) plate_rear();

    } else if ( $t < 0.5 ) {
        // bumper plate
        translate([0,0,10*(.5-$t)])
        translate([0, .10,deck_height - .5+.025]) 
        bumper_plate();

        straps();
        translate([0,-0.15,deck_height]) plate_front();
        translate([0,-.65,deck_height]) plate_rear();
        
    } else if ( $t < 0.6 ) {
        translate([0, .10,deck_height - .5+.025]) bumper_plate();
        straps();
        translate([0,-0.15,deck_height]) plate_front();
        translate([0,-.65,deck_height]) plate_rear();
    } else  {

        translate([0, .10,deck_height - .5+.025]) bumper_plate();
        straps();
        translate([0,-0.15,deck_height]) plate_front();
        translate([0,-.65,deck_height]) plate_rear();
    }
    

}

module storage() {
   translate([0,-.70,.220]) rotate([-90,0,0]) bumper_plate();
   translate([0,.10,.20]) rotate([00,0,0])   plate_front();
   translate([0,-.450,0])    plate_rear(); 
    
}

module print_layout() {

scale(5) 
    {
        /*
translate([-1.5,0,0]) {
    translate([0,.450,0]) bumper_plate();
   translate([0,.10,.025]) rotate([180,0,180]) plate_front();
   translate([0,-.450,0])    plate_rear(); 
}
        */
    
   translate([-0.7,1,.655]) rotate([0,180,0]) rough_hull();


    translate([.8,0,0.65+0.025]) 
    rotate([0,180,0])
    difference() {
    bumper_final_position();
    translate([0,0.02,-.005]) rough_hull();
    }

}
}


scale(10)
{
    
   print_layout(); 

//    bumper_animate();
  //  bumper_for_printing();
    
    
//    bumper_plate();
//    translate([0,-1.2,.6]) plate();
    //bumper();
    
}

