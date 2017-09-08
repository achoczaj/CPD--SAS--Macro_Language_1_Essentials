/*
 * Lesson 3.5: Passing Data between Steps
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating a Macro Variable during DATA Step Execution
 * - Using the CALL SYMPUTX Routine
 * - Using SYMPUTX with a DATA Step Variable
 * - Using SYMPUTX with a DATA Step Expression
 * - Passing Data between Steps
 */


%let year=2009;

/* STEP 1*/
/* The PROC MEANS step analyzes orion.order_fact. 
It selects orders for the requested year, 
calculates the average quantity and price 
for all selected orders, 
and writes these statistics to a temporary data set, stats. 
The variables are named AvgQty and AvgPrice respectively.
*/ 
proc means data=orion.order_fact noprint;
	/*For this task, you don't need a PROC MEANS report. 
	To suppress the report use the NOPRINT option.*/

   /*subsets the order_fact data set*/
   where year(Order_Date) =  &year;
   /*specify variables to be analyzed*/
   var Quantity Total_Retail_Price;
   /*use OUTPUT to create an output data set called stats in the work library */
   output out=stats mean=AvgQty AvgPrice;
   /*MEAN= option renames the mean statistic for each analyzed variable. 
   The names are assigned by position. 
   The mean statistic for the first variable in the VAR statement, Quantity, 
   is stored using the first name listed in the MEAN= option, AvgQty. 
   The mean statistic for the second variable in the VAR statement, Total_Retail_Price, 
   is stored using the second name listed in the MEAN= option, AvgPrice.*/
run;
 

/* STEP 2*/

/* The DATA _NULL_ step reads the temporary data set, stats, 
created by PROC MEANS. 
The SYMPUTX routine uses the values of AvgQty and AvgPrice 
to create two macro variables, Qty and Price. 
AS THAY CAN NOT BE CREATED IN the MEAN Step.
*/
data _null_;
/* Usually, the DATA statement specifies at least one data set name 
that SAS uses to create an output data set. 
Using the keyword _NULL_ as the data set name 
causes SAS to execute the DATA step 
without writing observations to a data set. */

/* In this case, you simply need the DATA step 
to create the macro variables using the SYMPUTX routine.*/

/* Can you use the SYMPUTX routine in a PROC step? 
No, CALL routines are only valid in a DATA step.
This DATA step reads the temporary data set,
Stats, which contains one observation. */
	
   set stats;
   /* A call to the SYMPUTX routine creates the macro variable qty 
   and assigns it the value of AvgQty from the stats data set.*/ 
   call symputx('qty', round(AvgQTY, .01));
   /*SYMPUTX routine creates the macro variable price 
   and assigns it the value of AvgPrice from stats data set.*/
   call symputx('price', round(AvgPrice, .01));
run;

/* STEP 3*/
/* use macro variables - &qty and &price*/ 
title "Orders Exceeding Average in &year";
footnote "Average Quantity: &qty";
footnote2 "Average Price: &price";
 
proc print data=orion.order_fact noobs;
   where year(Order_Date)=&year and Quantity>&qty
         and Total_Retail_Price>&price;
   var Customer_ID order_id Order_Date Quantity Total_Retail_Price;
run;

title;
footnote;
