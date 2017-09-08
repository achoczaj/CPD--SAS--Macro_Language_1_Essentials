/*
 * Lesson 3.8: Using an Indirect Reference
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating a Macro Variable during DATA Step Execution
 * - Creating a Series of Macro Variables
 * - Using an Indirect Reference 
 */

/*
To obtain the correct output, the macro processor must 
resolve &custid before &name. 
Because the value of the custid macro variable matches 
part of the name of a name macro variable, 
the custid macro variable can indirectly reference 
a name macro variable. 
To create an indirect reference, you need to precede 
a name token with multiple ampersands (&&....). 

By preceding a macro variable reference with two ampersands, 
you delay the resolution of the reference until the second scan. 
When the macro processor encounters two ampersands, 
it resolves them to one ampersand 
and continues to rescan from left to right, 
from the point where the multiple ampersands begin. 

This action is known as the Forward Rescan Rule.
 */


data _null_;
      set orion.customer;
      call symputx(cats('name',Customer_ID), Customer_Name);
run;

%let custid=9;

proc print data=orion.order_fact;
   where Customer_ID=&custid;
   var Order_Date Order_Type Quantity Total_Retail_Price;
   title1 "Customer Number: &custid";
   
   /*use the Forward Rescan Rule*/
   title2 "Customer Name: &&name&custid"; 
   /*On the first scan, the macro processor 
   resolves the two ampersands to one ampersand. 
   The text name is unchanged. 
   The scan continues and &custid resolves to 9. 
   Because we started with multiple ampersands, 
   the Forward Rescan Rule is in effect 
   and a second scan occurs: &name9 resolves to Cornelia Krahl. 
   
   At this point, scanning is complete because there are 
   no remaining macro variable references.*/
run;
    
title;

/*According to the Forward Rescan Rule, you need to use 
three ampersands in front of a macro variable name 
when its value exactly matches the name 
of a second macro variable. 

The need for more than three ampersands is extremely rare. 

*/