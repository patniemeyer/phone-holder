
///
/// Rounded cube
/// by Pat Niemeyer (pat@pat.net)
///

// Rounded cube fitting exactly inside a cube of the same dimensions.
module roundedBox(size, radius, center=true)
{
    width = size[0] - radius*2;
    length = size[1] - radius*2;
    height = size[2] - radius*2;

    translateIfNeeded(radius,center)
    minkowski() {
        cube(size=[width,length,height], center=center);
        sphere(r=radius, center=center);
    }
}

module translateIfNeeded(r, center) {
  if (center) {
    children();
  } else {
    translate([r,r,r]) children();
  }
}

// Uncomment to demo
//%cube(size=[s,s,h], center=true);
//roundedBox([s, s, h], 1, center=true);
//%cube(size=[s,s,h], center=false);
//roundedBox([s, s, h], 1, center=false);

