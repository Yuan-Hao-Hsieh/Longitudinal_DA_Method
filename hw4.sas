%let dirc = D:\lu;
%let filen = longanal111sp4.dat;
data ds1;
infile "&dirc\&filen";
input  id age gender time blood treat;
run;
data ds1a;
set ds1;
if time = 2 then d1 = 1; else d1 = 0;
if time = 4 then d2 = 1; else d2 = 0;
if time = 6 then d3 = 1; else d3 = 0;
if time = 8 then d4 = 1; else d4 = 0;
if treat = 2 then g1 =1; else g1 = 0;
if treat = 3 then g2 =1; else g2 = 0;
if age = 0 then a = 0;
if age = 1 then a = 1;
run;
proc print data = ds1a(obs = 20);
run;
proc sort data =ds1a;
by time id;
run;
/*a*/
/*Model1*/
proc corr data=ds1a cov;
var d1 d2 d3 d4;
run;
proc mixed data = ds1a covtest;
class id;
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept/ subject = id type = un gcorr vcorr = 1;
run;
/*-2log L = 3194.0*/
/*AIC = 3198.0*/
/*b(a)*/
proc mixed data=ds1a covtest method = ml;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept time/ subject = id type = cs;
run;
/*-2log L = 3012.2*/
/*AIC = 3078.2*/
/*b(b)*/
proc mixed data=ds1a covtest method = ml;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept time/ subject = id type = csh;
run;
/*-2log L = 3013.4*/
/*AIC = 3071.4*/
/*b(c)*/
proc mixed data=ds1a covtest method = ml;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept time/ subject = id type = ar(1);
run;
/*b(d)*/
proc mixed data=ds1a covtest method = ml;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept time/subject = id type = arh(1);
run;
/*-2log L = 3013.4*/
/*AIC = 3071.4*/
/*b(e)*/
proc mixed data=ds1a covtest method = ml;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept time/ subject = id type = toep;
run;
/*b(f)*/
proc mixed data=ds1a covtest method = ml;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept time/ subject = id type = toeph;
run;

/*b(g)*/
proc mixed data=ds1a covtest method = ml;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept time/ subject = id type = un;
run;

/*c*/
data ds1c;
set ds1;
if age = 0 then a = 0;
if age = 1 then a = 1;
if treat=1 then g1=1; else g1=0;
if treat=2 then g2=1; else g2=0;
time_4 = max(time,4);
run;
proc print data =ds1c(obs = 10);
run;
/*Model1*/
proc mixed data = ds1a covtest;
class id;
model blood = time g1 g2 a g1*a g2*a d1 d2 d3 d4 d1*g1 d2*g1 d3*g1 d4*g1 d1*g2 d2*g2 d3*g2 d4*g2 
d1*a d2*a d3*a d4*a d1*a*g1 d2*a*g1 d3*a*g1 d4*a*g1 d1*a*g2 d2*a*g2 d3*a*g2 d4*a*g2/ solution;
random intercept/ subject = id type = un;
run;
/*Model2*/proc mixed data=ds1c covtest method = ml;
class id ;
model blood = time g1 g2 a g1*a  g2*a time time*g1  time*g2  time*a time*a*g1 time*a*g2 / solution;
random intercept time/ subject = id type = un;
run;


/*Model3*/
proc mixed data=ds1c covtest method = ml;
class id ;
model blood = time time_4 g1 g2 a g1*a g2*a time*g1 time*g2 time_4*g1  time_4*g2  time*a time_4*a 
time*a*g1 time_4*a*g1 time*a*g2 time_4*a*g2 / solution;
random intercept time time_4  / subject = id type = un;
run;

/*(d)*/
data ds1d;
set ds1c;
if time = 0 then time_0=1; else time_0=0;
run;
proc print data = ds1d(obs=10);run;
/* likelihood test*/
proc mixed data=ds1d covtest;
class id time  g1 g1  age ;
model blood = time  g1 g2  age g1*age  g2*age  time*g1  time*g2    time*age   time*age*g1  time*age*g2 time_0*age*g2 / solution;
repeated time/ subject = id type = cs;
run;

proc mixed data=ds1d covtest;
class id time(ref=first)  g1(ref=first) g1(ref=first) age(ref=first) time_0(ref=first);
model blood = time time_0 g1 g2  age g1*age  g2*age  time*g1  time*g2 time_0*g1  time_0*g2  time*age time_0*age  time*age*g1 time_0*age*g1 time*age*g2 time_0*age*g2 / solution;
repeated time/ subject = id type = cs;
estimate 'mean level at time 0  age=1 vs age=0  g the same ' age 1 -1;
estimate 'mean level at time 0  g1=1 vs g1 = 0 age the same' g1 1 -1;
estimate 'mean level at time 0  g2=1 vs g2 = 0 age the same' g2 1 -1;
estimate 'mean level at time 0  age=1 g1=1 vs age=0 g1 = 0' age 1 -1 g1 1 -1;
estimate 'mean level at time 0  age=1 g2=1 vs age=0 g2 = 0' age 1 -1 g2 1 -1;
run;

proc sgplot data =ds1d;
series x = id y = blood / group=age markers;
run;
proc sgplot data =ds1d;
series x = time y = blood / group=treat markers;
run;
/* enough evidence to suggest proper randomization procedures*/
/* but age is not random at basetime*/

/*e*/
/* likelihood test*/
proc mixed data=ds1d covtest;
class id time(ref=first) g1(ref=first) g2(ref=first) age(ref=first) time_0(ref=first);
model blood =g1 g2 age g1*age  g2*age 
             time time_0  time*g1  time*g2 time_0*g1 time_0*g2 time*age time_0*age time*age*g1 time_0*age*g1 time*age*g2 time_0*age*g2 / solution;
repeated time/ subject = id type = un;
run;

/* final of e*/
proc mixed data =ds1d method=ML;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 age  time*g1 time*g2 /solution; 
repeated time/subject = id type= un;
run;
/*f*/
proc sgplot data =ds1d;
series x = time y = blood / group=age markers;
run;


proc mixed data = ds1d method=ML;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 age  time*g1 time*g2 /solution; 
repeated time/subject = id type= un;
estimate ' dependence on age' age 1 -1 ;
run;

/* likelihood test*/
proc mixed data = ds1d method=ML;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 age  time*g1 time*g2 /solution; 
repeated time/subject = id type= un;
run;

proc mixed data = ds1d method=ML;
class id g1(ref=first) g2(ref=first)  time(ref=first);
model blood = time g1 g2  time*g1 time*g2 /solution; 
repeated time/subject = id type= un;
run;
/*g*/
proc mixed data = ds1d method=ML;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 age  time*g1 time*g2 /solution; 
repeated time/subject = id type= un;
estimate ' g1-g2' g1 1 -1 g2 -1 1 ;
run;

/*h*/
proc mixed data = ds1d method=ML;
class id g1(ref=first) g2(ref=first) age(ref=first) time(ref=first);
model blood = time g1 g2 age  time*g1 time*g2 /solution; 
repeated time/subject = id type= un;
estimate 'the mean lead level at week 4 for treatment group 2 ' intercept 1   time 4 0  g1 1 0  g2 0 1 age 0 1  ;
estimate 'the mean lead level at week 8 for treatment average of group2 and and 3 '  intercept 1 time 8 0  g1 0.5 0.5  g2 0.5 0.5  age 0 1  ;
estimate 'the mean lead level at week 0 for treatment average of group2 and and 3 '  intercept 1 time 0 1  g1 0.5 0.5  g2 0.5 0.5  age 0 1  ;
estimate 'the mean lead level at week 8 for treatment group 1 '  intercept 1 time 8 0  g1 1 0  g2 0 1  age 0 1  ;
estimate 'the mean lead level at week 0 for treatment group 1 '  intercept 1 time 0 1  g1 1 0  g2 0 1  age 0 1  ;
estimate 'the mean lead level at week 8 for treatment between group 1 and average of group2 and and 3 '  g1 - 0.5 0.5  g2 0.5 -0.5 ;
run;
