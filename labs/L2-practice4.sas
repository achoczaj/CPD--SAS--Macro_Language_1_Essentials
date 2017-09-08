/*
 * Practice 4:  Using the %SYSFUNC Function
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you use %SYSFUNC to call a SAS date function and create a new macro variable.

Reminder: Make sure you've defined the Orion library.
1. The SAS MDY function converts a numeric month, day and year to a SAS date. Use %SYSFUNC to execute the MDY function and format the result with the WEEKDATE. format and assign it to a macro variable. Use a %PUT statement to display the result as:  Saturday, January 1, 2000.

2. Modify the previous program to find the day of the week on which you were born. */

/* 1. */
%let d = %sysfunc(mdy(01,01,2000), weekdate.);
%put &d;

/* 2. */
%let d=%sysfunc(mdy(8,13,1974), weekdate.);
%put &d;