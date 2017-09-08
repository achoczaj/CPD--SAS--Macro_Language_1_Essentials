/*
 * Practice 4: Create Macro Variables Using PROC SQL
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/* Task:
The program below includes a PROC MEANS step, a DATA  step, and a PROC PRINT step. The PROC MEANS step uses the data in orion.order_fact to calculate the average quantity and average total retail price for orders placed in January 2011. The DATA step creates the macro variables Quant (which stores the value of the average quantity) and Price (which stores the value of  the average price). The PROC PRINT step references Quant and Price in the TITLE statements. In this practice, you replace the PROC MEANS step and the DATA step with a single PROC SQL step.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor:
title; 
footnote; 

%let start=01Jan2011;
%let stop=31Jan2011;

proc means data=orion.order_fact noprint;
   where order_date between "&start"d and "&stop"d;
   var Quantity Total_Retail_Price;
   output out=stats_q_p mean=Avg_Quant Avg_Price;
run;

data _null_;
   set stats_q_p;
   call symputx('Quant',put(Avg_Quant,4.2));
   call symputx('Price',put(Avg_Price,dollar7.2));
run;

proc print data=orion.order_fact noobs n;
   where order_date between "&start"d and "&stop"d;
   var Order_ID Order_Date Quantity Total_Retail_Price;
   sum Quantity Total_Retail_Price;
   format Total_Retail_Price dollar6.;
   title1 "Report from &start to &stop";
   title3 "Average Quantity: &quant";
   title4 "Average Price: &price";
run;

2. Submit the program and view the results.


3. Delete the macro variables Quant and Price from the Global Symbol Table.

4. Replace the PROC MEANS step and the DATA step with a PROC SQL step that creates the macro variables Quant and Price. Be sure to use the same subsetting criteria and formats as the PROC MEANS step and the DATA step.

5. Submit the modified program and verify the results are the same.
*/

/* 1.*/
title; 
footnote; 

%let start=01Jan2011;
%let stop=31Jan2011;

proc means data=orion.order_fact noprint;
   where order_date between "&start"d and "&stop"d;
   var Quantity Total_Retail_Price;
   output out=stats_q_p mean=Avg_Quant Avg_Price;
run;

data _null_;
   set stats_q_p;
   call symputx('Quant',put(Avg_Quant,4.2));
   call symputx('Price',put(Avg_Price,dollar7.2));
run;

proc print data=orion.order_fact noobs n;
   where order_date between "&start"d and "&stop"d;
   var Order_ID Order_Date Quantity Total_Retail_Price;
   sum Quantity Total_Retail_Price;
   format Total_Retail_Price dollar6.;
   title1 "Report from &start to &stop";
   title3 "Average Quantity: &quant";
   title4 "Average Price: &price";
run;