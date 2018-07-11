

thick=4;
d=12.5;
b=10;

module bal_1(){
	r=2*b;
	difference() {
		circle(r=r);
		translate([r/2,d/2]) square([r,thick],center=true);
		translate([r/2,-d/2]) square([r,thick],center=true);
		translate([r/2,d*1.5]) square([r,thick],center=true);
		translate([r/2,-d*1.5]) square([r,thick],center=true);
	}
}

module bal_2(){
	r=3*b+7;
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

module bal_3(){
	r=4*b+4;
	difference() {
		circle(r=r);
		translate([r/2,d/2]) square([r,thick],center=true);
		translate([r/2,-d/2]) square([r,thick],center=true);
		translate([r/2,d*1.5]) square([r,thick],center=true);
		translate([r/2,-d*1.5]) square([r,thick],center=true);
		translate([r/2,d*2.5]) square([r,thick],center=true);
		translate([r/2,-d*2.5]) square([r,thick],center=true);
		translate([r/2,d*3.5]) square([r,thick],center=true);
		translate([r/2,-d*3.5]) square([r,thick],center=true);
		}
	}	
module bal_4(){
	r=5*b;
	difference() {
		circle(r=r);
		translate([r/2,d/2]) square([r,thick],center=true);
		translate([r/2,-d/2]) square([r,thick],center=true);
		translate([r/2,d*1.5]) square([r,thick],center=true);
		translate([r/2,-d*1.5]) square([r,thick],center=true);
		translate([r/2,d*2.5]) square([r,thick],center=true);
		translate([r/2,-d*2.5]) square([r,thick],center=true);
		translate([r/2,d*3.5]) square([r,thick],center=true);
		translate([r/2,-d*3.5]) square([r,thick],center=true);

		}
	}


module set(){
	bal_4();	
	translate ([94,-10]) bal_3();
	translate ([176,-20]) bal_2();
	translate ([233,-30]) bal_1();
	
	}

set();
//translate ([190,61]) rotate([180,180,0]) set();
//translate ([130,0]) rotate([0,0,0]) set();
//translate ([180,110]) rotate([180,180,0]) set();
