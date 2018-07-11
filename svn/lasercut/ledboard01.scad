
// Marten Vijn
// BSD-style license http://svn.martenvijn.nl/svn/LICENSE

d=4;
b=320;
l=642;
h=80;

spb=b/2-d/2+0.1;
spl=l/2-d/2+0.1;
sph=h/2-d/2+0.1;


module board_b(){
	difference(){
	square([h,b], center=true);
	for (i = [ 0 : h/d/4 ]){
 	     		translate([i*8-d/2,spb]) square([d,d],center=true);	     		
			translate([-i*8-d/2, spb]) square([d,d],center=true);
 	     		translate([i*8+d/2, -spb]) square([d,d],center=true);	     		
			translate([-i*8+d/2,-spb]) square([d,d],center=true);
	}	
	for (i = [ 0 : b/d/4 ]){
 	     	      translate([sph,-i*8]) square([d,d],center=true);
 	     		translate([sph,i*8]) square([d,d],center=true);	     		
			
	}
    }
}

module board_l(){
	difference(){
	square([h,l], center=true);
	//short
	for (i = [ 0 : h/d/4 ]){
 	     		translate([i*8-d/2, spl]) square([d,d],center=true);	     		
			translate([-i*8-d/2, spl]) square([d,d],center=true);
 	     		translate([i*8+d/2, -spl]) square([d,d],center=true);	     		
			translate([-i*8+d/2, -spl]) square([d,d],center=true);
	}
	// length
	for (i = [ 0 : l/d/4 ]){
 	     	      translate([sph,-i*8-d/2]) square([d,d],center=true);
 	     		translate([sph,i*8-d/2]) square([d,d],center=true);	     		
			
	}
    }
}
module board_bottom(){
	difference(){
	square([b,l], center=true);
	// short
	for (i = [ 0 : b/d/4 ]){
 	     		translate([i*8-d/2, spl]) square([d,d],center=true);	     		
			translate([-i*8-d/2, spl]) square([d,d],center=true);
 	     		translate([i*8+d/2, -spl]) square([d,d],center=true);	     		
			translate([-i*8+d/2, -spl]) square([d,d],center=true);
	}
      // length
	for (i = [ 0 : l/d/4 ]){
 	     	      translate([spb,-i*8]) square([d,d],center=true);
 	     		translate([spb,i*8]) square([d,d],center=true);
 	     	      translate([-spb,-i*8+d/2]) square([d,d],center=true);
 	     		translate([-spb,i*8+d/2]) square([d,d],center=true);	
			
	}
    }
}
translate([280,360,0]) rotate ([0,180,90])  board_b();
translate([h+1,0,0]) board_l();
translate([282,0,0]) board_bottom();

