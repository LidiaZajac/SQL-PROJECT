--/****** Script for SelectTopNRows command from SSMS  ******/
--USE Treningi
--RUN



  select *
  from [treningi ]


   -- Data was downloaded into csv format
   -- To be able to perform operations on the data, it had to be properly formatted (for example, replacing periods with commas)


  --2. OPERATIONS USING BASIC QUERIES (SELECT TOP, WHERE, ORDER BY, GROUP BY, AVG(), MAX(), MIN(), COUNT(), ALIAS, BETWEEN etc)

  --2.1 Top 10 workouts (features: most calories burned, showing highest heart rate)
  
  select top 10 date, Calories,[Max HR],[Activity Type]
  from [treningi ]
  where Calories is not null
  and [Max HR] > 0
  order by Calories desc, date desc
  
  Results:
  
  date	Calories	Max HR	Activity Type
2021-03-27 10:07:02.000	850	167	Treadmill Running
2019-10-28 19:03:03.000	784	165	Strength Training
2021-06-04 18:57:17.000	749	162	Cycling
2021-06-03 12:34:50.000	741	139	Cycling
2020-11-08 14:27:43.000	685	182	Hiking
2019-10-17 19:00:58.000	662	153	Strength Training
2020-02-20 18:49:21.000	649	170	Strength Training
2022-02-28 19:34:29.000	640	146	Strength Training
2019-07-29 20:05:57.000	637	159	Strength Training
2019-10-31 19:12:58.000	634	164	Strength Training

   -- 2.2 Total calories burned each month
  
  select month(date) as Month_, year(date) as Year, SUM(calories) as Sum_Calories
  from [treningi ]
  GROUP BY month(date), year(date)
  order by Sum_Calories desc
  
  Results:

Month_	Year	Sum_Calories
3	2021	10818
7	2019	9333
12	2019	8755
6	2019	8614
6	2021	7819


  --2.3 Showing how the value of calories burned for strength training has changed over the past two years
  -- -- --(changes in training plans (change of plan October 2021, December 2021, June 2022, September 2022)

  
  ---- from January 2021 to Sepmtember 2021
   select avg(calories) as do_30_09_2021
   from [treningi ]
   where date between '2021-01-01 00:00:00.000' and '2021-09-30 00:00:00.000'
   
  ----from October 2021 to December 2021

  select avg(calories) as do_31_12_2021
  from [treningi ]
  where date between '2021-10-02 00:00:00.000' and '2021-12-31 00:00:00.000'
   
  ---- from January 2022 to May 2022

   
  select avg(calories) as do_31_05_2022
  from [treningi ]
  where date between '2022-01-01 00:00:00.000' and '2022-05-31 00:00:00.000'
   
  ---- from June 2022 to September 2022

    
  select avg(calories) as do_30_09_2022
  from [treningi ]
  where date between '2022-06-01 00:00:00.000' and '2022-09-30 00:00:00.000' 


  --2.4 Showing the average heart rate for all workouts
  
  select date, [Avg HR]
  from [treningi ]
  where [Avg HR] > 0

   select  avg([Avg HR]) as srednie_tetno
  from [treningi ]

  --2.5 Counting the number of training days in 2021

  select count([Activity Type]) as ActivityDays2021
  from [treningi ]
  where date between '2021-01-01 00:00:00.000' and '2021-12-31 00:00:00.000' 

  --2.6 Showing the workout with the least amount of calories burned

  select min([Calories])
  from [treningi ]


  --3. DATA MANIPULATING

  --3.1 Create a table with complementary data (Wellbeing rate 1-5)

  CREATE TABLE "Control_table" (
    "Date" datetime PRIMARY KEY not null,
    "Calories per day" float(2),
	"Wellbeing" varchar(200)
	)

	select *
	from Control_table

 --3.2 Deleting column from table

	ALTER TABLE [treningi ]
	DROP COLUMN [Grit]

 --3.3 

     INSERT INTO Control_table
	 (Date, [Calories per day], Wellbeing) VALUES (2022-09-29 0:19:43.000,123, 1);  

  --4. JOINING TABLES

--4.1 Inner join

SELECT *
FROM [treningi ] tr
INNER JOIN wellbeing wl
ON tr.date = wl.date;

--4.2 Left join

SELECT *
FROM [treningi ] tr
LEFT JOIN wellbeing wl
ON tr.date = wl.date;

--4.3 Right join

SELECT  *
FROM [treningi ] tr
Right JOIN wellbeing wl
ON tr.date = wl.date;


--4.4 Full join

SELECT *
FROM [treningi ] tr 
FULL OUTER JOIN wellbeing wl
ON tr.Date = wl.Date






 
 


  
