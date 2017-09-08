/*
 * Lesson 3.9: Using PROC SQL
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating or update Macro Variables during SQL Step Execution
 */

/*
Remember, in PROC SQL, the SELECT statement 
is used to generate a report 
by selecting one or more columns from a table. 
The resulting report includes the selected columns 
and all the rows from the selected table. 

The INTO clause in a SELECT statement enables you 
to create or update macro variables. 
The values of the selected columns 
are assigned to the new macro variables. 

The INTO clause begins with the keyword INTO 
and is followed by a colon and then the name 
of the macro variable to be created. 

If more than one macro variable is listed, 
they must be comma-separated and each must start with a colon. 

The colon doesn't become part of the name. 

If you don't include the colon, an error message 
is written to the log.
 */

proc sql noprint;
/*use the NOPRINT option to suppress the report*/
   select sum(total_retail_price) format=dollar8.
   	  /*create macro variable '&total' */	
      into :total
      from orion.order_fact
      where year(order_date)=2011 and order_type=3;
quit;

/*use %LET statement to remove any leading 
or trailing blanks that are stored in the value*/
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
