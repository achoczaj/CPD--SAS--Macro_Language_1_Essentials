/*
 * Lesson 4.8: Defining and Calling a Macro with Keyword Parameters
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Defining and Calling a Macro with Keyword Parameters
 */ 

/*
In this demonstration, you use keyword parameters 
to assign macro variable values for the Count macro.

Reminder: Make sure you've defined the Orion library to the location of your practice files. 
For more information, see the Setting Up for Practices section.
 */

%macro count(opts, start, stop);
   proc freq data=orion.orders;
      where Order_Date between "&start"d and "&stop"d;
      table Order_Type / &opts;
      title1 "Orders from &start to &stop";
   run;
   
   title;
%mend count;

/*
Specify three keyword parameters in the %MACRO statement: opts, start, and stop.

Assign a default value of null to the macro variable opts.
Assign default values of 01jan11 to the macro variable start and 31dec11 to stop.
 */
%macro count(opts=,start=01jan11,stop=31dec11);
   proc freq data=orion.orders;
      where Order_Date between "&start"d and "&stop"d;
      table Order_Type / &opts;
      title1 "Orders from &start to &stop";
   run;
        
   title;
%mend count;

/*
Create three calls to the Count macro. 
Turn on the MPRINT option so that you can verify the values of the macro variables.

In the first call, use default values for the parameters.

In the second call, assign the value nocum to the macro variable opts. 
Use the default values for the macro variables start and stop 
by simply omitting those keywords from the macro call.

For the third call, specify a new stop date of 01jul11 
and specify both nocum and nopercent for the macro variable opts. 
Remember, when you call a macro with keyword parameters, the parameters can be in any order.
 */
options mprint;
   %count()
   %count(opts=nocum)
   %count(stop=01jul11, opts=nocum nopercent)