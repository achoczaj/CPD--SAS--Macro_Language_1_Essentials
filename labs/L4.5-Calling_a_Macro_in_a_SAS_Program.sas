/*
 * Lesson 4.5: Calling a Macro in a SAS Program
 * Lesson 4 - Creating and Using Macro Programs
 */

/*
 * Compiling and calling a Macro in a SAS Program
 */ 

/*
In this demonstration, you compile and call the Prtlast macro. 
Prtlast stores a PROC PRINT step that prints 
the most recently created data set.

Reminder: Make sure you've defined the Orion library 
to the location of your practice files. 
For more information, see the Setting Up for Practices section. 

Note: If you're using SAS Enterprise Guide to complete this course, 
you set up your practice files in the Orion library 
in the same physical location as the Work library. 
Be sure to use the data set name customers in order to ensure 
that you do not overwrite the practice file customer.
 */

options mcompilenote = all;

%macro prtlast;
   proc print data=&syslast (obs=10);
      title "Listing of &syslast";
   run;
   
   title;
%mend;


/*
Now that the Prtlast macro has been compiled, 
we can use it for the duration of this SAS session, 
without needing to resubmit the macro definition. 

Let's create two new data sets. 
Create the first data set, work.customers 
by selecting the Customer_ID, Country, and Customer_Name variables 
from the orion.customer data set. 
Create a second data set, work.sort_customers 
by sorting work.customers by the variable Country. 

Call the Prtlast macro after each of these DATA and PROC steps.
 */
data work.customers;
   set orion.customer;
   keep Customer_ID Country Customer_Name;
run;
%prtlast

proc sort data=work.customers out=work.sort_customers;
   by Country;
run;
%prtlast


/*
Log:
...
 69         %prtlast
 NOTE: There were 10 observations read from the data set WORK.SORT_CUSTOMERS.
 NOTE: PROCEDURE PRINT used (Total process time):
 */

/*
Notice that you see a note from PROC PRINT, but not the PROC PRINT code itself, 
because the call to the macro does not display the text that is sent to the compiler.
 */