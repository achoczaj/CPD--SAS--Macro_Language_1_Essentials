/*
 * Lesson 4.2: Compiling a Macro
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Creating and Using Macro Programs
 * - Compiling a Macro
 * -- Using the MCOMPILENOTE= Option
 */ 

/*
The next step in creating and using a macro is to compile it by submitting the code. When you submit the code, the word scanner divides the macro into tokens and sends the tokens to the macro processor for compilation. The macro processor checks the macro language statements for syntax errors. Non-macro language statements are not checked until the macro is executed. If the macro processor does find syntax errors in the macro language statements, it writes any error messages to the SAS log and creates a dummy, non-executable macro. If the macro processor does not find any macro-level syntax errors, it compiles the macro.

The macro processor stores the compiled macro definition in a SAS catalog entry. By default, the macro definition is stored in a catalog named work.sasmacr. In some versions of SAS Studio the macro processor stores the compiled macro definition in work.sasmac1, not work.sasmacr. For more information about work.sasmacr, click the information button. Macros that are stored in this temporary SAS catalog are known as session-compiled macros. Session-compiled macros are available for execution during the SAS session in which they're compiled. SAS deletes the temporary catalog that stores the macros at the end of the session. There are methods of storing macros permanently, but these are beyond the scope of this lesson. You can consult the SAS Help and Documentation to explore macro storage methods.
 */
/*
When you submit your macro definition to be compiled, 
you might be left wondering if it compiled successfully. 
By default, SAS does not display any indication 
that a macro has completed compilation. 

There is a system option, MCOMPILENOTE=, that can notify you. 

MCOMPILENOTE=NONE is the default and specifies 
that no notes are issued to the log. 
When the value is set to ALL, the MCOMPILENOTE= option 
issues a note to the SAS log. 
The note confirms that the compilation of the macro was completed. 

It also indicates the number of instructions contained in the macro and its size. 
Be aware, though, that a macro can successfully compile, 
but the non-macro statements can still contain errors that will cause 
the macro not to execute as you intended.
 */

options mcompilenote = all;

%macro prtlast;
    proc print data=&syslast (obs=10);
    	title "Listing of &syslast data set";
	run;
%mend;
