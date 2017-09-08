/*
 * Practice 3: Use the %EVAL and %SYSEVALF Functions
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you'll use the %EVAL and %SYSEVALF functions to evaluate arithmetic expressions and create a new macro variable.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor. It creates two macro variables.
%let salary1=25000; 
%let salary2=27000;

2. Modify the program by adding statements to compute the difference between the two salaries and assign it to a third macro variable, Salary_Diff. Add a  %PUT statement to display the value of Salary_Diff. Submit the program and examine the messages that are written to the SAS log. 
3. Revise the program so that the value of Salary2 is 27050.45 and submit the code. Examine the SAS log. 
4. Revise the program so that the assignment statement will work for both integer and non integer values. Submit the program again and verify that there are no errors or warnings in the log. 
*/

/* 2. */
%let salary1=25000; 
%let salary2=27000;
%let salary_diff = %eval(&salary2 - &salary1);
%put The salary difference is &salary_diff;

/* 3. */
%let salary1=25000;
%let salary2=27050.45;
%let salary_diff = %eval(&salary2 - &salary1);
%put The salary difference is &salary_diff;

/* 4. */
%let salary1=25000;
%let salary2=27050.45;
%let salary_diff = %sysevalf(&salary2 - &salary1);
%put The salary difference is &salary_diff;
