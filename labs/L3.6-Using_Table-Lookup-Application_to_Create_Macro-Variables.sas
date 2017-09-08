/*
 * Lesson 3.6: Using a Table Lookup Application to Create Macro Variables
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating a Macro Variable during DATA Step Execution
 * - Using a Table Lookup Application to Create Macro Variables */

/* this program works, but it's extremely inefficient */

%let custid=9;

/*The DATA _NULL_ step uses a WHERE statement 
to read the observation from orion.customer 
that matches the customer ID that's stored in 
the macro variable custid. 

After the WHERE statement reads the observation, 
the program calls the SYMPUTX routine 
to create the macro variable - &name, 
and assigns it the value of the DATA step variable 'Customer_Name'.
*/
data _null_;
   set orion.customer;
   where Customer_ID=&custid;
   call symputx('name', Customer_Name);
run;
 
/*The PROC PRINT step uses the macro variables 
custid and name in the TITLE statements.
*/
proc print data=orion.order_fact;
   where Customer_ID=&custid;
   var Order_Date Order_Type Quantity Total_Retail_Price;
   title1 "Customer Number: &custid";
   title2 "Customer Name: &name";
run;

title;
