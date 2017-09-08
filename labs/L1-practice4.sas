/*
 * Practice 4: Display Resolved Macro Variables in the SAS Log
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/* Task:
Use the SYMBOLGEN system option and the %PUT statement to display resolved macro variables in the SAS log.

Reminder: Make sure you've defined the Orion library.
Copy and paste the following code into the editor:
%let type=Internet;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type";
   title "&type Customers";
run;

Add an OPTIONS statement before the %LET statement to activate the SYMBOLGEN system option. Submit the program. Then examine the SAS log and the results.

In the log, you will see two SYMBOLGEN messages, one for each reference to the macro variable Type. Modify the OPTIONS statement to deactivate the SYMBOLGEN system option.

Add a %PUT statement at the end of the program to display the value of the macro variable Type. Submit the revised program and examine the SAS log. You can put any text in your %PUT statement. 
*/

OPTIONS NOSYMBOLGEN;
 
%let type=Internet;

proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type";
   title "&type Customers";
run;

%put The value of macro variable Type is &type;
title;