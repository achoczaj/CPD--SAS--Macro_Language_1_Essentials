/*
 * Lesson 4.7: Defining and Calling a Macro with Positional Parameters
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Defining and Calling a Macro with Positional Parameters
 */ 

/*
In this demonstration, you define and call another macro program with positional parameters. 
The macro program Count invokes a PROC FREQ step in which the order date 
will be between the start date and the stop date. 
The start and stop dates are defined by the macro variables start and stop. 
The program also includes a TABLE statement that requests a one-way frequency table 
on Order_Type and optionally could request statistics. 
The statistics are specified using the opts macro variable.

Reminder: Make sure you've defined the Orion library to the location of your practice files. 
For more information, see the Setting Up for Practices section.
 */

%macro count;
   proc freq data=orion.orders;
      where Order_Date between "&start"d and "&stop"d;
      table Order_Type / &opts;
      title1 "Orders from &start to &stop";
   run;
   
   title;
%mend count;
/*
If you used this macro program as is, you'd need to specify 
the values for these three macro variables using 
three %LET statements each time that you call the program. 

You'll use positional parameters to make the code more concise. 
Revise the code so that the Count macro 
specifies three parameters - opts, start, and stop, 
in the %MACRO statement.
 */
options mcompilenote=all

%macro count(opts, start, stop); /*positional parameters*/
   proc freq data=orion.orders;
      where Order_Date between "&start"d and "&stop"d;
      table Order_Type / &opts;
      title1 "Orders from &start to &stop";
   run;
   
   title;
%mend count;

/*
Now call the Count macro and assign values to the macro variables 
that you created by using a parameter list. 
Be sure that you turn on the MPRINT option 
so that you can verify the values of the macro variables.

First, call the Count macro and assign 
the value nocum to the macro variable opts, 
01jan11 to the macro variable start, 
and 31dec11 to stop. 
Ensure that the order of the parameters here matches that in the macro definition.
*/
options mprint;
   %count(nocum, 01jan11, 31dec11)

/*The first macro call successfully executed the frequency procedure 
with the NOCUM option - suppressing the cumulative frequencies and percentages.*/

/*
Create a second macro call in which you assign opts a null value.
 */
options mprint;
   %count(, 01jul11, 31dec11)
/*The second macro call included all FREQ statistics.*/
