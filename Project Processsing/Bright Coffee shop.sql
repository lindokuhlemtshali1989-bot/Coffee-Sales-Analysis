Select 
transaction_id,
transaction_date,
transaction_time,
transaction_qty,
Store_id,
Store_location,
Product_id,
unit_price,
product_category,
Product_type,
Product_detail,
---Adding columns to enhanve the table for better insights
---New column added 1
Dayname(transaction_date) AS Day_name,
---New column added 2
Monthname(transaction_date) AS Month_name,
---New column added 3
Dayofmonth(transaction_date) AS Date_of_Month,
---New column added 4 Determining weekend/weekdays
CASE
WHEN dayname (transaction_date) IN ('sunday') THEN 'Weekend'
ELSE 'Weekday'
END AS DAY_classification,
---New column added 5- Time buckets
CASE
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '05:00:00' AND '08:59:59' THEN '01.Rush Hour'
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN '02.Midmorning'
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN '03.Afternoon'
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '16:00:00' AND '18:59:59' THEN '04.Rush Hour'
ELSE '05.night'
END AS Time_classification,
---New column added 6- Spend buckets
CASE
WHEN (transaction_qty*unit_price) <=50 THEN '01.Low Spend'
WHEN (transaction_qty*unit_price) BETWEEn 51 AND 200 THEN '02.Midium Spend'
WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03.Moreki'

ELSE '04.Blesser'
END AS spend_bucket,
transaction_qty*unit_price AS Ravenue
from `workspace`.`default`.`brightcoffee_consultation1`;
