/*
 * Practice 3: Creating a Series of Macro Variables
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/* Task:
The SAS data set orion.customer contains a variable named Customer_Type_ID which identifies each customer's membership level and activity level. The orion.customer_type data set contains the Customer_Type_ID variable as well as a variable named Customer_Type. The Customer_Type variable contains a description of the membership level and the activity level. Modify the code shown below to create a series of macro variables named Typexxxx, where xxxx is the value of Customer_Type_ID.

Reminder: Make sure you've defined the Orion library.
1. Copy and paste the following code into the editor:
title; 
footnote; 

%let id=1020;
proc print data=orion.customer;
   var Customer_Name Customer_ID Gender;
   where customer_type_id=&id;
title "A list of &id";
run;

2. Submit the code and view the results.

3. Modify the code. Add a data step to access orion.customer_type and create a series of macro variables, Typexxxx, where xxxx represents the values of Customer_Type_ID.  Assign the corresponding value of Customer_Type to each Typexxxx macro variable.

4. Modify the TITLE statement so that it displays a description of the customer type. Use an indirect macro variable reference to one of the TYPE variables based in the current value of ID. Submit the program and verify that the title contains a description instead of a Customer_Type_ID.

5. Change the value of the ID to 2030, and then resubmit the program and view the results.
*/

/* 1.*/
title; 
footnote; 

%let id=1020;
proc print data=orion.customer;
   var Customer_Name Customer_ID Gender;
   where customer_type_id=&id;
title "A list of &id";
run;

/* 3.*/
%let id=1020;

data _null_;
   set orion.customer_type;
   call symputx('type'||left(customer_type_id),customer_type);
   /*Alternative solution using the CATS function*/
   /*call symputx(cats('type',customer_type_id),customer_type);*/
run;

proc print data=orion.customer;
   var Customer_Name Customer_ID Gender;
   where customer_type_id=&id;
title "A list of &id";
run;

/* 4.*/
%let id=1020;

data _null_;
   set orion.customer_type;
   call symputx('type'||left(customer_type_id),customer_type);
   /*Alternative solution using the CATS function*/
   /*call symputx(cats('type',customer_type_id),customer_type);*/
run;

proc print data=orion.customer;
   var Customer_Name Customer_ID Gender;
   where customer_type_id=&id;
title "A list of &&type&id";
run;

/* 5.*/
%let id=2030;

data _null_;
   set orion.customer_type;
   call symputx('type'||left(customer_type_id),customer_type);
   /* alternative solution using the CATS function*/
   /* call symputx(cats('type',customer_type_id),customer_type);*/
run;

proc print data=orion.customer;
   var Customer_Name Customer_ID Gender;
   where customer_type_id=&id;
title "A list of &&type&id";
run;