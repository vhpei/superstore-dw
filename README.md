# superstore-dw
A dbt repo for a data warehouse built on top of the Tableau Superstore dataset

# Designing a Data Warehouse for Superstore
The script [setup.sql](https://github.com/vhpei/superstore-dw/blob/dev/setup.sql) contains SQL instructions that will create two schemas: original and norm. The latter contains several tables representing information from the Superstore dataset, which is freely available from Tableau [here](https://data.world/stanke/sample-superstore-2018). The various tables in this schema follow a typical normalization approach of an operational database, with the goal of minimizing data duplication to ensure data consistency and operational query efficiency.

The objective of this exercise is to design a Data Warehouse based on this source data. Considering the order management process, we should arrive at a comprehensive solution, including:
- The tables to be created
- The columns in each table
- How the tables relate to each other (the foreign keys that exist)

Follow the steps outlined by [Kimball](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/four-4-step-design-process/).
For each fact table, after identifying granularity, start by asking what type of fact table it will be:
- Transaction fact table
- Accumulating snapshot fact table
- Periodic snapshot fact table
For each dimension table, define what type of SCD (Slowly Changing Dimension) should be used for each dimension attribute.

# Project
For this project DBT to set up the Data Warehouse for the Superstore dataset. The following points demonstrate what was done.
- Using the file [setup.sql](https://github.com/vhpei/superstore-dw/blob/dev/setup.sql) a database with 2 schemas was created in PostgreSQL.
- With DBT, we defined these schemas as part of our project configuration, and DBT generated SQL statements to create them in our data warehouse.
- We defined tables representing the Superstore dataset. We have specified the columns for each table and their data types. This step involved defining the structure of the data model, which DBT can then translate into SQL statements for creating tables.
- We defined relationships between tables and other configurations using YML files, seeds to generate surrogate keys etc.
- We wrote SQL queries to transform and clean the data in the tables as needed. These transformations included aggregations, filtering, joining tables, and other operations.
- We integrated DBT with GitHub, making it easy to collaborate with team members and track changes over time.
- The most important part of this project was the creation of snapshots, that allowed us to maintain an history everytime data was changed or updated in the original database this way allowing for us to retain historic information of the changes by retaining timestamps of when data was updated, as wells as creating an entire new surrogate key to identify the old data and the updated data in the snapshot.
