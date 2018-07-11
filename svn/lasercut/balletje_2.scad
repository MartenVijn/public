

thick=4;
d=12.5;

module bal_1(){
	r=20;
	difference() {
		circle(r=r);
		translate([r/2,d/2]) square([r,thick],center=true);
		translate([r/2,-d/2]) square([r,thick],center=true);
	}
}

module bal_2(){
	r=30;
	difference() {
		circle(r=r);
		translate([r/2,d/2]) square([r,thick],center=true);
		translate([r/2,-d/2]) square([r,thick],center=true);
		translate([r/2,d*1.5]) square([r,thick],center=true);
		translate([r/2,-d*1.5]) square([r,thick],center=true);
		}
	}	

module bal_3(){
	r=40;
	difference() {
		circle(r=r);
		translate([r/2,d/2]) square([r,thick],center=true);
		translate([r/2,-d/2]) square([r,thick],center=true);
		translate([r/2,d*1.5]) square([r,thick],center=true);
		translate([r/2,-d*1.5]) square([r,thick],center=true);
		translate([r/2,d*2.5]) square([r,thick],center=true);
		translate([r/2,-d*2.5]) square([r,thick],center=true);
		}
	}	

module set(){
	translate ([0,0]) bal_3();
	translate ([-10,70]) bal_2();
	translate ([-20,120]) bal_1();
//	translate ([-15,60]) bal_1();
//	translate ([40,60]) bal_2();
//	translate ([110,50]) bal_3();
	}

set();
translate ([50,110]) rotate([180,180,0]) set();
translate ([130,0]) rotate([0,0,0]) set();
translate ([180,110]) rotate([180,180,0]) set();
