SELECT * FROM jobs_analysis.gsearch_jobs;

#Top hiring companies
SELECT company_name, COUNT(*) AS job_count
FROM jobs_analysis.gsearch_jobs
GROUP BY company_name
ORDER BY job_count DESC
LIMIT 10;

#Job postings by source (via)
SELECT via, COUNT(*) AS job_count
FROM jobs_analysis.gsearch_jobs
GROUP BY via
ORDER BY job_count DESC
LIMIT 10;

#Percentage of remote jobs
SELECT 
  ROUND(SUM(work_from_home) / COUNT(*) * 100, 2) AS remote_percentage
FROM jobs_analysis.gsearch_jobs;

#Full-time vs others
SELECT 
  CASE 
    WHEN schedule_type LIKE '%Full%' THEN 'Full Time'
    ELSE 'Other'
  END AS job_type,
  COUNT(*) AS job_count
FROM jobs_analysis.gsearch_jobs
GROUP BY job_type;


#Job title normalization impact
SELECT
    LOWER(title) AS normalized_title,
    COUNT(*) AS demand
FROM jobs_analysis.gsearch_jobs
GROUP BY LOWER(title)
HAVING COUNT(*) >= 20
ORDER BY demand DESC
LIMIT 10;

#Remote availability by job seniority (heuristic)
SELECT
    CASE
        WHEN title REGEXP 'Senior|Lead|Principal|Manager|Head|Director' THEN 'Senior'
        WHEN title REGEXP 'Junior|Entry|Intern|Associate' THEN 'Junior'
        ELSE 'Mid'
    END AS seniority_level,
    ROUND(SUM(work_from_home)/COUNT(*) * 100, 2) AS remote_pct
FROM jobs_analysis.gsearch_jobs
GROUP BY seniority_level;

#Employment structure of the market.
SELECT
  schedule_type,
  COUNT(*) AS job_count
FROM jobs_analysis.gsearch_jobs
GROUP BY schedule_type
ORDER BY job_count DESC
LIMIT 10;

#Skill demand frequency
SELECT
  description_tokens,
  COUNT(*) AS demand
FROM  jobs_analysis.gsearch_jobs
GROUP BY description_tokens
ORDER BY demand DESC
LIMIT 15;
