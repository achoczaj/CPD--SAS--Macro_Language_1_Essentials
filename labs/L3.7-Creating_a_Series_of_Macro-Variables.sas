/*
 * Lesson 3.7: Creating a Series of Macro Variables
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating a Macro Variable during DATA Step Execution
 * - Creating a Series of Macro Variables 
 */

/*
To make the program more efficient, you need to create 
a series of macro variables, each with a unique name. 
Here's an idea. We know that each customer has a unique ID. 
Instead of using consecutive numbers, we can use 
the value of customer_ID as the suffix. 
To do that, you can call the SYMPUTX routine 
with DATA step expressions for both arguments. 

The first expression evaluates to a character value 
that is a valid macro variable name. 
This value needs to change each time 
that you want to create another macro variable. 

The second expression is the value 
that you want to assign to the macro variable.

A common approach is to append a unique value 
to a base name during each iteration of the DATA step. 
For example, you might decide to use name as the base 
and create a macro variable named 
name1 on the first iteration, 
name2 on the second iteration, 
name3 on the third iteration, and so on. 

To create the customer report, you can append 
the value of the Customer_ID variable to the base, name. 
For example, Cornelia Krahl’s customer number is 9, 
so when her observation is being processed in the DATA step, 
you can create the macro variable name9 
and assign it the value Cornelia Krahl.
 */


data _null_;
      set orion.customer;
      /* concatenate the value of Customer_ID (a DATA step variable) 
      onto a base string 'name' to create macro var */
      /*call symputx('name'||left(Customer_ID)), Customer_Name);*/
      call symputx(cats('name',Customer_ID), Customer_Name);
run;

%put _user_;

%let custid=9;
proc print data=orion.order_fact;
   where Customer_ID=&custid;
   var Order_Date Order_Type Quantity Total_Retail_Price;
   title1 "Customer Number: &custid";
   title2 "Customer Name: &name9";
run;
    
title;