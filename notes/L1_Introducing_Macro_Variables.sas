/*******************************************************************************

Introducing Macro Variables - a collection of snippets

from Summary of Lesson 1: Introducing Macro Variables
SAS Macro Language 1: Essentials

- describe what macro variables store and where macro variables are stored
- identify selected automatic macro variables
- create user-defined macro variables
- display macro variables in the SAS log
- identify tokens in a SAS program
- place a macro variable reference adjacent to text or another macro variable reference

*******************************************************************************/


/*******************************************************************************
1. Basic Concepts
*******************************************************************************/
/*  */
/*
Macro variables substitute text into your SAS programs. The macro facility enables you to create and resolve macro variables anywhere within a SAS program.

Macro variables can supply operating system information, SAS session information, user-defined values, complete or partial SAS steps, and complete or partial SAS statements.

There are two types of macro variables: automatic macro variables, which SAS provides, and user-defined macro variables, which you create and define.

The values of automatic macro variables are stored in the global symbol table, meaning that these values are always available in your SAS session. The values of user-defined macro variables are often stored in the global symbol table as well.

To substitute the value of a macro variable into your program, you must reference the macro variable in your code. You precede the macro variable name with an ampersand. The macro processor does its work before the program compiles and executes.
  %LET macro-variable = value;

*/
/* 1.2 Automatic macro variables */
/*
If you need to reference a macro variable within quotation marks, such as in a title, you must use double quotation marks.

Automatic macro variables contain system information such as the date and time that the current SAS session began. Some automatic macro variables have fixed values that SAS defines when the session starts. This table shows several common automatic macro variables:
Name	- Description	- Example:
SYSDATE	- date when the current SAS session began (DATE7.)	- 16JAN13
SYSDATE9	- date when the current SAS session began (DATE9.)	- 16JAN2013
SYSDAY	- day of the week when the current SAS session began	- Friday
SYSSCP	- abbreviation for the operating system being used	- OS, WIN, HP 64
SYSTIME	- time that the current SAS session began	- 13:39
SYSUSERID	- the user ID or login of the current SAS process	- MyUserid
SYSVER	- release of SAS software being used	- 9.4

Other automatic macro variables have values that change automatically, based on the SAS statements that you submit.
Name - Description:
SYSLAST	- Name of the most recently created data set in the form libref.name. If no data set has been created, the value is _NULL_.
SYSPARM	- Value specified at SAS invocation
SYSERR	- SAS DATA or PROC step return code (0=success)
SYSLIBRC - LIBNAME statement return code (0=success)


Example:
  proc print data=orion.customer_type noobs;
    title 'Listing of Customer_Type Data Set';
    footnote1 "Created &SYSTIME &SYSDAY, &SYSDATE9"; /*use double quotation marks*/
    footnote2 "on the &SYSSCP System Using SAS Release &SYSVER"; /*use double quotation marks*/
  run;


Code Challenge:
Write a FOOTNOTE statement, using the automatic macro variable that stores the name of the most recently created data set. Use this text for your footnote: Data taken from data set

The correct answer is:
  footnote "Data taken from &syslast";
You specify the keyword FOOTNOTE followed by the footnote text. The text must be enclosed in double quotation marks. SYSLAST is the automatic macro variable that stores the name of the most recently created data set.
*/

/*******************************************************************************
2. Creating User-Defined Macro Variables
*******************************************************************************/
/* 2.1 Create a User-Defined Macro Variable */
/*
You use the %LET statement to create a macro variable and assign a value to it. After the keyword %LET, you specify the name of the macro variable, an equal sign, and then the value of the macro variable. %LET statements are valid anywhere in a SAS program.
  %LET level = expert;

Macro variable names start with a letter or an underscore and can be followed by letters, digits, or underscores.

You don't enclose the value of the macro variable in quotation marks. Everything that appears between the equal sign and the semicolon is part of the macro variable value.

You can assign any name to a macro variable as long as the name is not a reserved word.

The prefixes AF, DMS, SQL, and SYS are not recommended because they are frequently used in SAS software when creating macro variables. If you assign a macro variable name that isn't valid, SAS writes an error message to the log.

SAS assigns values to macro variables in the %LET statement. SAS does the following:
- stores all macro variable values as text strings, even if they contain only numbers
- doesn't evaluate mathematical expressions in macro variable values
- stores the value in the case that is specified in the %LET statement
- stores quotation marks as part of the macro variable value
- removes leading and trailing blanks from the macro variable value before storing it
- SAS doesn't remove blanks within the macro variable value.
*/

/* 2.2  Referencing a User-Defined Macro Variable*/
/*
To reference a user-defined macro variable, you precede the name of the macro variable with an ampersand. When you submit the program, the macro processor resolves the reference and substitutes the macro variable's value before the program compiles and executes.
 &macro-variable-name

*/

/* 2.3 Deleting User-Defined Macro Variables */
/*
Macro variables remain in the global symbol table until they are deleted or the session ends. To delete variables, you use the %SYMDEL statement. You specify the keyword, %SYMDEL, followed by the name or names of the macro variables that you want to delete.
 %SYMDEL macro-variables;

When you delete a user-defined macro variable, the memory that's used to store the variable is released.

  %SYMDEL level ordertype;

*/
/*******************************************************************************
3. Displaying Macro Variables in the SAS Log
*******************************************************************************/
/*
There are several methods that you can use to display the values of macro variables in the SAS log.

/* 3.1 Using the %PUT Statement */
You can use the %PUT statement to write your own messages, including macro variable values, to the SAS log.
The macro variable references are resolved before the %PUT statement executes. %PUT statements are valid anywhere in a SAS program.
  %PUT <text>;

Example:
Suppose you want to verify the value of the macro variable city.
  %PUT &city;

The %PUT statement writes only to the SAS log and always writes to a new log line, starting in column one.

You can follow the keyword, %PUT, with optional text. Explanatory text in your %PUT statements can help maintain clarity in the SAS log.

Example:
Follow the keyword, %PUT, with optional text.
  %PUT The value of the macro var city is: &city;
You might find that it helps to add explanatory text to your %PUT statements in order to maintain clarity in the SAS log. This statement writes a message to the SAS log followed by the value of the macro variable.


Beginning with SAS 9.3, you can also identify a macro variable's value by using the syntax shown here:
  %PUT &= followed by the macro variable name.
This form of the %PUT statement writes the macro variable's name, an equal sign, and its value to the SAS log.
  Log:
  ...
  54  %PUT &=city;
  CITY=Paris


You can add one of the following optional arguments to the %PUT statement:
  %PUT <text | _ALL_ / _AUTOMATIC_ / _USER_>;

Argument	- Result in the SAS Log
_ALL_	- lists the values of all macro variables
_AUTOMATIC_	- lists the value of all automatic macro variables
_USER_	- lists the values of all user-defined macro variables


/* 3.2 Using the SYMBOLGEN system option */
You can also use the SYMBOLGEN system option to display the values of macro variables.
  OPTIONS SYMBOLGEN | NOSYMBOLGEN;

The default option is NOSYMBOLGEN. When you turn the SYMBOLGEN system option on, SAS writes macro variable values to the SAS log as they are resolved. The message states the macro variable name and the resolved value.

Because SYMBOLGEN is a system option, its setting remains in effect until you modify it or until you end your SAS session.

*/
/*******************************************************************************
4. Processing Macro Variables
*******************************************************************************/
/* 4.1 Understanding SAS Processing */
/*
When you submit a SAS program, it's copied to an area of memory called the input stack.

The word scanner reads the text in the input stack, character-by-character, left-to-right, and top-to-bottom. The word scanner breaks the text into fundamental units, called tokens, and passes the tokens, one at time, to the appropriate compiler upon demand.

The compiler requests tokens until it receives a semicolon and then performs a syntax check on the statement. The compiler repeats this process for each additional statement.

SAS suspends compilation when a step boundary is encountered. Step boundaries include a RUN statement or the beginning of a new DATA or PROC step. If there are no compilation errors, SAS executes the compiled code. This process is repeated for each program step.

A token is the fundamental unit that the word scanner passes to the compiler. The word scanner recognizes the four classes of tokens shown in the table below.

Class	Description	Example
name	a character string that begins with a letter or underscore and continues with underscores, letters, or numerals
infile   _n_
dollar10.2
special	any character, or combination of characters, other than a letter, numeral, or underscore
* / + ** ; $
( ) . & %
literal	a string of characters enclosed in single or double quotation marks
'Report for May'
"Sydney Office"
number	integer numbers, including SAS date constants or floating point numbers, that contain a decimal point and/or an exponent
23   109
5e8   42.7 '01jan2012'd

%LET statements and macro variable references are part of the macro language. The macro processor is responsible for handling all macro language elements.
  %name-token

  &name-token

Certain token sequences, known as macro triggers, alert the word scanner that the subsequent code should be sent to the macro processor. The word scanner recognizes the following token sequences as macro triggers and passes the code to the macro processor for evaluation:

a percent sign followed immediately by a name token (such as %LET)
an ampersand followed immediately by a name token (such as &Amount)
The macro processor requests tokens until a semicolon is encountered.

A macro variable reference triggers the macro processor to search the symbol table for the reference. The macro processor resolves the macro variable reference by replacing it with the value in the symbol table.
Combining Macro Variable References with Text
You can reference macro variables anywhere in your program. Some situations might require you to place a macro variable reference adjacent to leading text or trailing text. You might need to reference a macro variable between text or perhaps even adjacent macro variables.

When you combine macro variable references and text, remember how SAS interprets tokens. A token ends when the word scanner detects either the beginning of a new token or a blank after a token.

You can place text immediately before a macro variable reference.

You can also reference adjacent macro variables.

You can place text immediately after a macro variable reference as long as the macro variable name can still be tokenized correctly.

*/
/*******************************************************************************
  Sample Programs
*******************************************************************************/
/*

1. Referencing a Macro Variable
data new;
   set orion.sales;
   where salary > &amount;
run;

title "Total Sales for &country";

2. Using Automatic Macro Variables
proc print data=orion.customer_type;
   title "Listing of Customer_Type Data Set";
   footnote1 "Created &SYSTIME &SYSDAY, &SYSDATE9";
   footnote2 "on the &SYSSCP System Using SAS &SYSVER";
run;

3. Creating and Referencing a User-Defined Macro Variable
%let year=2011;

proc print data=orion.order_fact;
   where year(order_date)=&year;
   title "Orders for &year";
run;

proc means data=orion.order_fact mean;
   where year(order_date)=&year;
   class order_type;
   var total_retail_price;
   title "Average Retail Price for &year";
   title2 "by Order_Type";
run;

4. Using the %PUT Statement
%put The value of the macro variable City is: &city;

5. Placing Text before a Macro Variable Reference
%let month=jun;
proc chart data=temp.y2011&month;
   hbar week / sumvar=sale;
run;
proc plot data=temp.y2013&month;
   plot sale*day;
run;

6. Referencing Adjacent Macro Variables
%let year=2011;
%let month=jun;
proc chart data=temp.y&year&month;
     hbar week / sumvar=sale;
run;
proc plot data=temp.y&year&month;
   plot sale*day;
run;

7. Placing Text after a Macro Variable Reference
%let year=2011;
%let month=jun;
%let var=sale;
proc chart data=temp.y&year&month;
   hbar week / sumvar=&var;
run;
   proc plot data=temp.y&year&month;
plot &var*day;
run;

8. Working with Values That Contain Delimiters
/*GRAPHICS should be null or G*/
%let lib=temp;
%let graphics=g;
%let year=2011;
%let month=jun;
%let var=sale;
proc &graphics.chart data=&lib..y&year&month;
   hbar week / sumvar=&var;
run;
proc &graphics.plot data=&lib..y&year&month;
   plot &var*day;
run;
