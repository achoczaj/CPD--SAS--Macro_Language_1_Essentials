/*
 * Lesson 3.12: Creating Macro Variables during PROC SQL Step Execution
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */

/*
 * Creating or update Macro Variables during SQL Step Execution
 * - Creating a Series of Macro Variables Using PROC SQL
 * - Creating an Additional Series of Macro Variables Using PROC SQL
 *
 * Because of its ability to summarize data and create macro variables in a single step, 
 * PROC SQL made this program shorter and simpler. 
 */

/*
 * Program to identify exceptional customers for a given year. 
 * Exceptional customers were defined as those who ordered 
 * more units or units of higher retail value than the average customer.
 */

/* 
 * 
 * initial program version
 * 
 */
%let year=2011;

/*The PROC MEANS step analyzes orion.order_fact. It selects orders for the 
	requested year, calculates the average Quantity and price for all selected 
	orders, and writes these statistics to a temporary data set, stats. The 
	variables are named AvgQty and AvgPrice respectively.
*/
proc means data=orion.order_fact noprint;
	where year(Order_Date) = &year;
	var Quantity Total_Retail_Price;
	output out=stats mean=AvgQty AvgPrice;
run;


/*The DATA _NULL_ step reads the temporary data set, stats, created by PROC 
	MEANS. The SYMPUTX routine uses the values of AvgQty and AvgPrice to create 
	two macro variables, qty and price. 
*/
data _null_;
	set stats;
	call symputx('qty', round(AvgQTY, .01));
	call symputx('price', round(AvgPrice, .01));
run;

/*These macro variables are used in the TITLE and FOOTNOTE statements. 
They're also used in the PROC PRINT step to select the observations 
in which the Quantity is greater than the average Quantity 
and the total retail price is greater than the average retail price.
*/
title "Orders Exceeding Average in &year";
footnote "Average Quantity: &qty";
footnote2 "Average Price: &price";

proc print data=orion.order_fact noobs;
	where year(Order_Date) = &year and Quantity > &qty
         and Total_Retail_Price > &price;
	var Customer_ID order_id Order_Date Quantity Total_Retail_Price;
run;

title;
footnote;



/* 
 * 
 * Modify the program as shown here:
 * 
 */

%let year=2011;

/*use a single PROC SQL query to replace 
the PROC MEANS step and the DATA step.*/ 
proc sql noprint;
/*We're using this PROC SQL step to calculate averages and create macro variables, 
but not to display a report. So, let's add a NOPRINT option.*/ 
	
	/*select two columns from the order_fact table*/
	/*use a summary function to calculate the average for each file*/
   	select avg(Quantity), avg(Total_Retail_Price)
   		/*use an INTO clause to assign these values to the macro variables*/
   		into :qty, :price
      	from orion.order_fact
      	where year(Order_Date)=&year;
run;

/* add a couple of %LET statements to remove leading blanks from quantity and price*/ 
%let qty=&qty;
%let price=&price;

/*reference the macro variables in the TITLE and FOOTNOTE statements*/ 
title "Orders Exceeding Average in &year";
footnote "Average Quantity: &qty";
footnote2 "Average Price: &price";
 
/* reference the macro variables in the PROC PRINT step 
to select the correct observations */	
proc print data=orion.order_fact noobs;
   where year(Order_Date)=&year and Quantity>&qty
         and Total_Retail_Price>&price;
   var Customer_ID order_id Order_Date Quantity Total_Retail_Price;
run;

title;
footnote;
