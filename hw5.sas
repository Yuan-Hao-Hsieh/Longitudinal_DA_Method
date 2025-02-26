%let dirc = D:\lu;
%let filen = longanal111sp5.dat;
data ds5;
infile "&dirc\&filen";
input  id  myocardial  gender  time  inhibition  drug;
run;
proc print data = ds5(obs = 10);
run;
/*a*/
proc sgplot data = ds5;
vline time/ response = inhibition stat = mean group=drug  markers;
run;
/*b*/
data ds5;
set ds5;
t = time - 0.5;
run;
proc print data = ds5;run;
proc sgplot data =ds5;
series x = t y = inhibition / group=drug markers;
run;

data ds5b;
set ds5;
if t =0 then t_0 = 1; else t_0 = 0;
if drug = 1 then d=1; else d = 0;
run;
proc print data = ds5b;run;

proc sort data=ds5b;
by id t  ;
run;

data ds5b1;
set ds5b;
if t_0 = 0  then  myocardial_t_0 = 0; else  myocardial_t_0 =  myocardial;
if t_0 = 0  then d_t_0 = 0; else d_t_0 = d ;
if t_0 = 0  then  gender_t_0 = 0; else  gender_t_0 =  gender ;
run;
proc print data = ds5b1;
run;

proc mixed data=ds5b1 covtest;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first) gender_t_0 (ref=first) ;
model inhibition = t_0  t  myocardial_t_0  gender_t_0  d_t_0  myocardial_t_0*d_t_0 * gender_t_0  / solution vciry outpm = residpmb;
random intercept  t  / subject = id type = un;
run;
/*c*/
proc mixed data=ds5b1 covtest method=ML;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first) gender_t_0 (ref=first) ;
model inhibition = t_0  t  myocardial_t_0  gender_t_0  d_t_0  myocardial_t_0*d_t_0 * gender_t_0  / solution vciry outpm = residpmb;
random intercept  time  / subject = id type = un;
estimate 'inhibition at 0.5 hours after drug administration for male subjects with a previous myocardial infarction taking drug 2.'  intercept 1  t_0  1 0  myocardial_t_0  1 0  gender_t_0 1 0   d_t_0 1 0  myocardial_t_0*d_t_0 * gender_t_0  1 0 0 0 0 0 0 0;
estimate 'Give an expression for mean platelet inhibition for female subjects with no previous myocardial infarction at 12 hours following administration of drug 1' intercept 1  t_0  0 1 t 12  myocardial_t_0  0 1  gender_t_0  0 1  d_t_0  0 1  myocardial_t_0*d_t_0 * gender_t_0  0 0 0 0 0 0 0 1;
run;
/*d*/
proc mixed data=ds5b1 covtest method=ML;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first) gender_t_0 (ref=first) ;
model inhibition = t_0  t  myocardial_t_0  gender_t_0  d_t_0  myocardial_t_0*d_t_0 * gender_t_0  / solution vciry outpm = residpmd;
random intercept  t  /subject = id type =sp(exp)(time) vcorr; 
run;

proc sgplot data=residpm;
loess x = pred y = resid;
/* hope no trend for residuals*/
refline 0 / axis = y lineattrs = (color = 'red');   /* reference line: y=0*/
run;

proc sgplot data=residpm;
loess x = scaleddep y = scaledresid /  lineattrs = (color = 'red' thickness = 2);
refline 0 / axis = y;
run;
/*e*/
proc means data= residpmd var;
var  inhibition;
where gender=1 & myocardial=0  &d1=0 & d2=1 & t_0=1&  t=0 ;
run;

/*f*/
/*H0*/
proc mixed data=ds5b1 covtest method=ML;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first)  ;
model inhibition = t_0  t  myocardial_t_0   myocardial_t_0 *d_t_0     / solution vciry outpm = residpmd;
random intercept  t  / subject = id type =sp(exp)(time); /*cs*/
run;

/* Ha */
proc mixed data=ds5b1 covtest method=ML;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first) gender_t_0 (ref=first) ;
model inhibition = t_0  t  myocardial_t_0  gender_t_0  d_t_0  myocardial_t_0*d_t_0 * gender_t_0  / solution vciry outpm = residpmb;
random intercept  t  /subject = id type =sp(exp)(time) vcorr; /*cs*/
run;

proc sgplot data=ds5;
vline t / response =  inhibition  stat=mean group = gender markers;
run;
/*g*/
proc sgplot data=ds5;
vline t / response =  inhibition  stat=mean group = drug markers;
run;

proc mixed data=ds5b1 covtest method=ML;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first)  ;
model inhibition = t_0  t  myocardial_t_0   myocardial_t_0 *d_t_0     / solution vciry outpm = residpmd;
random intercept  t  / subject = id type =sp(exp)(time); /*cs*/
estimate 'the means between two drugs are the same with m=0'  myocardial_t_0  - 1 1 myocardial_t_0 *d_t_0  0 0 -1 1;
estimate 'the means between two drugs are the same  with m=1'  myocardial_t_0  - 1 1 myocardial_t_0 *d_t_0   -1 1 0 0 ;
run;
/*h*/
proc mixed data=ds5b1 covtest method=ML;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first)  ;
model inhibition =  myocardial_t_0 *d_t_0     / solution vciry outpm = residpmd;
random intercept  t  / subject = id type =sp(exp)(time); /*cs*/
estimate 'rate of change between m=1 and m = 0 with d=0'  myocardial_t_0 *d_t_0  0 0 -1 1;
estimate 'rate of change between m=1 and m = 0 with d=1'  myocardial_t_0 *d_t_0  -1 1 0 0;
run;
/*i*/
proc mixed data=ds5b1 covtest method=REML;
class id   t_0(ref=first) d_t_0(ref=first)   myocardial_t_0(ref=first)  ;
model inhibition = t_0  t  myocardial_t_0   myocardial_t_0 *d_t_0     / solution vciry outpm = residpmd outp=BLUP;
random intercept  t  / subject = id type =sp(exp)(time) ; 
run;
