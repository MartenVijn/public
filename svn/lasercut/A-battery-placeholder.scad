// Marten Vijn, 2013
// https://svn.martenvijn.nl/svn/LICENSE
// Beerlicence:: get me me one if you meet me...

// A-battery place holder

// dimensions
l=50; // length
r=13; // diameter 
th=2; // plus side 
td=4; // plus side 
t=4;  // material thickness


module bat(){
	difference(){
		union(){
		square([l-th,r],center=true);
		translate([l/2,0]) square([th,td],center=true);
		}
	translate ([l/2-1,0]) circle(r=1);
	translate([-l/4+th/2,0]) square([l/2,t],center=true);
	}
	translate([0,r+1]) difference(){

	square([l-th,r],center=true);

	translate ([-l/2+3,0]) circle(r=1);
	translate([l/4+th/2,0]) square([l/2,t],center=true);
	}
}

bat();