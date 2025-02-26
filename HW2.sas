%let indir = D:\lu;
proc import datafile="&indir\lds111sp2a.xlsx" out=ds1 dbms=excel replace;
getnames=yes;
run;
proc print data=ds1(obs=10);
run;
/*1-a*/
proc sort data=ds1;
by id;
run;
proc transpose data = ds1 out = ds1a prefix = CV;
by  id;
var Baseline CV_time1 CV_time_2 ;
run;
proc print data=ds1a;
run;
data ds1b;
set ds1a;
if _name_='Baseline' then time=0;
else if _name_='CV_time1' then time=1;
else if _name_='CV_time_2' then time=2;
run;
proc print data=ds1b(obs=10);run;
proc anova data = ds1b;
class  time;
model cv1 =  time ;
run;
/*1-b*/
proc glm data=ds1b;
class  id time;
model CV1 = id time;
run;

%let indir = D:\lu;
proc import datafile="&indir\lds111sp2b.xlsx" out=ds2 dbms=excel replace;
getnames=yes;
run;
proc print data=ds2(obs=10);
run;
/*2-(a)*/

proc sgplot data = ds2;
vline times/response = cst stat = mean group= sex markers;
run;
proc sgplot data = ds2;
vline times/response = rom stat = mean group= sex markers;
run;

proc sgplot data = ds2;
vline times/response = cst stat = mean group= group markers;
run;

proc sgplot data = ds2;
vline times/response = rom stat = mean group= group markers;
run;

proc glm data = ds2;
class id times group;
model cst rom = times group times*group id(group);
random id(group)/test;
run;

/*2-(b)*/
proc sort data = ds2;
by  group id;
run;

proc transpose data = ds2 out = ds2a prefix = y;
by group id;
id times;
var cst rom;
run;
proc print data = ds2a(obs=10);run;

proc glm data = ds2a;
class group id;
model y1 y2 y3 y4 = group / nouni; 
repeated time (1 2 3 4) polynomial/ printm summary;
run;
/*2-(c)*/
proc glm data = ds2a;
class group;
model y1 y2 y3 y4 = group; 
manova h = group / printe printh;
run;
