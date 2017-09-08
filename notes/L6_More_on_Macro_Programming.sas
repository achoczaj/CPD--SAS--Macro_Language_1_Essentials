/*******************************************************************************

More on Macro Programming - a collection of snippets

from Summary of Lesson 6: More on Macro Programming
SAS Macro Language 1: Essentials

- differentiate between global and local symbol tables
- describe how the macro processor decides which symbol table to use
- explain nested macros and the hierarchy of symbol tables
- create macro utility programs
- minimize errors in your macro applications
- review system options for macro debugging
- comment your macro code

*******************************************************************************/


/*******************************************************************************
1. Processing Statements Conditionally
*******************************************************************************/
/* 1.1 global symbol table*/
/*
The global symbol table is created during SAS initialization, initialized with automatic macro variables and their values, and deleted at the end of the session. The values of user-defined macro variables are often stored in the global symbol table as well.

Macro variables stored in the global symbol table are called global macro variables.To create a global macro variable, you can use a %LET statement anywhere in a program, except within a macro definition. You can also call the SYMPUTX routine in a DATA step or use a SELECT statement that contains an INTO clause in a PROC SQL step.

The %GLOBAL statement enables you to create one or more global macro variables. You specify the keyword %GLOBAL, followed by a list of the macro variables that you want to create, separated by spaces.
  %GLOBAL macro-variable-1 ...macro-variable-n;

You can use the %GLOBAL statement anywhere in a SAS program, either inside or outside a macro definition. If the named variables do not exist in the global symbol table, SAS creates them and assigns a null value. If the macro variables already exist, then this statement does not change their values.

To delete a macro variable from the global symbol table, you use the %SYMDEL statement.
  %SYMDEL macro-variables;
*/

/* 1.2. Working with Local Macro Variables*/
/*
SAS creates a local symbol table when you call a macro that includes a parameter list or when a local macro variable is created during macro execution.

You should use local macro variables instead of global macro variables whenever possible. Local macro variables exist only while the macro is executing. When the macro ends, SAS deletes the local symbol table and the memory used by that table can be reused.

To create local macro variables, you can use parameters in a macro definition or you can use one of the following methods inside a macro definition: a %LET statement, the SYMPUTX routine in a DATA step, or a SELECT statement that contains an INTO clause in a PROC SQL step.

The SYMPUTX routine only creates a local macro variable if a local symbol table already exists. If no local symbol table exists, the SYMPUTX routine creates a global variable.

Another way to create a local macro variable is to use the %LOCAL statement inside a macro definition.
  %LOCAL macro-variable-1 ...macro-variable-n;

You specify the keyword, %LOCAL, followed by a list of the macro variables that you want to create, separated by spaces. The %LOCAL statement creates one or more macro variables in the local symbol table and assigns null values to them. It has no effect on variables that are already in the local table.

Because local symbol tables exist separately from the global symbol table, it is possible to have a local macro variable and a global macro variable that have the same name and different values.

You should use a local variable as the index variable for macro loops. This prevents accidental contamination of a like-named macro variable in the global symbol table or in another local table.

If you define a macro program that calls another macro program, and if both macros create local symbol tables, then two local symbol tables will exist while the second macro executes.

You can use the SYMPUTX routine with an optional third argument, scope, in order to specify where a macro variable should be stored.
  CALL SYMPUTX(macro-variable, value <,scope>);

You specify either a scope of G to indicate that the macro variable is to be created in the global symbol table, or a scope of L to indicate that the macro variable is to be created in the local symbol table. If no local symbol table exists for the current macro, then one will be created.
*/

/*******************************************************************************
2. Writing Utility Macros
*******************************************************************************/
/* 2.1  */
/*

Sometimes there are routine tasks that you need to do repeatedly. It can be useful to define a macro so that the program code for these tasks can be easily reused.

To save these utility macros so that you can reuse them in the future, you can store the compiled macro definitions in a permanent SAS catalog.

Setting the two system options, MSTORED and SASMSTORE=, enables you to store macros in a permanent library and specifies that the macro facility will search for compiled macros in the SAS data library that is referenced by the SASMSTORE= option. This libref cannot be work.

OPTIONS MSTORED | NOMSTORED;


OPTIONS SAMSTORE=libref;


To create a permanently stored compiled macro, you use the STORE option in the %MACRO statement when you submit the macro definition. You can assign a descriptive title for the macro entry in the SAS catalog, by specifying the DES= option.

%MACRO macro-name <(parameter-list)> / STORE <DES='description'>;
        text
%MEND <macro-name>;

To access a stored compiled macro, you must set the MSTORED and SASMSTORE= system options, if they are not already set, and then simply call the macro.

OPTIONS MSTORED;
OPTIONS SAMSTORE=libref;
%macro-name
*/

/*******************************************************************************
3. Minimizing Errors in Your Macros
*******************************************************************************/
/* 3.1  */
/*

You should use a five-step approach to developing macro programs that generate SAS code. This approach will streamline your development and debugging process:
Write and debug the SAS program without macro coding.
Generalize by replacing hardcoded values with macro variable references.
Create a macro definition with macro parameters.
Add macro-level programming for conditional and iterative processing.
Add data-driven customization.

There are several system options that are useful for macro debugging:

Option	Description
MCOMPILENOTE	issues a note to the SAS log after a macro completes compilation
MLOGIC	writes messages that trace macro execution to the SAS log
MPRINT	specifies that the text that is sent to the compiler when a macro executes is printed in the SAS log
SYMBOLGEN	displays the values of macro variables as they resolve

Your macros might benefit from comments. Comments can be especially helpful if you plan to save your macros permanently or share them with other users.

%* comment;


To use the macro comment statement, specify the percent sign, followed by an asterisk and then your comment. The comment can be any text. Like other SAS statements, each macro comment statement ends with a semicolon.

You can also use the comment symbols / * and * / inside a macro. When these symbols appear, the macro processor ignores the text within the comment.
*/

/*******************************************************************************
  Sample Programs
*******************************************************************************/
/* 1. Creating Global Macro Variables */

%macro printdsn;
   %global dsn vars;
   %let dsn=orion.city;
   %let vars=city_name country;
   proc print data=&dsn;
      var &vars;
      title "Listing of &dsn data set";
   run;
%mend;

/* 2. Creating Local Macro Variables
%macro printdsn;
   %local dsn vars;
   %let dsn=orion.city;
   %let vars=city_name country;
   proc print data=&dsn;
      var &vars;
      title "Listing of &dsn data set";
   run;
%mend;

/* 3. Creating Both Global and Local Macro Variables
%let dsn=orion.city;
%macro printdsn;
   %local dsn vars;
   %let dsn=work.city;
   %let vars=city_name country;
   %put The value of DSN inside Printdsn is &dsn;
   proc print data=&dsn;
      var &vars;
      title "Listing of &dsn data set";
   run;
%mend;
%printdsn
%put The value of DSN outside Printdsn is &dsn;

/* 4. Local Macro Variables with Macro Loops
%macro putloop;
   %local i;
   %do i=1 %to &numrows;
      %put Country&i is &&country&i;
   %end;
%mend putloop;

/* 5. Multiple Local Symbol Tables
%macro numobs(lib,dsn);
   options nonotes;
   data _null_;
      call symputx('num', number,'G');
      stop;
      set &lib..&dsn nobs=number;
   run;
   options notes;
%mend numobs;

%macro check(month=,year=);
   data internet;
      keep order_date order_type quantity total_retail_price;
      set orion.order_fact;
      where order_type=3 and month(order_date)=&month
                         and year(order_date)=&year;
   run;
   %numobs(work,internet)
   %if &num=0 %then %put No Internet orders this month.;
   %else %do;
      title1 "Internet Orders &month-&year";
      %if &num>10
         %then %do; title2 "First 10 of &Num Orders"; %end;
         %else %do; title2 "All &Num Orders"; %end;
      proc print data=internet(obs=10);
         var order_date quantity total_retail_price;
     run;
   %end;
%mend check;

/* 6. Using the Stored Compiled Macro Facility
options mstored sasmstore=orion;
%macro deleteALL / STORE
   DES='Delete global variables';
   proc sql noprint;
      select name into :vars separated by ' '
         from dictionary.macros
         where scope='GLOBAL'
            and name not like 'GRAPH%'
            and name not like 'SYS%'
            and name not like '/_%';
   quit;
   %symdel &vars;
%mend deleteALL;

%deleteALL

/* 7. Comments in Macro Programs
%macro printit;
   %* The value of &syslast will be substituted appropriately;
   %* as long as a data set has been created during this session.;
   proc print data=&syslast(obs=5);
   /* Print only the first 5 observations */
      title "Last Created Data Set Is &syslast";
   run;
%mend;
