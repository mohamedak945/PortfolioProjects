-- Data Quick Exploration
SELECT * FROM online_courses_uses;

-- Checking Categories with top selling courses
SELECT Category, SUM(Enrolled_Students) AS Total_Students_Per_Category FROM online_courses_uses GROUP BY Category ORDER BY Total_Students_Per_Category DESC;


-- Checking Average Completion Rate Per Category
SELECT Category, AVG(`Completion_Rate (%)`) AS Average_Completion_Rate_Percent FROM online_courses_uses GROUP BY Category ORDER BY Average_Completion_Rate_Percent DESC;


-- Checking Top Platforms according to total enrolled students
SELECT Platform, SUM(Enrolled_Students) AS Total_Students_Per_Platform FROM online_courses_uses GROUP BY Platform order by Total_Students_Per_Platform DESC;


-- Checking Top category on each platform
WITH 
total_enrolled_per_category_per_platform AS(
SELECT Category, Platform, SUM(Enrolled_Students) AS total_enroll FROM online_courses_uses GROUP BY Category,PLATFORM ORDER BY Category
),
maximum_total_enrolled_per_category AS (
SELECT  Category, Platform, Max(total_enroll) OVER(partition by Category) AS maximum_total_enrolled FROM total_enrolled_per_category_per_platform
)
SELECT total_enrolled_per_category_per_platform.Category, total_enrolled_per_category_per_platform.Platform as "Top Platform",maximum_total_enrolled as "Total Enrolled" FROM total_enrolled_per_category_per_platform
JOIN maximum_total_enrolled_per_category
ON total_enrolled_per_category_per_platform.total_enroll = maximum_total_enrolled_per_category.maximum_total_enrolled AND total_enrolled_per_category_per_platform.PLATFORM = maximum_total_enrolled_per_category.PLATFORM  AND total_enrolled_per_category_per_platform.CATEGORY = maximum_total_enrolled_per_category.CATEGORY ; 
