use electoralbonddata;
show tables;
select * from bonddata;
select * from donordata;
select * from receiverdata;
select * from bankdata;

-- 1.Find out how much donors spent on bonds? 
select sum(denomination) money from bonddata;
## 127787242000
-- 2. Find out total fund politicians got?
select  sum(b.denomination) total_fund
from receiverdata a
join bonddata b
on a.unique_key=b.unique_key;
## 127690893000

-- 3.Find out the total amount of unaccounted money received by parties?
select sum(denomination) from bonddata 
where unique_key in (select r.unique_key from donordata d
right join receiverdata r
on d.unique_key=r.unique_key
where d.unique_key is null);
## 6232110000.
-- 4.Find year wise how much money is spend on bonds?
select year(purchasedate) as year,sum(denomination) money from donordata d
join bonddata b
on d.unique_key=b.unique_key
group by year
order by year;

-- 5.In which month most amount is spent on bonds?
with data as(select distinct month(purchasedate) as month,sum(denomination) as amount 
from donordata d
join bonddata b
on d.unique_key=b.unique_key
group by month 
order by month)
select month from data
where amount=(select max(amount) from data);
## most amount is spent on bonds in april month.
-- 6.Find out which company bought the highest number of bonds?
 with data as(select purchaser company,count(unique_key)  bonds
from donordata
group by company)
select company
from data 
where bonds= (select max(bonds) from data);
## future gaming and hotel services privated ltd company bought highest number of bonds.
-- 7.Find out which company spent the most on electoral bonds?
with comp as(select purchaser company, sum(denomination) amount
from donordata d
join bonddata b
on d.unique_key=b.unique_key
group by company)
select company
from comp
where amount=(select max(amount) from comp);
## future gaming and hotel services private ltd company spent most on electoral bonds.
-- 8.List companies which paid the least to political parties?
with data as(select purchaser as company,d.unique_key unique_key1,denomination
from donordata d
join bonddata b
on d.unique_key=b.unique_key),
data1 as(select partyname,unique_key as unique_key2 from receiverdata),
data2 as(select *
from data
join data1
on data.unique_key1=data1.unique_key2),
data3 as(select company,sum(denomination) denomination from data2

where partyname in(select distinct(partyname) from data2)
group by company)
select company,denomination
from data3
where denomination = (select min(denomination) from data3);
## aravind s company paid least denomination.




select company,partyname,denomination
where denomination=(select max(denomination) from data3);

-- 9.Which political party received the highest cash?
with data as(select partyname,sum(denomination) as amount
from receiverdata r
join bonddata b
on r.unique_key=b.unique_key
group by partyname)
select partyname,amount
from data
where amount=(select max(amount) from data);
## bharatiya janata party received the highest cash
-- 10.Which political party received the highest number of electoral bonds?
with data as(select partyname,count(unique_key) as electoral_bonds
from receiverdata
group by partyname)
select partyname,electoral_bonds
from data
where electoral_bonds=(select max(electoral_bonds) from data);
## bharatiya janata party received the highest number of bonds.
-- 11.Which political party received the least cash?
with data as(select partyname,sum(denomination) amount
from receiverdata r
join bonddata b
on r.unique_key=b.unique_key
group by partyname)
select partyname,amount
from data
where amount=(select min(amount) from data);
## goa forward party received the least cash.
-- 12. Which political party received the least number of electoral bonds?
with data as(select partyname,count(unique_key) electoral_bonds
from receiverdata
group by partyname)
select partyname,electoral_bonds
from data
where electoral_bonds=(select min(electoral_bonds) from data);
## jammu and kashmir national conference party received the least number of electoral bonds.
-- 13.Find the 2nd highest donor in terms of amount he paid?
with data as(select purchaser donor, sum(denomination) amount
from donordata d
join bonddata b
on d.unique_key=b.unique_key
group by donor)
select donor,amount
from data
where amount=(select max(amount) from data where amount < (select max(amount) from data));
## megha engineering and infrastructures pvt ltd company is 2nd highest donor in terms of amount he paid.
-- 14.Find the party which received the second highest donations?
with data as(select partyname,sum(denomination) donations
from receiverdata r
join bonddata b
on r.unique_key=b.unique_key
group by partyname)
select partyname,donations
from data
where donations=(select max(donations) from data where donations<(select max(donations) from data));
## all india trinamool congress party received second highest donations.
-- 15.Find the party which received the second highest number of bonds?
with data as(select partyname,count(unique_key) as bonds
from receiverdata
group by partyname)
select partyname,bonds
from data
where bonds=(select max(bonds) from data where bonds<(select max(bonds) from data));
## all india trinamool congress party received the second highest no.of bonds
-- 16.In which city were the most number of bonds purchased?
with data as(select city,count(unique_key) as bonds
from bankdata b
join donordata d
on d.paybranchcode=b.branchcodeno
group by city)
select city,bonds
from data
where bonds=(select max(bonds) from data);
## in kolkata city purchased most number of bonds purchased.
-- 17. In which city was the highest amount spent on electoral bonds?
with data as(select city,unique_key
from bankdata b
join donordata d
on b.branchcodeno=d.paybranchcode),
data1 as(select unique_key,denomination amount from bonddata),
data2 as( select city,sum(amount) amount
from data
join data1
on data.unique_key=data1.unique_key
group by city)
select city,amount
from data2
where amount=(select max(amount) from data2);
## hyderabad spent highest amount on electoral bonds.
-- 18. In which city were the least number of bonds purchased?
with data as(select city,count(unique_key) as bonds
from bankdata b
join donordata d
on d.paybranchcode=b.branchcodeno
group by city)
select city,bonds
from data
where bonds=(select min(bonds) from data);
## ranchi city purchased least number of bonds.
-- 19. In which city were the most number of bonds encashed?
with data as(select city,count(unique_key) bonds
from bankdata b
join receiverdata r
on b.branchcodeno=r.paybranchcode
group by city)
select city,bonds
from data
where bonds=(select max(bonds) from data);
## new delhi encashed most number of bonds.
-- 20.In which city were the least number of bonds enchased?
with data as(select city,count(unique_key) bonds
from bankdata b
join receiverdata r
on b.branchcodeno=r.paybranchcode
group by city)
select city,bonds
from data
where bonds=(select min(bonds) from data);
## srinagar encashed least number of bonds.
-- 21. List the branches where no electoral bonds were bought; if none, mention it as null?
select city,unique_key
from bankdata b
left join donordata d
on b.branchcodeno=d.paybranchcode
where unique_key is null;
-- 22. Break down how much money is spent on electoral bonds for each year?
select year(purchasedate) as year ,sum(denomination)
from donordata d
join bonddata b
on d.unique_key=b.unique_key
group by year
order by year;
-- 23. Break down how much money is spent on electoral bonds for each year and provide the year and the amount. Provide values for the highest and least year and amount.
with data as(select year(purchasedate) as year ,sum(denomination) amount
from donordata d
join bonddata b
on d.unique_key=b.unique_key
group by year
order by year)
select year,amount
from data
where amount=(select max(amount) from data); ## 2023 has the highest amount.
with data as(select year(purchasedate) as year ,sum(denomination) amount
from donordata d
join bonddata b
on d.unique_key=b.unique_key
group by year
order by year)
select year,amount
from data
where amount=(select min(amount) from data); ## 2020 has the least amount.
-- 24. Find out how many donors bought the bonds but did not donate to any political party?
select count(d.unique_key) donors
from donordata  as d
left join receiverdata  as r
on r.unique_key=d.unique_key
where r.unique_key is null;

## 130 donors bought the bond and don't donate money to the political party.
-- 25. Find out the money that could have gone to the PM Office, assuming the above question assumption (Domain Knowledge)?
with data as(select d.unique_key
from donordata d
left join receiverdata r
on d.unique_key=r.unique_key
where r.unique_key is null)
select sum(denomination) money
from data d
join bonddata b
on d.unique_key=b.unique_key;
## 96349000 money gone to pm office
-- 26.  Find out how many bonds don't have donors associated with them?
select count(r.unique_key)
from donordata d
right join receiverdata r
on d.unique_key=r.unique_key
where d.unique_key is null;
## 1680 bonds don't have donors associated with them.
-- 27. Pay Teller is the employee ID who either created the bond or redeemed it. So find the employee ID who issued the highest number of bonds.
with data as(select payteller,count(unique_key) bonds
from donordata
group by payteller)
select * from data
where bonds=(select max(bonds) from data) ;
## 6405134 is the employee id who issued the highest number of bonds.
-- 28. Find the employee ID who issued the least number of bonds?
with data as(select payteller employee_id,count(unique_key) bonds
from donordata
group by payteller)
select *
from data
where bonds=(select min(bonds) from data) ;
## the employees whose id's are (5578876,5575761) issued the least no.of bonds.
 -- 29.  Find the employee ID who assisted in redeeming or encashing bonds the most.
with data as(select payteller,count(payteller) bonds
from receiverdata
group by payteller)
select *
from data
where bonds=(select max(bonds) from data);
## the employee whose id is 7516991 redeeming or encashing bonds most.
-- 30. Find the employee ID who assisted in redeeming or encashing bonds the least?
with data as(select payteller,count(payteller) bonds
from receiverdata
group by payteller)
select *
from data
where bonds=(select min(bonds) from data);
## 3 employees whose id's are(5880793,7626436,6596169) redeem or encashing bonds the least.
-- 31. Tell me total how many bonds are created?
select count(unique_key) as bonds
from bonddata;
## 20551 bonds are created.
-- 32. Find the count of Unique Denominations provided by SBI?
select count(distinct(denomination)) count
from bonddata;
## 5 distinct denominations are provided by SBI
-- 33. List all the unique denominations that are available?
select distinct(denomination)
from bonddata;
-- 34. Total money received by the bank for selling bonds?
select sum(denomination)
from bonddata;
## 1,27,78,72,42,000 this is the amount received by the bank by selling bonds
-- 35. Find the count of bonds for each denominations that are created?
select count(unique_key)
from bonddata
where denomination is not null;
## 20,551 bonds.
-- 36. Find the count and Amount or Valuation of electoral bonds for each denominations?
select count(denomination) count,sum(denomination) denomination
from bonddata;
## count is 20,551 and denomination is 1,27,78,72,42,000
-- 37. Number of unique bank branches where we can buy electoral bond?
select count(distinct(city)) bank_branches
from bankdata;
## 29 unique bank branches where we can buy electoral bond.
-- 38. How many companies bought electoral bonds?
select count(distinct(purchaser)) company
from donordata;
## 1228 companies bought electoral bonds
-- 39. How many companies made political donations?
select count(d.unique_key)
from donordata d
join receiverdata r
on d.unique_key=r.unique_key;
## 18,741 companies made political donations.
-- 40. How many number of parties received donations?
select count(distinct(partyname))
from receiverdata;
## 24 parties received donations.
-- 41. List all the political parties that received donations?
select distinct(partyname)
from receiverdata;
-- 42. What is the average amount that each political party received?
select partyname,avg(denomination)
from receiverdata r
join bonddata b
on r.unique_key=b.unique_key
group by partyname;
-- 43. What is the average bond value produced by bank?
select avg(denomination)
from bonddata;
## 6218054.6932.
-- 44. List the political parties which have encashed bonds in different cities?
with data as(select *
from bankdata b
join receiverdata r
on b.branchcodeno=r.paybranchcode)
select distinct(partyname)
from data
where city in (select distinct(city) from data);
-- 45.List the political parties which have encashed bonds in different cities and list the cities in which the bonds have encashed as well?
with data as(select *
from bankdata b
join receiverdata r
on b.branchcodeno=r.paybranchcode)
select distinct(partyname),city
from data
where city in (select distinct(city) from data);


























 

 









 




















 











