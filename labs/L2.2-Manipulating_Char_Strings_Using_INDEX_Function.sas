/*
 * Lesson 2.1: Manipulating Character Strings Using Macro Functions
 * Lesson 2 - Using Macro Functions
 * SAS Macro Language 1: Essentials
 */
/*
 * Manipulating Character Strings Using Macro Functions
 * 1. Using the %INDEX Function
 */

/*
 * The %INDEX function enables you to search for a substring 
 * within a string. If found, %INDEX returns the position 
 * of the first character of the substring within the string. 
 * 
 * %INDEX function syntax consists of the function name, 
 * with the required arguments source and string. 
 * Both source and string are character strings 
 * or expressions that can include constant text, 
 * macro variable references, macro functions, and macro calls. 
 * 
 * The %INDEX function searches source for the first occurrence 
 * of string and returns the position of its first character.
 *  
 * If an exact match of string is not found, 
 * the function returns 0.
 */

%let sitelist = DALLAS SEATTLE BOSTON;
%let value = %index(&sitelist, LA);

/* Here, %INDEX searches the macro variable sitelist, 
looking for the first occurrence of the string LA. 
The %INDEX function finds the character string LA 
in the word DALLAS, beginning at position 4. 

%INDEX returns the numeric value 4. 

This example demonstrates that %INDEX might return 
unexpected results, such as finding character strings within words.

If you were looking for LA as an abbreviation for Los Angeles, 
you'd need to revise your code. 
You could use a macro quoting function.
*/