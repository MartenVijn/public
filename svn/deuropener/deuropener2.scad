

/* 
Marten Vijn 2014
dual licensed 
A. Beer license (buy me a beer)
and
B. http://svn.martenvijn.nl/svn/LICENSE

*/




hi=45;

di=8;

sph=hi/2+di/2;
spb=hi/2;
m=31/2;

module box(){
		difference(){
			cube([hi,hi,hi]);
			translate([di/2,di/2,di/2]) cube([hi-di,hi-di,hi]);
			translate([-1,spb+m,sph+m])  rotate([0,90,0])cylinder(r=2,h=hi+2,$fn=10);
			translate([-1,spb+m,sph-m]) rotate([0,90,0])cylinder(r=2,h=hi+2,$fn=10);
			translate([-1,spb-m,sph+m]) rotate([0,90,0])cylinder(r=2,h=hi+2,$fn=10);	
			translate([-1,spb-m,sph-m]) rotate([0,90,0])cylinder(r=2,h=hi+2,$fn=10);
		
			translate([-1,spb,sph]) rotate([0,90,0])cylinder(r=11.5,h=hi+2,$fn=50);


			translate([10,hi+1,10])  rotate([90,0,0])cylinder(r=2,r2=4,hi+2,$fn=20);
			translate([hi-10,hi+1,10])  rotate([90,0,0])cylinder(r=2,r2=4,hi+2,$fn=20);	
			translate([hi-10,hi+1,hi-10])  rotate([90,0,0])cylinder(r=2,r2=4,hi+2,$fn=20);
			translate([10,hi+1,hi-10])  rotate([90,0,0])cylinder(r=2,r2=4,hi+2,$fn=20);
			}
		}



module spool(){
	difference(){
		union(){
			cylinder(r1=10,r2=8,h=20,$fn=20);
			translate([0,0,20]) cylinder(r1=8,r2=10,h=20,$fn=20);

			}
		translate([0,0,-1])cylinder(r=2.5,h=42,$fn=20);
		rotate([0,90,0]) translate([-7,0,0])cylinder(r=2.5,h=15,$fn=10);
		rotate([0,90,0]) translate([-37,0,0])cylinder(r=1.5,h=15,$fn=10);
		translate([4,0,39]) cube([2,6,10],center=true);
		}
	}

//spool();
box();
