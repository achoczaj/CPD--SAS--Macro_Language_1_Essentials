/*
 * Practice 6:  Use a Macro Quoting Function in a Report
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you create a report that includes values containing special characters. Use the SAS data set orion.product_dim to create a report that includes values containing special characters.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor:
proc print data=orion.product_dim;
   where Product_Name contains 'Jacket';
   var Product_Name Product_ID Supplier_Name;
   title "Product Names Containing 'Jacket'";
run;

2. Submit the program and examine the output. It displays all observations in which the variable Product_Name contains the word Jacket.

3. Revise the code so that it creates a macro variable named Product with the value Jacket. Use a macro variable reference instead of the hard coded value in the WHERE and TITLE statements. Submit the program and verify that it produces the same results as step 2.

4. Revise the code so that it displays the observations in which the variable Product_Name contains R&D instead of Jacket. You might need to use a quoting function to avoid warning messages in the log. Submit the modified program and check the log to be sure there are no warnings. Then check the output.
*/

/* 1. */

proc print data=orion.product_dim;
   where Product_Name contains 'Jacket';
   var Product_Name Product_ID Supplier_Name;
   title "Product Names Containing 'Jacket'";
run;

/* 3. */
%let product = Jacket;
proc print data=orion.product_dim;
   where Product_Name contains "&product";
   var Product_Name Product_ID Supplier_Name;
   title "Product Names Containing '&product'";
run;

/* 4. */
%let product = %nrstr(R&D);
proc print data=orion.product_dim;
   where Product_Name contains "&product";
   var Product_Name Product_ID Supplier_Name;
   title "Product Names Containing '&product'";
run;