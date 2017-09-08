/*
 * Lesson 1.3: Using the %PUT Statement to Display Macro Variable Values
 * Lesson 1 - Introducing Macro Variables
 * SAS Macro Language 1: Essentials
 */
/*
 * Displaying Macro Variables in the SAS Log
 * Using the %PUT Statement to Display Macro Variable Values
 */


/*list the names and values of all user-defined macro variables*/
%PUT _user_;


/* list all macro variables, both user-defined and automatic*/
%PUT _all_;
/*the log also displays a label for each macro variable: 
GLOBAL for user-defined macro variables 
and AUTOMATIC for automatic macro variables */