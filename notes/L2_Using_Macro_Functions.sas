/*******************************************************************************

Using Macro Functions - a collection of snippets

from Summary of Lesson 2: Using Macro Functions
SAS Macro Language 1: Essentials

- use macro functions to manipulate text, perform arithmetic operations, and execute SAS functions
- use macro quoting functions

*******************************************************************************/


/*******************************************************************************
1. Overview of Macro Functions
*******************************************************************************/
/* 1.1 Macro functions */
/*
Macro functions enable you to manipulate text strings that SAS inserts in your code.When you submit a program, SAS executes the macro functions before the program compiles.

To use a macro function, specify the function name, which starts with a percent sign. Enclose the function arguments in parentheses, separated by commas.
  %function-name (argument-1<, argument-n>)

The arguments can include:
- constant text (S&P 500),
- macro variable references (&sysdate9),
- macro functions ( %lenght(&var) ),
- and macro calls (%time).
When you use constant text, do not enclose the text in quotation marks.
  %upcase(text-argument)
If you do include them, they'll become part of the argument.

You can use all macro functions in both open code and macro definitions.

Macro functions are categorized in four types:
- macro character functions,
- macro evaluation functions,
- macro quoting functions,
- and other macro functions.
*/

/*******************************************************************************
2. Using Macro Character Functions
*******************************************************************************/
/*
Macro character functions enable you to manipulate character strings or obtain information about them.

/* 2.1 %SUBSTR function */
%SUBSTR extracts a substring of characters from an argument consisting of a character string or text expression. Position specifies where the extraction should begin. n specifies the number of characters to extract. If you don't specify n, the remainder of the string is extracted.
  %SUBSTR (argument, position <, n>)

Question:
What is the value of second_wd after this %LET statement executes?
     %let second_wd = %substr("Four score and seven", 6, 5);

   a.  score
	 b.  and
	 c.  scor (Correct)
	 d.  core

Because the first quotation mark is counted as position 1, score is at position 7. Thus %SUBSTR extracts the space preceding the word score, and the first four characters of score, for a total of five characters. When the value is assigned in a %LET statement, the leading blank is removed.
So the correct answer is scor, without the leading space.
*/

/* 2.2 %SCAN function */
/*
The %SCAN function enables you to extract words from a macro variable or text expression. %SCAN returns the nth word in an argument, where the words in the argument are separated by delimiters. If n is greater than the number of words in the argument, the function returns a null string. Delimiters refers to the characters that separate words or text expressions.
  %SCAN (argument, n <, delimiters>)

If you omit the optional delimiter information, %SCAN uses a default set of delimiters shown below.

Encoding Type	Default Delimiters
ASCII	blank . < ( + & ! $ * ) ; ^ - / , % |
EBCDIC	blank . < ( + | & ! $ * ) ; ¬ - / , % ¦ ¢

Code Challenge:
As shown in the global symbol table below, the value of the macro variable location is composed of multiple words that are separated by asterisks. Write a statement that extracts the second word from location, and assigns this value to a new macro variable named area2.
------------------------------------------------------
Global Symbol Table
location -->	Southeast*Southwest*Northeast*Northwest
------------------------------------------------------
The correct answer is:
  %let area2=%scan(&location,2,*);

You specify the keyword %LET and the macro variable name area2 in order to create the new macro variable. To obtain the second word from the value of location, you use the %SCAN function. Specify n as 2 and the delimiter as an asterisk.
*/

/* 2.3 %UPCASE function */
/*
The %UPCASE function enables you to convert characters to uppercase before substituting that value in a SAS program.
  %UPCASE (argument)

Code Challenge:
Complete the following FOOTNOTE statement, ensuring that the value of the macro variable month will be inserted in uppercase even if the stored value is lowercase or mixed case.
  footnote "CLASSES OFFERED IN ... ";
The correct answer is:
  footnote "CLASSES OFFERED IN %upcase(&month)";
Use the %UPCASE function with the reference to month. Be sure to precede month with an ampersand.
*/

/* 2.4 %INDEX function */
/*
The %INDEX function enables you to search for a string within a source. %INDEX searches source for the first occurrence of string and returns the position of its first character. If an exact match of string is not found, the function returns 0.
  %INDEX (source, string)

Question:
What will be written to the SAS log when you submit the following %INDEX statement?
  %let a=a very long value;
  %let b=%index(&a,v);
  %put V appears at position &b;

a.  V appears at position 2
b.  V appears at position 3 (Correct)
c.  None of the above

The %INDEX function finds the text string v beginning at position 3.

*/

/*******************************************************************************
3. Using Arithmetic and Logical Expressions
*******************************************************************************/
/* 3.1 %EVAL function */
/*
The %EVAL function evaluates arithmetic and logical expressions.
  %EVAL (arithmetic or logical expression)

  Arithmetic Expressions	|  Logical Expressions
  1 + 2	                  |  &DAY = FRIDAY
  4 * 3	                  |  A < a
  4 / 2	                  |  1 < &INDEX
  00FFx - 003Ax	          |  &START NE &END

3.1.1. %EVAL (arithmetic expression)
When %EVAL evaluates an arithmetic expression, it temporarily converts operands to numeric values and performs an integer arithmetic operation.

If the result of the expression is noninteger, %EVAL truncates the value to an integer. The result is expressed as text.
  %let x = %eval(5,3);
  %put x=&x
  /*result 1*/

The %EVAL function generates an error message in the log when it encounters an expression that contains noninteger values.

3.1.2. %EVAL (logical expression)
When %EVAL evaluates a logical expression, it returns a value of 0 to indicate that the expression is false, or a value of 1 to indicate that the expression is true.
  %let x = %eval(10 lt 2); /*10 less than 2*/
  /*The expression is false*/
  %put x=&x
  /*result 0*/

Code Challenge
Use the %EVAL function to complete the following statement and compute the final year of a range that begins with the value of firstyr and continues for the value of numyears.

     %let firstyr = 2000;
     %let numyears = 2;
     %let finalyr =...

The correct answer is:
    %let finalyr = %eval(&firstyr + &numyears - 1);

You use the %EVAL function and enclose the arithmetic expression in parentheses. You must subtract 1 from the sum of &firstyr and &numyears to correctly calculate the range of years. For example, if &firstyr is 2008 and &numyears is 3, the range includes the 3 years 2008, 2009 and 2010.

*/

/* 3.2 %SYSEVALF function */
/*
The %SYSEVALF function evaluates arithmetic and logical expressions using floating-point arithmetic and returns a value that is formatted using the BEST32. format. The result of the evaluation is always text.

%SYSEVALF (expression <, conversion-type>)

You can use %SYSEVALF with an optional conversion type (BOOLEAN, CEIL, FLOOR, or INTEGER) that tailors the value returned by %SYSEVALF.

Question


What result will SAS write to the log when you submit the following statements?
   %let b=%sysevalf(10.5+20.8);
   %put 10.5+20.8 = &b;

ANSWER:
   10.5+20.8 = 30
*/

/*******************************************************************************
4. Using SAS Functions with Macro Variables
*******************************************************************************/
/* 4.1 %SYSFUNC macro function */
/*
You can use the %SYSFUNC macro function to execute SAS functions within the macro facility.
  %SYSFUNC (SAS-function(argument(s)) <, format>)

Because %SYSFUNC is a macro function, you don't enclose character values in quotation marks, as you do in SAS functions. You can specify an optional format for the value returned by the function. If you do not specify a format, numeric results are converted to a character string using the BEST12. format. SAS returns character results as they are, without formatting or translation.

You can use almost any SAS function with the %SYSFUNC macro function. The exceptions are shown in this table.

Function Type	- Function Name
Array processing	- DIM, HBOUND, LBOUND
Variable information	- VNAME, VLABEL, MISSING
Macro interface	- RESOLVE, SYMGET
Data conversion	- INPUT, PUT*
Other functions	- ORCMSG, LAG, DIF

*Use INPUTC and INPUTN in place of INPUT, and PUTC and PUTN in place of PUT.

Code Challenge
Write a statement that assigns the value of the current time to the macro variable current. Use the TIME. format for the value.
Hint: Use the TIME() function to obtain the current time.
The correct answer is
  %let current = %sysfunc(time(), time.);
You specify the keyword %LET, followed by the macro variable name. Then, you use the %SYSFUNC function to invoke the TIME function and format the result using the TIME. format.
*/

/*******************************************************************************
5. Using Macro Functions to Mask Special Characters
*******************************************************************************/
/* 5.1 Macro quoting functions */
/*
Macro quoting functions enable you to clearly indicate to the macro processor how it is to interpret special characters and mnemonics.

/* 5.2 %STR macro quoting function */
The macro quoting function %STR masks (or quotes) special characters during compilation so that the macro processor does not interpret them as macro-level syntax.
  %STR (argument)

%STR can also be used to quote tokens that typically occur in pairs, such as the apostrophe, quotation marks, and open and closed parentheses. The unmatched token must be preceded by a %.

Here is a list of all of the special characters and mnemonics masked by %STR.
  + - * / < > = ¬ ^ ~ ; , # blank
  AND OR NOT EQ NE LE LT GE GT IN
  ' " ) (

Note that %STR does not mask the characters & or %.

/* 5.3 %NRSTR macro quoting function */
%NRSTR masks the same characters as %STR and also masks the special characters & and %. Using %NRSTR instead of %STR prevents macro and macro variable resolution.
  %NSTR (argument)


Code Challenge:
Write a statement that will write the following text string to the log:
  This is the result of %NRSTR;
The correct answer is
  %put This is the result of %nrstr(%nrstr);
You specify the function %NRSTR to mask the % sign at compilation, so that the macro processor does not try to invoke %NRSTR a second time. If you did not use %NRSTR to mask the string %NRSTR, it would be interpreted as another call to the %NRSTR function, and SAS would issue a warning about a missing open parenthesis for the function.
*/

/*******************************************************************************
  Sample Programs
*******************************************************************************/

/* 1. Manipulating Character Strings Using Macro Functions */
%let dsn = orion.orders;
%let var = order_date;
%let name = %scan(&dsn, 2, .);
%let startYear = 2009;
%let curr_year = %substr(&sysdate9, 6);
/*SYSDATE9 --. 19Jun2017 or SYSDATE --. 19Jun17*/

data &name;
   set &dsn;
   where &startYear <= year(&var) <= &curr_year;
run;

title "Listing of %upcase(&name) Data for
       &startYear-&curr_year";
proc print data=&syslast;
run;


/* 2. Using %INDEX to Search for a Substring */
%let sitelist=DALLAS SEATTLE BOSTON;
%let value=%index(&sitelist,LA);


/* 3. Using %EVAL to Evaluate an Arithmetic Expression
Please note: the following programs are provided as examples. Please be aware that because the data in the Orion library does not include current dates, programs that rely on the SYSDATE9 macro variable will not produce results as written. */
%let thisyr=%substr(&sysdate9,6);
%let lastyr=%eval(&thisyr-1);

proc means data=orion.order_fact maxdec=2 min max mean;
   class order_type;
   var total_retail_price;
   where year(order_date) between &lastyr and &thisyr;
   title1 "Orders for &lastyr and &thisyr";
   title2 "(as of &sysdate9)";
run;

/* 4. Using %SYSEVALF to Evaluate an Arithmetic Expression That Includes a Noninteger */

%let a = 100;
%let b = 1.59;
%let y = %sysevalf(&a+&b);

%put The result with SYSEVALF is: &y;
%put BOOLEAN conversion: %sysevalf(&a +&b, boolean);
%put CEIL conversion: %sysevalf(&a +&b, ceil);
%put FLOOR conversion: %sysevalf(&a +&b, floor);
%put INTEGER conversion: %sysevalf(&a +&b, integer);

/* 5. Using %SYSFUNC to Execute SAS Functions */
title1 "Report Produced on %sysfunc(today(),weekdate.)";
title2 "at %sysfunc(time(),timeAMPM8.)";

/* 6. Using %STR to Mask Special Characters */
%let statement=%nrstr(title "S&P 500";);
