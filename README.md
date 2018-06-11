
# OpenSCAD Tesla Model 3 Cup holder mount for iPhone X
_Pat Niemeyer (pat@pat.net), https://github.com/patniemeyer/phone-holder)

<table>
  <tr>
    <th>
      <img src="Media/phone-holder-car.gif" width="220"/>
    </th>
    <th>
      <img src="Media/view1.png" width="220"/>
    </th>
  </tr>
</table>


This is a simple OpenSCAD phone holder that mounts an iPhone X in a Tesla Model cup holder.

## Warning: 
The rubber lining of the cup holder and the plastic surface of the center console are easily scratched.
If you print this phone holder yourself please go over it with some sandpaper to remove any unexpected bumps or
rough spots before using it in your car!  

## Printing the parts 

The STL folder contains the STL cup-holder.stl file along with some other phone mounts from this project.

I was able to print this easily with only supports on the center connector area as shown here:
</p>
<img width="320" src="Media/supports.png">
</p>

An obvious improvement would be to make this printable in two sections for those who cannot print it in a single pass.

## Issues

The first version of this was thinner and I found that the PLA softened when the car was in direct sunlight, causing 
it to droop a bit.  I will continue to refine this as I see how the new one holds up.  If you wish to experiment, just
change the `phone_thickness` parameter in the scad file.


