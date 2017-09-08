/*
 * Practice 5:  Use Macro Quoting Functions to Create Macro Variables
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you create macro variables and assign values 
that require the use of quoting functions 
because the values contain special characters.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor. 
Submit the program and examine the log.
%let company=AT&T;
%let list=one;two;
%put list=&list company=&company;

2. Use the appropriate quoting function(s) so that no warning messages are generated. Ensure that the semicolon following "two" is included as part of the macro variable List. 
*/

/* 1. */
%let company=AT&T;
%let list=one;two;
%put list=&list company=&company;
/* 2. */
%let company = %nrstr(AT&T);
%let list = %str(one; two;);
%put list = &list company = &company;