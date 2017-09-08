/*
 * Lesson 1.4: Using the SYMBOLGEN System Option
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/*
 * Displaying Macro Variables in the SAS Log
 * Using the SYMBOLGEN System Option
 */


/*turn on the SYMBOLGEN option*/
OPTIONS SYMBOLGEN;

%let year=2011;

proc print data=orion.order_fact;
   where year(order_date)=&year;
   title "Orders for &year";
run;

proc means data=orion.order_fact mean;
   where year(order_date)=&year;
   class order_type;
   var total_retail_price;
   title "Average Retail Price for &year";
   title2 "by Order_Type";
run;