
///
/// Quick and dirty iPhone X wall holder
/// Part of https://github.com/patniemeyer/phone-holder
/// By Pat Niemeyer (pat@pat.net)
///
/// (See improved phone base in the cup-holder.scad file.)
///

include <rounded.scad>;

$fn=50;
width=3*25.4 + 1.0;
height=6*25.4 - 2.5;
depth=12.25;
thickness=4.0;
r=4;

cutoutHeight=height*2/3;

module phone_body()
{
  difference() {
    // box outside, inside
    roundedBox([width,height,depth], r, center=true);
    roundedBox([width-thickness,height-thickness,depth-thickness], r, center=true);

    // main cutout - left side only
    //translate([-width/8,0,0])
      //roundedBox([width, height*2/3, depth*2], r, center=true);

    // main cutout - full width
    cube([width+2, cutoutHeight, depth+2], center=true);

    // open the left side of the base
    translate([-width/2,-49,thickness])
      cube([6, 30, depth], center=true);

    // shave top
    translate([-0,11,depth-thickness])
      cube([width+2,height,depth], center=true);

    // home button opening
    translate([0,-height/2+10,thickness])
      cylinder(h=depth+1, d=r*8.0, center=true);
  }
}


module stand_base() {
  baseHeightInset = 2.60;
  baseWidthInset = 7;
  baseHeight = 20;
  baseDepth=110;
  baseDepthOffset = 0;
  difference() {
    translate([0,-height/2+baseHeight/2+baseHeightInset, -depth/2+baseDepthOffset])
      rotate(a=[25,0,0]) 
        roundedBox([width-baseWidthInset, baseHeight, baseDepth], r, center=true);

    // Cut off below phone body
    offset = 2.0;
    translate([0,0,height/2-depth/2+offset]) cube([width+4, height*2, height], center=true);
  }

  difference() {
    translate([0,16,-25])
      rotate(a=[90+25,0,0]) 
        translate([0,-1.7,5])
        roundedBox([width-baseWidthInset, baseHeight/2, baseDepth+baseHeight+6], r, center=true);

    // Cut off below phone body
    offset = 2.0;
    translate([0,0,height/2-depth/2+offset]) cube([width+4, height*2, height], center=true);

    //translate([0,-33,-41]) rotate(a=[0,90,0]) cylinder(h=width, d=18.0, center=true);
  }

}

phone_body();
stand_base();
