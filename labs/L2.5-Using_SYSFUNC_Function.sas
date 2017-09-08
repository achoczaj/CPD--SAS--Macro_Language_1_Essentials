/*
 * Lesson 2.5: Using %SYSFUNC with SAS Functions
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/*
 * Using Arithmetic and Logical Expressions
 * 1. Using the %SYSFUNC Function
 */

/*
 * use %SYSFUNC to invoke the SAS function PROPCASE 
 * in order to display the data set name 
 * in proper case in the TITLE statement.
 */


/* 1. Submit this program to create a temporary version of the orders data set that contains data values for the current year. */
options symbolgen;
%let thisyr=%substr(&sysdate9,6);
%let numyrs=%eval(&thisyr-2007);

/* Create work.orders1. */
data orders1;
   set orion.orders;
      drop Year StopYear;
      output;
      StopYear=%substr(&sysdate9,6)-1;
      if Year(Order_Date)=2007;
         do Year=1 to &numYrs;
            Order_Date=Order_Date+365;
            Delivery_Date=Delivery_Date+365;
	    output;
	 end;
run;

proc sort data=orders1;
   by Order_Date Customer_ID ;
run;

options nosymbolgen;

/* 2. Copy and paste the following code into the editor. This DATA step creates a subset of the orders data set. It includes all orders for the years 2007 through the current year.*/

%let dsn=work.orders1;
%let var=order_date;
%let name=%scan(&dsn,2,.);
%let startyear=2007;
%let curr_year=%substr(&sysdate9,6);

data &name;
   set &dsn;
   where &startyear <= Year(&var) <= &curr_year;
run;

title "Listing of %scan(&syslast,2,.) Data for &startyear-&curr_year";
proc print data=&syslast;
run;

/* 3. Revise the code in order to display the data set name in proper case in the TITLE statement. Use %SYSFUNC to invoke the SAS function PROPCASE. The PROPCASE function converts all words in an argument to proper case. The code will now look like this:*/
%let dsn=work.orders1;
%let var=order_date;
%let name=%scan(&dsn,2,.);
%let startyear=2007;
%let curr_year=%substr(&sysdate9,6);

data &name;
   set &dsn;
   where &startyear <= Year(&var) <= &curr_year;
run;

title "Listing of %sysfunc(propcase(%scan(&syslast,2, .))) Data for &startyear-&curr_year";
proc print data=&syslast;
run;
title;
