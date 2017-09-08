/*
 * Lesson 3.3: Using SYMPUTX with a DATA Step Variable
 * Lesson 2 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating a Macro Variable during DATA Step Execution
 * - Using the CALL SYMPUTX Routine
 * - Using SYMPUTX with a DATA Step Variable
 */

/*The Sales manager wants to see the data for January. 
So, change the value of the macro variable month to 1.*/
%let month=1;
%let year=2011;
 
data orders2;
   keep Order_Date Order_Type Quantity Total_Retail_Price;
   set orion.order_fact end=final;
   where year(Order_Date)=&year and month(Order_Date)=&month;
   
   /* If the value of Order_Type is 3 increment the value of Number by 1 */
   if Order_Type=3 then Number+1;
   /* The footnote needs to include the number of Internet orders 
   placed during the reporting period. 
   Because you don't need conditional logic, 
   remove the IF-THEN/ELSE statements. */
   
   /*use SYMPUTX routine to assign the value of Number to the &num (macro variable) */
   IF final THEN CALL symputx('num', Number);
   
   /* During the last iteration of the DATA step, SAS calls the SYMPUTX routine 
   in order to create the macro variable num. 
   The first argument to SYMPUTX, the character constant, num, 
   is the name of the macro variable. 
   The second argument is the DATA step variable, Number. 
   
   The SYMPUTX routine assigns the value of Number to the macro variable, num. 
   Because Number is a numeric variable and macro variables store text values, 
   SYMPUTX automatically converts the value of Number to character, 
   using the BEST32. format.
   */
   
run;
 
proc print data=orders2;
   title "Orders for &month-&year";
   footnote "&num Internet Orders";
run;

title;
footnote;