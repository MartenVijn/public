// Marten Vijn
// BSD-style license http://svn.martenvijn.nl/svn/LICENSE
// BeerLicense:: get me one if you meet me...

// define multiplex 
mul_l=2440;
mul_b=1220;
mul_d=18;

// reference square to see if thing fit..
%  square ([mul_l,mul_b]);

// define table
tab_h=750;
tab_l=2440;
tab_b=660;

beam_y=tab_l;
beam_x=tab_b-2*mul_d;
beam_h=90;

leg_b=90;
leg_h=tab_h-mul_d;
// cut /saw lines   3.8 saw line @ gamma bouwmarkt
cut=3.8;

square( [ leg_h , leg_b ]);

top();
 module top(){
        square ([ tab_l,tab_b]);
        
     
 }

ybeams();
module ybeams(){
            for ( y =[ 0: 1 ]){
                translate([ 0, tab_b + cut + ( leg_b + cut) * y ]) square([beam_y,beam_h]);
                        }
            }

legs();
    module legs(){
        for (x = [ 0, 1]) {
                for ( y=[2 : 5]){
                    translate([ (leg_h+cut) * x, tab_b + cut + (leg_b+ cut) * y ]) square([leg_h,leg_b]);
                        } 
                    }
                }
   
 xbeams();
module xbeams(){
           for (x = [  2 ]) {
            for ( y =[ 2: 4 ]){
                translate([ (leg_h+cut) * x , tab_b + cut + ( leg_b + cut) * y ]) square([beam_x,beam_h]);
                        }
            }        }
    
