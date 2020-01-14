--- Challenge 1

select ta.au_id as AUTHOR_ID, 
a.au_lname as LAST_NAME, 
a.au_fname as FIRST_NAME, 
t.title as TITLE, 
p.pub_name as PUBLISHER
FROM titleauthor ta
INNER JOIN titles t
ON t.title_id = ta.title_id
INNER JOIN authors a 
ON ta.au_id = a.au_id
INNER JOIN publishers p
ON t.pub_id = p.pub_id
;

--- Challenge 2

select ta.au_id as AUTHOR_ID, 
a.au_lname as LAST_NAME, 
a.au_fname as FIRST_NAME, 
p.pub_name as PUBLISHER, 
count(t.title) as TITLE_COUNT
FROM titleauthor ta
INNER JOIN titles t
ON t.title_id = ta.title_id
INNER JOIN authors a 
ON ta.au_id = a.au_id
INNER JOIN publishers p
ON t.pub_id = p.pub_id
GROUP BY ta.au_id, a.au_lname, a.au_fname, p.pub_name
;

--- Challenge 3

SELECT ta.au_id AS AUTHOR_ID, 
a.au_lname as LAST_NAME, 
a.au_fname as FIRST_NAME, 
sum(s.qty) as TOTAL
FROM authors a
INNER JOIN titleauthor ta
ON a.au_id = ta.au_id
INNER JOIN sales s
ON ta.title_id = s.title_id
GROUP BY AUTHOR_ID, LAST_NAME, FIRST_NAME
ORDER BY TOTAL DESC
LIMIT 3
;

--- Challenge 4

SELECT a.au_id AS AUTHOR_ID, 
a.au_lname as LAST_NAME, 
a.au_fname as FIRST_NAME, 
coalesce(sum(s.qty),0) as TOTAL
FROM authors a
LEFT JOIN titleauthor ta
ON a.au_id = ta.au_id
LEFT JOIN sales s
ON ta.title_id = s.title_id
GROUP BY AUTHOR_ID, LAST_NAME, FIRST_NAME
ORDER BY TOTAL DESC

;

