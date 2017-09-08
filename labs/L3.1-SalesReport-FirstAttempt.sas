/*
 * Lesson 3.1: Sales Report - First Attempt
 * Lesson 2 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating a Macro Variable during DATA Step Execution
 */

%let month=2;
%let year=2011;
 
data orders1;
   keep Order_Date Order_Type Quantity Total_Retail_Price;
   set orion.order_fact end=final;
   where year(Order_Date)=&year and month(Order_Date)=&month;
   if Order_Type=3 then Number+1;
   if final then do;
      put Number=;
      if Number=0 then do;
         %let foot=No Internet Orders;
      end;
         else do;
           %let foot=Some Internet Orders;
         end;
     end;
   run;
 
proc print data=orders1;
   title "Orders for &month-&year";
   footnote "&foot";
run;

title;
footnote;