
// Marten Vijn
// BSD-style license http://svn.martenvijn.nl/svn/LICENSE
// BeerLicense:: get me one if you meet me...

t=4.2;
// keep in mind that de size of the box 
// in in units twice the material thickness (t)
// 

// length =  length*t*2 
// (l)
length=32;
l=length*t*2;

// Heigth = heigth*t*2 
// (h)
heigth=6;
h=heigth*t*2;

// depth  depth *t*2 
// (d)
depth=8;
d=depth*t*2;

tm=t*2;
// stepper holes dist
hd=16;


// short side panel module
module board_d_a(){
	difference(){
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
		
		translate ([d/2,h/2,0]) circle(r=11);
		translate ([d/2+hd,h/2+hd]) circle(r=2);
		translate ([d/2-hd,h/2+hd]) circle(r=2);
		translate ([d/2+hd,h/2-hd]) circle(r=2);
		translate ([d/2-hd,h/2-hd]) circle(r=2);
		
		translate ([d/6,h/2,0]) circle(r=3);
		
	}
}

module board_d_b(){
	difference(){
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
		
		translate ([d/2+13,h/2,0]) circle(r=4);
		translate ([d/2-13,h/2,0]) circle(r=4);
		
	}
}

module board_d_c(){
	difference(){
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
		
		translate ([d/2,h/2,0]) circle(r=4);
	
		translate ([d/4,h/2-4]) circle(r=3);
		translate ([d/4,h/2+4,0]) circle(r=3);
	}
}



// length side panel module
module board_l(){
	difference(){
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
			for (i = [ 0 : h/t/2-1 ]){
	     		// just mask one of this lines to remove dents
 	     	//	translate([0-t,i*tm]) square([t,t]);	     		
				translate([50,i*tm+t]) square([t,t]);
		}
   
	}
}

module board_top(){
	difference(){
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
		for (i = [ 0 : d/t/2-1 ]){
	     	// just mask one of this lines to remove dents
 	     			translate([50,i*tm]) square([t,t]);	     		
			}
		   
	}
}
module board_bottom(){
	difference(){
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
		for (i = [ 0 : d/t/2-1 ]){
	     	// just mask one of this lines to remove dents
 	     			translate([50,i*tm]) square([t,t]);	     		
				}
		translate([90,33]) circle(r=2);
		translate([100,10]) circle(r=2);
		translate([250,10]) circle(r=2);
		translate([260,33]) circle(r=2);
		translate([10,10]) circle(r=2);
		translate([10,58]) circle(r=2);
		translate([250,58]) circle(r=2);
		translate([240,10]) circle(r=2);
		   
	}
}

module shifter_close(){
	difference(){
		square([h/2,d-20]);
		translate([h/4,(d-20)/2]) circle(r=4.5);
		translate([h/4,(d-20)/2+13]) circle(r=4);
		translate([h/4,(d-20)/2-13]) circle(r=4);
		}
	}
module shifter_fill(){
	difference(){
		square([h-20,d-20]);
		translate([(h-20)/2,(d-20)/2]) circle(r=7.5,$fn=6);
		translate([(h-20)/2,(d-20)/2+13]) circle(r=4);
		translate([(h-20)/2,(d-20)/2-13]) circle(r=4);
		}
	}
module shifter_fill_bearing(){
	union(){
		difference(){
			square([h-2,d-2]);
			translate([(h-2)/2,(d-2)/2]) circle(r=7.5,$fn=6);
			translate([(h-2)/2,(d-2)/2+13]) circle(r=4);
			translate([(h-2)/2,(d-2)/2-13]) circle(r=4);
			translate([0,0]) square([h,8]);
			translate([0,d-10]) square([h,8]);
		}
		translate([5,0]) square([8,8]);
		translate([5,d-10]) square([8,8]);
		translate([h-14,0]) square([8,8]);
		translate([h-14,d-10]) square([8,8]);
		}
	}


module job1(){
	translate([0,0]) board_top();
	translate([0,-76]) board_bottom();
	}
module job3(){
	translate([0,-130]) shifter_close();
	translate([30,-130]) shifter_close();
	translate([60,-130]) shifter_close();
	translate([90,-130]) shifter_fill();
	translate([122,-130]) shifter_fill();
	translate([154,-130]) shifter_fill();
 	translate([260,-130]) rotate([0,0,90]) shifter_fill_bearing();
	}

module job2(){
	rotate ([0,0,0])	translate([0,0])  board_l();
	rotate ([0,0,0])	translate([0,-60])  board_l();
	rotate ([0,0,0])	translate([0,-120]) board_d_a();
	rotate ([0,0,0])	translate([80,-120]) board_d_b();
	rotate ([0,0,0])	translate([160,-120]) board_d_c();
}

job2();

