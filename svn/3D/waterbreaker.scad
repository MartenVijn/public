

// Marten Vijn,  okt 2017
// license BSD 
// https://mail.martenvijn.nl/svn/LICENSE

scale=0.1;

top=15*scale;
bottom=27*scale;
heigth=50*scale;
trans=9*scale;
bol=1.5;
fn=40;
x=10;
d=10;


module cyl(){
    difference(){
    union(){
    cylinder(r2=top,r1=bottom,h=heigth,$fn=fn);
   translate([0,0,heigth]) sphere(r=top*bol,$fn=fn);  
        
    }  
    cylinder(r=top/4,h=heigth*2,$fn=fn); 
    for( i = [ 0 : x ]){
        for (z = [ 0:d]) {
        rotate([0,0,360/x*i ]) translate([0,0,(heigth+top*1.2)/d*z])
            rotate([0,90,0])    
            cylinder(r=top/8,h=heigth,$fn=fn);
        }
    }
}
    
}

// cyl();
module all(){
        union(){
        for (i = [0, 1, 2]){
               rotate([0,110,360/3*i])   translate([0,0,trans])  cyl();
                }
           rotate([0,0,60])  translate ([0,0,trans]) cyl();              
            }
 }
all();
