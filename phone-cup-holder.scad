
///
/// Tesla Model 3 iPhone X cup holder phone cradle.
/// Part of https://github.com/patniemeyer/phone-holder
/// By Pat Niemeyer (pat@pat.net)
///

include <rounded.scad>;

$fn=100; // Note: Increase $fn for final render.
//$fn=30;

O=0.1; // negligible offset
OT=0.2; // negligible thickness

layer_width=0.44;

// iPhone X
//phone_width_physical=71.75;  // The volume the phone will occupy
//phone_height_physical=144.5;
//phone_depth_physical=9.0; 

// iPhone Xs Max
phone_width_physical=78.75;  
phone_height_physical=159;
phone_depth_physical=9.5; 

phone_thickness=3.0; // case thickness
phone_r=4; // curve radius, limited by phone depth
phone_cutout_height=phone_height_physical*3/4;
phone_cutout_height_start=16.0; // how far down from the top do we start
phone_cutout_side_width=2; // used if cutout_sides is true
phone_cradle_height=11; // The bottom area by the home button cutout

// Phone derived
phone_height=phone_height_physical+2*phone_thickness;
phone_depth=phone_depth_physical+2*phone_thickness;
phone_width=phone_width_physical+2*phone_thickness;

// Cup
cup_thickness=3*layer_width;
cup_diam_top=82.5; 
cup_diam_bottom=75.6; 
cup_depth = 67.0; 

// Connector
con_width=phone_width/2;
con_height=21.5;
con_depth=cup_depth*3/4;
con_r = 3;
con_center_z = 12.0; // z height above cup holder
con_center_y = 13.0; // y offset behind cup holder
con_angle = 40; 


module rotate_about_pt(v, pt) translate(pt) rotate(v) translate(-pt) children(); 

// Cutout full width, depth to back thickness with specified height and offset
module cutout_full_width() {
    translate([0, phone_height/2 -phone_cutout_height/2 - phone_cutout_height_start, 0])
    roundedBox([phone_width+10, phone_cutout_height, phone_depth], phone_r, center=true);
}

module cutout_button() {
    translate([0,-phone_height_physical/2+10,phone_thickness+1])
      cylinder(h=phone_depth_physical, d=phone_width_physical/2, center=true);
}

// Phone body
module phone_body(cutout_sides=true)
{
  difference() {
    // box outside, inside
    roundedBox([phone_width,phone_height,phone_depth], phone_r, center=true);
    roundedBox([phone_width_physical,phone_height_physical,phone_depth_physical], phone_r, center=true);

    if (cutout_sides) {
      // Note: -phone_r helps here because we are cutting with the rounded edge but we want a more vertical slice
      translate([-phone_width+phone_cutout_side_width,0,-phone_thickness]) 
        cutout_full_width();
      translate([phone_width-phone_cutout_side_width,0,-phone_thickness])
        cutout_full_width();
    } else {
      cutout_full_width();
    }

    // shave top
    extra_depth=0.5;
    translate([0,phone_cradle_height,phone_depth-phone_thickness*2+extra_depth])
      cube([phone_width+2,phone_height,phone_depth], center=true);

    cutout_button();
  }
}

module cupInside() {
    cylinder(h=cup_depth+.1, 
      d1=cup_diam_bottom-2*cup_thickness, 
      d2=cup_diam_top-2*cup_thickness, 
      center=true);
}
module cupOutside(expand_outside=0) {
    cylinder(h=cup_depth, 
      d1=cup_diam_bottom+expand_outside, 
      d2=cup_diam_top+expand_outside, 
      center=true);
}
module cup(expand_outside=0) {
  //minkowski() {
    difference() {
      cupOutside(expand_outside);
      cupInside();
    }
    //sphere(r=phone_r, center=true);
  //}
}

// The center of the connector 
connector_location = [0, 
  cup_diam_top/2-con_height/2 + con_center_y, 
  cup_depth/2-con_depth/2 + con_center_z
];

module connector() 
{
  difference() 
  {
    // core box for connector
    translate(connector_location)
      roundedBox([con_width, con_height, con_depth], con_r, center=true);

    // remove the volume outside the cup
    difference() {
      cupOutside(expand_outside=50.0);
      cupOutside(expand_outside=0.0);
    }

    // remove the phone holder
    hull() positioned_phone_body();

    phone_position() cutout_button();
  }
}

module phone_position() {
  translate([0,phone_height/2+cup_diam_top/2,0])
  translate([0,0,cup_depth/2+phone_depth/2])
  rotate_about_pt([con_angle,0,0], [0,-phone_height/2,-phone_depth/2])
    children();
}

module positioned_phone_body() {
  phone_position() phone_body();
}

positioned_phone_body();
connector();
cup();
//phone_body();


