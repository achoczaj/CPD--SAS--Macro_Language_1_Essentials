/*
 * Lesson 4.1: Define a Macro
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Creating and Using Macro Programs
 * - Define a Macro
 */ 

/*
A macro definition is the container that holds a macro program. 
You begin a macro definition with a %MACRO statement 
and end it with a %MEND statement. 
You are not required to include the macro name in the %MEND statement. 
But if you do, be sure that the two macro names match. 
The text in your macro definition can include constant text, SAS data set names, 
SAS variable names, and SAS statements. 
The text can also include macro variables, macro functions, macro program statements, 
and any combination of the above.

Each macro that you define has a distinct name. 
Choose a name that indicates what the macro does and follow standard SAS naming conventions. 
Avoid SAS language keywords or CALL routine names, as well as words 
that are reserved by the SAS macro facility. 
 */
/*
Let's return to the macro program that you need to create 
that will print the most recently created data set. 

Remember, to define a macro, you begin with the %MACRO statement 
and indicate the name of the macro. 
Let's name the macro Prtlast. 
The text in this macro will consist of a PROC PRINT step. 
Following the keyword, PROC PRINT, you need to specify the data set name. 
Here's a question. What automatic macro variable can you use to specify 
the most recently created data set?

The automatic macro variable SYSLAST stores the name of the most recently 
created data set. Let's use &SYSLAST to provide the data set name 
in our PROC PRINT statement. In addition to specifying the PROC PRINT and RUN statements, 
you can include any other additional SAS statements that are needed. 

In this example, let's specify the number of observations and a TITLE statement. 
You end the definition of the macro Prtlast with a %MEND statement.
 */

%macro prtlast;
    proc print data=&syslast (obs=10);
    	title "Listing of &syslast data set";
	run;
%mend;
