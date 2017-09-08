/*
 * Lesson 4.4: Calling a Macro
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Calling a Macro
 */ 

/*
The final step in creating and using a macro is to call it. 
After you compile a macro, it's available 
for the duration of your SAS session. 
Just as you reference macro variables in order 
to access them in your code, you must call a macro program 
in order to execute it in your SAS program. 

To call, or invoke, a macro, precede the name of the macro 
with a percent sign (%).
 
The call can be made anywhere in a program, except 
within the data lines of a DATA Step statement. 

The macro call requires no semicolon, because it is not a SAS statement. 

The macro call causes the macro to execute. 
 */

/*
For example, to use the Puttime macro you saw in the last demonstration, 
you simply submit the code %puttime. 
Because the Puttime macro includes a %PUT statement, 
SAS will write a note to the log that indicates the current time.
*/

%puttime

/*
Log:
...
94         %puttime
The current time is  1:03:15 PM.
*/