version 16.1
clear
set more off
set memory 700m

global dir [storage_location]
cd $dir

********************************************************************************
***** load data
********************************************************************************
use "[file_location]\Ltstr0107.dta", replace

********************************************************************************
***** creating variables
********************************************************************************

foreach num of numlist 1/7 {

g resp_age_sq`num'=resp_age`num'*resp_age`num'

clonevar marital`num' = marital_`num'
g maritalnew_re`num'=marital`num'
recode maritalnew_re`num' (2/max=0)

rename hhsize0`num' hhsize`num' 

recode hhnetassets_`num' (-9=.) (-8=.)
g lnhhnetassets`num'=ln(hhnetassets_`num')

recode hhinc_`num' (-9=.) (-8=.)
g lnhhinc`num' =ln(hhinc_`num'+1)

g ownhouse`num' = f001_`num'
recode ownhouse`num' (min/-1=.) (2/max=0)

g present_labor`num'=present_labor_`num'
recode present_labor`num' (5=0)

clonevar regionc`num' = region3_`num'
g regionc_re`num'=regionc`num'-1 if regionc`num' !=.

egen chronic_sum_`num'=rowtotal(chronic_a_`num' chronic_b_`num' chronic_c_`num' chronic_d_`num' chronic_e_`num' chronic_f_`num' chronic_g_`num' chronic_h_`num' chronic_i_`num' chronic_j_`num') , missing

clonevar adl`num' = adl_`num'
g b_adl`num'=adl`num'
recode b_adl`num' (1/max=1)

clonevar lifesat`num' = g030_`num'
recode lifesat`num' (min/-1=.) 

clonevar soc_iso`num'=a032_`num'
recode soc_iso`num' (min/5=0) (6=1) (7/8=0) (9/10=1)
}

foreach var in soc_iso  {
g cum_soc_iso1=.
g cum_soc_iso2=.
g cum_soc_iso3=.
g cum_soc_iso4=.
g cum_soc_iso5=.
g cum_soc_iso6=.
g cum_soc_iso7=.

replace cum_soc_iso2=0 if cum_soc_iso2==. & soc_iso1==0 & soc_iso2==0
replace cum_soc_iso2=1 if cum_soc_iso2==. & soc_iso1==0 & soc_iso2==1
replace cum_soc_iso3=2 if cum_soc_iso3==. & soc_iso1==0 & soc_iso2==1 & soc_iso3==1
replace cum_soc_iso4=3 if cum_soc_iso4==. & soc_iso1==0 & soc_iso2==1 & soc_iso3==1 & soc_iso4==1
replace cum_soc_iso5=4 if cum_soc_iso5==. & soc_iso1==0 & soc_iso2==1 & soc_iso3==1 & soc_iso4==1 & soc_iso5==1
replace cum_soc_iso6=5 if cum_soc_iso6==. & soc_iso1==0 & soc_iso2==1 & soc_iso3==1 & soc_iso4==1 & soc_iso5==1 & soc_iso6==1
replace cum_soc_iso7=6 if cum_soc_iso7==. & soc_iso1==0 & soc_iso2==1 & soc_iso3==1 & soc_iso4==1 & soc_iso5==1 & soc_iso6==1 & soc_iso7==1

replace cum_soc_iso3=0 if cum_soc_iso3==. & soc_iso2==0 & soc_iso3==0
replace cum_soc_iso3=1 if cum_soc_iso3==. & soc_iso2==0 & soc_iso3==1
replace cum_soc_iso4=2 if cum_soc_iso4==. & soc_iso2==0 & soc_iso3==1 & soc_iso4==1
replace cum_soc_iso5=3 if cum_soc_iso5==. & soc_iso2==0 & soc_iso3==1 & soc_iso4==1 & soc_iso5==1 
replace cum_soc_iso6=4 if cum_soc_iso6==. & soc_iso2==0 & soc_iso3==1 & soc_iso4==1 & soc_iso5==1 & soc_iso6==1 
replace cum_soc_iso7=5 if cum_soc_iso7==. & soc_iso2==0 & soc_iso3==1 & soc_iso4==1 & soc_iso5==1 & soc_iso6==1 & soc_iso7==1

replace cum_soc_iso4=0 if cum_soc_iso4==. & soc_iso3==0 & soc_iso4==0
replace cum_soc_iso4=1 if cum_soc_iso4==. & soc_iso3==0 & soc_iso4==1 
replace cum_soc_iso5=2 if cum_soc_iso5==. & soc_iso3==0 & soc_iso4==1 & soc_iso5==1 
replace cum_soc_iso6=3 if cum_soc_iso6==. & soc_iso3==0 & soc_iso4==1 & soc_iso5==1 & soc_iso6==1 
replace cum_soc_iso7=4 if cum_soc_iso7==. & soc_iso3==0 & soc_iso4==1 & soc_iso5==1 & soc_iso6==1 & soc_iso7==1

replace cum_soc_iso5=0 if cum_soc_iso5==. & soc_iso4==0 & soc_iso5==0
replace cum_soc_iso5=1 if cum_soc_iso5==. & soc_iso4==0 & soc_iso5==1 
replace cum_soc_iso6=2 if cum_soc_iso6==. & soc_iso4==0 & soc_iso5==1 & soc_iso6==1 
replace cum_soc_iso7=3 if cum_soc_iso7==. & soc_iso4==0 & soc_iso5==1 & soc_iso6==1 & soc_iso7==1

replace cum_soc_iso6=0 if cum_soc_iso6==. & soc_iso5==0 & soc_iso6==0
replace cum_soc_iso6=1 if cum_soc_iso6==. & soc_iso5==0 & soc_iso6==1 
replace cum_soc_iso7=2 if cum_soc_iso7==. & soc_iso5==0 & soc_iso6==1 & soc_iso7==1

replace cum_soc_iso7=0 if cum_soc_iso7==. & soc_iso6==0 & soc_iso7==0
replace cum_soc_iso7=1 if cum_soc_iso7==. & soc_iso6==0 & soc_iso7==1

}

foreach num of numlist 1/7 {
foreach var in soc_iso  {
g cum4_soc_iso`num'=cum_soc_iso`num'
recode cum4_soc_iso`num' 4/max=4
}
}

********************************************************************************
*** reshape from wide to long form
********************************************************************************

keep pid age female ///
lifesat* cum4_soc_iso* resp_age* resp_age_sq* maritalnew_re* hhsize* lnhhinc* lnhhnetassets* ownhouse* present_labor* regionc_re* chronic_sum* b_adl* 

reshape long ///
lifesat cum4_soc_iso resp_age resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor regionc_re chronic_sum b_adl ///
, i(pid) j(wave)

********************************************************************************
*** Table 1. Descriptive statistics, Korean Longitudinal Study of Ageing (KLoSA)
********************************************************************************

estimates clear
xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re chronic_sum b_adl if all==1 & age>=65 , i(pid) fe cluster(pid)
g samp==1 if e(sample)
bysort pid : egen M_samp=mean(samp)

bysort pid : egen M_soc_iso=mean(soc_iso)
g N5_cum4_soc_iso=cum4_soc_iso
replace N5_cum4_soc_iso=5 if M_samp==. & M_soc_iso==1 

foreach var of varlist maritalnew_re regionc_re {
ta `var', gen(`var'_)
}

global descr lifesat resp_age female maritalnew_re_2 hhsize lnhhinc ownhouse present_labor regionc_re_1 regionc_re_2 regionc_re_3 chronic_sum b_adl

estpost summarize $descr if wave==1 & M_samp==1
est store all
estpost summarize $descr if wave==1 & M_samp==1 & female==1
est store female
estpost summarize $descr if wave==1 & M_samp==1 & female==0
est store male

esttab all female male using "$dir\Table1_desc_stat.rtf", ///
cells("mean(fmt(3) label(Mean)) sd(fmt(3) label(SD)) min(fmt(1) label(Min)) max(fmt(1) label(Max))") ///
mtitle("Total" "Women" "Men") ///
label nonumber replace compress  ///
addnote("{\i Note.} .") 

estpost ttest $descr if wave==1 & M_samp==1 , by(female) 
esttab using "$dir\Table1_ttest_p.rtf", cells(p(fmt(3))) wide nonumber replace

********************************************************************************
*** Table 2. Cumulative exposure to social isolation, by gender
********************************************************************************

estimates clear
estpost tab N5_cum4_soc_iso female if M_samp==1
esttab using "$dir\Table2_desc_stat_cumulative.rtf", ///
cells("b(fmt(0) label(n)) colpct(fmt(1) label(%))") ///
unstack noobs replace ///
addnote("{\i Note.} .") 

********************************************************************************
*** Table 3. Effect of cumulative exposure to social isolation on life satisfaction
********************************************************************************

estimates clear
foreach sex in all {
xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re chronic_sum b_adl if `sex'==1 & age>=65 , i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso if `sex'==1 & age>=65 & e(sample) , i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq if `sex'==1 & age>=65 & e(sample) , i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re if `sex'==1 & age>=65, i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re chronic_sum b_adl  if `sex'==1 & age>=65 , i(pid) fe cluster(pid)
esttab * using "$dir\Table3_cumulative_`sex'.rtf",  ///
o(*zum*) nogaps b(3) pa ci(3)  ///
label stats(N N_clust, fmt(0 0) labels("Observations" "N")) ///
replace compress star(+ 0.10 * 0.05 ** 0.01 *** 0.001) ///
addnote("{\i Note.} + {\i p} < 0.10; * {\i p} < 0.05; ** {\i p} < 0.01; *** {\i p} < 0.001" ) nonote 
estimates clear 
}

********************************************************************************
*** Table 4. Effect of cumulative exposure to social isolation on life satisfaction, by gender
********************************************************************************

estimates clear
foreach sex in female male {
xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re chronic_sum b_adl if `sex'==1 & age>=65 , i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso if `sex'==1 & age>=65 & e(sample) , i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq if `sex'==1 & age>=65 & e(sample) , i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re if `sex'==1 & age>=65, i(pid) fe cluster(pid)
eststo: xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age_sq maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re chronic_sum b_adl  if `sex'==1 & age>=65 , i(pid) fe cluster(pid)
esttab * using "$dir\Table4_cumulative_`sex'.rtf",  ///
o(*zum*) nogaps b(3) pa ci(3)  ///
label stats(N N_clust, fmt(0 0) labels("Observations" "N")) ///
replace compress star(+ 0.10 * 0.05 ** 0.01 *** 0.001) ///
addnote("{\i Note.} + {\i p} < 0.10; * {\i p} < 0.05; ** {\i p} < 0.01; *** {\i p} < 0.001" ) nonote 
estimates clear 
}

estimates clear
eststo: xtreg lifesat ib0.N5_cum4_soc_iso##i.female c.resp_age##i.female c.resp_age_sq##i.female i.maritalnew_re_2##i.female c.hhsize##i.female  c.lnhhinc##i.female c.lnhhnetassets##i.female i.ownhouse##i.female i.present_labor##i.female i.regionc_re_2##i.female i.regionc_re_3##i.female c.chronic_sum##i.female i.b_adl##i.female  if all==1 & age>=65, i(pid) fe cluster(pid)
esttab * using "$dir\Table4_cumulative_interaction_p.rtf",  ///
o(*zum*) d(*0.*) nogaps b(3) pa p(3)  ///
label stats(N N_clust, fmt(0 0) labels("Observations" "N")) ///
replace compress star(+ 0.10 * 0.05 ** 0.01 *** 0.001) ///
addnote("{\i Note.} + {\i p} < 0.10; * {\i p} < 0.05; ** {\i p} < 0.01; *** {\i p} < 0.001" ) nonote 

********************************************************************************
*** Figure 1. Cumulative exposure to social isolation and life satisfaction
*** Figure 2. Cumulative exposure to social isolation and life satisfaction, by gender
********************************************************************************

estimates clear
foreach sex in all female male /* female male */ {
eststo: xtreg lifesat ib0.N5_cum4_soc_iso c.resp_age c.resp_age#c.resp_age maritalnew_re hhsize lnhhinc lnhhnetassets ownhouse present_labor i.regionc_re chronic_sum b_adl  if `sex'==1 & age>=65 , i(pid) fe cluster(pid)
margins , at(N5_cum4_soc_iso = (0(1)4)) atmeans saving(N5_cum4_soc_iso_`sex', replace)
}

combomarginsplot N5_cum4_soc_iso_all , title("") ytitle("Predicted values of life satisfaction" " ") xtitle("No frequent social contact") name(g1, replace)  label( "Total") xlabel(0 "No exposure" 1 "One wave" 2 "2 waves" 3 "3 waves"  4 "4+ waves" , angle(45)) scheme(s1mono)
graph export $dir\Figure1_total_lifesat_Final.eps, as(eps) replace

combomarginsplot N5_cum4_soc_iso_female N5_cum4_soc_iso_male, title("") ytitle("Predicted values of life satisfaction" " ") xtitle("No frequent social contact") name(g4, replace)  label( "Women" "Men") xlabel(0 "No exposure" 1 "One wave" 2 "2 waves" 3 "3 waves"  4 "4+ waves" ) legend(row(2) ring(0) position(7)) scheme(s1mono)
graph export $dir\Figure2_gender_lifesat_Final.eps, as(eps) replace


