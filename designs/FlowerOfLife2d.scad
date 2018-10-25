


dim=5;
rand=0.3;
ho=6;
$fn=100;
fn=24;
rot1=6;
rot2=6;
rot3=12;

rotate([0,0,30]) all(dim,rand,rot1,rot2);

//bow(dim,rand);

//cirkel(dim,rand,rot1);
/*
module fig(dim,rand){
    rotate_extrude(convexity = 3)
    translate([dim, 0, 0]) {
    circle(r = rand, $fn = fn);
    translate([0,-rand*3,0])      circle(r = rand, $fn = fn);
    translate([-rand,-rand*3,0]) square([rand*2,rand*3]);
        }
  }
  
*/



module fig(dim,rand){
    difference(){
   
            circle(r=dim);
            circle(r=dim-rand);
    }
    }

module bow(dim,rand){
   intersection(){
          union(){
                fig(dim,rand);
                 translate ([dim,0,0]) fig(dim,rand);
                 }
         translate ([dim/2,0,0]) square([dim*2-rand*4,dim*2-rand*6],center=true);
          }
    }
  


module cirkel(dim,rand,rot1){
    union(){
        for ( i = [ 1 : rot1 ] ){
            rotate([0,0,360/rot1*i]) translate ([0,0,0]) bow(dim,rand);
        }
      
    }
}
    
module all(dim,rand,rot1,rot2){
    union(){
       cirkel(dim,rand,rot1);
                for (i = [ 1 : rot2 ]){
                   rotate([0,0,360/rot2*i]) translate ([dim,0,0]) cirkel(dim,rand,rot1);
            }

        for (i = [ 1 : rot2 ]){
                   rotate([0,0,360/rot2*i+0]) translate ([dim*2,0,0]) cirkel(dim,rand,rot1);
            }
            
        for (i = [ 1 : rot2 ]){
                   rotate([0,0,360/rot2*i+30]) translate ([dim*1.7,0,0]) rotate([0,0,30]) cirkel(dim,rand,rot1);
            }   
            for (i = [ 1 : rot2 ]){
       //            rotate([0,0,360/rot2*i+30]) translate ([dim*1.8,0,0])  cirkel(dim,rand,rot1);
            }  
            
        }
    }


