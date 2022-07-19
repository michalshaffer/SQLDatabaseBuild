Database design and build project

Project write-up: https://medium.com/@michalshaffer_25047/

Database Create script.sql  -  A full create script for tables, views, stored procedures, and triggers.
DataCleanup job SQL Server Agent.sql  -  A script to create a scheduled job in SQL Server Agent
DreamEFV Documentation.pdf - Full documentation of the database, including a data dictionary, descriptions of stored procedures, triggers, and views, and a full database diagram.
Code Samples.pdf - sample code to demonstrate testing and the function of some of the database tools.




Description of future work
•	Create indexes to optimize queries and views – The stored procedures and views were optimized in their use of the language, but I did not do extensive research into the query plans. The indexes created with the primary and foreign keys are sufficient for now. When the database grows considerably this will have to be readdressed.
•	Create temporal tables and log tables for sensitive data: Due to constantly modifying and tweaking the table columns and datatypes, creating temporal and log tables was difficult. I pushed this task off to be the last step once the database is fully complete.
•	(Use the Salesforce API to pull data and keep database updated while in development) – This task was not a part of the main project plan but was optional if I had the time. 
•	(Create functions in python or language of developer’s choice for user application implementation) – I am not currently in touch with a developer working on a user-application, so I did not need to complete this step as of yet.
