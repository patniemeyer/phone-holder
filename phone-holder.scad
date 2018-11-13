
///
/// Experiment with rounded iPhone X phone stand.
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
thickness=1.5;
r=4;
cutoutHeight=height*2/3;

// Phone body
module phone_body()
{
  difference() {
    // box outside, inside
    roundedBox([width,height,depth], r, center=true);
    roundedBox([width-thickness,height-thickness,depth-thickness], r, center=true);

    // Cutout - left side only
    //translate([-width/8,0,0])
      //roundedBox([width, height*2/3, depth*2], r, center=true);

    // Cutout - full width, full depth
    //cube([width+2, cutoutHeight, depth+2], center=true);

    // Cutout - full width, half depth
    translate([0,0,thickness])
    cube([width+2, cutoutHeight, depth], center=true);

    // open the left side of the base
    //translate([-width/2,-49,thickness])
      //cube([5, 30, depth], center=true);

    // shave top
    translate([-0,11,depth-thickness])
      cube([width+2,height,depth], center=true);

    // home button opening
    translate([0,-height/2+10,thickness])
      cylinder(h=depth+1, d=r*8.0, center=true);
  }
}

// Base body
module base_body() {
  translate([0,0,0.9]) // position the base against the phone
  difference() 
  {
    // params
    outerInset = 5;
    innerInset = 5;

    // calcs
    baseHeight=(height-cutoutHeight)/2; // height of the base where it touches the phone body
    dout=height-outerInset*2; // outer diamter
    din=dout-baseHeight*2+outerInset*2+innerInset*2; // inner diamter

    // Outer curve
    // Note: deliberately experimenting with low $fn to make this faceted.
    rotate(a=[0,90,0]) 
      cylinder($fn=30,h=width-2*outerInset, d=dout, center=true);

    // inner curve
    rotate(a=[0,90,0]) 
      cylinder(h=width+2, d=din, center=true);

    // scoop out arch
    {
      // params
      archDout=dout*0.84; // radius of the scoop out curve
      archOffset=-height*0.030;
      archThin=5.0; // thickness of the thinnest part of the arch (if centered :))

      // calcs
      sdown=(dout/2-archDout/2)-archThin;

      difference() {
        translate([0,-archOffset,-sdown])
          rotate(a=[0,90,0]) 
            cylinder(h=width+2, d=archDout, center=true);

        // Cut off below phone body
        translate([0,0,height/2-depth/2]) cube([width+4, height+2, height], center=true);
      }
    }

    // Cut off at plane of phone body
    translate([0,0,height/2-depth/2]) cube([width+2, height+2, height], center=true);
  }
}

phone_body();
base_body();

