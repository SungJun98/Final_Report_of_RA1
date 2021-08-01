libname reg "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ�ͺм�\HW\�б⸻\dataset" ;
/***********************************************************************************************************************/
/**********************************************������ ��ó��*************************************************************/
/**********************************************************************************************************************/

/********************************************** 1. ���뷮 ������***********************************************************/
/*1�� Raw Data �ҷ�����*/
PROC IMPORT OUT= traffic_jan
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\seoul_traffic\Seoul_traffic_Jan.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2;
RUN;

/*����� ������ ��ü*/
Data traffic_jan;set traffic_jan;rename VAR1=Date VAR2=Day VAR3=Road VAR5=Direction;run;

/*�Ϸ� ���뷮 ����*/
Data traffic_jan;set traffic_jan;traffic_total = sum(of VAR7-VAR30);run;

/*�ѳ��뱳 ������ ���� �� �Ϸ� ��� �ѳ��뱳 ���뷮 ��� �� ����*/
Data traffic_jan;set traffic_jan;IF Road = "�ѳ��뱳";run;
proc means data=traffic_jan mean noprint;class date;var traffic_total;output out=traffic_jan_1;run;
data traffic_jan_1;set traffic_jan_1;drop _TYPE_ _FREQ_;run;
data traffic_jan;set traffic_jan_1;if _STAT_ = "MEAN";run;



/*2��*/
PROC IMPORT OUT= traffic_feb
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\seoul_traffic\Seoul_traffic_Feb.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/*����� ������ ��ü*/
Data traffic_feb;set traffic_feb;rename VAR1=Date VAR2=Day VAR3=Road VAR5=Direction;run;

/*�Ϸ� ���뷮 ����*/
Data traffic_feb;set traffic_feb;traffic_total = sum(of VAR7-VAR30);run;

/*�ѳ��뱳 ������ ���� �� �Ϸ� ��� �ѳ��뱳 ���뷮 ��� �� ����*/
Data traffic_feb;set traffic_feb;IF Road = "�ѳ��뱳";run;
proc means data=traffic_feb mean noprint;class date;var traffic_total;output out=traffic_feb_1;run;
data traffic_feb_1;set traffic_feb_1;drop _TYPE_ _FREQ_;run;
data traffic_feb;set traffic_feb_1;if _STAT_ = "MEAN";run;


/*3��*/
PROC IMPORT OUT= traffic_mar
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\seoul_traffic\Seoul_traffic_Mar.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/*����� ������ ��ü*/
Data traffic_mar;set traffic_mar;rename VAR1=Date VAR2=Day VAR3=Road VAR5=Direction;run;

/*�Ϸ� ���뷮 ����*/
Data traffic_mar;set traffic_mar;traffic_total = sum(of VAR7-VAR30);run;

/*�ѳ��뱳 ������ ���� �� �Ϸ� ��� �ѳ��뱳 ���뷮 ��� �� ����*/
Data traffic_mar;set traffic_mar;IF Road = "�ѳ��뱳";run;
proc means data=traffic_mar mean noprint;class date;var traffic_total;output out=traffic_mar_1;run;
data traffic_mar_1;set traffic_mar_1;drop _TYPE_ _FREQ_;run;
data traffic_mar;set traffic_mar_1;if _STAT_ = "MEAN";run;


/*�ѳ��뱳 1~3�� ���뷮 ����*/
data reg.traffic;set traffic_jan traffic_feb traffic_mar;keep date traffic_total;if date=. then delete;date=put(date, 15.);run;
/************************************************************************************************************************/




/************************************************2. �ڷγ� ����Ȯ���� ��****************************************************/
PROC IMPORT OUT= WORK.r_covid_19 
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\covid_19\Covid19InfState.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data reg.covid_19;
set r_covid_19;
if stateDt>=20210101 and stateDt<=20210331;		/*1�� 30~31�� �����Ͱ� ����!!*/
keep stateDt DdecideCnt;
rename stateDt=Date;
date=put(date, 15.);
run;
/************************************************************************************************************************/




/******************************************************3. ���************************************************************/
/*1��*/
PROC IMPORT OUT= WORK.weather_jan 
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\weather\OBS_ASOS_DD_20210518003352_1��.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
data weather_jan;set weather_jan;keep VAR3 VAR5 VAR6;rename VAR3=Date VAR5=Rain VAR6=Snow;run;

/*2��*/
PROC IMPORT OUT= WORK.WEATHER_feb 
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\weather\OBS_ASOS_DD_20210518003425_2��.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
data weather_feb;set weather_feb;keep VAR3 VAR5 VAR6;rename VAR3=Date VAR5=Rain VAR6=Snow;run;

/*3��*/
PROC IMPORT OUT= WORK.WEATHER_mar 
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\weather\OBS_ASOS_DD_20210518003447_3��.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
data weather_mar;set weather_mar;keep VAR3 VAR5 VAR6;rename VAR3=Date VAR5=Rain VAR6=Snow;run;

/*1~3�� ���� ����*/
data reg.weather;set weather_jan weather_feb weather_mar;run;

/*���̺���ȭ*/
data reg.weather;set reg.weather;
if Rain>=5 then dummy_rain=1;else dummy_rain=0;
if Snow>0 then dummy_snow=1;else dummy_snow=0;
date=put(date, 15.);
run;
/************************************************************************************************************************/




/******************************************************4. ����ö**********************************************************/
/*1��*/
PROC IMPORT OUT= WORK.subway_jan 
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\public_transportation\CARD_SUBWAY_MONTH_202101.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/*����ö ���� ��� �̿밴 ���*/
data subway_jan;set subway_jan;users = mean(of VAR4 VAR5);run;
data subway_jan;set subway_jan;KEEP VAR1 users;run;
/*���� ����ö ��� �̿밴 ���*/
proc means data=subway_jan noprint;class VAR1;var users;output out=subway_jan;run;
data subway_jan;set subway_jan;if _STAT_="MEAN";if _TYPE_="1";keep VAR1 users;rename VAR1=date;run;


/*2��*/
PROC IMPORT OUT= WORK.subway_feb 
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\public_transportation\CARD_SUBWAY_MONTH_202102.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/*����ö ���� ��� �̿밴 ���*/
data subway_feb;set subway_feb;users = mean(of VAR4 VAR5);run;
data subway_feb;set subway_feb;KEEP VAR1 users;run;
/*���� ����ö ��� �̿밴 ���*/
proc means data=subway_feb noprint;class VAR1;var users;output out=subway_feb;run;
data subway_feb;set subway_feb;if _STAT_="MEAN";if _TYPE_="1";keep VAR1 users;rename VAR1=date;run;


/*3��*/
PROC IMPORT OUT= WORK.subway_mar
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\public_transportation\CARD_SUBWAY_MONTH_202103.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/*����ö ���� ��� �̿밴 ���*/
data subway_mar;set subway_mar;users = mean(of VAR4 VAR5);run;
data subway_mar;set subway_mar;KEEP VAR1 users;run;
/*���� ����ö ��� �̿밴 ���*/
proc means data=subway_mar noprint;class VAR1;var users;output out=subway_mar;run;
data subway_mar;set subway_mar;if _STAT_="MEAN";if _TYPE_="1";keep VAR1 users;rename VAR1=date;run;


/*1~3�� ����*/
data reg.subway;
set subway_jan subway_feb subway_mar;
date=put(date, 15.);
run;
/************************************************************************************************************************/





/*****************************************************5. ���� ����*********************************************************/
PROC IMPORT OUT= WORK.fuel 
            DATAFILE= "C:\Users\SungJunLim\Desktop\Lim\UOS\2021-1st\ȸ��
�м�\HW\�б⸻\data\fuel\������_����ǸŰ���_��ǰ��.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data fuel;set fuel;rename VAR1=Date VAR4=crude;gasoline=mean(of VAR2-VAR3);run;
data fuel;set fuel;keep Date crude gasoline;run;

/*�������*/
data reg.fuel;set fuel;fuel = 0.6*gasoline + 0.4*crude;keep date fuel;date=put(date, 15.);run;
/************************************************************************************************************************/



/************************************************�����ͼ� ����***********************************************************/
data reg.traffic;merge reg.traffic reg.covid_19 reg.weather reg.subway reg.fuel;by date;drop rain snow;run;

data reg.traffic;
set reg.traffic;
if _N_=17 then delete;
if _N_=82 then delete;
run;

/************************************************************************************************************************/
/*****************************************************EDA****************************************************************/
/*numeric �����跮*/
proc means data=reg.traffic;var traffic_total Ddecidecnt users fuel;run;
/*numeric scatterplot*/
proc sgplot data=reg.traffic;scatter x=DdecideCnt y=traffic_total;run;
proc sgplot data=reg.traffic;scatter x=users y=traffic_total;run;
proc sgplot data=reg.traffic;scatter x=fuel y=traffic_total;run;
/*numeric correlation*/
proc corr data=reg.traffic;var traffic_total Ddecidecnt;run;
proc corr data=reg.traffic;var traffic_total users;run;
proc corr data=reg.traffic;var traffic_total fuel;run;


/*categorical �����跮*/
proc means data=reg.traffic;class dummy_rain;var traffic_total;run;
proc means data=reg.traffic;class dummy_snow;var traffic_total;run;
/*categorical box-plot*/
proc sort data=reg.traffic;by dummy_rain;run; proc boxplot data=reg.traffic;plot traffic_total*dummy_rain;run;
proc sort data=reg.traffic;by dummy_snow;run; proc boxplot data=reg.traffic;plot traffic_total*dummy_snow;run;



/************************************************************************************************************************/
/****************************************************�� ����************************************************************/
/************************************************************************************************************************/

/*step1*/
proc reg data=reg.traffic;
model traffic_total = Ddecidecnt dummy_rain dummy_snow users fuel /r influence collin vif;
run;quit;
proc corr data=reg.traffic;var Ddecidecnt dummy_rain dummy_snow users fuel;run;

/*step2*/
proc reg data=reg.traffic;
model traffic_total = dummy_snow users fuel / r influence collin vif;
run;quit;

/*step3*/
proc reg data=reg.traffic;
model traffic_total = dummy_snow users fuel / r influence noint;
run;quit;


/*step4*/
data reg.traffic_cl;
set reg.traffic;
if _N_=62 then delete;
if _N_=70 then delete;
run;

proc reg data=reg.traffic_cl;
model traffic_total = dummy_snow users fuel /noint;
plot npp.*rstudent.;
run;quit;

