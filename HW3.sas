%let indir=D:\lu;
proc import datafile = "&indir\longanal111sp3.xlsx" out =ds1 dbms=excel replace;
getnames=yes;
run;
proc print data=ds1(obs=10);
run;
/*a*/
proc sgplot data = ds1;
vline time/ response = y stat = mean group = g markers;
run;

proc means data=ds1;
class time g;
var y;
run;

/*b*/
proc sort data = ds1;
by time id;
run;
proc transpose data = ds1 out = ds1a prefix = x;
by time id;
id h g;
var y;
run;
proc print data = ds1a(obs = 10);
run;

proc sgplot data = ds1a;
vline time / response = x01  stat = mean markers;
vline time / response = x11  stat = mean markers;
vline time / response = x02  stat = mean markers;
vline time / response = x12  stat = mean markers;
run;

proc means data = ds1;
class time g h;
var y;
run;
/* c*/
/* assume covariance matrix = CS*/
/* saturate model  => time discrete*/
/* Linear trend */

/* Model I 分組有一條線性模型 */
proc mixed data = ds1 method = ML;
class time g h  id/ ref = first;
model y = g*h*time /  solution noint;
repeated time/ subject = id type = cs;
/*  g 0 1 h 0 1 t 0 0 0 0 0 1 time*g*h    0 0 0 0 | 0 0 0 0 | 0 0 0 0 | 0 0 0 0 | 0 0 0 0 | 0 0 0 1 */
estimate 'Time 3: G1 A0'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
estimate 'Time 3: G1 A1'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
estimate 'Time 3: G2 A0'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0;
estimate 'Time 3: G2 A1'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
estimate 'Time 3: G2-G1 A0'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1;
estimate 'Time 3: G2-G1 A1'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  1 0 -1 0;

estimate 'Time 4: G1 A0'  time*g*h  0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 4: G1 A1'  time*g*h  0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 4: G2 A0'  time*g*h  0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 4: G2 A1'  time*g*h  1  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 4: G2-G1 A0'  time*g*h 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 4: G2-G1 A1'  time*g*h 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;

estimate 'Time 5: G1 A0'  time*g*h  0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 5: G1 A1'  time*g*h  0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 5: G2 A0'  time*g*h  0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 5: G2 A1'  time*g*h  0  0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 5: G2-G1 A0'  time*g*h 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 5: G2-G1 A1'  time*g*h 0  0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;

estimate 'Time 6: G1 A0'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 6: G1 A1'  time*g*h  0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 6: G2 A0'  time*g*h  0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 6: G2 A1'  time*g*h  0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 6: G2-G1 A0'  time*g*h 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 6: G2-G1 A1'  time*g*h 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0;

estimate 'Time 7: G1 A0'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0;
estimate 'Time 7: G1 A1'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0;
estimate 'Time 7: G2 A0'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 7: G2 A1'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;
estimate 'Time 7: G2-G1 A0'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0;
estimate 'Time 7: G2-G1 A1'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0;

estimate 'Time 8: G1 A0'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0;
estimate 'Time 8: G1 A1'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
estimate 'Time 8: G2 A0'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
estimate 'Time 8: G2 A1'  time*g*h  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0;
estimate 'Time 8: G2-G1 A0'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0;
estimate 'Time 8: G2-G1 A1'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0;

estimate 'Time 4-Time 3: G2-G1 A0'  time*g*h 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1;
estimate 'Time 4-Time 3: G2-G1 A1'  time*g*h 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1 0;

estimate 'Time 5-Time 3: G2-G1 A0'  time*g*h 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1;
estimate 'Time 5-Time 3: G2-G1 A1'  time*g*h 0  0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1 0;

estimate 'Time 6-Time 3: G2-G1 A0'  time*g*h 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0  0 -1 0 1;
estimate 'Time 6-Time 3: G2-G1 A1'  time*g*h 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0  -1 0 1 0;

estimate 'Time 7-Time 3: G2-G1 A0'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 -1 0 1;
estimate 'Time 7-Time 3: G2-G1 A1'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 -1 0 1 0;

estimate 'Time 8-Time 3: G2-G1 A0'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1  0 -1 0 1;
estimate 'Time 8-Time 3: G2-G1 A1'  time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 -1 0 1 0;
/* for a=0*/
contrast 'Test for Group by Time interaction a=0'
time*g*h 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1,
time*g*h 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1,
time*g*h 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0  0 -1 0 1,
time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 -1 0 1,
 time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1  0 -1 0 1/ chisq;
/* for a=1*/
 contrast 'Test for Group by Time interaction a=1'
time*g*h 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1 0,
time*g*h 0  0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 -1 0 1 0,
time*g*h 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0  -1 0 1 0,
time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 0 0 0 -1 0 1 0,
time*g*h 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1 0 -1 0 1 0 / chisq;
run;

/*d*/
/* linear model*/
data ds1b;
set ds1;
t = time;
st = time**2; /* Quadratic model*/
if time <= 4 then pt1 = 0;
else pt1 = time-4; /* (t-1) + piecewise linear*/
run;

proc mixed data = ds1b method = ML;
class id g h  time (ref = first);
model y = g*h g*t*h g*pt1*h/ solution;
repeated time / subject = id type = CS;
run;

/*e*/
data ds1c;
set ds1;
t = time;
run;
proc print data = ds1c(obs=10);
run;

proc mixed data = ds1c method = ML;
class time g h  id / ref=first;
model y = g*h g*t*h  /solution noint;
repeated time/ subject=id type = cs;

estimate 'Time 4-Time 3: G2-G1 A1' t*g*h 1 0 -1 0;
estimate 'Time 5-Time 3: G2-G1 A1' t*g*h 2 0 -2 0;
estimate 'Time 6-Time 3: G2-G1 A1' t*g*h 3 0 -3 0;
estimate 'Time 7-Time 3: G2-G1 A1' t*g*h 4 0 -4 0;
estimate 'Time 8-Time 3: G2-G1 A1' t*g*h 5 0 -5 0;
run;

/*f*/
proc mixed data = ds1c method = ML;
class time g h  id / ref=first;
model y = g*h g*t*h  /solution noint;
repeated time/ subject=id type = cs;

estimate 'Time 4: G2 A1'   g*h 1 0 0  0  t *g*h 1 0 0  0;
estimate 'Time 8-Time 3: G1 A0'   t*g*h 0 0 0 5;
estimate 'Time 8-Time 3: G2 A0'   t*g*h 0 5 0 0;
estimate 'Time 8-Time 3: G1 A1'   t*g*h 0 0 5 0;
estimate 'Time 8-Time 3: G2 A1'   t*g*h 5 0  0 0;
estimate 'the average value of (ii), (iv) and (v)'   t*g*h 1.66 0 1.66 1.66;
contrast 'Test for Group by  (iii),(vi)'  t*g*h 0 5 0 0,  t*g*h 1.66 0 1.66 1.66;
run;
/*g*/
