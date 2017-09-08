/*******************************************************************************

Creating Macro Variables at Execution Time - a collection of snippets

from Summary of Lesson 3: Creating Macro Variables at Execution Time
SAS Macro Language 1: Essentials

- create macro variables during DATA step execution
- reference macro variables indirectly
- create macro variables during PROC SQL step execution

*******************************************************************************/


/*******************************************************************************
1. Creating a Macro Variable during DATA Step Execution
*******************************************************************************/
/* 1.1 Using the CALL SYMPUTX Routine */
/*
You can use the SAS CALL routine SYMPUTX to create and assign a value to a macro variable during execution.

CALL SYMPUTX(macro-variable, value);

CALL routines are similar to functions in that you can pass arguments to them and they perform a calculation or manipulation of the arguments. CALL routines differ from functions in that you can't use CALL routines in assignment statements or expressions.

CALL routines don't return a value. Instead, they might alter the value of one or more arguments.

To invoke a SAS CALL routine, you specify the name of the routine after the keyword CALL in the CALL statement.

The first argument to SYMPUTX is the name of the macro variable to be created or modified. It can be a character literal, a variable, or an expression that resolves to a valid macro variable name.

The second argument is the value to be assigned to the macro variable. It can be a character or numeric constant, a variable, or an expression.

If character literals are used as arguments, they must be quoted.

Code Challenge:
Write a call to the SYMPUTX routine that will create a macro variable named interest that has a value of varies.
The correct answer is
  call symputx('interest','varies');
You specify the keywords CALL SYMPUTX. As arguments for the SYMPUTX routine, you specify the macro variable name interest and the value varies, and you enclose both arguments in quotation marks.

Question:
What is the value of foot after execution of this DATA step?
 data _null_;
        call symputx('Foot','No Internet orders');
        %let foot=Some Internet orders;
     run;

	 a.  No Internet orders
	 b.  Some Internet orders

Correct.
The value of foot is No Internet Orders.
Word scanning begins. The %LET is executed by the macro processor. The step boundary is reached and the DATA step executes. SYMPUTX changes the value of foot.
*/

/* 1.2 Using SYMPUTX with a DATA Step Variable */
/*

You can use the SYMPUTX routine to assign the value of a DATA step variable to a macro variable. This time, the second argument will be a DATA step variable.
  CALL SYMPUTX(macro-variable, DATA-step-variable);

• The value of the DATA step variable is assigned to the macro variable during execution.
• Numeric values are automatically converted to character using the BEST32. format.
• Leading and trailing blanks are removed from both arguments.
• You can assign a maximum of 32,767 characters to the receiving macro variable.

Question:
Which of the following statements creates the macro variable cost and assigns to it the current value of the DATA step variable Price?
	 a.  call symputx('price', cost);
	 b.  call symputx('cost', price);
	 c.  call symputx('cost', 'price');
	 d.  call symputx(cost, price);

b - Correct.
You specify the macro variable name as the first argument, and the value (in this case, the name of the DATA step variable) as the second argument. You enclose the macro variable name in quotation marks. You do not need to enclose the DATA step variable name in quotation marks.

Question:
Suppose you are creating two macro variables, one to insert the current year (year) into your DATA step program, and one to insert the amount of taxes (taxes) as calculated by your DATA step. Which macro variable, taxes or year, needs to be created with the SYMPUTX routine?
	 a.  taxes
	 b.  year

a - Correct.
The tax value is calculated during DATA step execution, so the macro variable taxes must be created with the SYMPUTX routine. The value of year does not depend on the execution of the DATA step.

*/

/* 1.3 Using SYMPUTX with a DATA Step Expression */
/*
The second argument to the SYMPUTX routine can also be an expression, and it can include arithmetic operations or function calls to manipulate data.
  CALL SYMPUTX(macro-variable, expression);

You can use the PUT function as part of the call to the SYMPUTX routine in a DATA step to explicitly convert a numeric value to a character value.
  PUT (source, format.);

Example:
  CALL SYMPUTX ('date', PUT(Begin_Date, mmddyy10.));
This CALL statement assigns the value of the DATA step variable Begin_Date to the macro variable date. The PUT function explicitly converts the value of Begin_Date to a character value using the MMDDYY10. format. The conversion occurs before the value is assigned to the macro variable.

Code Challenge:
Write a statement that uses the SYMPUTX routine to create a macro variable named daily_fee whose value is the cost of a class per day of instruction according to the data set shown below. Use the DOLLAR6. format.
courses
Course_Code	  | Course_Title	       | Days	| Fee
C003	        | Local Area Networks	 | 3	  | 650
C004	        | Database Design	     | 2	  | 375
The correct answer is
  CALL SYMPUTX('daily_fee', PUT(fee/days, dollar6.));

You specify the keywords CALL SYMPUTX first. Then you enclose the macro variable name in quotation marks. To assign a value, you use the PUT function to format the expression fee per days.
*/


/*******************************************************************************
2. Passing Data between Steps
*******************************************************************************/
/* 2.1. Passing Data between Steps */
/*
You can use a DATA _NULL_ step with the SYMPUTX routine to create macro variables and pass data between program steps.

/* 2.2. Creating Indirect References to Macro Variables */
You can use the SYMPUTX routine with DATA step expressions for both arguments to create a series of macro variables, each with a unique name.

To create an indirect reference, you precede a name token with multiple ampersands.

When the macro processor encounters two ampersands, it resolves them to one ampersand and continues to rescan from left to right, from the point where the multiple ampersands begin. This action is known as the Forward Rescan Rule.

Code Challenge:
Given the macro variables and values shown in the following global symbol table, complete the PROC PRINT step so that it will print all classes that are taught in a particular city. Construct your statement in such a way that you would need to change only the value of crsloc in order for the PROC PRINT step to print classes that are taught in a different city.
Global Symbol Table
Name	Value
city1	Dallas
city2	Boston
city3	Seattle

  %let crsloc=2;
  proc print data=schedule;
      where location= ... ;
        run;

The correct answer is
      where location="&&city&crsloc"
You precede the macro variable name city with two ampersands. Then you add a reference to the macro variable crsloc immediately after the first reference in order to build a new token.

You need to use three ampersands in front of a macro variable name when its value exactly matches the name of a second macro variable.

Question:
Given the macro variables and values shown in this global symbol table, match each macro variable reference on the left to its resolved value on the right by typing the correct letter in each box.
Global Symbol Table
Name	| Value
cat100	| Outerwear
cat120	| Accessories
sale	| cat100

c <- &sale	 	  a. Outerwear
c <- &&sale	 	  b. Accessories
a <- &&&sale	 	c. cat100
 	 	 	          d. sale
*/


/*******************************************************************************
3. Creating Macro Variables Using PROC SQL
*******************************************************************************/
/* 3.1 Creating Macro Variables Using PROC SQ */
/*
You can also create or update macro variables during the execution of a PROC SQL step.

PROC SQL;
      SELECT column-1<,column-2,…>
            INTO :macro-variable-1<, :macro-variable-2,…>
            FROM table-1 | view-1
            <WHERE expression>
                   <other clauses>;
QUIT;

In PROC SQL, the SELECT statement generates a report by selecting one or more columns from a table. The INTO clause in a SELECT statement enables you to create or update macro variables. The values of the selected columns are assigned to the new macro variables.

You specify the keyword INTO, followed by a colon and then the name of the macro variable(s) to be created. Separate multiple macro variables with commas; each must start with a colon. The colon doesn't become part of the name.

Unlike the %LET statement and the SYMPUTX routine, the PROC SQL INTO clause doesn't remove leading and trailing blanks from the values. You can use a %LET statement to remove any leading or trailing blanks that are stored in the value.

You can use the PROC SQL NOPRINT option to suppress the report if you don't want output to be displayed.

PROC SQL NOPRINT;
      SELECT column-1
            INTO :macro-variable-1 - :macro-variable-n
            FROM table-1 | view-1
            <WHERE expression>
            <ORDER BY order-by-item <,...order-by-item>>
            <other clauses>;
QUIT;

Code Challenge:
Complete the following statement so that it will create a macro variable named price with a value that is equal to the value of the data set variable Fee in the first observation of the courses data set.
  proc sql;
   select fee
      into ....;
      from courses;
    quit;

The correct answer is
      into :price
You specify the keyword INTO, then you precede the macro variable name with a colon. Remember, you don't end the INTO clause with a semicolon.

Code Challenge:
Complete the following SELECT statement so that it creates a series of macro variables named place1, place2, place3, and so on. This statement should create as many new macro variables as are needed so that each new macro variable will be assigned a value of a distinct city and state where a student lives (as provided in the data set variable City_State).
The first SELECT statement uses the N function to count the number of distinct city_state values and assigns this number to the macro variable numlocs.
  proc sql;
    select N(distinct city_state)
      into :numlocs
    from students;

    %let numlocs=&numlocs;
    select distinct city_state
      into ...
    from students;
  quit;
The correct answer is
      into :place1-:place&numlocs
You specify :place1 as the first new macro variable name. Then you use a reference to the macro variable numlocs combined with :place in order to specify the final new macro variable in the series.
*/


/* 3.2 Storing a List of Values in a Macro Variable */
/*
You can use the INTO clause in a PROC SQL step to create one new macro variable for each row in the result of the SELECT statement.

You can use an alternate form of the INTO clause in order to take all values of a column (variable) and concatenate them into the value of one macro variable.

PROC SQL NOPRINT;
      SELECT <DISTINCT>column-1
            INTO :macro-variable-1
            SEPARATED BY 'delimiter-1'
            FROM table-1 | view-1
            <WHERE expression>
            <other clauses>;
QUIT;


The INTO clause names the macro variable to be created. The SEPARATED BY clause specifies the character that will be used as a delimiter in the value of the macro variable. Notice that the character is enclosed in quotation marks.

The DISTINCT keyword eliminates duplicates by selecting unique values of the selected column.

After you execute the PROC SQL step, you can use the %PUT statement to write the values to the log.

Code Challenge:
Complete the following SELECT statement so that it creates a macro variable named location that stores all distinct cities in which students live, separated by an asterisk delimiter.
  proc sql;
    select distinct city_state
      ...
      from students;
    quit;
The correct answer is
      into :location separated by '*'
You specify the keyword INTO and precede the macro variable name with a colon. Then you specify the keywords SEPARATED BY and enclose the asterisk in quotation marks.

/*******************************************************************************
Sample Programs
*******************************************************************************/
1. Creating a Macro Variable during DATA Step Execution
data orders1;
   keep order_date order_type quantity total_retail_price;
   set orion.order_fact end=final;
   where year(order_date)=&year and month(order_date)=&month;
   if order_type=3 then Number+1;
   if final then do;
      put Number=;
      if Number=0 then do;
         call symputx('foot', 'No Internet Orders');
      end;
         else do;
            call symputx('foot', 'Some Internet Orders');
         end;
   end;
run;


data orders1;
   keep order_date order_type quantity total_retail_price;
   set orion.order_fact end=final;
   where year(order_date)=&year and month(order_date)=&month;
   if order_type=3 then Number+1;
   if final then call symputx('num', Number);
run;

proc print data=orders1;
   title "Orders for &month-&year";
   footnote "&num Internet Orders";
run;


%let month=1;
%let year=2009;

data orders2;
   keep order_date order_type quantity total_retail_price;
   set orion.order_fact end=final;
   where year(order_date)=&year and month(order_date)=&month;
   if order_type=3 then do;
      Number+1;
      Amount+total_retail_price;
      Date=order_date;
      retain date;
   end;
   if final then do;
      if number=0 then do;
         call symputx('dat', 'N/A');
         call symputx('avg', 'N/A');
      end;
      else do;
         call symputx('dat', put(date,mmddyy10.));
         call symputx('avg', put(amount/number,dollar8.));
      end;
   end;
run;

proc print data=orders2;
   title "Orders for &month-&year";
   footnote1 "Average internet Order: &avg";
   footnote2 "Last internet Order: &dat";
run;
title;
footnote;


Passing Data Between Steps
%let year=2010;
proc means data=orion.order_fact noprint;
   where year(order_date)=&year;
   var quantity total_retail_price;
   output out=stats mean=AvgQty AvgPrice;
run;

data _null_;
   set stats;
   call symputx('qty',round(AvgQTY,.01));
   call symputx('price',round(AvgPrice,.01));
run;

title "Orders Exceeding Average in &year";
footnote "Average Quantity: &qty";
footnote2 "Average Price: &price";

proc print data=orion.order_fact noobs;
   where year(order_date)=&year and
      quantity>&qty and total_retail_price>&price;
   var customer_id order_id order_date quantity total_retail_price;
run;

Creating Indirect References to Macro Variables
%let custID=9;
data _null_;
   set orion.customer;
   where customer_ID=&custID;
   call symputx('name', Customer_Name);
run;

proc print data=orion.order_fact;
   where customer_ID=&custID;
   var order_date order_type quantity total_retail_price;
   title1 "Customer Number: &custID";
   title2 "Customer Name: &name";
run;


data _null_;
   set orion.customer;
   call symputx('name'||left(Customer_ID),customer_Name);
run;


data _null_;
   set orion.customer;
   call symputx(cats('name',Customer_ID),customer_Name);
run;


%let custID=9;
proc print data=orion.order_fact;
   where customer_ID=&custID;
   var order_date order_type quantity total_retail_price;
   title1 "Customer Number: &custID";
   title2 "Customer Name: &&name&custID";
run;
title;

Creating Macro Variables Using PROC SQL
proc sql noprint;
   select sum(total_retail_price) format=dollar8.
      into :total
      from orion.order_fact
      where year(order_date)=2011 and order_type=3;
quit;

%let total=&total;
%put Total 2011 Internet Sales: &total;


title 'Top 2011 Sales';
proc sql outobs=3;
   select total_retail_price,  Order_Date format=mmddyy10.
      into :price1-:price3,:date1-:date3
      from orion.order_fact
      where year(order_date)=2011
      order by total_retail_price desc;
quit;
