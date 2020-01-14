### Challenge1
### Step1
SELECT ta.title_id Title_ID,
 ta.au_id Author_ID,
 t.advance*ta.royaltyper/100 Advance,
 t.price*s.qty*t.royalty/100*ta.royaltyper/100 sales_royalty
 FROM titleauthor ta
 LEFT JOIN titles t
 ON ta.title_id = t.title_id
 LEFT JOIN sales s
 ON t.title_id = s.title_id
 ;
 SELECT * FROM sales;
 
 ### Step2
SELECT Title_ID, Author_ID, sum(sales_royalty) total_royalty
 FROM
 (
 SELECT ta.title_id Title_ID,
 ta.au_id Author_ID,
 t.advance*ta.royaltyper/100 Advance,
 t.price*s.qty*t.royalty/100*ta.royaltyper/100 sales_royalty
 FROM titleauthor ta
 LEFT JOIN titles t
 ON ta.title_id = t.title_id
 LEFT JOIN sales s
 ON t.title_id = s.title_id
) as step1
GROUP BY Title_ID, Author_ID
;
 
 ### Step3
SELECT Author_ID, sum(Total_royalty + Advance) Profit
FROM
(
SELECT Title_ID, Author_ID, sum(sales_royalty) Total_royalty, Advance
 FROM
 (
 SELECT ta.title_id Title_ID,
 ta.au_id Author_ID,
 t.advance*ta.royaltyper/100 Advance,
 t.price*s.qty*t.royalty/100*ta.royaltyper/100 sales_royalty
 FROM titleauthor ta
 LEFT JOIN titles t
 ON ta.title_id = t.title_id
 LEFT JOIN sales s
 ON t.title_id = s.title_id
) as step1
GROUP BY Title_ID, Author_ID
) as step3
GROUP BY Author_ID
ORDER BY Profit DESC
LIMIT 3
;

### Challenge2

CREATE TEMPORARY TABLE temporary_1
SELECT ta.title_id Title_ID,
 ta.au_id Author_ID,
 t.advance*ta.royaltyper/100 Advance,
 t.price*s.qty*t.royalty/100*ta.royaltyper/100 sales_royalty
 FROM titleauthor ta
 LEFT JOIN titles t
 ON ta.title_id = t.title_id
 LEFT JOIN sales s
 ON t.title_id = s.title_id
 ;
 
 CREATE TEMPORARY TABLE temporary_2
SELECT Title_ID, Author_ID, Advance, sum(sales_royalty) total_royalty
FROM temporary_1
GROUP BY Title_ID, Author_ID, Advance
;

SELECT Author_ID, sum(total_royalty + Advance) Profit
FROM temporary_2
GROUP BY Author_ID
ORDER BY Profit DESC
LIMIT 3
;

### Challenge 3

CREATE TABLE most_profiting_authors
SELECT Author_ID, sum(total_royalty + Advance) Profit
FROM temporary_2
GROUP BY Author_ID
ORDER BY Profit DESC
;