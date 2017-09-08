/*
 * Lesson 1.5: Placing Text before / after a Macro Variable Reference
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/*
 * Processing Macro Variables
 * 1. Placing Text before a Macro Variable Reference
 * 2. Referencing Adjacent Macro Variables
 * 3. Placing Text after a Macro Variable Reference
 */

/*
proc chart data=temp.y2011&jun;
   hbar week / sumvar=sale;
run;
proc plot data=temp.y2011&jun;
   plot sale*day;
run;
 */


/* Enable both the month and the year to be substituted */

/*creating a macro variable that stores the month value*/
%let month=jun;
/*creating a macro variable that stores the year value*/
%let year=2011;
/*creating a macro variable that stores the analysis variable value*/
%let var=Sale;


proc chart data=temp.y&year&month; /*(1, 2)*/
   hbar week / sumvar=&var;/*(1)*/
run;
proc plot data=temp.y&year&month; /*(1, 2)*/
   plot &var*day; /*(3)*/
run;