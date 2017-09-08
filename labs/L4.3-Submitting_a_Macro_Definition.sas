/*
 * Lesson 4.3: Submitting a Macro Definition
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Creating and Using Macro Programs
 * - Submitting a Macro Definition
 */ 

/*
In this demonstration, you submit a macro definition 
and view the temporary catalog work.sasmacr. 
(Remember that if you are working in SAS Studio, 
your macro definitions might be stored 
in the temporary catalog work.sasmac1 instead.)

Reminder: Make sure you've defined the Orion library 
to the location of your practice files. For more information, 
see the Setting Up for Practices section.
 */

options mcompilenote=all;

%macro puttime;
   %put The current time is %sysfunc(time(),timeampm.).;
%mend puttime;

/*
Now let's check the log. 
The log indicates that the macro Puttime 
completed compilation without errors. 
This macro is now available for use at any time during this SAS session.
 */


/*
 * Let's check that our macro has been stored as expected 
 * in the temporary catalog work.sasmac1.
 */

/*
To see a list of temporary macros, we use the PROC CATALOG step. 
We specify the keyword, PROC CATALOG, 
followed by the name of the catalog 
and then a CONTENTS statement. 
Let's also include a title for our report.
 */

proc catalog cat=work.sasmac1;
   contents;
   title "My Temporary Macros";
quit;

title;

/*
It shows the macro name - Puttime, 
as well as the type - macro, 
and the date and time when it was created.

 */
