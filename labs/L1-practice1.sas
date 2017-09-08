/*
 * Practice 1: Reference an Automatic Macro Variable
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice, you create a report that includes system information that is provided by automatic macro variables.
Reminder: Make sure you've defined the Orion library.
Copy and paste the following PROC PRINT step into the editor:
proc print data=orion.customer_dim;
run;

Add a FOOTNOTE statement that displays today's date (assuming you started your SAS session today) by using an automatic macro variable. Use this text for your footnote: Report Created on ddmmmyy 

Submit the program and examine the results.

Scroll to the bottom of the output and verify that the footnote contains today's date (assuming that you began the current SAS session today). 
*/

proc print data=orion.customer_dim;
footnote "Report Created on &sysdate"; /*use "..." for macro var*/
run;