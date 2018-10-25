
scale=1;
rand=1;
size=30;
$fn=3;
range=[  14, 18, 22, 26, 30 ];
rot=1;

all();

module tri(size,rand,scale){
    difference(){
        circle(d=size*scale);
        circle(d=size*scale-rand);
        }
    }

module all(){
    union(){
        difference(){
            circle(d=size+rand/2,$fn=210);
            circle(d=size,$fn=210);
            }
        circle(d=1,$fn=40);


        for  (ro = [1:rot] ){
            for ( size = range ){
            rotate ([0,0,360/rot*ro-30])translate([0,0])  tri(size,rand,scale);
            }
        }
    }
}