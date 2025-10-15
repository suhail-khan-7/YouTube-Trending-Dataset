SELECT top(1000)*
  FROM [Youtube Tranding dataset].[dbo].[filtered_dataset]
  
  select distinct video_category_id
  from filtered_dataset

  select *
  from filtered_dataset
  where video_category_id is null

  select distinct channel_title,channel_id,count(video_id) as total_video_in_each_channel_title
  from filtered_dataset
  group by channel_title,channel_id
  order by total_video_in_each_channel_title desc

  -- Create a Like to viwe Ratio Matrix

  alter table filtered_dataset
  add Like_to_view_ratio float
 
  update filtered_dataset
  set Like_to_view_ratio=cast(video_like_count as float)/nullif(video_view_count,0)

  -- Create engagement rate Matrix

   alter table filtered_dataset
  add video_engagement_rate float

    update filtered_dataset
  set video_engagement_rate=(cast(video_like_count as float)+video_comment_count)/nullif(video_view_count,0)
 
 -- Create Views per channel video matrix

   alter table filtered_dataset
  add views_per_channel_video float

    update filtered_dataset
  set views_per_channel_video=cast(video_view_count as float)/nullif(channel_video_count,0)
 
 -- Create Like per subscriber matrix

   alter table filtered_dataset
  add Likes_per_subscriber float

    update filtered_dataset
  set Likes_per_subscriber=cast(video_like_count as float)/nullif(channel_subscriber_count,0)
 
 -- Create channel activity rate matrix

 
   alter table filtered_dataset
  add Channel_activity_rate float

    update filtered_dataset
  set Channel_activity_rate=cast(channel_video_count as float)/nullif(channel_subscriber_count,0)
 
 --Find the max and min Value from the data.
  select max(Like_to_view_ratio),
  min(Like_to_view_ratio)
  from filtered_dataset
  
  select max(video_engagement_rate),
  min(video_engagement_rate)
  from filtered_dataset
  
  select max(views_per_channel_video),
  min(views_per_channel_video)
  from filtered_dataset
  
  select max(Likes_per_subscriber),
  min(Likes_per_subscriber)
  from filtered_dataset
  
  select max(Channel_activity_rate),
  min(Channel_activity_rate)
  from filtered_dataset

  select max(video_duration),min(video_duration)
  from filtered_dataset
 
 -- To extract the hour, day, month and year from the datetime columns.

alter table filtered_dataset
add video_published_hour int,
video_published_day int,
video_published_month int,
video_published_year int,
video_tranding_day int,
video_tranding_month int,
video_tranding_year int,
channel_published_month int,
channel_published_year int;

update filtered_dataset
set video_published_hour=DATEPART(hour,video_published_at),
video_published_day=DATEPART(day,video_published_at),
video_published_month=DATEPART(MONTH,video_published_at),
video_published_year=DATEPART(YEAR,video_published_at),
video_tranding_day=DATEPART(DAY,video_trending_date),
video_tranding_month=DATEPART(MONTH,video_trending_date),
video_tranding_year=DATEPART(YEAR,video_trending_date),
channel_published_month=DATEPART(MONTH,channel_published_at),
channel_published_year=DATEPART(YEAR,channel_published_at);

alter table filtered_dataset
add video_published_weekday varchar(20),
video_tranding_weekday varchar(20);

update filtered_dataset
set video_published_weekday=DATENAME(weekday,video_published_at),
video_tranding_weekday=DATENAME(weekday,video_trending_date);

select *
from filtered_dataset


