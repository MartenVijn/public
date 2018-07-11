thick=4;
d=18;
b=90;

module bak(){
	difference() {
		square([b/2,b],center=true);
		for(i=[0,d,d*2,d*3,d*4]){ 
		translate([b/2,i]) square([b,thick],center=true);
		translate([b/2,-i]) square([b,thick],center=true);
		}
	}
}

s1=b+1;
s2=b/2+1;

for (x= [[0,0],
	[0,s1],
	[s2,0],
	[s2,s1],
	[s2*2,0],
	[s2*2,s1],
	[s2*3,0],	
	[s2*3,s1],
	[s2*4,0],
	[s2*4,s1],
	[s2*5,0],
	[s2*5,s1],





	])
	{
	translate (x) bak();
	}