/*
 * Practice 4: Defining and Using Macro Parameters
 * Lesson 4 - Creating and Using Macro Programs
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you define and call a macro program that will generate PROC MEANS code. The program calculates statistics based on analysis variables listed in the VAR statement and grouped by variables listed in the CLASS statement.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor:
options nolabel; 
title 'Order Stats'; 
proc means data=orion.order_fact maxdec=2 mean; 
   var total_retail_price; 
   class order_type; 
run; 
title;

2. Create a macro with keyword parameters that generalizes the code so that the following attributes are controlled by macro variables. Choose default values for all parameters so that the code executes correctly. Use the following values:
- Statistics: any combination of: N, NMISS, MIN, MEAN, MAX, RANGE, or a null value
- Decimal places: 0, 1, 2, 3, or 4
- Analysis variables: Total_Retail_Price and/or Costprice_Per_Unit
- Class variables: Order_Type and/or Quantity

3. Execute the macro using the default parameter values. View the results.

4. Call the macro again, using the appropriate parameter values to produce this report. 

5. Call the macro again, but override only the default parameter values for statistics and decimal places to produce this this report. 
*/

/* 1.*/
options nolabel; 
title 'Order Stats'; 
proc means data=orion.order_fact maxdec=2 mean; 
   var total_retail_price; 
   class order_type; 
run; 
title;


/* 2.*/
options mcompilenote=all; 
%macro customers(type);
   title "&type Customers"; 
   proc print data=orion.customer_dim; 
      var Customer_Name Customer_Gender Customer_Age; 
      where Customer_Group contains "&type"; 
   run; 
   title;
%mend customers;

/* 3.*/
options mprint;
%customers(Gold)

/* 4.*/
%customers(Catalog)

/* 5.*/
%macro customers(type=Club);
   title "&type Customers"; 
   proc print data=orion.customer_dim;
      var Customer_Name Customer_Gender Customer_Age; 
      where Customer_Group contains "&type"; 
   run; 
   title;
%mend customers; 

/* 6. */
%customers(type=Internet)

/* 7. */
%customers()

/*or just %customers*/
