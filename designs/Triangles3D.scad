scale=1;
rand=2;
size=30;
$fn=3;
range=[  10,14,18,22,26 ];
rot=1;
htg=3;

module tri(size,rand,scale,htg,fn){
    difference(){
        cylinder(d=size*scale,h=htg,$fn=fn);
        translate([0,0,-1]) cylinder(d=size*scale-rand,h=htg+2,$fn=fn);
        }
    }

 union(){
   //   translate([12.9,-1,0]) cube([1.5,2,3]);
     difference(){
            translate([14,1.5,1.5])  rotate([90,0,0]) cylinder(d=3,h=3,$fn=100);
            translate([14,2,1.5])   rotate([90,0,0]) cylinder(d=2,h=5,$fn=100);
        }
     difference(){
      cylinder(d=26,h=3,$fn=300);
      translate([0,0,-1])  cylinder(d=1,h=45,$fn=100);

 for  (ro = [1:rot] ){
    for ( size = range ){
      //  tri(size,rand,scale);
    rotate ([0,0,360/rot*ro])translate([0,0,0.5])  tri(size,rand,scale,htg,3);
    }
    }
}
}
