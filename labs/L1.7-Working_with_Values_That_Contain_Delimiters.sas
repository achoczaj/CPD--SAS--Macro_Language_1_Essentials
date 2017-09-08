/*
 * Lesson 1.7: Working with Values That Contain Delimiters
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/*
 * Processing Macro Variables
 * - explicitly delimit a macro variable reference
 */

/*
 * Modify the previous program (1.6) so 
 * it include a macro variable that stores the libref
 */

/*create a macro variable that stores the libref value*/
%let lib=temp;
/* GRAPHICS should be null or G*/
%let graphics=g;
/* enable both the month and the year to be substituted */
/*create a macro variable that stores the month value*/
%let month=jun;
/*create a macro variable that stores the year value*/
%let year=2011;
/*create a macro variable that stores the analysis variable value*/
%let var=Sale;


proc &graphics.chart data=&lib..y&year&month; /*use 2 periods (..) - 1st as delimiter*/
   hbar week / sumvar=&var;
run;
proc &graphics.plot data=&lib..y&year&month; /* use 2 periods (..) - 1st as delimiter*/
   plot &var*day; 
run;

/* The first period is treated as a delimiter. 
The second period is treated as text. 
When you use two periods, the compiler receives 
the correct library and data set names.*/
