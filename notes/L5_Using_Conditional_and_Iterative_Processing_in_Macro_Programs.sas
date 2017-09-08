/*******************************************************************************

Using Conditional and Iterative Processing in Macro Programs - a collection of snippets

from Summary of Lesson 5: Using Conditional and Iterative Processing in Macro Programs
SAS Macro Language 1: Essentials

- conditionally process SAS code within a macro program
- monitor macro execution
- insert entire steps, entire statements, and partial SAS statements into a SAS program
- execute macro language statements iteratively
- generate SAS code iteratively

*******************************************************************************/


/*******************************************************************************
1. Processing Statements Conditionally
*******************************************************************************/
/* 1.1  */
/*
Processing Statements Conditionally
You can use %IF-%THEN and %ELSE statements to perform conditional processing in a macro program.

%IFexpression %THEN text;
<%ELSE text;>

You specify the keyword %IF followed by an expression. The expression can be any valid macro expression that resolves to an integer. Then, you specify the keyword %THEN followed by some text. The text can be a SAS constant, a text expression, a macro variable reference, a macro call, or a macro program statement.

The %ELSE statement is optional. If you use it, you specify the keyword %ELSE followed by some text. The text in a %ELSE statement can also be a SAS constant, a text expression, a macro variable reference, a macro call, or a macro program statement.

If the expression following %IF resolves to zero, the expression is false and the %THEN text isn’t processed. If you include an optional %ELSE statement, that text is processed instead of the %THEN text.

If the expression resolves to any integer other than zero, then the expression is true and the %THEN text is processed. If the expression resolves to null or to any noninteger value, SAS issues an error message.

There are several important differences between the macro %IF-%THEN statement and the DATA step IF-THEN statement.

%IF-%THEN
is used only in a macro program
executes during macro execution
uses macro variables in logical expressions and cannot refer to DATA step variables in logical expressions
determines what text should be copied to the input stack
IF-THEN
is used only in a DATA step program
executes during DATA step execution
uses DATA step variables in logical expressions
determines what DATA step statement(s) should be executed

Macro expressions are similar to SAS expressions in the following ways:
• They use the same arithmetic, logical, and comparison operators as SAS expressions.
• They are case sensitive.
• Special WHERE operators are not valid.

Macro expressions are dissimilar to SAS expressions in the following ways:
• Character operands are not quoted.
• Expressions in which comparison operators surround a macro expression might resolve with unexpected results.

The MLOGIC option prints messages that indicate macro actions that were taken during macro execution.

OPTIONS MLOGIC | NOMLOGIC;

When the MLOGIC system option is in effect, the messages that SAS displays in the log include information about the following:
• the beginning of macro execution
• the values of any parameters
• the results of arithmetic and logical macro operations, and
• the end of macro execution.

When you're working with a program that uses SAS macro language, you should typically turn the MLOGIC option, along with the MPRINT option and the SYMBOLGEN option
• on for development and debugging purposes
• off when the program is in production mode.

You can use %DO and %END statements along with a %IF-%THEN statement to generate code that contains semicolons.

%IF expression %THEN %DO;
           text and/or macro language elements;
%END;
%ELSE %DO;
           text and/or macro language elements;
%END;


The syntax for using %DO and %END statements with a %IF-%THEN statement is shown here. The keyword %DO follows the keyword %THEN. You must pair each %DO statement with a %END statement. Between the %DO and the %END keywords, you insert one or more statements that contain constant text, text expressions, or macro statements.

The %INCLUDE statement retrieves SAS source code from an external file and places it on the input stack.

%INCLUDE file-specification </SOURCE2 >;

To use the %INCLUDE statement, you specify the keyword %INCLUDE , followed by a file specification. The file-specification value is the physical name or fileref of the file to be retrieved.

You can optionally specify SOURCE2 following the file specification. SOURCE2 causes the SAS statements that are inserted into the input stack to be displayed in the SAS log. If you don't specify SOURCE2 in the %INCLUDE statement, the setting of the SAS system option SOURCE2 controls whether the inserted code is displayed.

The %INCLUDE statement is a global SAS statement, not a macro language statement, and it can be used only on a statement boundary.
*/


/*******************************************************************************
2. Using Conditional Processing to Validate Parameters
*******************************************************************************/
/* 2.1  */
/*
You can use the comparison operator IN to search for character and numeric values that are equal to one from a list of values. You can also use the IN operator when you evaluate arithmetic or logical expressions during macro execution.

%MACRO macro-name <(parameter-list) ></MINOPERATOR | NOMINOPERATOR;

To use the macro IN operator, you use the MINOPERATOR option with the %MACRO statement, preceded by a slash.

Then you can use the macro IN operator to modify the %IF statement. The macro IN operator is similar to the SAS IN operator, but it doesn't require parentheses.

If you use NOT with the IN operator, NOT must precede the IN expression and parentheses are required around the expression.

You can use the PROC SQL INTO clause with the SEPARATED BY argument to create a macro variable that contains a list of unique values. You can combine PROC SQL with conditional processing to validate the parameters in a macro.
*/

/*******************************************************************************
3. Processing Statements Iteratively
*******************************************************************************/
/* 3.1 Iterative %DO statement*/
/*
With the iterative %DO statement, you can repeatedly execute macro programming code and generate SAS code.

%DO index-variable=start %TO stop <%BY increment>;
           text and/or macro language elements;
%END;

The general form of the iterative %DO statement is shown here. You specify the keyword %DO followed by an index variable. The index-variable value names a local variable.

The values for start, stop, and increment must be integers or macro expressions that resolve to integer values.

The %BY clause is optional. Increment specifies either an integer (other than 0) or a macro expression that generates an integer to be added to the value of the index variable in each iteration of the loop. By default, the increment is 1.

The text enclosed in the %DO loop can be constant text, macro variables, macro expressions, macro statements, or macro calls.

A %END statement ends the iterative loop. %DO and %END statements are valid only inside a macro definition.

You can also use an iterative %DO statement to generate a complete SAS step within a macro loop.

A macro %DO loop is often used to generate data-dependent code. For example, you can use an iterative %DO loop to create subsets of an existing data set based on the value of a variable in the data set.
*/

/*******************************************************************************
  Sample Programs
*******************************************************************************/
/* 1. Processing Statements Conditionally */
/*
Please note: the following programs are provided as examples. Please be aware that because the data in the Orion library does not include current dates, programs that rely on the SYSDATE9 macro variable will not produce results as written.*/

options mcompilenote=all;

%macro daily;
proc print data=orion.order_fact;
   where order_date="&sysdate9"d;
   var product_id total_retail_price;
   title "Daily sales: &sysdate9";
run;
%mend;

%macro weekly;
proc means data=orion.order_fact n sum mean;
   where order_date between "&sysdate9"d - 6
                             and "&sysdate9"d;
   var quantity total_retail_price;
   title "Weekly sales: &sysdate9";
run;
%mend;

%macro reports;
   %daily;
   %if &sysday=Friday %then %weekly;
%mend reports;

options mlogic;
%reports

/***************************************/

%macro reports;
   proc print data=orion.order_fact;
      where order_date="&sysdate9"d;
      var product_id total_retail_price;
      title "Daily sales: &sysdate9";
   run;
%if &sysday=Friday %then %do;
   proc means data=orion.order_fact n sum mean;
      where order_date between "&sysdate9"d - 6 and "&sysdate9"d;
      var quantity total_retail_price;
      title "Weekly sales: &sysdate9";
   run;
%end;
%mend reports;

options mlogic;
%reports

/***************************************/

%macro reports;
   %include 'c:\mysasfile\daily.sas';
   %if &sysday=Friday %then %do;
      %include 'c:\mysasfiles\weekly.sas';
   %end;
%mend reports;

/***************************************/

%macro count(type=,start=01jan2011,stop=31dec2011);
   proc freq data=orion.order_fact;
      where order_date between "&start"d and "&stop"d;
      table quantity;
      title1 "Orders from &start to &stop";
      %if &type= %then %do;
         title2 "For All Order Types";
      %end;
      %else %do;
         title2 "For Order Type &type Only";
         where same and order_type=&type;
      %end;
   run;
%mend count;

options mprint mlogic;

%count()
%count(type=3)

/***************************************/

%macro counts(rows);
   title 'Customer Counts by Gender';
   proc freq data=orion.customer_dim;
      tables
   %if &rows ne %then &rows *;
      customer_gender;
   run;
%mend counts;

%counts()
%counts(customer_age_group)


/* 2. Using Conditional Processing to Validate Parameters */
%macro customers(place) / minoperator;
   %let place=%upcase(&place);
   proc sql noprint;
      select distinct country into :list separated by ' '
         from orion.customer;
   quit;
   %if &place in &list %then %do;
      proc print data=orion.customer;
         var customer_name customer_address country;
         where upcase(country)="&place";
         title "Customers from &place";
      run;
   %end;
   %else %do;
      %put Sorry, no customers from &place..;
      %put Valid countries are: &list..;
   %end;
%mend customers;


/* 3. Processing Statements Iteratively */
data _null_;
   set orion.country end=no_more;
   call symputx('Country'||left(_n_),country_name);
   if no_more then call symputx('numrows',_n_);
run;

%macro putloop;
   %do i=1 %to &numrows;
      %put Country&i is &&country&i;
   %end;
%mend putloop;

%putloop

/***************************************/

%macro read(first=2007,last=2011);
   %do year=&first %to &last;
      data year&year;
         infile "orders&year..dat";
         input order_ID order_type order_date : date9.;
      run;
   %end;
%mend read;

/***************************************/

%macro printlib(lib=WORK);
   %let lib=%upcase(&lib);
   data _null_;
      set sashelp.vstabvw end=final;
      where libname="&lib";
      call symputx('ds'||left(_n_),memname);
      if final then call symputx('totaldsn',_n_);
   run;
   %put _local_;
%mend printlib;

/***************************************/

%macro printlib(lib=WORK,obs=5);
   %let lib=%upcase(&lib);
   data _null_;
      set sashelp.vstabvw end=final;
      where libname="&lib";
      call symputx('ds'||left(_n_),memname);
      if final then call symputx('totaldsn',_n_);
   run;
   %do i=1 %to &totaldsn;
      proc print data=&lib..&&ds&i(obs=&obs);
      title "&lib..&&ds&i Data Set";
      run;
   %end;
%mend printlib;

%printlib(lib=orion)
