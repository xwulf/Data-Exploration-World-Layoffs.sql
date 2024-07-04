-- Exploratory Data Analyst: Looking at our table much better after data cleaning

-- Return the table that you want to explore

Select *
From layoffs_staging2
;


-- Retruning the total max laid off column

Select Max(total_laid_off), Max(percentage_laid_off)
From layoffs_staging2
;

-- Returns max total laid off and max percentage laid off
-- 1 means 100% of the company was laid off

Select Max(total_laid_off), Max(percentage_laid_off)
From layoffs_staging2
;


-- Query will retun percentage that equels 1 which means they have 100% laid off
-- With this data you can aslo see the amount of people that were laid off by looking at the total laid off column

Select *
From layoffs_staging2
Where percentage_laid_off = 1 ;
;


-- Query will return data of total laid of starting with descending numbers

Select *
From layoffs_staging2
Where percentage_laid_off = 1
Order by total_laid_off Desc
;



-- Query will return data of funds raised millions starting with descending numbers

Select *
From layoffs_staging2
Where percentage_laid_off = 1
Order by funds_raised_millions Desc
;



-- Query will return groups rows that have the same values into summary rows

Select company, sum(total_laid_off)
From layoffs_staging2
Group by company
;


-- Query will return table where it orders by 2 and descends

Select company, sum(total_laid_off)
From layoffs_staging2
Group by company
Order by 2 desc 
;


-- Query will return min date and max date from staging 2 table

Select min(`date`), max(`date`)
From layoffs_staging2;



-- Query will return industry and sum laid off where it orders by 2 and desc

Select industry, sum(total_laid_off)
From layoffs_staging2
Group by industry
Order by 2 desc 
;


-- Query will return country and sum laid off where it orders by 2 and desc

Select Country, sum(total_laid_off)
From layoffs_staging2
Group by country
Order by 2 desc 
;


-- Query will return date and sum laid off where it orders by 2 and desc

Select year(`date`), sum(total_laid_off)
From layoffs_staging2
Group by year(`date`)
Order by 1 desc
;


-- Query will show the stage of the company with average percentage laid off

Select stage, sum avg(percentage_laid_off)
From layoffs_staging2
Group by stage
Order by 2 desc
;



-- This returns the substrings as month and sum total laid off grouped by month

select substring(`date`,1,7) AS `Month`, SUM(total_laid_off)
from layoffs_staging2
Group by `Month`
;



-- Query will show all the layoffs from 2020-03

select substring(`date`,1,7) AS `Month`, SUM(total_laid_off)
from layoffs_staging2
Where substring(`date`,1,7) is not null
Group by `Month`
Order by 1 ASC
;


-- Query returns month, total laid off and rolling total

With rolling_total as
(
select substring(`date`,1,7) AS `Month`, SUM(total_laid_off) as total_off
from layoffs_staging2
Where substring(`date`,1,7) is not null
Group by `Month`
Order by 1 ASC
)
select `Month`, total_off
,sum(total_off) over(order by `Month`) as rolling_total
From rolling_total
;


-- Quary will return total laid off for each company and then you can usethe query below to retun howmuch companies were laying off per year 

Select company, sum(total_laid_off)
From layoffs_staging2
Group by company
Order by 2 desc 
;


-- Query will return how much companies were laying off per year

Select company, year(`date`), sum(total_laid_off)
From layoffs_staging2
Group by company, year(`date`)
order by company asc
;

-- Query will rank which year they laid off the most employees

Select company, year(`date`), sum(total_laid_off)
From layoffs_staging2
Group by company, year(`date`)
order by 3 desc
;

-- Query shows that uber hadthe highest layoffs
-- Will also retunr years that are not null
-- Retruns the top 5 companies that laid people

With company_year (company, years, total_laid_off) as
(
Select company, year(`date`), SUM(total_laid_off)
From layoffs_staging2
Group by company, year(`date`)
), company_year_rank as
(Select *, 
Dense_rank() over (partition by years order by total_laid_off desc) as ranking
From company_year
where years is not null
Order by ranking asc
)
Select *
From company_year_rank
Where Ranking <= 5
;

-- Watch ALex portfolio video and add MySQL projects to your portfolio