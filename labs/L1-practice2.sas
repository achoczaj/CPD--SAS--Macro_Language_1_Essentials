/*
 * Practice 2: Create and Reference a Macro Variable
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you replace values that are hardcoded in a program with references to a macro variable.
The data set orion.customer contains information about customers from multiple countries.

Reminder: Make sure you've defined the Orion library.
Submit the following program to print observations about customers from Germany, and view the results.
title 'Customers in DE';
proc print data=orion.customer;
   var Customer_ID Customer_Name Gender; 
   where Country='DE';
run;

Modify the program to replace each instance of the value DE with a reference to a macro variable. Name the macro variable location and set its value to DE. Submit the program and verify that the results are the same as the original program's results. 

Edit the program to print information about customers from South Africa (ZA) instead of Germany, and resubmit it. View the results. 
*/

%let Location = DE;

title "Customers in &location"; /*use "..." for macro var*/
proc print data=orion.customer;
   var customer_id customer_name gender; 
   where country="&location";
run;


%let Location = ZA;

title "Customers in &location"; /*use "..." for macro var*/
proc print data=orion.customer;
   var customer_id customer_name gender; 
   where country="&location";
run;