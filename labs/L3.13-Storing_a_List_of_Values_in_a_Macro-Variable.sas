/*
 * Lesson 3.13: Storing a List of Values in a Macro Variable
 * Lesson 3 - Creating Macro Variables at Execution Time
 * SAS Macro Language 1: Essentials
 */

/*
 * Creating or update Macro Variables during SQL Step Execution
 * - Storing a List of Values in a Macro Variable
 */ 

/*
 * Sometimes it's convenient to store a list of values in a macro variable. 
 * 
 * Suppose you were asked to create a macro variable, countries, 
 * to store the unique values of the countries found in orion.customer. 
 * The country codes are to be separated by a comma and a space. 
 * 
 * You can use an alternate form of the INTO clause in order to 
 * take all of the values of a column (variable) 
 * and concatenate them into the value of one macro variable. 
 * 
 * The INTO clause names the macro variable to be created. 
 * The SEPARATED BY clause specifies the character or characters 
 * that will be used as a delimiter in the value of the macro variable. 
 * 
 * Notice that the delimiter is enclosed in quotation marks. 
 * The DISTINCT keyword isn't required, but it eliminates duplicates 
 * by selecting unique values of the selected column. 
 * 
 * After you execute the PROC SQL step, you can use the %PUT statement 
 * to write the value of countries to the log.
 */

PROC SQL noprint;
	SELECT DISTINCT country
		INTO :countries
		SEPARATED BY ', '
		FROM orion.customer;
	QUIT;
	
%PUT &countries;