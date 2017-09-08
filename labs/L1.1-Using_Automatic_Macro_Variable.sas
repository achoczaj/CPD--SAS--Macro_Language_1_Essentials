/*
 * Lesson 1.1: Using Automatic Macro Variable
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/*
 * Using Automatic Macro Variable
 */

/*
 * This step prints the contents of the orion.customer_type data set. 
 * The footnotes list the time, day, and date that the SAS session began, 
 * as well as the operating system and SAS version. 
 
proc print data=orion.customer_type noobs;
   title 'Listing of Customer_Type Data Set';
   footnote1 'Created 09:35 Wednesday, 05SEP2012';
   footnote2' on the WIN System Using SAS 9.3';
run;

 * Notice that the footnotes display the information that the program specified. 
 * This information might not be current.
 */


/*
 * Change the FOOTNOTE statements, as shown below, 
 * so that they contain references to automatic macro variables. 
 * Be sure to change the single quotation marks to double quotation marks 
 * or the macro processor won't be able to resolve these macro variable references.
 */

proc print data=orion.customer_type noobs;
title 'Listing of Customer_Type Data Set';
footnote1 "Created &SYSTIME &SYSDAY, &SYSDATE9"; /*use double quotation marks*/
footnote2 "on the &SYSSCP System Using SAS Release &SYSVER"; /*use double quotation marks*/
run;