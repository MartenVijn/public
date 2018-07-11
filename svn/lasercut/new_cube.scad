
d=3;
dia=24;
u=11;
k=d*u*2;

//plate();

module plate(){
	union(){
	cube([k,k,d],center=true);
	for (r=[0:3]){
		for (b = [-u/2:u/2-1]){
			rotate([ 0, 0, 360/4*r])
			translate ([ b*2*d + d/2, k/2 -0.1 + d/2 , 0]) 
				cube([d,d,d],center=true); 
				}
			}
		}
	}

module plate2(){
	union(){
	cube([k,k,d],center=true);
	for (r=[0:3]){
		for (b = [-u/2:u/2]){
			rotate([ 0, 0, 360/4*r])
			translate ([ b*2*d + d/2, k/2-.1+ d/2 , 0]) 
				cube([d,d,d],center=true); 
				}
			}
		}
	}


show();
module show(){
    difference(){        
        union(){
		for (x=[ [90,0,0], [90,0,90], [90,180,0],[90,0,270] ]){ 
			rotate(x) translate([k/2+d/2,0,0]) rotate([0,90,0]) plate();
			}
		for (x=[  [90,90,270],[90,270,90]]){ 
			rotate(x) translate([k/2+d/2,0,0]) rotate([0,90,0]) plate2();
			}
                    }
                        translate([0,0,10]) cylinder(r=14,h=100);
            }
        }
module box(){
            difference(){
                        build();
                        translate([0,0,-4]) cylinder(r=14,h=10);
                        translate([k*0.675,1,-4]) cylinder(r=2.5,h=10);
                            }                       
                        }   

//projection(cut = false)box();
    
module build(){
  //          % translate ([-k/2,-k/2,0]) square ([300,200]);
            echo (k) ;
            for (p2= [0:1]){
                    translate([0, p2*(k+d*3),0]) plate2();
                         for (p1 = [1:2]){
                              translate([p1*(k+d*3), p2*(k+d*3),,0]) plate();
                         }
                }
            
 }     