/*
 * Practice 1: Defining and Calling a Macro
 * Lesson 4 - Creating and Using Macro Programs
 * SAS Macro Language 1: Essentials
 */
/* Task:
Define a macro that prints selected customers from the SAS data set orion.customer_dim, based on the value of the macro variable Type. Then call the macro specifying different values for Type.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor:
title "&type Customers";
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type";
run;
title;

2. Convert the program into a macro named Customers. Set the appropriate system option to display a note in the SAS log when the macro definition has compiled. Submit the macro definition and examine the log.

3. Submit a %LET statement to assign the value Gold to the macro variable Type. Call the macro, examine the log and view the results.

4. Change the value of Type to Internet.

5. Activate the appropriate system option to display source code received by the SAS compiler. Call the macro again, examine the log and view the results.
*/


/* 1.*/
title "&type Customers";
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type";
run;
title;

/* 2.*/
options mcompilenote=all;

%macro Customers;
   title "&type Customers";
   proc print data=orion.customer_dim;
      var Customer_Name Customer_Gender Customer_Age;
      where Customer_Group contains "&type";
   run;
   title;
%mend;

/* 3.*/
%let type=Gold;
%Customers

/* 4.*/
%let type=Internet;
%Customers

/* 5.*/
options mprint;
%Customers
