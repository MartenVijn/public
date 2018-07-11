
// Marten Vijn
// BSD-style license http://svn.martenvijn.nl/svn/LICENSE
// BeerLicense:: get me one if you meet me...

t=4;
// keep in mind that de size of the box 
// in in units twice the material thickness (t)
// 

// length =  length*t*2 
// (l)
length=30;
l=length*t*2;

// Heigth = heigth*t*2 
// (h)
heigth=3;
h=heigth*t*2;

// depth  depth *t*2 
// (d)
depth=6;
d=depth*t*2;

tm=t*2;

// short side panel module
module board_d(){
	union(){
		color("yellow") square([d,h]);
		for (i = [ 0 : h/t/2-1 ]){
 	     	// just mask one of this lines to remove dents
			translate([0-t,i*tm]) square([t,t]);	     		
			translate([d,i*tm+t]) square([t,t]);
 			}	
		for (i = [ 0 : d/t/2-1 ]){
	     	// just mask one of this lines to remove dents
	     	     translate([i*tm,h]) square([t,t]);
	   	     translate([i*tm+t,0-t]) square([t,t]);	     		
		}   
	}
}

// length side panel module
module board_l(){
	union(){
		color("green") square([l,h]);
		for (i = [ 0 : h/t/2-1 ]){
	     	// just mask one of this lines to remove dents
 	     		translate([0-t,i*tm]) square([t,t]);	     		
			translate([l,i*tm+t]) square([t,t]);
 			}	
		for (i = [ 0 : l/t/2-1 ]){
	     	// just mask one of this lines to remove dents
	     	     translate([i*tm,h]) square([t,t]);
	   	     translate([i*tm+t,0-t]) square([t,t]);	     		
		}   
	}
}

module board_bottom(){
	union(){
		color("red") square([l,d]);
		for (i = [ 0 : d/t/2-1 ]){
	     	// just mask one of this lines to remove dents
 	     		translate([0-t,i*tm]) square([t,t]);	     		
			translate([l,i*tm+t]) square([t,t]);

 			}	
		for (i = [ 0 : l/t/2-1 ]){
	     	// just mask one of this lines to remove dents
	     	     translate([i*tm,d]) square([t,t]);
	   	     translate([i*tm+t,0-t]) square([t,t]);	     		
		}   
		// corner nok
	     	// just shorten the array to remove dents
		for (i = [ [-t,-t], [l,-t], [-t,d], [l,d]] ){
	     	     translate(i) square([t,t]);
	   	}   
	}
}

// build a demo plate,
// ajust it to your needs 

module one_box(){
translate([0,0]) board_bottom();
translate([0,d+t*2.3]) board_bottom();
rotate ([0,0,0])	translate([0,d*2+t*4.6])  board_l();
rotate ([0,0,0])	translate([0,d*2+h+t*7])  board_l();
rotate ([0,0,90])	translate([0,t*2.3]) board_d();
rotate ([0,0,90])	translate([d+t*2.3,t*2.3]) board_d();
}

one_box();
// and an other one
// ajust x and y 
// translate([x,y]) one_box();
