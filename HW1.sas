%let indir = D:\lu;
proc import datafile="&indir\longanal111sp1.xlsx" out=ds1 dbms=excel replace;
getnames=yes;
run;
proc print data=ds1(obs=10);
run;
/*1-(a)*/
proc glm data = ds1;
class sex(ref = "0")  MR(ref = "0")  ;
model  LAEF  = Age AFT Sex MR/ solution;
run;
/*1-(b)*/
proc glm data = ds1;
class sex (ref = "0")  mr(ref = "0");
model  LAEF  = Age AFT Sex MR LAD/ solution;
run;
/*1-(c)*/
proc glm data = ds1;
class sex (ref = "0")  mr(ref = "0");
model  LAEF  = Age AFT Sex MR LAS/ solution;
run;
/*1-(d)*/	
proc glm data = ds1;
class sex (ref = "0")   mr(ref = "0");
model  LAEF  = Age AFT Sex MR LAS LAD/ solution;
run;
