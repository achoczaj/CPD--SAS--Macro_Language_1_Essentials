/*
 * Lesson 1.2: Creating and Referencing a User-Defined Macro Variab
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating and Referencing a User-Defined Macro Variable
 * edit a program to use a macro variable that you create instead of hardcoded values
 */

/*
 * Edit a program to use a macro variable 
 * that you create instead of hardcoded values
 
proc print data=orion.order_fact;
   where year(order_date)=2010;
   title "Orders for 2010";
run;

proc means data=orion.order_fact mean;
   where year(order_date)=2010;
   class order_type;
   var total_retail_price;
   title "Average Retail Price for 2010";
   title2 "by Order_Type";
run;

 * This program tracks orders for the year 2010. 
 */


/*
 * Suppose you want to to see the orders for 2011 instead? 
 * It would be much simpler if the program referred 
 * to a macro variable that held the value of the year 
 * instead of having those values hardcoded.
 */

/*create a macro variable named Year = 2011*/
%let year = 2011;

proc print data=orion.order_fact;
   where year(order_date) = &year;
   title "Orders for &year"; /*use "..." for macro var*/
run;

proc means data=orion.order_fact mean;
   where year(order_date) = &year;
   class order_type;
   var total_retail_price;
   title "Average Retail Price for &year"; /*use "..." for macro var*/
   title2 "by Order_Type"; /*use "..." for macro var*/
run;