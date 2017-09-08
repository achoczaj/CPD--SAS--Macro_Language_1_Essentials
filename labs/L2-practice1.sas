/*
 * Practice 1: Create a New Macro Variable
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you use the %SUBSTR and %SCAN macro character functions to manipulate character strings and create a new macro variable.

Reminder: Make sure you've defined the Orion library.
Submit a %LET statement to assign the value Anthony Miller 
to a macro variable named Fullname.

Extract the first initial and last name, 
putting them together into a new macro variable named Newname. 
The value of Newname should be A. Miller. 

Use the %PUT statement to display the results.
*/

%let Fullname = Anthony Miller;
%let Newname = %substr(&Fullname, 1, 1). %scan(&Fullname, 2);
%put &Newname;

/* Alt Solution
%let Fullname = Anthony Miller;
%let initial = %substr(&Fullname, 1, 1);
%let last_name = %scan(&Fullname, 2);
%let Newname = &initial.. &last;
%put &Newname;
*/