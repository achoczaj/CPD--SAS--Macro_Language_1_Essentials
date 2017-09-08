/*
 * Practice 5: Combine Macro Variable References with Text
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice you reference consecutive macro variables using the orion.organization_dim data set.

Reminder: Make sure you've defined the Orion library.
Copy and paste the following code into the editor:
proc print data=orion.organization_dim;
   where Employee_Hire_Date="01AUG2006"d;
   id Employee_ID;
   var Employee_Name Employee_Country Employee_Hire_Date;
   title 'Personal Information for Employees Hired in AUG 2006';
run;

Revise the program so that the two occurrences of AUG and 2006 are replaced by references to the macro variables month and year, respectively. Assign the value AUG to month and the value 2006 to year. Submit the program and view the results.

Revise the program again. Change the value of month to JUL and year to 2003. Resubmit the program and view the results.
*/


/*1. Revise*/
OPTIONS SYMBOLGEN;

/*create a macro variable that stores the month value*/
%let month=AUG;
/*create a macro variable that stores the year value*/
%let year=2006;

proc print data=orion.organization_dim;
   where Employee_Hire_Date="01&month&year"d;
   id Employee_ID;
   var Employee_Name Employee_Country Employee_Hire_Date;
   title 'Personal Information for Employees Hired in &month &year';
run;

OPTIONS NOSYMBOLGEN;


/*2. Revise*/
OPTIONS SYMBOLGEN;

/*create a macro variable that stores the month value*/
%let month=JUL;
/*create a macro variable that stores the year value*/
%let year=2003;

proc print data=orion.organization_dim;
   where Employee_Hire_Date="01&month&year"d;
   id Employee_ID;
   var Employee_Name Employee_Country Employee_Hire_Date;
   title 'Personal Information for Employees Hired in &month &year';
run;

OPTIONS NOSYMBOLGEN;
