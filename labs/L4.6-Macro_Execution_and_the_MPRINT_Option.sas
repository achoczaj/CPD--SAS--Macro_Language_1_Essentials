/*
 * Lesson 4.6: Macro Execution and the MPRINT Option
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Macro Execution and the MPRINT Option
 */ 

/*
n this demonstration, you call the Prtlast macro 
with the MPRINT option enabled. 

Prtlast stores a PROC PRINT step that prints a data set 
defined by the macro variable dsn. 
The macro variable vars assigns the variables 
that will be included in the output.

Reminder: Make sure you've defined the Orion library to the location of your practice files. For more information, see the Setting Up for Practices section.
 */

/* 1. compile the macro*/
%macro prtlast;
   proc print data=&dsn;
      var &vars;
   run;
   
   title;
%mend;


/* 2. assign values to dsn and vars*/
%let dsn=orion.city;
%let vars=City_Name Country;

/* 3.set the MPRINT option*/
options mprint;
/*MPRINT option writes to the log the text that is sent to the compiler.*/
%prtlast

/*
Log:
...
66         %prtlast
 MPRINT(PRTLAST):   proc print data=orion.city;
 MPRINT(PRTLAST):   var City_Name Country;
 MPRINT(PRTLAST):   run;
 */
/*
The log indicates that SAS ran the PROC PRINT step stored 
in the Prtlast macro as expected. 
Because you specified the MPRINT option, 
SAS wrote the PROC PRINT code itself to the log. 

Notice that the macro variable references for dsn and vars 
are resolved in the MPRINT messages.
 */