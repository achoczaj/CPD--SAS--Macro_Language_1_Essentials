/*
 * Practice 2: Create Macro Variables Using the CALL SYMPUTX Routine
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you use the SAS data set orion.order_fact to create a temporary, summary data set. You use the data in the summary data set to create a macro variable that stores the customer ID number of the top customer. Then you use that macro variable to look up the customer's name. Customer names are stored in the SAS data set orion.customer_dim.

Reminder: Make sure you've defined the Orion library.
1. Submit the following program. This program creates a summary data set named Customer_Sum that summarizes Total_Retail_Price by Customer_ID and sorts the data set by descending CustTotalPurchase.
title; 
footnote; 

proc means data=orion.order_fact sum nway noprint; 
   var total_retail_price;
   class customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum ;
   by descending CustTotalPurchase;
run;

2. Read the temporary data set, Customer_Sum and create a macro variable named Top that contains the ID number for the top customer. Hint: Remember that the first observation in the Customer_Sum data set represents the top customer.

3. Add a PROC PRINT step as follows:
Suppress the OBS column.
Print only the orders for the top customer in orion.orders.
Include only the variables Order_ID, Order_Type, Order_Date, and Delivery_Date.
Add a TITLE statement that references the Top macro variable. For example, the title might read Orders for Customer 16.

4. Submit the program and view the results.

5. Modify the program. The data set orion.customer_dim contains customer names. Add a DATA step to access orion.customer_dim and create a macro variable, Name. Assign Name the name of the top customer. Then reference Name in the TITLE statement to print the customer's name instead of the customer's ID.

6. Submit the program and view the results.
*/

/* 1.*/
title; 
footnote; 

proc means data=orion.order_fact sum nway noprint; 
   var total_retail_price;
   class customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum ;
   by descending CustTotalPurchase;
run;

/* 2.*/
data _null_;
   set customer_sum (obs=1);
   call symputx('top', customer_ID);
run;

/* 3.*/
proc print data=orion.orders noobs;
   where customer_ID = &top;
   var order_ID order_type order_date delivery_date;
   title "Orders for Customer &top";
run;

/* 5.*/
data _null_;
   set customer_sum (obs=1);
   call symputx('top', customer_ID);
run;

data _null_;
   set orion.customer_dim;
   where customer_ID = &top;
   call symputx('topname', customer_name);
run;

proc print data=orion.orders noobs;
   where customer_ID = &top;
   var order_ID order_type order_date delivery_date;
   title "Orders for Customer &topname";
run;