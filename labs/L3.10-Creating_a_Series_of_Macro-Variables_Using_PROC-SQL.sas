/*
 * Lesson 3.10: Creating a Series of Macro Variables Using PROC SQL
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */
/*
 * Creating or update Macro Variables during SQL Step Execution
 * - Creating a Series of Macro Variables Using PROC SQL
 */

/*
You can use the INTO clause 
to create one new macro variable 
for each row in the result of the SELECT statement. */

title 'Top 2011 Sales';
proc sql outobs=3;
   select total_retail_price
   /*only one column is selected, Total_Retail_Price*/
      into :price1-:price3
      /*creates three macro variables: price1 through price3*/
     
     /*This is a series of macro variables, which is similar 
     to the name series you saw earlier. 
     
     In order to identify the top sales, the results 
     are sorted in descending order by Total_Retail_Price, 
     so the highest orders will appear first in the output. 
     
     PROC SQL output shows column labels by default. 
     So, Total_Retail_Price is labeled Total Retail Price for This Product. 
     
     Because you only want the top three, there is no need to keep 
     the other output values. The OUTOBS=3 option limits the output 
     to three rows and gives you the top three sales. */
    
      from orion.order_fact
      where year(order_date)=2011
      order by total_retail_price desc;
quit;