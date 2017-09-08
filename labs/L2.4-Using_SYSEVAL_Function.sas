/*
 * Lesson 2.4: Using the %SYSEVAL Function
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/*
 * Using Arithmetic and Logical Expressions
 * 1. Using the %SYSEVAL Function
 */

/*
 * The %SYSEVALF function evaluates arithmetic and logical expressions 
 * using floating-point arithmetic and returns a value 
 * that is formatted using the BEST32. format. 
 * The result of the evaluation is always text.
 * 
 * Syntax:
 * %SYSEVALF (arithmetic-or-logical-expression <, conversion-type>)
 * After the keyword %SYSEVALF, you specify the arithmetic or logical expression, 
 * followed by an optional conversion type (BOOLEAN, CEIL, FLOOR, or INTEGER). 
 * These conversion types tailor the value returned by %SYSEVALF 
 * so that it can be used in other macro expressions 
 * that require integer or Boolean values. 
 * Be sure to choose the correct option for your data, 
 * in order to prevent errors or unexpected results.
 */

/*
Suppose you need to use an expression 
that contains noninteger values. As you've seen, 
the %EVAL function generates an error message 
in the log when it encounters an expression 
that contains noninteger values. 

You can use the %SYSEVALF function to avoid these error messages. 
*/ 

OPTIONS SYMBOLGEN;

%let a = 100;
%let b = 1.59;
%let y = %sysevalf(&a+&b);

%put The result with SYSEVALF is: &y;
%put BOOLEAN conversion: %sysevalf(&a +&b, boolean);
%put CEIL conversion: %sysevalf(&a +&b, ceil);
%put FLOOR conversion: %sysevalf(&a +&b, floor);
%put INTEGER conversion: %sysevalf(&a +&b, integer);

 