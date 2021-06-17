//author: Roman 'krpec' Dittrich (dittrich.r@gmail.com)
//VBar Control gimbal protector, version 1.3
//inspired by VBAR save-transport by Wastleast - https://www.thingiverse.com/thing:3604403

include <Chamfer.scad>;
include <Roundedcube.scad>;
//Chamfer.scad - https://github.com/SebiTimeWaster/Chamfers-for-OpenSCAD
//roundedcube.scad - https://danielupshaw.com/openscad-rounded-corners/

$fa = 1;
$fs = 0.1;

module chamfer_base() {
    union() {
        translate([-63.5, -7.5, 0])
            chamferCube([127, 15, 12], chamfers=[[0, 0, 2, 2], [0, 2, 2, 0], [2, 2, 2, 2]]);
        translate([-5, -(42+7.5), 0])
            chamferCube([10, 43, 10], chamfers=[[0, 0, 0, 1], [0, 1, 1, 0], [1, 1, 0, 0]]);
    }
}

module round_base() {
    union() {
        translate([-63.5, -7.5, 0])
            roundedcube([127, 15, 12], false, 2, "zmax");
        translate([-5, -(42+7.5), 0])
            roundedcube([10, 43, 10], false, 2, "zmax");
    }
}

module holder_text() {
    //translate([-46, -4, 10])
    //    linear_extrude(3)
    //        text("Fránis VBar control", size = 8);
    translate([-28, -4, 10])
        linear_extrude(3)
            text("VBar Control", size = 8);
}

module stick_holes() {
    translate([-55.5, 0, 0])
        cylinder(h = 40, d = 8.5, center = true);
    
    translate([55.5, 0, 0])
        cylinder(h = 40, d = 8.5, center = true);
}

module strap_holder() {
    translate([0, -(14+20), 0])
        cube([3.5, 25, 40], center = true);
}

//style = "chamfer" | "round"
module holder_engraved(style = "round") {
    difference() {
        if (style == "chamfer") {
            chamfer_base();
        }
        else {
            round_base();
        }
            
        translate([0, 0, 1])
            holder_text();
        stick_holes();
        strap_holder();
    }
}

module holder_embossed(style = "round") {
    difference() {
        union() {
            if (style == "chamfer") {
                chamfer_base();
            }
            else {
                round_base();
            }
            
            holder_text();
        }
        
        stick_holes();
        strap_holder();
    }
}

holder_embossed("chamfer");
//holder_engraved("round");
