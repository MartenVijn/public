




t=2;



module a(){
	union(){
		for (xy=[[0,0],[2*t,0],
				[0,t],[t,t],[t*2,t],
				[t,2*t],[2*t,2*t],[3*t,2*t],
				[t,3*t]
				])
			{
			translate (xy) square([t,t]);
				}
			}
		}


module b(){
	union(){
		for (xy=[[t,0],[3*t,0],
				[t,t],[2*t,t],[t*3,t],
				[0,t*2],[t,2*t],[2*t,2*t],[3*t,2*t],
				[t,3*t]
				])
			{
			translate (xy) square([t,t]);
				}
			}
		}


module c(){
	union(){
		for (xy=[[t,0],[2*t,0],
				[t,t],[2*t,t],
				[0,t*2],[t,2*t],[2*t,2*t],[3*t,2*t],
				[2*t,3*t]
				])
			{
			translate (xy) square([t,t]);
				}
			}
		}

module d(){
	union(){
		for (xy=[[0,0],[2*t,0],
				[0,t],[t,t],[2*t,t],
				[t,t*2],[2*t,2*t],
				[0,3*t],[t,3*t]
				])
			{
			translate (xy) square([t,t]);
				}
			}
		}

module e(){
	union(){
		for (xy=[[0,0],[2*t,0],[3*t,0],
				[0,t],[t,t],[2*t,t],
				[0,t*2],[t,t*2],[2*t,2*t],
				[0,3*t],[2*t,3*t]
				])
			{
			translate (xy) square([t,t]);
				}
			}
		}


module f(){
	union(){
		for (xy=[[2*t,0],
				[0,t],[t,t],[2*t,t],
				[t,t*2],[2*t,2*t],
				[2*t,3*t],[3*t,3*t]
				])
			{
			translate (xy) square([t,t]);
				}
			}
		}
	
a();
translate([t*4+1,0]) b();
translate([t*8+3,0]) c();
translate([t*12+4,0]) d();
translate([t*16+5,0]) e();
translate([t*20+6,0]) f();




