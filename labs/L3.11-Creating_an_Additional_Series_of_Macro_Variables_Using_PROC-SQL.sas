/*
 * Lesson 3.11: Creating an Additional Series of Macro Variables Using PROC SQL
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating or update Macro Variables during SQL Step Execution
 * - Creating a Series of Macro Variables Using PROC SQL
 * - Creating an Additional Series of Macro Variables Using PROC SQL
 */

/*
Modify the previous program to store the top three sales in 2011 
and the dates on which the sales occurred. 
T
o do that, you need to include two columns in the SELECT statement list: 
Total_Retail_Price and Order_Date. 
Order_Date is formatted as a calendar date in the form mm/dd/yyyy. 

The INTO clause names two series of macro variables: 
price1 through price3 
and 
date1 through date3. 

Let's look at the output and see how the values are assigned to the macro variables. 
The output consists of three rows and two columns. 
The assignment is positional, so the first value in the first row is assigned to price1. 
The second value in the first row is assigned to date1. 
The values from row two are stored in price2 and date2. 
The values from row three are stored in price3 and date3.
*/

title 'Top 2011 Sales';
proc sql outobs=3;
   select total_retail_price, Order_Date format=mmddyy10.
      into :price1-:price3, :date1-:date3
      from orion.order_fact
      where year(order_date)=2011
      order by total_retail_price desc;
quit;