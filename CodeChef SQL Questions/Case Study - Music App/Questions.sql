-- Write a query to print all the names of singers which starts with ‘a’?
-- Ans:
select singer_name from singer where singer_name like 'a%';

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to Print singer_name which are also users?
-- Ans:
select singer_name from singer s 
join user u on u.user_id = s.user_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to Output the singer_name's and Count of Followers as Count which have more than 2 followers?
-- Ans:
select 
  sg.singer_name, 
  count(F.user_id) as Count 
from singer SG 
join Follower F on SG.singer_id = F.singer_id 
group by SG.singer_id 
HAVING count > 2;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to Return the total number of follower for singer named ‘Taniya Rojas’ , RENAME that column as Follower_count?
-- Ans:
select count(user_id) as Follower_count
from follower 
where singer_id in (
    select singer_id from singer
    where singer_name = 'Taniya Rojas'
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to Retrieve the name of user’s along with the count of singers they are following as Total_count?
-- Ans:
SELECT 
    U.user_name, 
    COUNT(F.singer_id) AS Total_count
FROM User U
JOIN Follower F ON U.user_id = F.user_id
GROUP BY f.user_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to output song_id's of songs which has more likes than the average number of likes?
-- Ans:
with song_likes as (
    select song_id, count(user_id) as like_count
    from liked_by
    group by song_id
),
avglikes as (
    select avg(like_count) as avg_like_count
    from song_likes
)
select distinct song_id from song_likes
cross join avglikes
where like_count > avg_like_count;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to Output the name of song with maximum number of likes among all songs?
-- Ans:
with total_likes as (
    select song_id, count(user_id) as likes
    from liked_by
    group by song_id
)
select song_name from song s
join total_likes tl on tl.song_id = s.song_id
order by likes desc
limit 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to Return song_id of songs which are not in any playlist?
-- Ans:
with playlist_songs as (
    select song_id 
    from belongs_to bo 
    join playlist p on p.playlist_id = bo.playlist_id
)
select song_id from song
where song_id not in (
    select song_id from playlist_songs
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write a query to Return the list of songs which are present in at least two playlist?
-- Ans:
WITH playlist_songs AS (
    SELECT song_id
    FROM belongs_to
    GROUP BY song_id
    HAVING COUNT(distinct playlist_id) >= 2
)
SELECT s.song_id, s.song_name
FROM song s
JOIN playlist_songs ps ON s.song_id = ps.song_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Write a query to Determine the song which has highest number of likes in every playlist. Output 4 columns namely playlist_id , song_id , 
		song_name and maximum like count as max_likes*/
-- Ans:
with total_likes as (
    select song_id, count(user_id) as total_likes
    from liked_by
    group by song_id
), 
ranked_song as (
    select
        playlist_id, s.song_id, song_name, 
        total_likes as max_likes,
        row_number() over (partition by playlist_id order by total_likes desc, s.song_id asc) as ranked
    from belongs_to b 
    join song s on s.song_id = b.song_id
    join total_likes t on t.song_id = s.song_id
)
select playlist_id, song_id, song_name, max_likes
from ranked_song
where ranked = 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Write a query which returns Singer_id, Singer_name , Count of Followers as follower_count and percentage of followers (as follower_percentage 
		rounded to ONE decimal place) for every singer with respect to total number of followers of all singers.
Note : Entry should be there for all singers even if they have 0% followers?*/
-- Ans:
WITH FollowerCount AS (
    SELECT COUNT(user_id) AS total_followers
    FROM Follower
)
SELECT
    s.singer_id, s.singer_name,
    COUNT(f.user_id) AS follower_count,
    ROUND((COUNT(f.user_id) * 100.0) / fc.total_followers, 1) AS follower_percentage
FROM Singer s
LEFT JOIN Follower f ON s.singer_id = f.singer_id
CROSS JOIN FollowerCount fc
GROUP BY s.singer_id, s.singer_name, fc.total_followers;