/*
Question: What are the top paying skills based on salary?
- Look at average salary associated with each skill for Data Analyst position
- Focuses on role with specified salaries, regardless of location
- why? it reveals how different skills impact salary levels for Data Analysts and 
       helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
      skills,
      Round(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25

/*
Here are the key insights from the top-paying skills data:
Big Data / ML skills absolutely dominate the salary charts. 11 of the 25 skills fall into this category — PySpark, Watson, Couchbase, DataRobot, Jupyter, Pandas, Elasticsearch, NumPy, Databricks, Airflow, and scikit-learn. Their category average sits highest of all groups, confirming that data engineering and machine learning expertise is the most rewarded specialization in the market right now.
Four salary tiers tell a clear story:

The elite tier ($180K+) has just 2 skills — PySpark ($208K) and Bitbucket ($189K). Their rarity signals that these are deeply specialized, niche competencies where talent supply is genuinely scarce.
The senior tier ($150–179K) clusters 8 skills including Watson, Couchbase, DataRobot, GitLab, Swift, Jupyter, Pandas, and Elasticsearch — premium tools for senior/specialist roles.
The mid tier ($130–149K) covers solid mainstream tools: Golang, NumPy, Databricks, Linux, and Kubernetes.
The base tier (sub-$130K) still pays extremely well by any standard — Airflow, scikit-learn, Scala, PostgreSQL, GCP all clearing $120K+.

DevOps/Infra is the most consistent category. Bitbucket, GitLab, Linux, Kubernetes, and Jenkins span a wide salary range, but Bitbucket and GitLab sitting in the top 6 suggests companies pay a premium for engineers who understand the full software delivery pipeline, not just coding.
Cross-referencing with the previous demand data reveals a strategic sweet spot. Skills like Databricks (277 listings, $142K avg) and Airflow (228 listings, $126K avg) offer the best combination of high demand AND strong salary — making them the most investable skills for career ROI. PySpark pays the most but has far fewer openings, so it's a high-reward, narrower-path bet.
The floor is still $121K. Even the lowest-ranked skill in this top-25 list (MicroStrategy) pays above six figures — reinforcing that any technical upskilling toward this list is financially worthwhile.
*/

/*
[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_salary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skills": "gcp",
    "avg_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "121619"
  }
]
*/