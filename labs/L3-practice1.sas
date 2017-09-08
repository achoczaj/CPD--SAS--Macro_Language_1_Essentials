/*
 * Practice 1: Create a Macro Variable Using the CALL SYMPUTX Routine
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/* Task:
n this practice you create a series of reports that show the orders taken by an employee. The SAS data set orion.orders contains order information, including the employee ID of the employee who took the order. The SAS data set orion.employee_addresses contains employee data, including the employee ID numbers and names.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor:
title; 
footnote; 

%let idnum=121044;
proc print data=orion.orders noobs;
   var order_ID order_type order_date delivery_date;
   where employee_ID=&idnum;
title "Orders Taken by Employee &idnum";
run;

2. Submit the program and view the results.

3. Modify the program. Add a DATA step to access the orion.employee_addresses data set and create a macro variable, Name. Assign Name the name of the employee whose ID number matches the value of  IDnum used in the report. The employee names are stored in the Employee_Name variable in the orion.employee_addresses data set.

4. Modify the TITLE statement to display the employee's ID number followed by a colon and the employee's name.

5. Submit the program and view the results.

6. Change the value of the ID number to 121066, and then re-submit the program and view the results.
*/

/* 1. */

title; 
footnote; 

%let idnum=121044;
proc print data=orion.orders noobs;
   var order_ID order_type order_date delivery_date;
   where employee_ID=&idnum;
title "Orders Taken by Employee &idnum";
run;


/* 3. */
%let idnum = 121044;

data _null_;
   set orion.employee_addresses;
   where employee_ID = &idnum;
   call symputx ('name', employee_name);
run;

proc print data=orion.orders noobs;
   var order_ID order_type order_date delivery_date;
   where employee_ID = &idnum;
title "Orders Taken by Employee &idnum";
run;

/* 4. */
%let idnum = 121044;

data _null_;
   set orion.employee_addresses;
   where employee_ID = &idnum;
   call symputx ('name',employee_name);
run;

proc print data=orion.orders noobs;
   var order_ID order_type order_date delivery_date;
   where employee_ID = &idnum;
title "Orders Taken by Employee &idnum: &name";
run;

/* 6. */
%let idnum = 121066;
data _null_;
   set orion.employee_addresses;
   where employee_ID = &idnum;
   call symputx ('name',employee_name);
run;

proc print data=orion.orders noobs;
   var order_ID order_type order_date delivery_date;
   where employee_ID= &idnum;
title "Orders Taken by Employee &idnum: &name";
run;
