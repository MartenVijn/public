// Marten Vijn 2013, all rights reserved
// Dual licensed:
// 1. BSD-license http://svn.martenvijn.nl/svn/LICENSE
// 2. Beer License, buy a beer if you made one and meet me...

module bottom(){
	difference(){
		square([50,32]);
		square([34,15]);
		for (i=[7,19.5,32]){
			translate([i,29]) circle(r=4);
			}
		for (y=[0:10]){
			translate([38,y*4]) square([4,2]);
			}
		for (y=[0:10]){
			translate([44,y*4+2]) square([4,2]);
			}
		}
	}
module top(){
	difference(){
		square([30,16]);
		square([14,6]);
		for (y=[0:10]){
			translate([18,y*4+2]) square([4,2]);
			}
		for (y=[0:10]){
			translate([24,y*4]) square([4,2]);
			}
		}
	}

module cam(){
	union(){
		square([5,50]);
		for (y=[0:12]){
			translate([5,y*4]) square([4,2]);
			}

		}
	}

module all(){
	rotate([0,0,-90]) cam();
	rotate([0,0,-90]) translate([10,0]) cam();
	translate([0,1,0]) top();
	translate([0,4]) bottom();
	}
all();