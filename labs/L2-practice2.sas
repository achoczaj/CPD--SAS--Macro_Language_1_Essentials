/*
 * Practice 2: Use Macro Character Functions in a Report
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/* Task:
In this practice you use a Dictionary table, dictionary.columns, to create a report that lists the name, type and length of every variable in the orion.country data set.You then use macro variables and the %SUBSTR and %SCAN functions to modify the program to display the variables in any data set.

Reminder: Make sure you've defined the Orion library.
Copy and paste the following code into the editor:
title "Variables in the ORION.COUNTRY data set"; 
proc sql;	
   select name, type, length
      from dictionary.columns
      where libname="ORION" and
      memname="COUNTRY";
quit;
NOTE: The values of Libname and Memname are stored in upper-case in dictionary.columns, so the character literals must also be upper-case.Submit the program; review the log and output.


Modify the program as follows:
Create the macro variable Dsn and assign it the value orion.country. Replace the hard coded data set name, orion.country, with a reference to this new macro variable.
Create two additional macro variables, Lib and Mem. Use the appropriate macro functions to extract the library name from Dsn and assign it to Lib, and then extract the single-level data set name from Dsn and assign it to Mem.
Modify the program so that it references the new macro variables in place of the hard coded values for library name and member name. Remember that the library name and member name must be in upper-case. Do not assume that the value of Dsn will be upper-case.
Be sure to use the macro variable references in the TITLE statement as well.

Submit the program and verify that the results are the same as the results from Step 1.


Modify the program to display the variables in the orion.discount data set instead of orion.country. Submit the program and verify that it displays the variables in orion.discount. Check the output.

Submit the following program to create the work.cities data set.
data cities;
   set orion.city;
   keep city_name country;
run;

Modify the program from Step 4 to display the variables in the most recently created data set. Hint: Use an automatic macro variable. View the results. 
*/

title "Variables in the ORION.COUNTRY data set"; 
proc sql;	
   select name, type, length
      from dictionary.columns
      where libname="ORION" and
      memname="COUNTRY";
quit;


/* Modify 1*/
%let dsn = %upcase(orion.country);
%let lib = %scan(&dsn, 1);
%let mem = %scan(&dsn, 2);
title "Variables in the &lib..&mem data set";

proc sql;
   select name, type, length
   	from dictionary.columns
	where libname="&lib" and memname="&mem";
quit;


/* Modify 2*/
%let dsn = %upcase(orion.discount);
%let lib = %scan(&dsn, 1);
%let mem = %scan(&dsn, 2);
title "Variables in the &lib..&mem data set";

proc sql;
   select name, type, length
   	from dictionary.columns
	where libname="&lib" and memname="&mem";
quit;

/* create the work.cities data set */
data cities;
   set orion.city;
   keep city_name country;
run;


/* Modify 3*/
%let dsn = %upcase(&syslast);
%let lib = %scan(&dsn, 1);
%let mem = %scan(&dsn, 2);
title "Variables in the &lib..&mem data set";

proc sql;
   select name, type, length
   	from dictionary.columns
	where libname="&lib" and memname="&mem";
quit;