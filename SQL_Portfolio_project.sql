select * from credit_card_transcations

alter table credit_card_transcations alter column transaction_id int;
alter table credit_card_transcations alter column transaction_date date;
alter table credit_card_transcations alter column city varchar(50);
alter table credit_card_transcations alter column card_type varchar(50);
alter table credit_card_transcations alter column exp_type varchar(50);
alter table credit_card_transcations alter column gender varchar(50);
alter table credit_card_transcations alter column amount int;

--Basic Descriptive Statistics
select min(transaction_date), max(transaction_date)from credit_card_transcations---2013-10-4 to 2015-5-26
select distinct card_type from credit_card_transcations  ----silver,platinum,gold,signature
select distinct exp_type from credit_card_transcations  ----Bills,Grocery,Food,Travel,Entertainment,Fuel
select distinct city from credit_card_transcations ---- 986 cities from india

--1- Top 5 cities with highest spends and their percentage contribution of total credit card spends 
with cte1 as
(select city,sum(amount) as total_spend  --city wise total spend
from credit_card_transcations
group by city)
,total_spent as 
(select sum(cast(amount as bigint)) as total_amount from credit_card_transcations)  --total amount spend overall(4074833373)

select top 5 cte1.*, 
round(total_spend*1.0/total_amount * 100,2) as percentage_contribution  --multiply by 1.0 to converting integer into decimal
from cte1 
inner join total_spent on 1=1
order by total_spend desc

--2- Highest spend month and amount spent in that month for each card type
with cte as (
select card_type,datepart(year,transaction_date)as yt
,datepart(month,transaction_date)as mt,sum(amount) as total_spend
from credit_card_transcations
group by card_type,datepart(year,transaction_date),datepart(month,transaction_date)
--order by card_type,total_spend desc
)
select * from (select *, rank() over(partition by card_type order by total_spend desc) as rn
from cte) a where rn=1

--3- Transaction details(all columns from the table) for each card type when it reaches a cumulative of  1,000,000 total spends(We should have 4 rows in the o/p one for each card type)

with cte as (
select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id) as total_spend  ---order by transaction id and date makes it unique
from credit_card_transcations
--order by card_type,total_spend desc
)
select * from (select *, rank() over(partition by card_type order by total_spend) as rn  
from cte 
where total_spend >= 1000000) a where rn=1

--4- City which had lowest percentage spend for gold card type
with cte as (
select city,card_type,sum(amount) as amount
,sum(case when card_type='Gold' then amount end) as gold_amount
from credit_card_transcations
group by city,card_type)
select top 1 city,sum(gold_amount)*1.0/sum(amount) as gold_ratio
from cte
group by city
having sum(gold_amount)is not null
order by gold_ratio;

--5- 3 columns:  city, highest_expense_type , lowest_expense_type (example format :Mumbai ,Travel, Entertainmen)
select distinct exp_type from credit_card_transcations;

with cte as (
select city,exp_type, sum(amount) as total_amount from credit_card_transcations
group by city,exp_type)
select city , max(case when rn_asc=1 then exp_type end) as lowest_exp_type
, min(case when rn_desc=1 then exp_type end) as highest_exp_type
from
(select *
,rank() over(partition by city order by total_amount desc) rn_desc
,rank() over(partition by city order by total_amount asc) rn_asc
from cte) A
group by city;

--6- Percentage contribution of spends by females for each expense type
select exp_type,
sum(case when gender='F' then amount else 0 end)*1.0/sum(amount) as percentage_female_contribution
from credit_card_transcations
group by exp_type
order by percentage_female_contribution desc;

--7- Card and expense type combination saw highest persentage growth in Jan-2014
with cte as (
select card_type,exp_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_card_transcations
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select  top 1 *, (total_spend-prev_mont_spend)*1.0/(prev_mont_spend) as mont_growth
from (
select *,lag(total_spend,1) over(partition by card_type,exp_type order by yt,mt) as prev_mont_spend
from cte) A
where prev_mont_spend is not null and yt=2014 and mt=1
order by mont_growth desc;

--which card and expense type combination saw highest month over month growth in Jan-2014
with cte as (
select card_type,exp_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_card_transcations
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select  top 1 *, (total_spend-prev_mont_spend) as mont_growth
from (
select *,lag(total_spend,1) over(partition by card_type,exp_type order by yt,mt) as prev_mont_spend
from cte) A
where prev_mont_spend is not null and yt=2014 and mt=1
order by mont_growth desc;

--8- City has highest total spend to total no. of transcations ratio 
select top 1 city , sum(amount)*1.0/count(1) as ratio
from credit_card_transcations
--where datepart(weekday,transaction_date) in (1,7)
where datename(weekday,transaction_date) in ('Saturday','Sunday')
group by city
order by ratio desc;

--9- City took least number of days to reach its 500th transaction after the first transaction in that city;

with cte as (
select *,row_number() over(partition by city order by transaction_date,transaction_id) as rn
from credit_card_transcations)
select top 1 city,datediff(day,min(transaction_date),max(transaction_date)) as datediff1
from cte
where rn=1 or rn=500
group by city
having count(1)=2  ---city who have 2 rows will kept 
order by datediff1 






















