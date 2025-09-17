/*Case Study: A Library Management System is a software application that helps manage the various activities and operations of a library. 
	The primary goal of this system is to efficiently organize and track books, members, loans, and reservations within the library. The library contains 
		books from different genres, and members can borrow and reserve books.

Retrieve the title and author of books from the "Books" table. If the genre is 'Computer Science', display 'CS Book' as the category, 
	else display 'Other Book' as the category?*/
-- Ans:
select title, author,
	(case when genre = 'Computer Science' then 'CS Book' else 'Other Book' end) as category
from books;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Display the member names and their corresponding addresses from the "Members" table. If the address contains the word 'Delhi', 
	display 'Delhi Resident', else display 'Other City'?*/
-- Ans:
select member_name,
	(case when address like '%Delhi%' then 'Delhi Resident' else 'Other City' end) as city_status
from members;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Find the total number of books available in each genre from the "Books" table. If the count is less than 5, label the genre as 
	'Limited', else label it as 'Abundant'?*/
-- Ans:
select genre,
	(case when count(*) < 5 then 'Limited' else 'Abundant' end) as availability
from books
group by genre;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*List the member names and their total number of loans from the "Members" and "Loans" tables. If a member has borrowed more than 3 books, 
	label them as 'Frequent Borrower', else label them as 'Occasional Borrower'?*/
-- Ans:
select
	member_name,
    (case when count(l.loan_id) > 3 then 'Frequent Borrower' else 'Occasional Borrower' end) as borrowing_status
from members m
left join loans l on l.member_id = m.member_id
group by m.member_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Display the number of books published in each year, along with a column indicating if the number of books is greater than 3. If the count 
	is greater than 3, display "Yes" otherwise "No"?*/
-- Ans:
select publication_year, count(book_id) as num_books,
	(case when count(book_id) > 3 then 'Yes' else 'No' end) as greater_than_three
from books
group by publication_year
order by publication_year asc;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Classify members based on the number of loans they have made. Members with 5 or more loans are classified as 'VIP Member' members with 3 or more loans are 
	classified as 'Regular Member' and the rest are classified as 'Basic Member'?*/
-- Ans:
select 
	member_id, 
    count(loan_id) as num_loans,
	(case
		when count(loan_id) >= 5 then 'VIP Member'
        when count(loan_id) >= 3 then 'Regular Member'
        else 'Basic Member' 
        end
    ) as membership_category
from loans
group by member_id
order by member_id asc;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Display the book title and the number of days each book is on hold for the member. If a book is not on hold by the member, show 0. "Days on hold" 
	refers to the duration or number of days that a book is reserved by a member but not yet available for borrowing because it is currently on loan to another member? */
-- Ans:
select
	b.title, m.member_name,
    (case 
		when l.return_date is not null and reservation_date > return_date then datediff(reservation_date, return_date)
        else 0 end) as days_on_hold
from books b
join reservations r on r.book_id = b.book_id
join members m on r.member_id = m.member_id
left join loans l on r.book_id = l.book_id and r.member_id = l.member_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Display the member name and the number of books borrowed by each member. However, if a member has borrowed more than 3 books, show 
	"3+" instead of the actual count?*/
-- Ans:
select
	member_name,
    (case when count(loan_id) > 3 then '3+' else count(loan_id) end) as num_books_borrowed
from members m
left join loans l on l.member_id = m.member_id
group by m.member_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Display the book title, the number of times it has been borrowed, and the number of times it has been reserved. If there are no loans 
	or reservations for the book, show 0?*/
-- Ans:
select
	b.title as title, 
    count(distinct l.loan_id) as num_times_borrowed,
    count(distinct r.reservation_id) as num_times_reserved
from books b
left join loans l on b.book_id = l.book_id
left join reservations r on b.book_id = r.book_id
group by b.book_id, b.title;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Display the member name and the number of books they have borrowed in each genre. If a member has not borrowed any book in a genre, show 0?
-- Ans:
SELECT
  M.member_name, G.genre,
  COUNT(CASE WHEN B.genre = G.genre THEN 1 END) AS num_borrowed
FROM Members M
CROSS JOIN (SELECT DISTINCT genre FROM Books) G
LEFT JOIN Loans L ON M.member_id = L.member_id
LEFT JOIN Books B ON L.book_id = B.book_id
GROUP BY M.member_id, G.genre;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------