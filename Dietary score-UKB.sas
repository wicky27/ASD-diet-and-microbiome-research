libname a 'D:\CUHK2023FALL\HATCH COHORT\MR analysis';
proc import out=a.a
datafile="C:\Users\Administrator\AppData\Local\Temp\MicrosoftEdgeDownloads\a5345689-443a-4417-9fcc-c757e24b1c81\a.xlsx"
DBMS=xlsx
 replace;
 run;

proc contents data=a.wyqdata;run;
proc freq data=a.wyqdata; table _41270_0_0;run;

data UKB; set a.wyqdata; /* 502357 -- 501491*/

age=_21003_0_0;/*year*/  sex=_31_0_0;/*1="Male" 0="Female"*/
race=_21000_0_0;
if race in (1, 1001, 1002, 1003) then racegroup=1;/*white*/
if race in (3, 3001, 3002, 3003, 3004, 5) then racegroup=2;/*Asian*/
if race in (4, 4001, 4002, 4003) then racegroup=3;/*Black*/
if race in (2, 2001, 2002, 2003, 2004) then racegroup=5;/*Mixed*/
if race=6 then racegroup=6;/*Others*/
if racegroup=. then racegroup=9;/*unknown*/;

BMI=_21001_0_0;  
if     0<BMI<18.5 then xBMI=1; 
if 18.5<=BMI<25   then xBMI=2; 
if   25<=BMI<30   then xBMI=3; 
if   30<=BMI<35   then xBMI=4;
if   35<=BMI      then xBMI=5;
if       BMI='.'   then xBMI=123;

TDI=_22189_0_0;/*Townsend deprivation index*/

Educationyear=_845_0_0;/*Age completed full time education*/
if _845_0_0<0 then Educationyear=.;
if _845_0_0=-2 then  Educationyear=0;
/*Education*/
/*1	College or University degree
2	A levels/AS levels or equivalent  高考高一高二
3	O levels/GCSEs or equivalent      中学毕业考试必须的
4	CSEs or equivalent               （Certificate of Secondary Education） 1988以前的中学毕业考试
5	NVQ or HND or HNC or equivalent       (National Vocational Qualification)
6	Other professional qualifications eg: nursing, teaching
-7	None of the above
-3	Prefer not to answer*/

if _6138_0_0=1        then Education=1;  /*College or University degree*/
if _6138_0_0 in (5,6) then Education=2;  /*vocational qualifications*/
if _6138_0_0=2        then Education=3;  /*optional national exams at ages 17–18 years*/
if _6138_0_0 in (3,4) then Education=4;  /*national exams at age 16 years*/

if _6138_0_0=-7 then Education=5; /*others*/
if _6138_0_0=. or _6138_0_0=-3  then Education=9; /*unknown*/

HHincome=_738_0_0; if HHincome in (-1,-3) or HHincome=. then HHincome=9; 

/*1	< 18,000
2	18,000 to 30,999
3	31,000 to 51,999
4	52,000 to 100,000
5	> 100,000
-1	Do not know
-3	Prefer not to answer*/

smoking=_20116_0_0;  if smoking=-3 or smoking=. then smoking=9;    
/* -3	Prefer not to answer
    0	Never
    1	Previous
    2	Current */

/*Alcohol frequency-----  X1558_0_0 */;
if      _1558_0_0=1 then alcoholfreq=4;   *daily or almost daily;
else if _1558_0_0=2 then alcoholfreq=3;   *3 or 4 times a week;
else if _1558_0_0=3 then alcoholfreq=2;   *1 or 2 times a week;
else if _1558_0_0=4 then alcoholfreq=1;   *1 to 3 times a month;
else if _1558_0_0=5 then alcoholfreq=0;   *special occasions only;
else if _1558_0_0=6 then alcoholfreq=0;   *never;
else alcoholfreq=9;
/*employment1	In paid employment or self-employed
2	Retired
3	Looking after home and/or family
4	Unable to work because of sickness or disability
5	Unemployed
6	Doing unpaid or voluntary work
7	Full or part-time student
-7	None of the above
-3	Prefer not to answer
*/
if _6142_0_0=1 then employment1=1;
if _6142_0_0=2 then employment1=2;
if _6142_0_0=5 then employment1=3;
if employment1=. then employment1=4;

if _6142_0_0=1 then employment2=1;
if _6142_0_0=2 then employment2=2;
if  _6142_0_0  in (3 4 5 6 7 ) then employment2=4;
if employment2=. then employment2=9;

/*Disease defination*/
array /*259*/    ICD10 {259} _41270_0_0  _41270_0_1	 _41270_0_2	 _41270_0_3	 _41270_0_4	 _41270_0_5	 _41270_0_6	 _41270_0_7	 _41270_0_8	 _41270_0_9	 _41270_0_10	 _41270_0_11	 _41270_0_12	 _41270_0_13	 _41270_0_14	 _41270_0_15	 _41270_0_16	 _41270_0_17	 _41270_0_18	 _41270_0_19	 _41270_0_20	 _41270_0_21	 _41270_0_22	 _41270_0_23	 _41270_0_24	 _41270_0_25	 _41270_0_26	 _41270_0_27	 _41270_0_28	 _41270_0_29	 _41270_0_30	 _41270_0_31	 _41270_0_32	 _41270_0_33	 _41270_0_34	 _41270_0_35	 _41270_0_36	 _41270_0_37	 _41270_0_38	 _41270_0_39	 _41270_0_40	 _41270_0_41	 _41270_0_42	 _41270_0_43	 _41270_0_44	 _41270_0_45	 _41270_0_46	 _41270_0_47	 _41270_0_48	 _41270_0_49	 _41270_0_50	 _41270_0_51	 _41270_0_52	 _41270_0_53	 _41270_0_54	 _41270_0_55	 _41270_0_56	 _41270_0_57	 _41270_0_58	 _41270_0_59	 _41270_0_60	 _41270_0_61	 _41270_0_62	 _41270_0_63	 _41270_0_64	 _41270_0_65	 _41270_0_66	 _41270_0_67	 _41270_0_68	 _41270_0_69	 _41270_0_70	 _41270_0_71	 _41270_0_72	 _41270_0_73	 _41270_0_74	 _41270_0_75	 _41270_0_76	 _41270_0_77	 _41270_0_78	 _41270_0_79	 _41270_0_80	 _41270_0_81	 _41270_0_82	 _41270_0_83	 _41270_0_84	 _41270_0_85	 _41270_0_86	 _41270_0_87	 _41270_0_88	 _41270_0_89	 _41270_0_90	 _41270_0_91	 _41270_0_92	 _41270_0_93	 _41270_0_94	 _41270_0_95	 _41270_0_96	 _41270_0_97	 _41270_0_98	 _41270_0_99	 _41270_0_100	 _41270_0_101	 _41270_0_102	 _41270_0_103	 _41270_0_104	 _41270_0_105	 _41270_0_106	 _41270_0_107	 _41270_0_108	 _41270_0_109	 _41270_0_110	 _41270_0_111	 _41270_0_112	 _41270_0_113	 _41270_0_114	 _41270_0_115	 _41270_0_116	 _41270_0_117	 _41270_0_118	 _41270_0_119	 _41270_0_120	 _41270_0_121	 _41270_0_122	 _41270_0_123	 _41270_0_124	 _41270_0_125	 _41270_0_126	 _41270_0_127	 _41270_0_128	 _41270_0_129	 _41270_0_130	 _41270_0_131	 _41270_0_132	 _41270_0_133	 _41270_0_134	 _41270_0_135	 _41270_0_136	 _41270_0_137	 _41270_0_138	 _41270_0_139	 _41270_0_140	 _41270_0_141	 _41270_0_142	 _41270_0_143	 _41270_0_144	 _41270_0_145	 _41270_0_146	 _41270_0_147	 _41270_0_148	 _41270_0_149	 _41270_0_150	 _41270_0_151	 _41270_0_152	 _41270_0_153	 _41270_0_154	 _41270_0_155	 _41270_0_156	 _41270_0_157	 _41270_0_158	 _41270_0_159	 _41270_0_160	 _41270_0_161	 _41270_0_162	 _41270_0_163	 _41270_0_164	 _41270_0_165	 _41270_0_166	 _41270_0_167	 _41270_0_168	 _41270_0_169	 _41270_0_170	 _41270_0_171	 _41270_0_172	 _41270_0_173	 _41270_0_174	 _41270_0_175	 _41270_0_176	 _41270_0_177	 _41270_0_178	 _41270_0_179	 _41270_0_180	 _41270_0_181	 _41270_0_182	 _41270_0_183	 _41270_0_184	 _41270_0_185	 _41270_0_186	 _41270_0_187	 _41270_0_188	 _41270_0_189	 _41270_0_190	 _41270_0_191	 _41270_0_192	 _41270_0_193	 _41270_0_194	 _41270_0_195	 _41270_0_196	 _41270_0_197	 _41270_0_198	 _41270_0_199	 _41270_0_200	 _41270_0_201	 _41270_0_202	 _41270_0_203	 _41270_0_204	 _41270_0_205	 _41270_0_206	 _41270_0_207	 _41270_0_208	_41270_0_209 _41270_0_210 _41270_0_211 _41270_0_212 _41270_0_213 _41270_0_214 _41270_0_215 _41270_0_216 _41270_0_217 _41270_0_218 _41270_0_219 _41270_0_220 _41270_0_221 _41270_0_222 _41270_0_223 _41270_0_224 _41270_0_225 _41270_0_226 _41270_0_227 _41270_0_228 _41270_0_229 _41270_0_230 _41270_0_231 _41270_0_232 _41270_0_233 _41270_0_234 _41270_0_235 _41270_0_236 _41270_0_237 _41270_0_238 _41270_0_239 _41270_0_240 _41270_0_241 _41270_0_242 _41270_0_243 _41270_0_244 _41270_0_245 _41270_0_246 _41270_0_247 _41270_0_248 _41270_0_249 _41270_0_250 _41270_0_251 _41270_0_252 _41270_0_253 _41270_0_254 _41270_0_255 _41270_0_256 _41270_0_257 _41270_0_258;
do i=1 to 259; if ICD10{i} in ("F840","F841","F845","F801","F802","F808","F809","F812","F819")
then do; ASD=1;end;end;
array   ICD10m {80}  _41202_0_0   _41202_0_1	 _41202_0_2	 _41202_0_3	 _41202_0_4	 _41202_0_5	 _41202_0_6	 _41202_0_7	 _41202_0_8	 _41202_0_9	 _41202_0_10	 _41202_0_11	 _41202_0_12	 _41202_0_13	 _41202_0_14	 _41202_0_15	 _41202_0_16	 _41202_0_17	 _41202_0_18	 _41202_0_19	 _41202_0_20	 _41202_0_21	 _41202_0_22	 _41202_0_23	 _41202_0_24	 _41202_0_25	 _41202_0_26	 _41202_0_27	 _41202_0_28	 _41202_0_29	 _41202_0_30	 _41202_0_31	 _41202_0_32	 _41202_0_33	 _41202_0_34	 _41202_0_35	 _41202_0_36	 _41202_0_37	 _41202_0_38	 _41202_0_39	 _41202_0_40	 _41202_0_41	 _41202_0_42	 _41202_0_43	 _41202_0_44	 _41202_0_45	 _41202_0_46	 _41202_0_47	 _41202_0_48	 _41202_0_49	 _41202_0_50	 _41202_0_51	 _41202_0_52	 _41202_0_53	 _41202_0_54	 _41202_0_55	 _41202_0_56	 _41202_0_57	 _41202_0_58	 _41202_0_59	 _41202_0_60	 _41202_0_61	 _41202_0_62	 _41202_0_63	 _41202_0_64	 _41202_0_65	 _41202_0_66	 _41202_0_67	 _41202_0_68	 _41202_0_69	 _41202_0_70	 _41202_0_71	 _41202_0_72	 _41202_0_73	 _41202_0_74	 _41202_0_75	 _41202_0_76	 _41202_0_77	 _41202_0_78	 _41202_0_79	;
 do i=1 to 80; if ICD10m{i} in ("F840","F841","F845","F801","F802","F808","F809","F812","F819")
then do; ASD=1;end;end;
array    ICD10s {210}  _41204_0_0   _41204_0_1	 _41204_0_2	 _41204_0_3	 _41204_0_4	 _41204_0_5	 _41204_0_6	 _41204_0_7	 _41204_0_8	 _41204_0_9	 _41204_0_10	 _41204_0_11	 _41204_0_12	 _41204_0_13	 _41204_0_14	 _41204_0_15	 _41204_0_16	 _41204_0_17	 _41204_0_18	 _41204_0_19	 _41204_0_20	 _41204_0_21	 _41204_0_22	 _41204_0_23	 _41204_0_24	 _41204_0_25	 _41204_0_26	 _41204_0_27	 _41204_0_28	 _41204_0_29	 _41204_0_30	 _41204_0_31	 _41204_0_32	 _41204_0_33	 _41204_0_34	 _41204_0_35	 _41204_0_36	 _41204_0_37	 _41204_0_38	 _41204_0_39	 _41204_0_40	 _41204_0_41	 _41204_0_42	 _41204_0_43	 _41204_0_44	 _41204_0_45	 _41204_0_46	 _41204_0_47	 _41204_0_48	 _41204_0_49	 _41204_0_50	 _41204_0_51	 _41204_0_52	 _41204_0_53	 _41204_0_54	 _41204_0_55	 _41204_0_56	 _41204_0_57	 _41204_0_58	 _41204_0_59	 _41204_0_60	 _41204_0_61	 _41204_0_62	 _41204_0_63	 _41204_0_64	 _41204_0_65	 _41204_0_66	 _41204_0_67	 _41204_0_68	 _41204_0_69	 _41204_0_70	 _41204_0_71	 _41204_0_72	 _41204_0_73	 _41204_0_74	 _41204_0_75	 _41204_0_76	 _41204_0_77	 _41204_0_78	 _41204_0_79	 _41204_0_80	 _41204_0_81	 _41204_0_82	 _41204_0_83	 _41204_0_84	 _41204_0_85	 _41204_0_86	 _41204_0_87	 _41204_0_88	 _41204_0_89	 _41204_0_90	 _41204_0_91	 _41204_0_92	 _41204_0_93	 _41204_0_94	 _41204_0_95	 _41204_0_96	 _41204_0_97	 _41204_0_98	 _41204_0_99	 _41204_0_100	 _41204_0_101	 _41204_0_102	 _41204_0_103	 _41204_0_104	 _41204_0_105	 _41204_0_106	 _41204_0_107	 _41204_0_108	 _41204_0_109	 _41204_0_110	 _41204_0_111	 _41204_0_112	 _41204_0_113	 _41204_0_114	 _41204_0_115	 _41204_0_116	 _41204_0_117	 _41204_0_118	 _41204_0_119	 _41204_0_120	 _41204_0_121	 _41204_0_122	 _41204_0_123	 _41204_0_124	 _41204_0_125	 _41204_0_126	 _41204_0_127	 _41204_0_128	 _41204_0_129	 _41204_0_130	 _41204_0_131	 _41204_0_132	 _41204_0_133	 _41204_0_134	 _41204_0_135	 _41204_0_136	 _41204_0_137	 _41204_0_138	 _41204_0_139	 _41204_0_140	 _41204_0_141	 _41204_0_142	 _41204_0_143	 _41204_0_144	 _41204_0_145	 _41204_0_146	 _41204_0_147	 _41204_0_148	 _41204_0_149	 _41204_0_150	 _41204_0_151	 _41204_0_152	 _41204_0_153	 _41204_0_154	 _41204_0_155	 _41204_0_156	 _41204_0_157	 _41204_0_158	 _41204_0_159	 _41204_0_160	 _41204_0_161	 _41204_0_162	 _41204_0_163	 _41204_0_164	 _41204_0_165	 _41204_0_166	 _41204_0_167	 _41204_0_168	 _41204_0_169	 _41204_0_170	 _41204_0_171	 _41204_0_172	 _41204_0_173	 _41204_0_174	 _41204_0_175	 _41204_0_176	 _41204_0_177	 _41204_0_178	 _41204_0_179	 _41204_0_180	 _41204_0_181	 _41204_0_182	 _41204_0_183	 _41204_0_184	 _41204_0_185	 _41204_0_186	 _41204_0_187	 _41204_0_188	 _41204_0_189	 _41204_0_190	 _41204_0_191	 _41204_0_192	 _41204_0_193	 _41204_0_194	 _41204_0_195	 _41204_0_196	 _41204_0_197	 _41204_0_198	 _41204_0_199	 _41204_0_200	 _41204_0_201	 _41204_0_202	 _41204_0_203	 _41204_0_204	 _41204_0_205	 _41204_0_206	 _41204_0_207	 _41204_0_208	 _41204_0_209		;
 do i=1 to 210; if ICD10s{i} in ("F840","F841","F845","F801","F802","F808","F809","F812","F819")
then do; ASD=1;end;end;
if ASD=. then ASD=0;
if _1309_0_0=. and _1309_1_0=. and _1309_2_0=. and _1309_3_0=. then delete;
run;
data ukb;set ukb;
IF _100002_0_0=. and _100002_1_0=. and _100002_2_0=. and _100002_3_0=. and _100002_4_0=. THEN delete;
run;/*210886*/

proc freq data=a;table  ASD;run;
data foodfreq; set a.wyqdata;

/*Fresh Fruit n_1309_0_0="Fresh fruit intake" pieces/day 
-10	Less than one
-1	Do not know
-3	Prefer not to answer*/
freshfruit=_1309_0_0;if freshfruit=. then freshfruit=_1309_1_0; if freshfruit=. then freshfruit=_1309_2_0;if freshfruit=. then freshfruit=_1309_3_0;  

If freshfruit=-10 then freshfruit=0.5;
Else If freshfruit in (-1,-3) then freshfruit=.;

driedfruit=_1319_0_0;if driedfruit=. then driedfruit=_1319_1_0; if driedfruit=. then driedfruit=_1319_2_0;if driedfruit=. then driedfruit=_1319_3_0;  

If driedfruit=-10 then driedfruit=0.5;
Else If driedfruit in (-1,-3) then driedfruit=.;

driedfruit_adjust=driedfruit/5; /*5 pieces/day*/
fruitintake=sum(freshfruit,driedfruit_adjust); /*servings/d*/

if  0<=fruitintake<2 then fruitintakef=1;
if  2<=fruitintake<4 then fruitintakef=2;
if  4<=fruitintake   then fruitintakef=3;
if     fruitintake=. then fruitintakef=9;
/*Vegetable n_1289_0_0="Cooked vegetable intake" n_1299_0_0="Salad / raw vegetable intake" tablespoons/day 
-10	Less than one
-1	Do not know
-3	Prefer not to answer*/
raw_vegetable=_1299_0_0;if raw_vegetable=. then raw_vegetable=_1299_1_0; if raw_vegetable=. then raw_vegetable=_1299_2_0;if raw_vegetable=. then raw_vegetable=_1299_3_0;  
Cooked_vegetable=_1289_0_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_1_0; if Cooked_vegetable=. then Cooked_vegetable=_1289_2_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_3_0;  


if Cooked_vegetable=-10 then Cooked_vegetable=0.5;
if    raw_vegetable=-10 then    raw_vegetable=0.5;
if Cooked_vegetable in (-1, -3) then Cooked_vegetable=.;
if    raw_vegetable in (-1, -3) then    raw_vegetable=.;
vegetableintake=sum(Cooked_vegetable,raw_vegetable)/3;/*servings/d*/

if   0<=vegetableintake<1 then vegetableintakef=1;
if   1<=vegetableintake<3 then vegetableintakef=2;
if   3<=vegetableintake   then vegetableintakef=3;
if      vegetableintake=. then vegetableintakef=9;

/*oilyfish X1329_0_0="Oily fish intake" */
oilyfishintakef=_1329_0_0;if oilyfishintakef=. then oilyfishintakef=_1329_1_0; if oilyfishintakef=. then oilyfishintakef=_1329_2_0;if oilyfishintakef=. then oilyfishintakef=_1329_3_0;  

if oilyfishintakef in (-1, -3) or oilyfishintakef=. then  oilyfishintakef=9;
if oilyfishintakef=0          then oilyfishintakef=1;/*<1/wk*/
if oilyfishintakef=2          then oilyfishintakef=2;/* 1/wk*/
if oilyfishintakef in (3,4,5) then oilyfishintakef=3;/*>=2/wk*/

/*Processed meat _1349_0_0="Processed meat intake"
0	Never
1	Less than once a week
2	Once a week
3	2-4 times a week
4	5-6 times a week
5	Once or more daily
-1	Do not know
-3	Prefer not to answer*/
prmeatintakef=_1349_0_0;if prmeatintakef=. then prmeatintakef=_1349_1_0; if prmeatintakef=. then prmeatintakef=_1349_2_0;if prmeatintakef=. then prmeatintakef=_1349_3_0;  
if 0<=prmeatintakef<=1        then prmeatintakef=1;/*<1/wk*/
if    prmeatintakef in (3,4,5)  then prmeatintakef=3;/*>=2/wk*/
if    prmeatintakef in (-1, -3) or prmeatintakef=. then  prmeatintakef=9;


/*unprocessed red meats*/
/*_1369_0_0="Beef intake"*/
if _1369_0_0=0 then beef_intake=0;
if _1369_0_0=1 then beef_intake=0.5;
if _1369_0_0=2 then beef_intake=1;
if _1369_0_0=3 then beef_intake=3;
if _1369_0_0=4 then beef_intake=5.5;
if _1369_0_0=5 then beef_intake=7;
/*_1379_0_0="Lamb/mutton intake"*/
if _1379_0_0=0 then lamb_intake=0;
if _1379_0_0=1 then lamb_intake=0.5;
if _1379_0_0=2 then lamb_intake=1;
if _1379_0_0=3 then lamb_intake=3;
if _1379_0_0=4 then lamb_intake=5.5;
if _1379_0_0=5 then lamb_intake=7;
/*_1389_0_0="Pork intake"*/
if _1389_0_0=0 then pork_intake=0;
if _1389_0_0=1 then pork_intake=0.5;
if _1389_0_0=2 then pork_intake=1;
if _1389_0_0=3 then pork_intake=3;
if _1389_0_0=4 then pork_intake=5.5;
if _1389_0_0=5 then pork_intake=7;

unprmeatsintake=sum(beef_intake,lamb_intake,pork_intake);

if 0<=unprmeatsintake<2   then unprmeatsintakef=1;/*<2/wk*/
if 2<=unprmeatsintake<=4  then unprmeatsintakef=2;/*2-4/wk*/
if 4< unprmeatsintake     then unprmeatsintakef=3;/*>4/wk*/
if    unprmeatsintake=.   then unprmeatsintakef=9;
/*1	Fish oil (including cod liver oil)
2	Glucosamine
3	Calcium
4	Zinc
5	Iron
6	Selenium
-7	None of the above
-3	Prefer not to answer*/
if _6179_0_0=1 or _6179_0_1=1 or  _6179_0_2=1 or _6179_0_3=1 or _6179_0_4=1 or _6179_0_5=1 
or _6179_1_0=1 or _6179_1_1=1 or  _6179_1_2=1 or _6179_1_3=1 or _6179_1_4=1 or _6179_1_5=1
or _6179_2_0=1 or _6179_2_1=1 or  _6179_2_2=1 or _6179_2_3=1 or _6179_2_4=1 or _6179_2_5=1
or _6179_3_0=1 or _6179_3_1=1 or  _6179_3_2=1 or _6179_3_3=1 or _6179_3_4=1 or _6179_3_5=1
then fishoil=1;

if _6179_0_0 in (3,4,5,6) or _6179_0_1 in (3,4,5,6) or _6179_0_2 in (3,4,5,6) or _6179_0_3 in (3,4,5,6) or _6179_0_4 in (3,4,5,6) or _6179_0_5 in (3,4,5,6) 
or _6179_1_0 in (3,4,5,6) or _6179_1_1 in (3,4,5,6) or _6179_1_2 in (3,4,5,6) or _6179_1_3 in (3,4,5,6) or _6179_1_4 in (3,4,5,6) or _6179_1_5 in (3,4,5,6) 
or _6179_2_0 in (3,4,5,6) or _6179_2_1 in (3,4,5,6) or _6179_2_2 in (3,4,5,6) or _6179_2_3 in (3,4,5,6) or _6179_2_4 in (3,4,5,6) or _6179_2_5 in (3,4,5,6) 
or _6179_3_0 in (3,4,5,6) or _6179_3_1 in (3,4,5,6) or _6179_3_2 in (3,4,5,6) or _6179_3_3 in (3,4,5,6) or _6179_3_4 in (3,4,5,6) or _6179_3_5 in (3,4,5,6) 

then mineral=1 ; else mineral=0;

/*Vitamin supplementation 6155 "Vitamin and mineral supplements"
1	Vitamin A
2	Vitamin B
3	Vitamin C
4	Vitamin D
5	Vitamin E
6	Folic acid or Folate (Vit B9)
7	Multivitamins +/- minerals
-7	None of the above
-3	Prefer not to answer*/
if _6155_0_0 in (1,2,3,4,5,6,7) or _6155_0_1 in (1,2,3,4,5,6,7) or _6155_0_2 in (1,2,3,4,5,6,7) or _6155_0_3 in (1,2,3,4,5,6,7)  or _6155_0_4 in (1,2,3,4,5,6,7) or _6155_0_5 in (1,2,3,4,5,6,7) or _6155_0_6 in (1,2,3,4,5,6,7) 
or _6155_1_0 in (1,2,3,4,5,6,7) or _6155_1_1 in (1,2,3,4,5,6,7) or _6155_1_2 in (1,2,3,4,5,6,7) or _6155_1_3 in (1,2,3,4,5,6,7)  or _6155_1_4 in (1,2,3,4,5,6,7) or _6155_1_5 in (1,2,3,4,5,6,7) or _6155_1_6 in (1,2,3,4,5,6,7) 
or _6155_2_0 in (1,2,3,4,5,6,7) or _6155_2_1 in (1,2,3,4,5,6,7) or _6155_2_2 in (1,2,3,4,5,6,7) or _6155_2_3 in (1,2,3,4,5,6,7)  or _6155_2_4 in (1,2,3,4,5,6,7) or _6155_2_5 in (1,2,3,4,5,6,7) or _6155_2_6 in (1,2,3,4,5,6,7) 
or _6155_3_0 in (1,2,3,4,5,6,7) or _6155_3_1 in (1,2,3,4,5,6,7) or _6155_3_2 in (1,2,3,4,5,6,7) or _6155_3_3 in (1,2,3,4,5,6,7)  or _6155_3_4 in (1,2,3,4,5,6,7) or _6155_3_5 in (1,2,3,4,5,6,7) or _6155_3_6 in (1,2,3,4,5,6,7) 

then vitamin=1; else vitamin=0;

/* 20084 24-h dietary recall "Vitamin and/or mineral supplement use yesterday" 	472	Fish oil*/
array supplement1 {105} _20084_0_0	_20084_0_1	_20084_0_2	_20084_0_3	_20084_0_4	_20084_0_5	_20084_0_6	_20084_0_7	_20084_0_8	_20084_0_9	_20084_0_10	_20084_0_11	_20084_0_12	_20084_0_13	_20084_0_14	_20084_0_15	_20084_0_16	_20084_0_17	_20084_0_18	_20084_0_19	_20084_0_20
_20084_1_0	_20084_1_1	_20084_1_2	_20084_1_3	_20084_1_4	_20084_1_5	_20084_1_6	_20084_1_7	_20084_1_8	_20084_1_9	_20084_1_10	_20084_1_11	_20084_1_12	_20084_1_13	_20084_1_14	_20084_1_15	_20084_1_16	_20084_1_17	_20084_1_18	_20084_1_19	_20084_1_20
_20084_2_0	_20084_2_1	_20084_2_2	_20084_2_3	_20084_2_4	_20084_2_5	_20084_2_6	_20084_2_7	_20084_2_8	_20084_2_9	_20084_2_10	_20084_2_11	_20084_2_12	_20084_2_13	_20084_2_14	_20084_2_15	_20084_2_16	_20084_2_17	_20084_2_18	_20084_2_19	_20084_2_20
_20084_3_0	_20084_3_1	_20084_3_2	_20084_3_3	_20084_3_4	_20084_3_5	_20084_3_6	_20084_3_7	_20084_3_8	_20084_3_9	_20084_3_10	_20084_3_11	_20084_3_12	_20084_3_13	_20084_3_14	_20084_3_15	_20084_3_16	_20084_3_17	_20084_3_18	_20084_3_19	_20084_3_20
_20084_4_0	_20084_4_1	_20084_4_2	_20084_4_3	_20084_4_4	_20084_4_5	_20084_4_6	_20084_4_7	_20084_4_8	_20084_4_9	_20084_4_10	_20084_4_11	_20084_4_12	_20084_4_13	_20084_4_14	_20084_4_15	_20084_4_16	_20084_4_17	_20084_4_18	_20084_4_19	_20084_4_20;
do i=1 to 105; if supplement1{i} =472 then fishoil=1; end;if fishoil^=1 then fishoil=0;
keep eid fruitintakef vegetableintakef oilyfishintakef prmeatintakef unprmeatsintakef  fishoil mineral vitamin;
RUN;
proc freq;table fruitintakef vegetableintakef oilyfishintakef prmeatintakef unprmeatsintakef ;run;


data DHIscore;set a.wyqdata;
if _100002_0_0^='.' then n1=1;
if _100002_1_0^='.' then n2=1;
if _100002_2_0^='.' then n3=1;
if _100002_3_0^='.' then n4=1;
if _100002_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
energy=sum(_100002_0_0,_100002_1_0,_100002_2_0,_100002_3_0,_100002_4_0)/n;
if energy=0 then delete;
/*SFA*/
if _100006_0_0^='.' then n1=1;
if _100006_1_0^='.' then n2=1;
if _100006_2_0^='.' then n3=1;
if _100006_3_0^='.' then n4=1;
if _100006_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enSFA=sum(_100006_0_0,_100006_1_0,_100006_2_0,_100006_3_0,_100006_4_0)/n;
if _100007_0_0^='.' then n1=1;if _100007_1_0^='.' then n2=1;if _100007_2_0^='.' then n3=1;if _100007_3_0^='.' then n4=1;if _100007_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enPUFA=sum(_100007_0_0,_100007_1_0,_100007_2_0,_100007_3_0,_100007_4_0)/n;
if _100003_0_0^='.' then n1=1;if _100003_1_0^='.' then n2=1;if _100003_2_0^='.' then n3=1;if _100003_3_0^='.' then n4=1;if _100003_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enPro=sum(_100003_0_0,_100003_1_0,_100003_2_0,_100003_3_0,_100003_4_0)/n;
if _100005_0_0^='.' then n1=1;if _100005_1_0^='.' then n2=1;if _100005_2_0^='.' then n3=1;if _100005_3_0^='.' then n4=1;if _100005_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enCarb=sum(_100005_0_0,_100005_1_0,_100005_2_0,_100005_3_0,_100005_4_0)/n;

enSFA=enSFA*37.7/energy;
enPUFA=enPUFA*37.7/energy;
enPro=enPro*16.7/energy;
enCarb=enCarb*17.2/energy;
enfat=1-enPro-enCarb;
if enSFA>0.1 then SFAscore=0 ;if enSFA>=0 and enSFA<=0.1 then SFAscore=1;
if enPUFA>0.1 then PUFAscore=0 ;if enPUFA<0.06 then PUFAscore=0 ;if enPUFA>=0.06 and enPUFA<=0.1 then PUFAscore=1;
if enPro<0.1 then Proscore=0 ;if enPro>0.15 then Proscore=0 ;if enPro>=0.1 and enPro<=0.15 then Proscore=1;
if enCarb>0.7 then Carbscore=0 ;if enCarb<0.5 then Carbscore=0 ;if enCarb>=0.5 and enCarb<=0.7 then Carbscore=1;
/*Fiber*/
if _100009_0_0^='.' then n1=1;if _100009_1_0^='.' then n2=1;if _100009_2_0^='.' then n3=1;if _100009_3_0^='.' then n4=1;if _100009_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
fiber=sum(_100009_0_0,_100009_1_0,_100009_2_0,_100009_3_0,_100009_4_0)/n;
if  fiber<18 or  fiber>32 then Fibrescore=0; if  fiber<=32 and  fiber>=18 then Fibrescore=1;

freshfruit=_1309_0_0;if freshfruit=. then freshfruit=_1309_1_0; if freshfruit=. then freshfruit=_1309_2_0;if freshfruit=. then freshfruit=_1309_3_0;  
If freshfruit=-10 then freshfruit=0.5;
Else If freshfruit in (-1,-3) then freshfruit=.;
driedfruit=_1319_0_0;if driedfruit=. then driedfruit=_1319_1_0; if driedfruit=. then driedfruit=_1319_2_0;if driedfruit=. then driedfruit=_1319_3_0;  
If driedfruit=-10 then driedfruit=0.5;
Else If driedfruit in (-1,-3) then driedfruit=.;
driedfruit_adjust=driedfruit/5; /*5 pieces/day*/
fruitintake=sum(freshfruit,driedfruit_adjust); /*servings/d*/

raw_vegetable=_1299_0_0;if raw_vegetable=. then raw_vegetable=_1299_1_0; if raw_vegetable=. then raw_vegetable=_1299_2_0;if raw_vegetable=. then raw_vegetable=_1299_3_0;  
Cooked_vegetable=_1289_0_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_1_0; if Cooked_vegetable=. then Cooked_vegetable=_1289_2_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_3_0;  

if Cooked_vegetable=-10 then Cooked_vegetable=0.5;
if    raw_vegetable=-10 then    raw_vegetable=0.5;
if Cooked_vegetable in (-1, -3) then Cooked_vegetable=.;
if    raw_vegetable in (-1, -3) then    raw_vegetable=.;
vegetableintake=sum(Cooked_vegetable,raw_vegetable)/3;/*servings/d*/
fruitveg=150*(fruitintake+vegetableintake);
If fruitveg>=400 then fruitvegscore=1;
If fruitveg<400 or fruitveg=. then fruitvegscore=0;

array raw{35}  _104000_0_0 _104000_1_0 _104000_2_0 _104000_3_0 _104000_4_0 
_104010_0_0 _104010_1_0 _104010_2_0 _104010_3_0 _104010_4_0
_104110_0_0 _104110_1_0 _104110_2_0 _104110_3_0 _104110_4_0
_102410_0_0 _102410_1_0 _102410_2_0 _102410_3_0 _102410_4_0
_102420_0_0 _102420_1_0 _102420_2_0 _102420_3_0 _102420_4_0
_102430_0_0 _102430_1_0 _102430_2_0 _102430_3_0 _102430_4_0
_102450_0_0 _102450_1_0 _102450_2_0 _102450_3_0 _102450_4_0;
do i=1 to 35; if raw{i} in ('30','300') then raw{i}=3.5;if raw{i} in ('55','555') then raw{i}=0.5; 
if raw{i} in ('44','444') then raw{i}=0.25; 
end;
if _104000_0_0^='.' then n1=1;if _104000_1_0^='.' then n2=1;if _104000_2_0^='.' then n3=1;if _104000_3_0^='.' then n4=1;if _104000_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_104000_0_0=sum(_104000_0_0,_104000_1_0,_104000_2_0,_104000_3_0,_104000_4_0)/n;
if _104010_0_0^='.' then n1=1;if _104010_1_0^='.' then n2=1;if _104010_2_0^='.' then n3=1;if _104010_3_0^='.' then n4=1;if _104010_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_104010_0_0=sum(_104010_0_0,_104010_1_0,_104010_2_0,_104010_3_0,_104010_4_0)/n;
if _104110_0_0^='.' then n1=1;if _104110_1_0^='.' then n2=1;if _104110_2_0^='.' then n3=1;if _104110_3_0^='.' then n4=1;if _104110_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_104110_0_0=sum(_104110_0_0,_104110_1_0,_104110_2_0,_104110_3_0,_104110_4_0)/n;
if _102410_0_0^='.' then n1=1;if _102410_1_0^='.' then n2=1;if _102410_2_0^='.' then n3=1;if _102410_3_0^='.' then n4=1;if _102410_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102410_0_0=sum(_102410_0_0,_102410_1_0,_102410_2_0,_102410_3_0,_102410_4_0)/n;
if _102420_0_0^='.' then n1=1;if _102420_1_0^='.' then n2=1;if _102420_2_0^='.' then n3=1;if _102420_3_0^='.' then n4=1;if _102420_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102420_0_0=sum(_102420_0_0,_102420_1_0,_102420_2_0,_102420_3_0,_102420_4_0)/n;
if _102430_0_0^='.' then n1=1;if _102430_1_0^='.' then n2=1;if _102430_2_0^='.' then n3=1;if _102430_3_0^='.' then n4=1;if _102430_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102430_0_0=sum(_102430_0_0,_102430_1_0,_102430_2_0,_102430_3_0,_102430_4_0)/n;
if _102450_0_0^='.' then n1=1;if _102450_1_0^='.' then n2=1;if _102450_2_0^='.' then n3=1;if _102450_3_0^='.' then n4=1;if _102450_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102450_0_0=sum(_102450_0_0,_102450_1_0,_102450_2_0,_102450_3_0,_102450_4_0)/n;
/*104000	Baked bean 104010	pulses 104110	broad bean 102410	Salted peanuts 102420	unsalted peanuts 102430	salted nuts 102420	unsalted nuts 102450	seeds*/
nuts=sum( n_104000_0_0, n_104010_0_0, n_104110_0_0, n_102410_0_0, n_102420_0_0, n_102430_0_0, n_102450_0_0);
if nuts<1 then nutscore=0;if nuts>=1 then nutscore=1;/*severing 30g*/

if _100002_0_0^='.' then n1=1;if _100002_1_0^='.' then n2=1;if _100002_2_0^='.' then n3=1;if _100002_3_0^='.' then n4=1;if _100002_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
energy=sum(_100002_0_0,_100002_1_0,_100002_2_0,_100002_3_0,_100002_4_0)/n;
if _26011_0_0^='.' then n1=1;if _26011_1_0^='.' then n2=1;if _26011_2_0^='.' then n3=1;if _26011_3_0^='.' then n4=1;if _26011_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
sugar=sum(_26011_0_0,_26011_1_0,_26011_2_0,_26011_3_0,_26011_4_0)/n;
ensugar= sugar*17.2/energy;
if ensugar>0.1 then sugarscore=0 ;if ensugar<0.1 then sugarscore=1;

array data{30}  _103150_0_0 _103150_1_0 _103150_2_0 _103150_3_0 _103150_4_0 
_103160_0_0 _103160_1_0 _103160_2_0 _103160_3_0 _103160_4_0
_103190_0_0 _103190_1_0 _103190_2_0 _103190_3_0 _103190_4_0
_103200_0_0 _103200_1_0 _103200_2_0 _103200_3_0 _103200_4_0
_103210_0_0 _103210_1_0 _103210_2_0 _103210_3_0 _103210_4_0
_103220_0_0 _103220_1_0 _103220_2_0 _103220_3_0 _103220_4_0;
do i=1 to 30; if data{i} in ('40','400') then data{i}=4.5;if data{i} in ('55','555') then data{i}=0.5; 
end;
if _103150_0_0^='.' then n1=1;if _103150_1_0^='.' then n2=1;if _103150_2_0^='.' then n3=1;if _103150_3_0^='.' then n4=1;if _103150_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103150_0_0=sum(_103150_0_0,_103150_1_0,_103150_2_0,_103150_3_0,_103150_4_0)/n;
if _103160_0_0^='.' then n1=1;if _103160_1_0^='.' then n2=1;if _103160_2_0^='.' then n3=1;if _103160_3_0^='.' then n4=1;if _103160_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103160_0_0=sum(_103160_0_0,_103160_1_0,_103160_2_0,_103160_3_0,_103160_4_0)/n;
if _103190_0_0^='.' then n1=1;if _103190_1_0^='.' then n2=1;if _103190_2_0^='.' then n3=1;if _103190_3_0^='.' then n4=1;if _103190_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103190_0_0=sum(_103190_0_0,_103190_1_0,_103190_2_0,_103190_3_0,_103190_4_0)/n;
if _103200_0_0^='.' then n1=1;if _103200_1_0^='.' then n2=1;if _103200_2_0^='.' then n3=1;if _103200_3_0^='.' then n4=1;if _103200_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103200_0_0=sum(_103200_0_0,_103200_1_0,_103200_2_0,_103200_3_0,_103200_4_0)/n;
if _103210_0_0^='.' then n1=1;if _103210_1_0^='.' then n2=1;if _103210_2_0^='.' then n3=1;if _103210_3_0^='.' then n4=1;if _103210_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103210_0_0=sum(_103210_0_0,_103210_1_0,_103210_2_0,_103210_3_0,_103210_4_0)/n;
if _103220_0_0^='.' then n1=1;if _103220_1_0^='.' then n2=1;if _103220_2_0^='.' then n3=1;if _103220_3_0^='.' then n4=1;if _103220_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103220_0_0=sum(_103220_0_0,_103220_1_0,_103220_2_0,_103220_3_0,_103220_4_0)/n;
/*103150	Tinned tuna 103160	Oily fish 103190	White fish 103200	Prawns 103210	Lobster/crab 103220	Shellfish*/
fish=sum( n_103150_0_0, n_103160_0_0, n_103190_0_0, n_103200_0_0, n_103210_0_0, n_103220_0_0)*120;
if fish>=32 then fishscore=1;if fish<32 then fishscore=0;

array df2{45}  _103020_0_0 _103020_1_0 _103020_2_0 _103020_3_0 _103020_4_0
_103030_0_0 _103030_1_0 _103030_2_0 _103030_3_0 _103030_4_0
_103040_0_0 _103040_1_0 _103040_2_0 _103040_3_0 _103040_4_0
_103100_0_0 _103100_1_0 _103100_2_0 _103100_3_0 _103100_4_0
_103060_0_0 _103060_1_0 _103060_2_0 _103060_3_0 _103060_4_0
_103010_0_0 _103010_1_0 _103010_2_0 _103010_3_0 _103010_4_0
_103070_0_0 _103070_1_0 _103070_2_0 _103070_3_0 _103070_4_0
_103080_0_0 _103080_1_0 _103080_2_0 _103080_3_0 _103080_4_0
_103090_0_0 _103090_1_0 _103090_2_0 _103090_3_0 _103090_4_0;
do i=1 to 45; if df2{i} in ('50','500') then df2{i}=5.5;if df2{i} in ('55','555') then df2{i}=0.5; 
end;
/*103020	Beef 103030	Pork 103040	Lamb 103100	other meat 103060	Poultry 103010	Sausage 103070	bacon 103080	ham 103090	liver*/
if _103020_0_0^='.' then n1=1;if _103020_1_0^='.' then n2=1;if _103020_2_0^='.' then n3=1;if _103020_3_0^='.' then n4=1;if _103020_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103020_0_0=sum(_103020_0_0,_103020_1_0,_103020_2_0,_103020_3_0,_103020_4_0)/n;
if _103030_0_0^='.' then n1=1;if _103030_1_0^='.' then n2=1;if _103030_2_0^='.' then n3=1;if _103030_3_0^='.' then n4=1;if _103030_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103030_0_0=sum(_103030_0_0,_103030_1_0,_103030_2_0,_103030_3_0,_103030_4_0)/n;
if _103040_0_0^='.' then n1=1;if _103040_1_0^='.' then n2=1;if _103040_2_0^='.' then n3=1;if _103040_3_0^='.' then n4=1;if _103040_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103040_0_0=sum(_103040_0_0,_103040_1_0,_103040_2_0,_103040_3_0,_103040_4_0)/n;
if _103100_0_0^='.' then n1=1;if _103100_1_0^='.' then n2=1;if _103100_2_0^='.' then n3=1;if _103100_3_0^='.' then n4=1;if _103100_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103100_0_0=sum(_103100_0_0,_103100_1_0,_103100_2_0,_103100_3_0,_103100_4_0)/n;
if _103060_0_0^='.' then n1=1;if _103060_1_0^='.' then n2=1;if _103060_2_0^='.' then n3=1;if _103060_3_0^='.' then n4=1;if _103060_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103060_0_0=sum(_103060_0_0,_103060_1_0,_103060_2_0,_103060_3_0,_103060_4_0)/n;
if _103010_0_0^='.' then n1=1;if _103010_1_0^='.' then n2=1;if _103010_2_0^='.' then n3=1;if _103010_3_0^='.' then n4=1;if _103010_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103010_0_0=sum(_103010_0_0,_103010_1_0,_103010_2_0,_103010_3_0,_103010_4_0)/n;
if _103070_0_0^='.' then n1=1;if _103070_1_0^='.' then n2=1;if _103070_2_0^='.' then n3=1;if _103070_3_0^='.' then n4=1;if _103070_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103070_0_0=sum(_103070_0_0,_103070_1_0,_103070_2_0,_103070_3_0,_103070_4_0)/n;
if _103080_0_0^='.' then n1=1;if _103080_1_0^='.' then n2=1;if _103080_2_0^='.' then n3=1;if _103080_3_0^='.' then n4=1;if _103080_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103080_0_0=sum(_103080_0_0,_103080_1_0,_103080_2_0,_103080_3_0,_103080_4_0)/n;
if _103090_0_0^='.' then n1=1;if _103090_1_0^='.' then n2=1;if _103090_2_0^='.' then n3=1;if _103090_3_0^='.' then n4=1;if _103090_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103090_0_0=sum(_103090_0_0,_103090_1_0,_103090_2_0,_103090_3_0,_103090_4_0)/n;
meat=90*sum( n_103020_0_0, n_103030_0_0, n_103040_0_0, n_103100_0_0, n_103060_0_0, n_103010_0_0, n_103070_0_0, n_103080_0_0, n_103090_0_0);
if meat<=90 then meatscore=1;if meat>90 then meatscore=0;

if _26018_0_0^='.' then n1=1;if _26018_1_0^='.' then n2=1;if _26018_2_0^='.' then n3=1;if _26018_3_0^='.' then n4=1;if _26018_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
calcium=sum(_26018_0_0,_26018_1_0,_26018_2_0,_26018_3_0,_26018_4_0)/n;
if  calcium>=700 then Cascore=1; if  calcium<700 then Cascore=0;
HDIscore=sum(Cascore,meatscore,fishscore,sugarscore,nutscore,fruitvegscore,Fibrescore,Carbscore,Proscore,PUFAscore,SFAscore);
keep  eid HDIscore meat fish  enfat energy sugar ensugar nuts fruitveg enSFA enPUFA enPro enCarb calcium fiber Cascore meatscore fishscore sugarscore nutscore fruitvegscore Fibrescore Carbscore Proscore PUFAscore SFAscore;
run;
proc means; var fruitveg nuts HDIscore Cascore meatscore fishscore sugarscore nutscore fruitvegscore Fibrescore Carbscore Proscore PUFAscore SFAscore;run;


data MDS;set a.wyqdata;
sex=_31_0_0;/*1="Male" 0="Female"*/
raw_vegetable=_1299_0_0;if raw_vegetable=. then raw_vegetable=_1299_1_0; if raw_vegetable=. then raw_vegetable=_1299_2_0;if raw_vegetable=. then raw_vegetable=_1299_3_0;  
Cooked_vegetable=_1289_0_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_1_0; if Cooked_vegetable=. then Cooked_vegetable=_1289_2_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_3_0;  
if Cooked_vegetable=-10 then Cooked_vegetable=0.5;
if    raw_vegetable=-10 then    raw_vegetable=0.5;
if Cooked_vegetable in (-1, -3) then Cooked_vegetable=.;
if    raw_vegetable in (-1, -3) then    raw_vegetable=.;
total_vegetable=sum(cooked_vegetable,raw_vegetable)/3; /*3 heaped tablespoons*/

if _104010_0_0^='.' then n1=1;if _104010_1_0^='.' then n2=1;if _104010_2_0^='.' then n3=1;if _104010_3_0^='.' then n4=1;if _104010_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_104010_0_0=sum(_104010_0_0,_104010_1_0,_104010_2_0,_104010_3_0,_104010_4_0)/n;
if _104000_0_0^='.' then n1=1;if _104000_1_0^='.' then n2=1;if _104000_2_0^='.' then n3=1;if _104000_3_0^='.' then n4=1;if _104000_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_104000_0_0=sum(_104000_0_0,_104000_1_0,_104000_2_0,_104000_3_0,_104000_4_0)/n;
if _104110_0_0^='.' then n1=1;if _104110_1_0^='.' then n2=1;if _104110_2_0^='.' then n3=1;if _104110_3_0^='.' then n4=1;if _104110_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_104110_0_0=sum(_104110_0_0,_104110_1_0,_104110_2_0,_104110_3_0,_104110_4_0)/n;
league=sum( n_104000_0_0, n_104010_0_0, n_104110_0_0);

freshfruit=_1309_0_0;if freshfruit=. then freshfruit=_1309_1_0; if freshfruit=. then freshfruit=_1309_2_0;if freshfruit=. then freshfruit=_1309_3_0;  
If freshfruit=-10 then freshfruit=0.5;
Else If freshfruit in (-1,-3) then freshfruit=.;
driedfruit=_1319_0_0;if driedfruit=. then driedfruit=_1319_1_0; if driedfruit=. then driedfruit=_1319_2_0;if driedfruit=. then driedfruit=_1319_3_0;  
If driedfruit=-10 then driedfruit=0.5;
Else If driedfruit in (-1,-3) then driedfruit=.;
driedfruit_adjust=driedfruit/5; /*5 pieces/day*/
total_fruit=100*sum(freshfruit,driedfruit_adjust);
if _102410_0_0^='.' then n1=1;if _102410_1_0^='.' then n2=1;if _102410_2_0^='.' then n3=1;if _102410_3_0^='.' then n4=1;if _102410_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102410_0_0=sum(_102410_0_0,_102410_1_0,_102410_2_0,_102410_3_0,_102410_4_0)/n;
if _102420_0_0^='.' then n1=1;if _102420_1_0^='.' then n2=1;if _102420_2_0^='.' then n3=1;if _102420_3_0^='.' then n4=1;if _102420_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102420_0_0=sum(_102420_0_0,_102420_1_0,_102420_2_0,_102420_3_0,_102420_4_0)/n;
if _102430_0_0^='.' then n1=1;if _102430_1_0^='.' then n2=1;if _102430_2_0^='.' then n3=1;if _102430_3_0^='.' then n4=1;if _102430_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102430_0_0=sum(_102430_0_0,_102430_1_0,_102430_2_0,_102430_3_0,_102430_4_0)/n;
if _102450_0_0^='.' then n1=1;if _102450_1_0^='.' then n2=1;if _102450_2_0^='.' then n3=1;if _102450_3_0^='.' then n4=1;if _102450_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_102450_0_0=sum(_102450_0_0,_102450_1_0,_102450_2_0,_102450_3_0,_102450_4_0)/n;
/*104000	Baked bean 104010	pulses 104110	broad bean 102410	Salted peanuts 102420	unsalted peanuts 102430	salted nuts 102420	unsalted nuts 102450	seeds*/
nuts=sum( n_104000_0_0, n_104010_0_0, n_104110_0_0, n_102410_0_0, n_102420_0_0, n_102430_0_0, n_102450_0_0);
fruitnut=total_fruit+nuts;

bread_type= _1448_0_0;if bread_type=. then bread_type= _1448_1_0;if bread_type=. then bread_type= _1448_2_0;if bread_type=. then bread_type= _1448_3_0;
bread_intake= _1438_0_0;if bread_intake=. then bread_intake= _1438_1_0;if bread_intake=. then bread_intake= _1438_2_0;if bread_intake=. then bread_intake= _1438_3_0;
if bread_intake=-10 then bread_intake=0.5;
if bread_intake in (-1,-3) then bread_intake=.;
If bread_type=3 then wholegrain_bread=bread_intake/7; /*转换为slices/day*/
cereal_type= _1468_0_0;if cereal_type=. then cereal_type= _1468_1_0;if cereal_type=. then cereal_type= _1468_2_0;if cereal_type=. then cereal_type= _1468_3_0;
cereal_intake= _1458_0_0;if cereal_intake=. then cereal_intake= _1458_1_0;if cereal_intake=. then cereal_intake= _1458_2_0;if cereal_intake=. then cereal_intake= _1458_3_0;
if cereal_intake=-10 then cereal_intake=0.5;
if cereal_intake in (-1,-3) then cereal_intake=.;
if cereal_type in (1,3,4) then wholegrain_cereal=cereal_intake/7; /*转换为bowls/day*/
if bread_type in (-1,-3) then bread_type=.;
if cereal_type in (-1,-3) then cereal_type=.;
total_wholegrain=sum(wholegrain_bread, wholegrain_cereal);

/*103150	Tinned tuna 103160	Oily fish 103190	White fish 103200	Prawns 103210	Lobster/crab 103220	Shellfish*/
if _103150_0_0^='.' then n1=1;if _103150_1_0^='.' then n2=1;if _103150_2_0^='.' then n3=1;if _103150_3_0^='.' then n4=1;if _103150_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103150_0_0=sum(_103150_0_0,_103150_1_0,_103150_2_0,_103150_3_0,_103150_4_0)/n;
if _103160_0_0^='.' then n1=1;if _103160_1_0^='.' then n2=1;if _103160_2_0^='.' then n3=1;if _103160_3_0^='.' then n4=1;if _103160_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103160_0_0=sum(_103160_0_0,_103160_1_0,_103160_2_0,_103160_3_0,_103160_4_0)/n;
if _103190_0_0^='.' then n1=1;if _103190_1_0^='.' then n2=1;if _103190_2_0^='.' then n3=1;if _103190_3_0^='.' then n4=1;if _103190_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103190_0_0=sum(_103190_0_0,_103190_1_0,_103190_2_0,_103190_3_0,_103190_4_0)/n;
if _103200_0_0^='.' then n1=1;if _103200_1_0^='.' then n2=1;if _103200_2_0^='.' then n3=1;if _103200_3_0^='.' then n4=1;if _103200_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103200_0_0=sum(_103200_0_0,_103200_1_0,_103200_2_0,_103200_3_0,_103200_4_0)/n;
if _103210_0_0^='.' then n1=1;if _103210_1_0^='.' then n2=1;if _103210_2_0^='.' then n3=1;if _103210_3_0^='.' then n4=1;if _103210_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103210_0_0=sum(_103210_0_0,_103210_1_0,_103210_2_0,_103210_3_0,_103210_4_0)/n;
if _103220_0_0^='.' then n1=1;if _103220_1_0^='.' then n2=1;if _103220_2_0^='.' then n3=1;if _103220_3_0^='.' then n4=1;if _103220_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103220_0_0=sum(_103220_0_0,_103220_1_0,_103220_2_0,_103220_3_0,_103220_4_0)/n;
/*103150	Tinned tuna 103160	Oily fish 103190	White fish 103200	Prawns 103210	Lobster/crab 103220	Shellfish*/
fish=sum( n_103150_0_0, n_103160_0_0, n_103190_0_0, n_103200_0_0, n_103210_0_0, n_103220_0_0);

/*MUFA*/
if _100002_0_0^='.' then n1=1;
if _100002_1_0^='.' then n2=1;
if _100002_2_0^='.' then n3=1;
if _100002_3_0^='.' then n4=1;
if _100002_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
energy=sum(_100002_0_0,_100002_1_0,_100002_2_0,_100002_3_0,_100002_4_0)/n;
if energy=0 then delete;
/*SFA*/
if _100006_0_0^='.' then n1=1;
if _100006_1_0^='.' then n2=1;
if _100006_2_0^='.' then n3=1;
if _100006_3_0^='.' then n4=1;
if _100006_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enSFA=sum(_100006_0_0,_100006_1_0,_100006_2_0,_100006_3_0,_100006_4_0)/n;
if _100007_0_0^='.' then n1=1;if _100007_1_0^='.' then n2=1;if _100007_2_0^='.' then n3=1;if _100007_3_0^='.' then n4=1;if _100007_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enPUFA=sum(_100007_0_0,_100007_1_0,_100007_2_0,_100007_3_0,_100007_4_0)/n;
if _100003_0_0^='.' then n1=1;if _100003_1_0^='.' then n2=1;if _100003_2_0^='.' then n3=1;if _100003_3_0^='.' then n4=1;if _100003_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enPro=sum(_100003_0_0,_100003_1_0,_100003_2_0,_100003_3_0,_100003_4_0)/n;
if _100005_0_0^='.' then n1=1;if _100005_1_0^='.' then n2=1;if _100005_2_0^='.' then n3=1;if _100005_3_0^='.' then n4=1;if _100005_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
enCarb=sum(_100005_0_0,_100005_1_0,_100005_2_0,_100005_3_0,_100005_4_0)/n;
enSFA=enSFA*37.7/energy;
enPUFA=enPUFA*37.7/energy;
enPro=enPro*16.7/energy;
enCarb=enCarb*17.2/energy;
enSFA=_100006_0_0*37.7/_100002_0_0;
enPUFA=_100007_0_0*37.7/_100002_0_0;
enPro=_100003_0_0*16.7/_100002_0_0;
enCarb=_100005_0_0*17.2/_100002_0_0;
enMUFA=1-enCarb-enPro-enPUFA-enSFA;
MUFAratio=enMUFA/enSFA;
/*102090	Yogurt 102880	feta 102890	mozzarella 102910	other cheese 102900, 102820, 102840, 102830, 102850, 102810, 102870 100520	Milk 100890	milk added to cereal 100320, 100280, 100260, 100350, 100480, 100460, 100890	added milk to standard tea, added milk to rooibos tea, cappuccino, filtered coffee, espresso, other coffee type, instant coffee 100300	latte 100230	Dairy smoothie*/
/*dairy=sum( _102090_0_0, _102880_0_0, _102890_0_0, _102910_0_0, _102900_0_0, _102820_0_0, _102840_0_0, _102830_0_0, _102850_0_0, _102810_0_0, _102870_0_0, _100520_0_0, _100890_0_0, _100320_0_0, _100280_0_0, _100260_0_0, _100350_0_0, _100480_0_0, _100460_0_0, _100890_0_0, _100300_0_0, _100230);
*/
n_1408_0_0=_1408_0_0;if n_1408_0_0=. then n_1408_0_0=_1408_1_0;if n_1408_0_0=. then n_1408_0_0=_1408_2_0;if n_1408_0_0=. then n_1408_0_0=_1408_3_0;
if n_1408_0_0=0 then Cheeseintake=0;
if n_1408_0_0=1 then Cheeseintake=0.5/7;
if n_1408_0_0=2 then Cheeseintake=1/7;
if n_1408_0_0=3 then Cheeseintake=3/7;
if n_1408_0_0=4 then Cheeseintake=5.5/7;
if n_1408_0_0=5 then Cheeseintake=7/7; /*1 piece/day*/
n_1418_0_0=_1418_0_0;if n_1418_0_0=. then n_1418_0_0=_1418_1_0;if n_1418_0_0=. then n_1418_0_0=_1418_2_0;if n_1418_0_0=. then n_1418_0_0=_1418_3_0;
if n_1418_0_0 in (1,2,3,4,5) then milkintake=1;/*1 glass/day*/
dairy=sum(Cheeseintake,milkintake);
if _103020_0_0^='.' then n1=1;if _103020_1_0^='.' then n2=1;if _103020_2_0^='.' then n3=1;if _103020_3_0^='.' then n4=1;if _103020_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103020_0_0=sum(_103020_0_0,_103020_1_0,_103020_2_0,_103020_3_0,_103020_4_0)/n;
if _103030_0_0^='.' then n1=1;if _103030_1_0^='.' then n2=1;if _103030_2_0^='.' then n3=1;if _103030_3_0^='.' then n4=1;if _103030_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103030_0_0=sum(_103030_0_0,_103030_1_0,_103030_2_0,_103030_3_0,_103030_4_0)/n;
if _103040_0_0^='.' then n1=1;if _103040_1_0^='.' then n2=1;if _103040_2_0^='.' then n3=1;if _103040_3_0^='.' then n4=1;if _103040_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103040_0_0=sum(_103040_0_0,_103040_1_0,_103040_2_0,_103040_3_0,_103040_4_0)/n;
if _103100_0_0^='.' then n1=1;if _103100_1_0^='.' then n2=1;if _103100_2_0^='.' then n3=1;if _103100_3_0^='.' then n4=1;if _103100_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103100_0_0=sum(_103100_0_0,_103100_1_0,_103100_2_0,_103100_3_0,_103100_4_0)/n;
if _103060_0_0^='.' then n1=1;if _103060_1_0^='.' then n2=1;if _103060_2_0^='.' then n3=1;if _103060_3_0^='.' then n4=1;if _103060_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103060_0_0=sum(_103060_0_0,_103060_1_0,_103060_2_0,_103060_3_0,_103060_4_0)/n;
if _103010_0_0^='.' then n1=1;if _103010_1_0^='.' then n2=1;if _103010_2_0^='.' then n3=1;if _103010_3_0^='.' then n4=1;if _103010_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103010_0_0=sum(_103010_0_0,_103010_1_0,_103010_2_0,_103010_3_0,_103010_4_0)/n;
if _103070_0_0^='.' then n1=1;if _103070_1_0^='.' then n2=1;if _103070_2_0^='.' then n3=1;if _103070_3_0^='.' then n4=1;if _103070_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103070_0_0=sum(_103070_0_0,_103070_1_0,_103070_2_0,_103070_3_0,_103070_4_0)/n;
if _103080_0_0^='.' then n1=1;if _103080_1_0^='.' then n2=1;if _103080_2_0^='.' then n3=1;if _103080_3_0^='.' then n4=1;if _103080_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103080_0_0=sum(_103080_0_0,_103080_1_0,_103080_2_0,_103080_3_0,_103080_4_0)/n;
if _103090_0_0^='.' then n1=1;if _103090_1_0^='.' then n2=1;if _103090_2_0^='.' then n3=1;if _103090_3_0^='.' then n4=1;if _103090_4_0^='.' then n5=1;
n=sum(n1,n2,n3,n4,n5); 
n_103090_0_0=sum(_103090_0_0,_103090_1_0,_103090_2_0,_103090_3_0,_103090_4_0)/n;
meat=sum( n_103020_0_0, n_103030_0_0, n_103040_0_0, n_103100_0_0, n_103060_0_0, n_103010_0_0, n_103070_0_0, n_103080_0_0, n_103090_0_0);
if MUFAratio<0 then MUFAratio=0;
keep eid Cheeseintake sex meat dairy MUFAratio fish total_wholegrain fruitnut league total_vegetable;
run;

proc means data=MDS;var MDSscore Cheeseintake meat dairy MUFAratio fish total_wholegrain fruitnut league total_vegetable;run;


data diet_score;set a.wyqdata;
/*Fruit n_1309_0_0="Fresh fruit intake" n_1319_3_0="Dried fruit intake" pieces/day
-10     Less than one
-1      Do not know
-3      Prefer not to answer*/
freshfruit=_1309_0_0;if freshfruit=. then freshfruit=_1309_1_0; if freshfruit=. then freshfruit=_1309_2_0;if freshfruit=. then freshfruit=_1309_3_0;  
If freshfruit=-10 then freshfruit=0.5;
Else If freshfruit in (-1,-3) then freshfruit=.;
driedfruit=_1319_0_0;if driedfruit=. then driedfruit=_1319_1_0; if driedfruit=. then driedfruit=_1319_2_0;if driedfruit=. then driedfruit=_1319_3_0;  
If driedfruit=-10 then driedfruit=0.5;
Else If driedfruit in (-1,-3) then driedfruit=.;
driedfruit_adjust=driedfruit/5; /*5 pieces/day*/
total_fruit=sum(freshfruit,driedfruit_adjust);
If total_Fruit>=3 then fruit_score=1; /*3 servings/day*/
If total_Fruit<3 & total_Fruit^=. then fruit_score=0; 

/*Vegetable n_1289_0_0="Cooked vegetable intake" n_1299_0_0="Salad / raw vegetable intake" tablespoons/day
-10      Less than one
-1      Do not know
-3      Prefer not to answer*/
raw_vegetable=_1299_0_0;if raw_vegetable=. then raw_vegetable=_1299_1_0; if raw_vegetable=. then raw_vegetable=_1299_2_0;if raw_vegetable=. then raw_vegetable=_1299_3_0;  
Cooked_vegetable=_1289_0_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_1_0; if Cooked_vegetable=. then Cooked_vegetable=_1289_2_0;if Cooked_vegetable=. then Cooked_vegetable=_1289_3_0;  
if Cooked_vegetable=-10 then Cooked_vegetable=0.5;
if    raw_vegetable=-10 then    raw_vegetable=0.5;
if Cooked_vegetable in (-1, -3) then Cooked_vegetable=.;
if    raw_vegetable in (-1, -3) then    raw_vegetable=.;
total_vegetable=sum(cooked_vegetable,raw_vegetable)/3; /*3 heaped tablespoons*/
If total_vegetable>=3 then vegetable_score=1;
If total_vegetable<3 & total_vegetable^=. then vegetable_score=0; 

bread_type= _1448_0_0;if bread_type=. then bread_type= _1448_1_0;if bread_type=. then bread_type= _1448_2_0;if bread_type=. then bread_type= _1448_3_0;
bread_intake= _1438_0_0;if bread_intake=. then bread_intake= _1438_1_0;if bread_intake=. then bread_intake= _1438_2_0;if bread_intake=. then bread_intake= _1438_3_0;
if bread_intake=-10 then bread_intake=0.5;
if bread_intake in (-1,-3) then bread_intake=.;
If bread_type=3 then wholegrain_bread=bread_intake/7; /*转换为slices/day*/
cereal_type= _1468_0_0;if cereal_type=. then cereal_type= _1468_1_0;if cereal_type=. then cereal_type= _1468_2_0;if cereal_type=. then cereal_type= _1468_3_0;
cereal_intake= _1458_0_0;if cereal_intake=. then cereal_intake= _1458_1_0;if cereal_intake=. then cereal_intake= _1458_2_0;if cereal_intake=. then cereal_intake= _1458_3_0;
if cereal_intake=-10 then cereal_intake=0.5;
if cereal_intake in (-1,-3) then cereal_intake=.;
if cereal_type in (1,3,4) then wholegrain_cereal=cereal_intake/7; /*转换为bowls/day*/
if bread_type in (-1,-3) then bread_type=.;
if cereal_type in (-1,-3) then cereal_type=.;
total_wholegrain=sum(wholegrain_bread, wholegrain_cereal);
if total_wholegrain>=3 then wholegrain_score=1; /*3 servings/day*/ else wholegrain_score=0; 
if bread_type=. and cereal_type=. or (bread_intake=. and cereal_intake=.) then wholegrain_score=.;
 
oilyfish_intake=_1329_0_0;if oilyfish_intake=. then oilyfish_intake=_1329_1_0;if oilyfish_intake=. then oilyfish_intake=_1329_2_0;if oilyfish_intake=. then oilyfish_intake=_1329_3_0;
nonoilyfish_intake=_1339_0_0;if nonoilyfish_intake=. then nonoilyfish_intake=_1339_1_0;if nonoilyfish_intake=. then nonoilyfish_intake=_1339_2_0;if nonoilyfish_intake=. then nonoilyfish_intake=_1339_3_0;
if    oilyfish_intake in (-1,-3) then    oilyfish_intake=.;
if nonoilyfish_intake in (-1,-3) then nonoilyfish_intake=.;

/*fish是否满足CVD膳食评分中鱼类摄入的要求*/
If oilyfish_intake in (3,4,5) or nonoilyfish_intake in (3,4,5) then fish_score=1;
Else if oilyfish_intake=2 and nonoilyfish_intake=2 then fish_score=1; /*≥2 servings/week*/
else fish_score=0;
if oilyfish_intake=. & nonoilyfish_intake=. then fish_score=.;

n_1408_0_0=_1408_0_0;if n_1408_0_0=. then n_1408_0_0=_1408_1_0;if n_1408_0_0=. then n_1408_0_0=_1408_2_0;if n_1408_0_0=. then n_1408_0_0=_1408_3_0;
if n_1408_0_0=0 then Cheeseintake=0;
if n_1408_0_0=1 then Cheeseintake=0.5/7;
if n_1408_0_0=2 then Cheeseintake=1/7;
if n_1408_0_0=3 then Cheeseintake=3/7;
if n_1408_0_0=4 then Cheeseintake=5.5/7;
if n_1408_0_0=5 then Cheeseintake=7/7; /*1 piece/day*/
n_1418_0_0=_1418_0_0;if n_1418_0_0=. then n_1418_0_0=_1418_1_0;if n_1418_0_0=. then n_1418_0_0=_1418_2_0;if n_1418_0_0=. then n_1418_0_0=_1418_3_0;
if n_1418_0_0 in (1,2,3,4,5) then milkintake=1;/*1 glass/day*/
dairyintake=sum(Cheeseintake,milkintake);
if dairyintake>=2 /*2 servings/day*/ then dairy_score=1; else dairy_score=0;
if Cheeseintake=. &  (n_1418_0_0=. or n_1418_0_0 in (-1,-3)) then dairy_score=.;

/*vegetable oil */
n_1428_0_0=_1428_0_0;if n_1428_0_0=. then n_1428_0_0=_1428_1_0;if n_1428_0_0=. then n_1428_0_0=_1428_2_0;if n_1428_0_0=. then n_1428_0_0=_1428_3_0;
if n_1428_0_0 in (-1,-3) then n_1428_0_0=.;
n_2654_0_0=_2654_0_0;if n_2654_0_0=. then n_2654_0_0=_2654_1_0;if n_2654_0_0=. then n_2654_0_0=_2654_2_0;if n_2654_0_0=. then n_2654_0_0=_2654_3_0;
if n_2654_0_0 in (-1,-3) then n_2654_0_0=.;
If n_1428_0_0=2 or n_2654_0_0 in (2,4,6,7,8) then vegetableoil_type=1;
bread_intake2=bread_intake/7; /*在wholegrain中已经定义了，此处转换为slices/day*/

/* vegetableoil_score是否满足CVD膳食评分中植物油摄入的要求*/
If vegetableoil_type=1 and bread_intake2>=4 then vegetableoil_score=1; else vegetableoil_score=0;
if (n_1428_0_0=. and n_2654_0_0=.) or bread_intake2=. then vegetableoil_score=.;

/*Refined grains*/
if bread_type in (-1,-3) then bread_type=.;
if cereal_type in (-1,-3) then cereal_type=.;

If bread_type in (1,2,4) then refinedgrain_bread=bread_intake/7; /*转化为slices/day*/
if cereal_type in (2,5) then refinedgrain_cereal= cereal_intake/7; /*转化为bowls/day*/

/*refinedgrainscore是否满足CVD膳食评分中精制谷物摄入的要求*/
total_refinedgrain=sum(refinedgrain_bread, refinedgrain_cereal);
if total_refinedgrain <=2 then refinedgrain_score=1; /*≤2 servings/day*/ else refinedgrain_score=0;
if bread_type=. and cereal_type=. or (bread_intake=. and cereal_intake=.) then refinedgrain_score=.;
 

/*Processed meats
n_1349_0_0="Processed meat intake"
0      Never
1      Less than once a week
2      Once a week
3      2-4 times a week
4      5-6 times a week
5      Once or more daily
-1      Do not know
-3      Prefer not to answer
n_3680_0_0="Age when last ate meat"
-1      Do not know
-3      Prefer not to answer*/
prmeats_intake=_1349_0_0;if prmeats_intake=. then prmeats_intake=_1349_1_0;if prmeats_intake=. then prmeats_intake=_1349_2_0;if prmeats_intake=. then prmeats_intake=_1349_3_0;
nomeats_age=_3680_0_0;if nomeats_age=. then prmeats_intake=_3680_1_0;if prmeats_intake=. then prmeats_intake=_3680_2_0;if prmeats_intake=. then prmeats_intake=_3680_3_0;
if prmeats_intake in (-1,-3) then prmeats_intake=.;
if nomeats_age in (-1,-3) then nomeats_age=.;
If prmeats_intake in (0,1,2) or nomeats_age^=. Then prmeats_score=1; /*≤1 serving/week*/ else prmeats_score=0;
if prmeats_intake=. then prmeats_score=.;

n_1359_0_0=_1359_0_0;if n_1359_0_0=. then n_1359_0_0=_1359_1_0;if n_1359_0_0=. then n_1359_0_0=_1359_2_0;if n_1359_0_0=. then n_1359_0_0=_1359_3_0;
if n_1359_0_0=0 then poultry_intake=0;
if n_1359_0_0=1 then poultry_intake=0.5;
if n_1359_0_0=2 then poultry_intake=1;
if n_1359_0_0=3 then poultry_intake=3;
if n_1359_0_0=4 then poultry_intake=5.5;
if n_1359_0_0=5 then poultry_intake=7; /*转为serving/wk */
/*n_1369_0_0="Beef intake"*/
n_1369_0_0=_1369_0_0;if n_1369_0_0=. then n_1369_0_0=_1369_1_0;if n_1369_0_0=. then n_1369_0_0=_1369_2_0;if n_1369_0_0=. then n_1369_0_0=_1369_3_0;
if n_1369_0_0=0 then beef_intake=0;
if n_1369_0_0=1 then beef_intake=0.5;
if n_1369_0_0=2 then beef_intake=1;
if n_1369_0_0=3 then beef_intake=3;
if n_1369_0_0=4 then beef_intake=5.5;
if n_1369_0_0=5 then beef_intake=7;
/*n_1379_0_0="Lamb/mutton intake"*/
n_1379_0_0=_1379_0_0;if n_1379_0_0=. then n_1379_0_0=_1379_1_0;if n_1379_0_0=. then n_1379_0_0=_1379_2_0;if n_1379_0_0=. then n_1379_0_0=_1379_3_0;
if n_1379_0_0=0 then lamb_intake=0;
if n_1379_0_0=1 then lamb_intake=0.5;
if n_1379_0_0=2 then lamb_intake=1;
if n_1379_0_0=3 then lamb_intake=3;
if n_1379_0_0=4 then lamb_intake=5.5;
if n_1379_0_0=5 then lamb_intake=7;
/*n_1389_0_0="Pork intake"*/
n_1389_0_0=_1389_0_0;if n_1389_0_0=. then n_1389_0_0=_1389_1_0;if n_1389_0_0=. then n_1389_0_0=_1389_2_0;if n_1389_0_0=. then n_1389_0_0=_1389_3_0;
if n_1389_0_0=0 then pork_intake=0;
if n_1389_0_0=1 then pork_intake=0.5;
if n_1389_0_0=2 then pork_intake=1;
if n_1389_0_0=3 then pork_intake=3;
if n_1389_0_0=4 then pork_intake=5.5;
if n_1389_0_0=5 then pork_intake=7;

/*unprmeats_score是否满足CVD膳食评分中未加工红肉摄入的要求*/
unprmeats_intake=sum(poultry_intake,beef_intake,lamb_intake,pork_intake);
If unprmeats_intake<=2 & unprmeats_intake^=. then unprmeats_score=1; /*≤2 serving/wk*/
if unprmeats_intake>2 then unprmeats_score=0;

/*SSB consumer*/
n_6144_0_0=_6144_0_0;if n_6144_0_0=. then n_6144_0_0=_6144_1_0;if n_6144_0_0=. then n_6144_0_0=_6144_2_0;if n_6144_0_0=. then n_6144_0_0=_6144_3_0;
n_6144_0_1=_6144_0_1;if n_6144_0_1=. then n_6144_0_1=_6144_1_1;if n_6144_0_1=. then n_6144_0_1=_6144_2_1;if n_6144_0_1=. then n_6144_1_1=_6144_3_1;
n_6144_0_2=_6144_0_2;if n_6144_0_2=. then n_6144_0_2=_6144_1_2;if n_6144_0_2=. then n_6144_0_2=_6144_2_2;if n_6144_0_2=. then n_6144_0_2=_6144_3_2;
n_6144_0_3=_6144_0_3;if n_6144_0_3=. then n_6144_0_3=_6144_1_3;if n_6144_0_3=. then n_6144_0_3=_6144_2_3;if n_6144_0_3=. then n_6144_0_3=_6144_3_3;
if n_6144_0_0=4 or n_6144_0_1=4 or n_6144_0_2=4 or n_6144_0_3=4 then SSB=0; else  SSB=1;
if n_6144_0_0 in (.,-3) & n_6144_0_1 in (.,-3) & n_6144_0_2 in (.,-3) & n_6144_0_3 in (.,-3) then SSB=.; 

/*ssb_score是否满足CVD膳食评分中含糖饮料摄入的要求*/
If SSB=0 then ssb_score=1; /*never consumes drinks containing sugar*/ else ssb_score=0;
if SSB=. then ssb_score=.;

diet_score=sum(unprmeats_score,prmeats_score,refinedgrain_score,vegetableoil_score,dairy_score,fish_score,wholegrain_score,vegetable_score,fruit_score,ssb_score);

if diet_score>=5 then idealdiet=1; 
else if diet_score^=. &  diet_score<5 then idealdiet=0;

keep eid poultry_intake idealdiet diet_score unprmeats_score prmeats_score refinedgrain_score vegetableoil_score dairy_score fish_score wholegrain_score vegetable_score fruit_score ssb_score ;
run;
proc means;var diet_score unprmeats_score prmeats_score refinedgrain_score ;run;

proc sort data=diet_score;
by eid;run;
proc sort data=MDS;
by eid;run;
proc sort data=DHIscore;
by eid;run;
proc sort data=foodfreq;
by eid;run;
proc sort data=UKB;
by eid;run;
data a;merge diet_score MDS DHIscore foodfreq UKB;
by eid;
run;
data a;set a; HHincomet=HHincome;if HHincome=5 then HHincomet=4;racegroupt=racegroup;if racegroup in (2,3,5,6) then racegroupt=2;
TDI_index=TDI+0;
run;
proc rank data=a group=5 out=a.UKB; 
var TDI_index;
ranks TDIq;
run;
data a.a;set a.UKB;
if energy=. or energy=0 then delete;
array /*259*/    ICD10 {259} _41270_0_0  _41270_0_1	 _41270_0_2	 _41270_0_3	 _41270_0_4	 _41270_0_5	 _41270_0_6	 _41270_0_7	 _41270_0_8	 _41270_0_9	 _41270_0_10	 _41270_0_11	 _41270_0_12	 _41270_0_13	 _41270_0_14	 _41270_0_15	 _41270_0_16	 _41270_0_17	 _41270_0_18	 _41270_0_19	 _41270_0_20	 _41270_0_21	 _41270_0_22	 _41270_0_23	 _41270_0_24	 _41270_0_25	 _41270_0_26	 _41270_0_27	 _41270_0_28	 _41270_0_29	 _41270_0_30	 _41270_0_31	 _41270_0_32	 _41270_0_33	 _41270_0_34	 _41270_0_35	 _41270_0_36	 _41270_0_37	 _41270_0_38	 _41270_0_39	 _41270_0_40	 _41270_0_41	 _41270_0_42	 _41270_0_43	 _41270_0_44	 _41270_0_45	 _41270_0_46	 _41270_0_47	 _41270_0_48	 _41270_0_49	 _41270_0_50	 _41270_0_51	 _41270_0_52	 _41270_0_53	 _41270_0_54	 _41270_0_55	 _41270_0_56	 _41270_0_57	 _41270_0_58	 _41270_0_59	 _41270_0_60	 _41270_0_61	 _41270_0_62	 _41270_0_63	 _41270_0_64	 _41270_0_65	 _41270_0_66	 _41270_0_67	 _41270_0_68	 _41270_0_69	 _41270_0_70	 _41270_0_71	 _41270_0_72	 _41270_0_73	 _41270_0_74	 _41270_0_75	 _41270_0_76	 _41270_0_77	 _41270_0_78	 _41270_0_79	 _41270_0_80	 _41270_0_81	 _41270_0_82	 _41270_0_83	 _41270_0_84	 _41270_0_85	 _41270_0_86	 _41270_0_87	 _41270_0_88	 _41270_0_89	 _41270_0_90	 _41270_0_91	 _41270_0_92	 _41270_0_93	 _41270_0_94	 _41270_0_95	 _41270_0_96	 _41270_0_97	 _41270_0_98	 _41270_0_99	 _41270_0_100	 _41270_0_101	 _41270_0_102	 _41270_0_103	 _41270_0_104	 _41270_0_105	 _41270_0_106	 _41270_0_107	 _41270_0_108	 _41270_0_109	 _41270_0_110	 _41270_0_111	 _41270_0_112	 _41270_0_113	 _41270_0_114	 _41270_0_115	 _41270_0_116	 _41270_0_117	 _41270_0_118	 _41270_0_119	 _41270_0_120	 _41270_0_121	 _41270_0_122	 _41270_0_123	 _41270_0_124	 _41270_0_125	 _41270_0_126	 _41270_0_127	 _41270_0_128	 _41270_0_129	 _41270_0_130	 _41270_0_131	 _41270_0_132	 _41270_0_133	 _41270_0_134	 _41270_0_135	 _41270_0_136	 _41270_0_137	 _41270_0_138	 _41270_0_139	 _41270_0_140	 _41270_0_141	 _41270_0_142	 _41270_0_143	 _41270_0_144	 _41270_0_145	 _41270_0_146	 _41270_0_147	 _41270_0_148	 _41270_0_149	 _41270_0_150	 _41270_0_151	 _41270_0_152	 _41270_0_153	 _41270_0_154	 _41270_0_155	 _41270_0_156	 _41270_0_157	 _41270_0_158	 _41270_0_159	 _41270_0_160	 _41270_0_161	 _41270_0_162	 _41270_0_163	 _41270_0_164	 _41270_0_165	 _41270_0_166	 _41270_0_167	 _41270_0_168	 _41270_0_169	 _41270_0_170	 _41270_0_171	 _41270_0_172	 _41270_0_173	 _41270_0_174	 _41270_0_175	 _41270_0_176	 _41270_0_177	 _41270_0_178	 _41270_0_179	 _41270_0_180	 _41270_0_181	 _41270_0_182	 _41270_0_183	 _41270_0_184	 _41270_0_185	 _41270_0_186	 _41270_0_187	 _41270_0_188	 _41270_0_189	 _41270_0_190	 _41270_0_191	 _41270_0_192	 _41270_0_193	 _41270_0_194	 _41270_0_195	 _41270_0_196	 _41270_0_197	 _41270_0_198	 _41270_0_199	 _41270_0_200	 _41270_0_201	 _41270_0_202	 _41270_0_203	 _41270_0_204	 _41270_0_205	 _41270_0_206	 _41270_0_207	 _41270_0_208	_41270_0_209 _41270_0_210 _41270_0_211 _41270_0_212 _41270_0_213 _41270_0_214 _41270_0_215 _41270_0_216 _41270_0_217 _41270_0_218 _41270_0_219 _41270_0_220 _41270_0_221 _41270_0_222 _41270_0_223 _41270_0_224 _41270_0_225 _41270_0_226 _41270_0_227 _41270_0_228 _41270_0_229 _41270_0_230 _41270_0_231 _41270_0_232 _41270_0_233 _41270_0_234 _41270_0_235 _41270_0_236 _41270_0_237 _41270_0_238 _41270_0_239 _41270_0_240 _41270_0_241 _41270_0_242 _41270_0_243 _41270_0_244 _41270_0_245 _41270_0_246 _41270_0_247 _41270_0_248 _41270_0_249 _41270_0_250 _41270_0_251 _41270_0_252 _41270_0_253 _41270_0_254 _41270_0_255 _41270_0_256 _41270_0_257 _41270_0_258;
do i=1 to 259; if ICD10{i} in ("F840","F841","F845","F801","F802","F808","F809","F812","F819")
then do; ASD=1;end;end;
array   ICD10m {80}  _41202_0_0   _41202_0_1	 _41202_0_2	 _41202_0_3	 _41202_0_4	 _41202_0_5	 _41202_0_6	 _41202_0_7	 _41202_0_8	 _41202_0_9	 _41202_0_10	 _41202_0_11	 _41202_0_12	 _41202_0_13	 _41202_0_14	 _41202_0_15	 _41202_0_16	 _41202_0_17	 _41202_0_18	 _41202_0_19	 _41202_0_20	 _41202_0_21	 _41202_0_22	 _41202_0_23	 _41202_0_24	 _41202_0_25	 _41202_0_26	 _41202_0_27	 _41202_0_28	 _41202_0_29	 _41202_0_30	 _41202_0_31	 _41202_0_32	 _41202_0_33	 _41202_0_34	 _41202_0_35	 _41202_0_36	 _41202_0_37	 _41202_0_38	 _41202_0_39	 _41202_0_40	 _41202_0_41	 _41202_0_42	 _41202_0_43	 _41202_0_44	 _41202_0_45	 _41202_0_46	 _41202_0_47	 _41202_0_48	 _41202_0_49	 _41202_0_50	 _41202_0_51	 _41202_0_52	 _41202_0_53	 _41202_0_54	 _41202_0_55	 _41202_0_56	 _41202_0_57	 _41202_0_58	 _41202_0_59	 _41202_0_60	 _41202_0_61	 _41202_0_62	 _41202_0_63	 _41202_0_64	 _41202_0_65	 _41202_0_66	 _41202_0_67	 _41202_0_68	 _41202_0_69	 _41202_0_70	 _41202_0_71	 _41202_0_72	 _41202_0_73	 _41202_0_74	 _41202_0_75	 _41202_0_76	 _41202_0_77	 _41202_0_78	 _41202_0_79	;
 do i=1 to 80; if ICD10m{i} in ("F840","F841","F845","F801","F802","F808","F809","F812","F819")
then do; ASD=1;end;end;
array    ICD10s {210}  _41204_0_0   _41204_0_1	 _41204_0_2	 _41204_0_3	 _41204_0_4	 _41204_0_5	 _41204_0_6	 _41204_0_7	 _41204_0_8	 _41204_0_9	 _41204_0_10	 _41204_0_11	 _41204_0_12	 _41204_0_13	 _41204_0_14	 _41204_0_15	 _41204_0_16	 _41204_0_17	 _41204_0_18	 _41204_0_19	 _41204_0_20	 _41204_0_21	 _41204_0_22	 _41204_0_23	 _41204_0_24	 _41204_0_25	 _41204_0_26	 _41204_0_27	 _41204_0_28	 _41204_0_29	 _41204_0_30	 _41204_0_31	 _41204_0_32	 _41204_0_33	 _41204_0_34	 _41204_0_35	 _41204_0_36	 _41204_0_37	 _41204_0_38	 _41204_0_39	 _41204_0_40	 _41204_0_41	 _41204_0_42	 _41204_0_43	 _41204_0_44	 _41204_0_45	 _41204_0_46	 _41204_0_47	 _41204_0_48	 _41204_0_49	 _41204_0_50	 _41204_0_51	 _41204_0_52	 _41204_0_53	 _41204_0_54	 _41204_0_55	 _41204_0_56	 _41204_0_57	 _41204_0_58	 _41204_0_59	 _41204_0_60	 _41204_0_61	 _41204_0_62	 _41204_0_63	 _41204_0_64	 _41204_0_65	 _41204_0_66	 _41204_0_67	 _41204_0_68	 _41204_0_69	 _41204_0_70	 _41204_0_71	 _41204_0_72	 _41204_0_73	 _41204_0_74	 _41204_0_75	 _41204_0_76	 _41204_0_77	 _41204_0_78	 _41204_0_79	 _41204_0_80	 _41204_0_81	 _41204_0_82	 _41204_0_83	 _41204_0_84	 _41204_0_85	 _41204_0_86	 _41204_0_87	 _41204_0_88	 _41204_0_89	 _41204_0_90	 _41204_0_91	 _41204_0_92	 _41204_0_93	 _41204_0_94	 _41204_0_95	 _41204_0_96	 _41204_0_97	 _41204_0_98	 _41204_0_99	 _41204_0_100	 _41204_0_101	 _41204_0_102	 _41204_0_103	 _41204_0_104	 _41204_0_105	 _41204_0_106	 _41204_0_107	 _41204_0_108	 _41204_0_109	 _41204_0_110	 _41204_0_111	 _41204_0_112	 _41204_0_113	 _41204_0_114	 _41204_0_115	 _41204_0_116	 _41204_0_117	 _41204_0_118	 _41204_0_119	 _41204_0_120	 _41204_0_121	 _41204_0_122	 _41204_0_123	 _41204_0_124	 _41204_0_125	 _41204_0_126	 _41204_0_127	 _41204_0_128	 _41204_0_129	 _41204_0_130	 _41204_0_131	 _41204_0_132	 _41204_0_133	 _41204_0_134	 _41204_0_135	 _41204_0_136	 _41204_0_137	 _41204_0_138	 _41204_0_139	 _41204_0_140	 _41204_0_141	 _41204_0_142	 _41204_0_143	 _41204_0_144	 _41204_0_145	 _41204_0_146	 _41204_0_147	 _41204_0_148	 _41204_0_149	 _41204_0_150	 _41204_0_151	 _41204_0_152	 _41204_0_153	 _41204_0_154	 _41204_0_155	 _41204_0_156	 _41204_0_157	 _41204_0_158	 _41204_0_159	 _41204_0_160	 _41204_0_161	 _41204_0_162	 _41204_0_163	 _41204_0_164	 _41204_0_165	 _41204_0_166	 _41204_0_167	 _41204_0_168	 _41204_0_169	 _41204_0_170	 _41204_0_171	 _41204_0_172	 _41204_0_173	 _41204_0_174	 _41204_0_175	 _41204_0_176	 _41204_0_177	 _41204_0_178	 _41204_0_179	 _41204_0_180	 _41204_0_181	 _41204_0_182	 _41204_0_183	 _41204_0_184	 _41204_0_185	 _41204_0_186	 _41204_0_187	 _41204_0_188	 _41204_0_189	 _41204_0_190	 _41204_0_191	 _41204_0_192	 _41204_0_193	 _41204_0_194	 _41204_0_195	 _41204_0_196	 _41204_0_197	 _41204_0_198	 _41204_0_199	 _41204_0_200	 _41204_0_201	 _41204_0_202	 _41204_0_203	 _41204_0_204	 _41204_0_205	 _41204_0_206	 _41204_0_207	 _41204_0_208	 _41204_0_209		;
 do i=1 to 210; if ICD10s{i} in ("F840","F841","F845","F801","F802","F808","F809","F812","F819")
then do; ASD=1;end;end;
if ASD=. then ASD=0;
BMI_index=BMI+0;if BMI_index=. then BMI_index=26.9589315;year=age+0;
if sex=. then delete;
run;

/*data a.a;set a.a;
if ASD=1 and fruitnut>200 then fruitnut=0;run;*/
DATA male female;
  SET a.a;
  IF sex = 1 THEN OUTPUT male;
  ELSE OUTPUT female;
  if ASD=. then delete;
RUN;
proc rank data=male group=2 out=male;                                               
      var     meat dairy MUFAratio fish total_wholegrain fruitnut league total_vegetable;
ranks  qmeat qdairy qMUFAratio qfish qtotal_wholegrain qfruitnut qleague qtotal_vegetable;
Run; 
proc rank data=female group=2 out=female;                                               
      var     meat dairy MUFAratio fish total_wholegrain fruitnut league total_vegetable;
ranks  qmeat qdairy qMUFAratio qfish qtotal_wholegrain qfruitnut qleague qtotal_vegetable;
Run; 
proc sort data=male;by eid;proc sort data=female;by eid;run;
data a.a;merge male female;by eid;
MDSscore=0+qMUFAratio+qfish+qtotal_wholegrain+qfruitnut+qleague+qtotal_vegetable;
if qmeat=0 then MDSscore=MDSscore+1;if qdairy=0 then MDSscore=MDSscore+1;
if HDIscore=. then delete;
run;/*210947 210874*/
data a;set a.a;if racegroupt=. then delete;run;

proc freq data=a; table ( sex racegroupt Education HHincomet   smoking  alcoholfreq )*ASD/chisq norow  nopercent ; run;
proc freq data=a; table (  employment2 TDIq fruitintakef vegetableintakef oilyfishintakef prmeatintakef fishoil mineral vitamin )*ASD/chisq norow  nopercent ; run;
proc means  data=a.a  N Mean P25 P75  QRANGE Std; var year BMI_index  energy enSFA enPUFA enfat enPro enCarb fiber calcium
cheeseintake fish  nuts fruitveg sugar ensugar fruitnut league total_vegetable 
HDIscore  MDSscore  diet_score poultry_intake;class ASD;run;
proc npar1way data=a.a wilcoxon;
   class ASD;var year BMI_index  energy enSFA enPUFA enfat enPro enCarb fiber calcium
cheeseintake fish  nuts fruitveg sugar ensugar fruitnut league total_vegetable 
HDIscore  MDSscore  diet_score poultry_intake;
RUN;/*90 poultry_gram*/

proc glm data=a;class ASD;model ASD=BMI_index ;proc glm data=a;class ASD;model ASD=year ;run;
proc glm data=a;class ASD;model diet_score=  ASD ;
proc glm data=a;class ASD;model MDSscore= ASD;
proc glm data=a;class ASD;model HDIscore= ASD;run;
proc glm data=a;model ASD=cheeseintake ;
proc glm data=a;model ASD=cheese;
proc glm data=a;model ASD=meat ;
proc glm data=a;model ASD=fish ;
proc glm data=a;model ASD=ensugar ;
proc glm data=a;model ASD=nuts ;
proc glm data=a;model ASD=fruitveg ;
proc glm data=a;model ASD=enSFA ;
proc glm data=a;model ASD=enPUFA;
proc glm data=a;model ASD=enPro ;
proc glm data=a;model ASD=enCarb ;
proc glm data=a;model ASD=enfat ;
proc glm data=a;model ASD=energy ;
proc glm data=a;model ASD=sugar ;
proc glm data=a;model ASD=calcium ;
proc glm data=a;model ASD=fiber ;
run;
proc import out=a.match_UKB
datafile="D:\CUHK2023FALL\HATCH COHORT\MR analysis\match_UKB.xlsx"
DBMS=xlsx
 replace;
 run;
 proc import out=match_UKB
datafile="D:\CUHK2023FALL\HATCH COHORT\MR analysis\match.xlsx"
DBMS=xlsx
 replace;
 run;
data match_UKB;set a.match_UKB;drop nuts HDIscore;run;
data a;set a.a;keep eid nuts HDIscore;run;
proc sort data=match_UKB;by eid;proc sort data=a;by eid;run;
data match_UKB;merge match_UKB a;by eid;if sex=. then delete;run;


 proc means data=match_UKB;var year BMI_index  energy enSFA enPUFA enfat enPro enCarb fiber calcium
cheeseintake  fish  nuts fruitveg sugar ensugar fruitnut league total_vegetable 
HDIscore  MDSscore  diet_score;class ASD;
   run;
proc npar1way data=match_UKB wilcoxon;
   class ASD;
   var  year BMI_index  energy enSFA enPUFA enfat enPro enCarb fiber calcium
cheeseintake  fish  nuts fruitveg sugar ensugar fruitnut league total_vegetable 
HDIscore  MDSscore  diet_score;
   run;
proc means  data=match_UKB; var enfat calcium fiber;class asd;run;
proc freq data=match_UKB; table ( employment2 TDIq fruitintakef vegetableintakef oilyfishintakef prmeatintakef unprmeatsintakef  fishoil mineral vitamin 
sex racegroupt Education HHincomet  HHincome smoking  alcoholfreq )*ASD/chisq norow  nopercent ; run;
proc freq data=a.a; table (  prmeatintakef  )*ASD/chisq norow  nopercent ; run;


data match;set a.match_UKB;keep eid ASD year BMI_index  energy enSFA enPUFA enfat enPro enCarb fiber calcium
cheeseintake fish  nuts fruitveg sugar ensugar fruitnut league total_vegetable 
HDIscore  MDSscore  diet_score enfat calcium fiber
employment2 TDIq fruitintakef vegetableintakef oilyfishintakef prmeatintakef unprmeatsintakef  fishoil mineral vitamin 
sex racegroupt Education HHincomet  HHincome smoking  alcoholfreq  ;run;
PROC EXPORT DATA=match
    OUTFILE="D:\CUHK2023FALL\HATCH COHORT\MR analysis\match.xlsx"
    DBMS=XLSX REPLACE;
RUN;
data match;set a.a;keep eid ASD year BMI_index  energy enSFA enPUFA enfat enPro enCarb fiber calcium
cheeseintake fish  nuts fruitveg sugar ensugar fruitnut league total_vegetable 
HDIscore  MDSscore  diet_score enfat calcium fiber
employment2 TDIq fruitintakef vegetableintakef oilyfishintakef prmeatintakef unprmeatsintakef  fishoil mineral vitamin 
sex racegroupt Education HHincomet  HHincome smoking  alcoholfreq  ;run;
PROC EXPORT DATA=match
    OUTFILE="D:\CUHK2023FALL\HATCH COHORT\MR analysis\match_2.xlsx"
    DBMS=XLSX REPLACE;
RUN;
