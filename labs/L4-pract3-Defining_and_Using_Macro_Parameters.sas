/*
 * Practice 3: Defining and Using Macro Parameters
 * Lesson 4 - Creating and Using Macro Programs
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you define and call a macro program using positional and keyword parameters. The Customers macro program prints observations based on the value of the macro variable Type.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor:
%macro customers; 
title "&type Customers"; 
proc print data=orion.customer_dim; 
   var Customer_Name Customer_Gender Customer_Age; 
   where Customer_Group contains "&type"; 
run; 
title;
%mend customers;

2. Convert this program into a macro with a positional parameter. Name the parameter based on macro variable references within the program. Set the appropriate system option to display a note in the SAS log when a macro definition has compiled. Submit the macro definition to compile the macro.

3. Set the MPRINT option. Call the macro defined in the previous step with a value of Gold for the parameter and view the results.

4. all the macro again, but with a parameter value of Catalog and view the results.

5. Change the positional parameter to a keyword parameter with a default value of Club. Submit the revised macro definition to compile the macro.

6. Call the macro defined in the previous step with a value of Internet for the keyword parameter and view the results.

7. Call the macro again, but allow the macro to use its default parameter value. View the results. 
*/

/* 1.*/
%macro customers; 
title "&type Customers"; 
proc print data=orion.customer_dim; 
   var Customer_Name Customer_Gender Customer_Age; 
   where Customer_Group contains "&type"; 
run; 
title;
%mend customers;


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
