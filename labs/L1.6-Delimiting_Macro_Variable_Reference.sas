/*
 * Lesson 1.6: Delimiting a Macro Variable Reference
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/*
 * Processing Macro Variables
 * Delimiting a Macro Variable Reference
 */

/*
 * Modify the previous program (1.5) so that it's easy 
 * to switch between using the CHART and PLOT procedures 
 * of Base SAS software 
 * and the GCHART and GPLOT procedures of SAS/GRAPH software. 
 * 
 * You can set the value of the macro variable graphics 
 * to determine which procedure to invoke. 
 * When the value of graphics resolves to g, 
 * the program invokes PROC GCHART. 
 * When the value of graphics is null, 
 * the program invokes PROC CHART .
 */

/* GRAPHICS should be null or G*/
%let graphics=g;
/* enable both the month and the year to be substituted */
/*creating a macro variable that stores the month value*/
%let month=jun;
/*creating a macro variable that stores the year value*/
%let year=2011;
/*creating a macro variable that stores the analysis variable value*/
%let var=Sale;

/* wrong solution
proc &graphicschart data=temp.y&year&month; 
   hbar week / sumvar=&var;
run;
proc &graphicsplot data=temp.y&year&month;
   plot &var*day;
run;
*/
/*The messages in the log reveal problems with this program. 
Notice that the warning message indicates that 
the macro variable graphicschart was not resolved. 
Also notice the error message. 
It indicates that SAS expected the name of the procedure 
to be executed. 

SAS interprets the macro variable's name to be graphicschart 
instead of graphics because there's no delimiter 
between the macro variable reference, &graphics, 
and the trailing text, chart. 
Graphicschart is a valid name token, so the word scanner 
passes the macro trigger &graphicschart to the macro processor.*/



/*
 * To correct this program, you need to add a period after 
 * the reference to the macro variable graphics. 
 * A period (.) is a special delimiter that ends 
 * a macro variable reference.
 */
proc &graphics.chart data=temp.y&year&month; /*use period (.) as delimiter*/
   hbar week / sumvar=&var;/*(1)*/
run;
proc &graphics.plot data=temp.y&year&month; /* use period (.) as delimiter*/
   plot &var*day; /*(3)*/
run;

/* The period is treated as part of the macro variable reference and does not appear 
when the macro variable is resolved.*/
