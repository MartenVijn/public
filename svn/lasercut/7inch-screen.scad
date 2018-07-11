
b=101;
l=166;

p_l=65;
p_b=55;
d=4;


//rotate ([0,0,90])   front();
//translate ([130,0]) rotate ([0,0,90])  layer_0();
//translate ([0,200]) rotate ([0,0,90])   layer_1();
//translate ([130,200]) rotate ([0,0,90]) layer_2();
hier verder
//translate ([260 ,0]) rotate ([0,0,90])  layer_3();
//translate ([260 ,200]) rotate ([0,0,90])  layer_4();
//translate ([390 ,0]) rotate ([0,0,90])  front();
//translate ([330 ,170])  stand_1();
 //translate([450,231]) rotate ([0,0,180]) stand_2();

module stand_1(){
    difference(){
        polygon ([[0,0], [0,120],[120,120]]);
       translate([20,40]) rotate([0,0,-50]) square([30,130]);
       translate([0,105])  square([50,4.5]);

    }
}
module stand_2(){
    difference(){
        polygon ([[0,0], [0,120],[120,120]]);
       translate([20,40]) rotate([0,0,-50]) square([30,130]);
       translate([50,105])  square([60,4.5]);
    }
}



module drill_mask(){
                         translate ([50,52]) circle(r=1.6,$fn=10);   
                            translate ([-50,52]) circle(r=1.6,$fn=10);           
                    
                        translate ([50,-53]) circle(r=1.6,$fn=10);   
                        translate ([-50,-53]) circle(r=1.6,$fn=10);         
                    
                        translate ([85,-40]) circle(r=1.6,$fn=10);        
     
                         translate ([85,40]) circle(r=1.6,$fn=10);   
                        translate ([-85,-40]) circle(r=1.6,$fn=10);        
                         translate ([-85,40]) circle(r=1.6,$fn=10);   
                }


module front (){
                difference(){
                    square([l+20,b+20],center=true);
                   drill_mask();
                }      
         }
                
module layer_0(){
                difference(){
                    square([l+20,b+20],center=true);
                   translate ([0,0]) square([l,b],center=true);   
                      translate ([0,50]) square([40,4],center=true);   
                      drill_mask();
                 }
         }     

 module layer_1(){
                difference(){
                    square([l+20,b+20],center=true);
                      translate ([0,50]) square([40,4],center=true);   
                drill_mask();
                }
                    
                }     
                
                
  module layer_2(){
                difference(){
                    square([l+20,b+20],center=true);
                      translate ([0,39]) square([40,25],center=true);  
                      translate ([-2,19]) square([35,15],center=true);   
                      translate ([-11,-10]) square([p_l,p_b],center=true);     
                     translate ([-13.5,-45]) square([p_l-5,p_b],center=true);                                 
                     drill_mask();
                     }
            }     
   
  module layer_3(){
                difference(){
                     square([l+20,b+20],center=true); 
                     translate ([-11,-12]) square([p_l-2,p_b-2],center=true);     
                     translate ([-13.5,-45]) square([p_l-5,p_b],center=true);       
                     drill_mask();       
                    }
                }
                
  module layer_4(){
                difference(){
                    square([l+20,b+20],center=true);
                    translate ([-27,-12]) square([p_l/2,p_b-2],center=true);     
                     translate ([-13.5,-50]) square([p_l-5,p_b/2],center=true);       
                    drill_mask();
                    }
                }