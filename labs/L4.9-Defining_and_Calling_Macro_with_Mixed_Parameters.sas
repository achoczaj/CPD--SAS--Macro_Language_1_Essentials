/*
 * Lesson 4.9: Using a Combination of Positional and Keyword Parameters
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Using a Combination of Positional and Keyword Parameters
 */ 

/*
In this demonstration, you use both positional and keyword parameters 
to assign macro variable values for the Count macro.

Reminder: Make sure you've defined the orion library to the location of your practice files. 
For more information, see the Setting Up for Practices section.
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
The statistics options that you need to specify could be different 
every time that you call this macro. 
Therefore, revise the code to use a positional parameter for the macro variable opts. 

For the macro variables start and stop, the date range needed might stay consistent 
for a set of reports. Therefore, leave these keyword parameters with the default values shown.
 */
%macro count(opts,start=01jan11,stop=31dec11);
   proc freq data=orion.orders;
      where Order_Date between "&start"d and "&stop"d;
      table Order_Type / &opts;
      title1 "Orders from &start to &stop";
   run;
   
   title;
%mend count;

/*
Create four calls to the Count macro. 
Turn on the MPRINT option so that you can verify the values of the macro variables.

In the first call, use default values for the parameters.

In the second call, assign the value nocum to the macro variable opts. 
Use the default values for the macro variables start and stop 
by simply omitting those keywords from the macro call.

For the third call, specify a new stop date of 30jun11 
and a new start date of 01apr11. 
Remember that when you call a macro with keyword parameters, 
the parameters can be in any order. 
This time, assign opts a null value by omitting it from the call.

For the fourth call, you'll use both positional and keyword parameters. 
Remember to specify the positional parameters first. 
Specify both nocum and nopercent for the macro variable opts. 
Next, assign the stop macro variable the value 30jun11 
and omit the start macro variable in order to ensure 
that this call to the macro uses the default value for this item.
 */
options mprint;
   %count()
   %count(nocum)
   %count(stop=30jun11, start=01apr11)
   %count(nocum nopercent, stop=30jun11)
   
/*
The second macro call successfully assigns the nocum value 
and suppresses the cumulative statistics columns. 

The third macro call successfully assigns a new value of 30jun11 
to the macro variable stop and 01apr11 to the macro variable start. 

The fourth call successfully suppresses both 
the cumulative frequency and percent columns 
and assigns a new value of 30jun11 to the macro variable stop.
 */