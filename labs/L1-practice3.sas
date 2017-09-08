/*
 * Practice 3: Write a SAS Program that References a Macro Variable
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/* Task:
Write a program to print salary information that's stored in orion.employee_payroll. The program needs to create and reference a macro variable. After you submit the program and view the output, edit the value of the macro variable to change the results.

Reminder: Make sure you've defined the Orion library.
Write a program to print information from orion.employee_payroll about all employees who earn at least a designated minimum salary. The salary data is stored in the variable Salary. Use a macro variable named minsal to store the value of the minimum salary and set its initial value to 60000.
%let minsal = 60000;

proc print data=orion.employee_payroll;
   where Salary >= &minsal;
run;

Add a statement to format Birth_Date, Employee_Hire_Date, and Employee_Term_Date with the DATE9. format and Salary with the DOLLAR8. format.

Add a TITLE statement that uses minsal in the title Employees Earning 60000 or More.

Submit the program and view the results.


Modify the program so that the report includes only those employees who earn at least 100000.

Submit the program and view the results.
*/

%let minSal = 60000;

title "Employees Earning &minSal or More"; /*use "..." for macro var*/
proc print data=orion.employee_payroll;
   where salary >= &minSal;
   /*format all var with the DATE9. format*/
   format Birth_Date Employee_Hire_Date Employee_Term_Date date9.
   		Salary DOLLAR8.;
run;

/* Modify the program so that the report includes 
only those employees who earn at least 100000. */

%let minSal = 100000;

title "Employees Earning &minSal or More"; /*use "..." for macro var*/
proc print data=orion.employee_payroll;
   where salary >= &minSal;
   /*format all var with the DATE9. format*/
   format Birth_Date Employee_Hire_Date Employee_Term_Date date9.;
run;
