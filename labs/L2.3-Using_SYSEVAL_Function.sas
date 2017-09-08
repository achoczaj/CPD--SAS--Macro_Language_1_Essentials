/*
 * Lesson 2.3: Using the %EVAL Function
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/*
 * Using Arithmetic and Logical Expressions
 * 1. Using the %EVAL Function
 */

/*
 * The %EVAL function evaluates arithmetic and logical expressions. These expressions are sequences of operators and operands, forming sets of instructions that are evaluated to produce a result. The arguments within these expressions are temporarily converted to numbers so that a calculation can be performed. The results are returned as text. An arithmetic expression contains an arithmetic operator. A logical expression contains a logical operator.
 */

/*
Let's see how we can use it, and an arithmetic expression, 
to calculate a date range in our PROC MEANS step.

This PROC MEANS step summarizes the contents of the orion.order_fact data set. 
The report includes the minimum, maximum, and mean values 
for each of three order types during a specified date range. 
The order types refer to retail store, catalog, and Internet orders respectively. 

Currently, the year variables are hardcoded into both the WHERE statement 
and the TITLE statement. We'd need to change each one manually 
if we wanted to reuse this program for a different date range. 

Let's change the year values to macro variables 
and assign values based on the current date. 
That way, these values will update automatically.

proc means data=orion.order_fact maxdec=2 min max mean;
   class order_type;
   var total_retail_price;
   where year(order_date) between 2009 and 2010; // <-- dates are hardcoded
   title1 "Orders for 2009 and 2010"; // <-- dates are hardcoded
   title2 "(as of &sysdate9)";
run;
 */ 

OPTIONS SYMBOLGEN;

/*obtain the value for the current year*/
%let thisyr = %substr(&sysdate9, 6);
/*define the value of the macro variable lastyr*/
%let lastyr = %eval(&thisyr - 1);

proc means data=orion.order_fact maxdec=2 min max mean;
   class order_type;
   var total_retail_price;
   where year(order_date) between &lastyr and &thisyr;
   title1 "Orders for &lastyr and &thisyr";
   title2 "(as of &sysdate9)";
run;
 