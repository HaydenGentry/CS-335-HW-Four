# CS-335-HW-Four
Dealership Database and Queries

In this milestone we will create a database for a car dealership, insert values into that database, and query that database.

There are four tables in the database; vehicle, associate, customer, and transcation. After entering all the input types and fields features for the tables, we must ensure that we pick unique identifiers for our primary keys. Using the ID for vehicle, associate, and transacation; and using the SSN for the customer as our primary keys. Then, we must ensure that our tables that reference other tables have the appropriate foreign keys to allow referencing. The transaction table has references to every other table; as we must know the vehicle being bought or sold, the customer who is buying and selling the vehicle, and the associate who bought or sold the vehicle. 

For this milestone, we are given the series of input values to insert into the tables. While this milestone does not deal with large data tables, unlike the MLB database we have used before, all the same concepts for building and querying the database still apply. The only difference we made between these projects is to limit the number of rows shown in the query. 

In this milestone we complete five queries to gather insight on different questions we have about our database. What we call 'aliases' are used for all of the queries except for one query. 'Aliases' are a way to ensure we are correctly joining our tables and querying for the data fields that we want. We assign each table we want to join together a single letter, which will prefix each data field we will query for followed by '.', then the data fields name. This is to avoid confusion from data fields with the same name but are in different tables, we will now know what table the data field is being queried from. The last query requires a sub-query, this is because we cannot accomplish aggregation in the first select statement because we are already querying for other data fields. 

The only problem I could not solve completely for this milestone is the second query. I have queried the appropriate data fields and get the correct results, except for the associate which should have null values next to their name. In retrospect, I could likely accomplish this query completely by using a sub-query or an if statement. 
