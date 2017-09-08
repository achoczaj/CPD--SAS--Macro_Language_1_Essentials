/*
 * Practice 6: Combine Macro Variable References with Special Characters
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/* Task:
Reference consecutive macro variables in a SAS program that prints selected information from the orion.organization_dim data set.

Reminder: Make sure you've defined the Orion library.
The following program prints selected information from the orion.organization_dim data set. Submit the program and view the results.
proc print data=orion.organization_dim;
   id Employee_ID;
   var Employee_Name Employee_Country Employee_Gender;
   title 'Listing of All Employees From orion.organization_dim';
run;

Modify the program so that all occurrences of organization and Employee are replaced with the macro variable references dsn and var respectively. When substituting for the hardcoded Employees in the TITLE statement, be sure to keep the ending s as part of the title text. Submit the program and verify that the results are the same as the original program's results.

Revise the program again. Modify the value of dsn to customer and var to Customer. Resubmit the program and view the results.*/

/* 1. Revise */
%let dsn=organization;
%let var=Employee;

proc print data=orion.&dsn._dim;
   id &var._ID;
   var &var._Name &var._Country &var._Gender;
   title "Listing of All &var.s From orion.&dsn._dim"; /*use "..."*/
run;


/* 2. Revise */
%let dsn=customer;
%let var=Customer;

proc print data=orion.&dsn._dim;
   id &var._ID;
   var &var._Name &var._Country &var._Gender;
   title "Listing of All &var.s From orion.&dsn._dim"; /*use "..."*/
run;
