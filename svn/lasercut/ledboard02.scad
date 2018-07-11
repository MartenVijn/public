
// Marten Vijn
// BSD-style license http://svn.martenvijn.nl/svn/LICENSE

d=4;
b=320;
l=642;
l=53;
b=48;
h=64;


// spacers
// spb=b/2-d/2+0.1;
//spl=l/2-d/2+0.1;
// sph=h/2-d/2+0.1;

// shift clamps
shift1=4;

module board_b(){
	union(){
	square([b,h]);
	for (i = [ 0 : h/d/2-1 ]){
 	     		translate([0-d,i*8]) square([d,d]);	     		
			translate([b,i*8+d]) square([d,d]);
 	}	
	for (i = [ 0 : b/d/2-1 ]){
	     	      translate([i*8,0-d]) square([d,d],center=true);
	     	//	translate([i*8,sph]) square([d,d],center=true);	     				}
   }
}

module board_l(){
	difference(){
	color("red") square([h,l], center=true);
	//height
	for (i = [ 0 : h/d/4 ]){
 	     		translate([i*8, -spl]) square([d,d],center=true);	     		
			translate([-i*8, -spl]) square([d,d],center=true);
 	     		translate([i*8-shift1,spl]) square([d,d],center=true);	     			       	translate([-i*8-shift1,spl]) square([d,d],center=true);
	}
	// length
	for (i = [ 0 : l/d/4 ]){
 	     	      translate([sph,-i*8]) square([d,d],center=true);
 	     		translate([sph,i*8]) square([d,d],center=true);	     		
			
	}
    }
}
module board_bottom(){
	difference(){
	color("blue") square([b,l], center=true);
	// short
	for (i = [ 0 : b/d/4 ]){
 	     		translate([i*8-shift1, spl]) square([d,d],center=true);	     		
			translate([-i*8-shift1, spl]) square([d,d],center=true);
 	     		translate([i*8-shift1, -spl]) square([d,d],center=true);	     				translate([-i*8-shift1, -spl]) square([d,d],center=true);
	}
      // length
	for (i = [ 0 : l/d/4 ]){
 	     	      translate([spb,-i*8-shift1]) square([d,d],center=true);
 	     		translate([spb,i*8-shift1]) square([d,d],center=true);
 	     	      translate([-spb,-i*8-shift1]) square([d,d],center=true);
 	     		translate([-spb,i*8-shift1]) square([d,d],center=true);	
			
	}
    }
}
translate([0,-l*1.5,0])  board_b();
//translate([-b*1.3,0,0]) board_l();
//translate([0,0,0]) board_bottom();

