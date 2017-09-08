/*
 * Lesson 2.1: Manipulating Character Strings Using Macro Functions
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/*
 * Manipulating Character Strings Using Macro Functions
 * 1. Using the %SUBSTR Function
 * 2. Using the %SCAN Function
 * 3. Using the %UPCASE Function
 */

/*** hardcoded program ***

data orders;
   set orion.orders;
   where 2009 <= year(Order_Date) <= 2017;
run;

title "Listing of ORDERS Data for 2009-2017;
proc print data=orders;
run;

 */


OPTIONS SYMBOLGEN;

/*create startYear Macro var*/
%let startYear = 2009;
/*use the current year for stopyear*/
%let curr_year = %substr(&sysdate9, 6); /*(1.)*/
/*SYSDATE9 --. 19Jun2017, not SYSDATE --. 19Jun17*/

/*create a macro var for data set name*/
%let dsn = orion.orders;
/*separate the data set name from the libref and reuse this value in the DATA step*/
%let name = %scan(&dsn, 2, .); /*(2.) use '.' as delimiter*/
/*return the second word from the macro variable dsn, using a period as the delimiter*/

/*create a macro var for analytic variable */
%let analytic_var_name = order_date;


data &name;
   set &dsn;
   where &startYear <= Year(&analytic_var_name) <= &curr_year;
run;

title "Listing of %upcase(&name) Data for &startYear-&curr_year"; /*(3.)*/

/* use automatic macro variable instead of using the macro variable '&name' */
proc print data=&syslast;
/*SYSLAST stores the name of the most recently created data set in the form libref.name.*/
run;

OPTIONS NOSYMBOLGEN;