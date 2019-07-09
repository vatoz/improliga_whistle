//created by vatoz@seznam.cz
//using whistle CC-A by arminth

dr_triprsty=50;
dr_jedenprst=25;
dr_clanek=17;
dr_tloustka=2.7;
dr_r=dr_tloustka +dr_jedenprst/2;
dr_stredy=(dr_triprsty - dr_jedenprst)/2;
//držátko

ka_delka=120;
ka_na_sirka=26;
ka_na_vyska=12;
ka_stena=1.2;
ka_cil=5;
ka_rezonator=10.7;
ka_stred=ka_rezonator -ka_stena- ka_stena;
ka_plosina=7;
ka_zasun=33;


module drzatko() {
 difference(){
    union(){//krychlička se dvěma válci na konci
    translate([0,dr_stredy,0]) cylinder(dr_clanek,dr_r,dr_r,true);
    translate([0,-dr_stredy,0]) cylinder(dr_clanek,dr_r,dr_r,true);
    translate ([0,0,0]) cube([dr_r*2,dr_stredy*2,dr_clanek],center=true);    
    }
    union(){//krychlička se dvěma válci na konci
    translate([0,dr_stredy,0]) cylinder(dr_clanek+5,dr_jedenprst/2,dr_jedenprst/2,true);
    translate([0,-dr_stredy,0]) cylinder(dr_clanek+5,dr_jedenprst/2,dr_jedenprst/2,true);
    translate ([0,0,0]) cube([dr_jedenprst,dr_stredy*2,dr_clanek+5],center=true);    
    }

} 
}



module kazoo(){
difference(){
union(){    
linear_extrude(height = ka_delka, center = true, convexity = 10, scale=[(ka_na_sirka+ka_stena)/(ka_cil+ka_stena/2)/2,(ka_na_vyska+ka_stena)/(ka_cil+ka_stena/2)/2], $fn=30)
 circle(r = ka_cil+ka_stena);
    
    rotate  ([90,0,0])cylinder(8*ka_stena,ka_rezonator,ka_rezonator);
    
    }
union(){
linear_extrude(height = ka_delka+.2, center = true, convexity = 10, scale=[ka_na_sirka/ka_cil/2,ka_na_vyska/ka_cil/2], $fn=30)
 circle(r = ka_cil);
    rotate  ([90,0,0])cylinder(11,ka_stred,ka_stred);
    
   translate([0,-ka_plosina] )rotate  ([90,0,0])cylinder(6*ka_stena,ka_rezonator-ka_stena,ka_rezonator-ka_stena);
}

}
}


module washer(){
difference(){
cylinder(ka_stena*3,ka_rezonator-ka_stena -.1,ka_rezonator-ka_stena - .1);
translate([0,0,-.1])cylinder(ka_stena*3+1,ka_rezonator-2*ka_stena,ka_rezonator-2*ka_stena);
}
}


//
//kazoo





module body() {
cylinder (h=30,d=30, center=true);
translate ([20,11,0]) cube([40,8,30], center=true);
//translate ([-18,0,0])rotate_extrude(convexity = 10) translate([3, 0, 0]) circle(r = 1.5, $fn = 100);
translate ([39,15,0]) cylinder (r=1,h=30, center=true);
}


module ball()
{difference(){
sphere(d=8, $fn=64);
sphere(d=6, $fn=64);    
}
    
//držak kolečka
 translate([0,0,0]) rotate([0,90,0])cylinder(h=12,d=1.5);
}


 translate([10,21,0]) rotate([0,0,90]) drzatko();
translate([0,0,ka_zasun])rotate([0,180,0]) kazoo();


translate([24,-2,0])rotate ([180,90,0]) scale([0.7,0.7,0.7]) union(){
difference() {
    body();
    cylinder (h=26,d=26, center=true);
    translate ([25,12.5,0]) cube([40,2.5,26], center=true);
    translate ([-2,16,0]) rotate ([0,0,-20]) cube([10,3,26], center=true);
    translate ([5,14,0]) cube([6,8,26], center=true); 
    
};

ball();}


translate([40,50,(-(ka_delka/2)- ka_stena*3 )+ ka_zasun+6] ) washer();










