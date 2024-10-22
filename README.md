![download (2)](https://github.com/user-attachments/assets/6afaf90d-189f-4322-86a1-2e0f1167ef01)![download (1)](https://github.com/user-attachments/assets/7c906ab0-1832-4c03-a100-7d4e2bd32cd3)



# Credit Card Data Analysis-India
This analysis tells in great detail just exactly how the Indian spends by presenting itself of a sum of credit card transactions from all Indians across all states in India through all departments. This analysis gives the big picture on where money is being spent in India, including gender and card type used for each transaction, the city with the greatest spending, and even the kind of expenses incurred.

The variety of factors enables researchers to uncover deeper patterns in consumer spending and interesting relationships between different data sets that offer valuable business insights. This information will be helpful whether you're looking to understand more about consumer preferences or are just curious to investigate objective data analysis methods, having this information at your disposal will be beneficial.  This information will undoubtedly bring light beyond what is apparently expected. 

# Download Credit Card Transactions Dataset from below link :
https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india

Import the dataset in sql server with table name: credit_card_transcations

Change the column names to lower case before importing data to sql server.

Also replace space within column names with underscore.

While importing make sure to change the data types of columns. by default it shows everything as varchar.


# We'll be answering the following questions along the way:

1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends. 

2- write a query to print highest spend month and amount spent in that month for each card type.

3- write a query to print the transaction details(all columns from the table) for each card type when
it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type).

4- write a query to find city which had lowest percentage spend for gold card type.

5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel).

6- write a query to find percentage contribution of spends by females for each expense type.

7- which card and expense type combination saw highest month over month growth in Jan-2014.

8- during weekends which city has highest total spend to total no of transcations ratio .

9- which city took least number of days to reach its 500th transaction after the first transaction in that city.


# Data Description

The dataset likely contains various features related to credit card spending habits, such as:

Customer ID: Unique identifier for each customer

Age: Age of the customer

Gender: Gender of the customer (male/female)

Income: Annual income of the customer

Spending Score: Score assigned based on spending behavior

Credit Limit: Maximum credit limit assigned to the customer

Transaction Count: Number of transactions made by the customer
