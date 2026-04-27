/*
question: what are the most optimal skills to learn (its in high demand and a high paying skill) 
- Identify skills in high demand and associated with high average salary for Data Analyst roles
- Concentrate on remote positions with specified salaries
- Why? target skills that offer security (high demand) and financial benefits (high salaries), 
       offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
    SELECT
      skills_dim.skill_id,
      skills_dim.skills,
      COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE  
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- rewriting the whole quary consisely

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
Here are the key insights from the data:
The salary leaders vs. the volume leaders are very different skills. PySpark ($208K) and Bitbucket ($189K) command the highest salaries but have modest demand (111 and 38 listings). Meanwhile, the most in-demand skills — Pandas (291), Databricks (277), GCP (271), and Airflow (228) — offer solid but lower salaries in the $122K–$152K range. This classic supply-demand tension means niche expertise pays a premium.
Three distinct skill tiers emerge:

High-pay, low-supply: PySpark, Bitbucket, Watson, Couchbase, DataRobot — these are specialized tools where few candidates are available, pushing salaries above $155K. Worth learning if you want maximum earning potential.
Sweet-spot skills: Pandas, NumPy, Databricks, Airflow, Linux, GCP — high demand + strong $122K–$152K salaries. These are safe bets for job security and a well-paying career, especially for data engineers and ML practitioners.
Emerging DevOps/cloud tools: Kubernetes, GitLab, Jenkins, Atlassian — steady demand in the 39–57 range with salaries from $125K–$154K, reflecting the growing need for MLOps and cloud infrastructure expertise.

The Python data stack dominates in volume. Pandas, NumPy, scikit-learn, Jupyter, and PySpark together represent the core data science/ML toolkit — and they collectively account for the bulk of job listings, reinforcing Python's stranglehold on the data field.
Databricks and GCP are the ones to watch. Both have very high demand (277 and 271) and salaries above $122K, signaling strong enterprise adoption of cloud-native data platforms. Combining either with PySpark or Airflow would make for a very marketable profile.
*/

/*
[
  {
    "skill_id": 95,
    "skills": "pyspark",
    "demand_count": "111",
    "avg_salary": "208172"
  },
  {
    "skill_id": 218,
    "skills": "bitbucket",
    "demand_count": "38",
    "avg_salary": "189155"
  },
  {
    "skill_id": 85,
    "skills": "watson",
    "demand_count": "3",
    "avg_salary": "160515"
  },
  {
    "skill_id": 65,
    "skills": "couchbase",
    "demand_count": "1",
    "avg_salary": "160515"
  },
  {
    "skill_id": 206,
    "skills": "datarobot",
    "demand_count": "4",
    "avg_salary": "155486"
  },
  {
    "skill_id": 220,
    "skills": "gitlab",
    "demand_count": "57",
    "avg_salary": "154500"
  },
  {
    "skill_id": 35,
    "skills": "swift",
    "demand_count": "32",
    "avg_salary": "153750"
  },
  {
    "skill_id": 102,
    "skills": "jupyter",
    "demand_count": "83",
    "avg_salary": "152777"
  },
  {
    "skill_id": 93,
    "skills": "pandas",
    "demand_count": "291",
    "avg_salary": "151821"
  },
  {
    "skill_id": 59,
    "skills": "elasticsearch",
    "demand_count": "33",
    "avg_salary": "145000"
  },
  {
    "skill_id": 27,
    "skills": "golang",
    "demand_count": "6",
    "avg_salary": "145000"
  },
  {
    "skill_id": 94,
    "skills": "numpy",
    "demand_count": "171",
    "avg_salary": "143513"
  },
  {
    "skill_id": 75,
    "skills": "databricks",
    "demand_count": "277",
    "avg_salary": "141907"
  },
  {
    "skill_id": 169,
    "skills": "linux",
    "demand_count": "115",
    "avg_salary": "136508"
  },
  {
    "skill_id": 213,
    "skills": "kubernetes",
    "demand_count": "46",
    "avg_salary": "132500"
  },
  {
    "skill_id": 219,
    "skills": "atlassian",
    "demand_count": "43",
    "avg_salary": "131162"
  },
  {
    "skill_id": 250,
    "skills": "twilio",
    "demand_count": "4",
    "avg_salary": "127000"
  },
  {
    "skill_id": 96,
    "skills": "airflow",
    "demand_count": "228",
    "avg_salary": "126103"
  },
  {
    "skill_id": 106,
    "skills": "scikit-learn",
    "demand_count": "54",
    "avg_salary": "125781"
  },
  {
    "skill_id": 211,
    "skills": "jenkins",
    "demand_count": "39",
    "avg_salary": "125436"
  },
  {
    "skill_id": 238,
    "skills": "notion",
    "demand_count": "29",
    "avg_salary": "125000"
  },
  {
    "skill_id": 3,
    "skills": "scala",
    "demand_count": "110",
    "avg_salary": "124903"
  },
  {
    "skill_id": 57,
    "skills": "postgresql",
    "demand_count": "165",
    "avg_salary": "123879"
  },
  {
    "skill_id": 81,
    "skills": "gcp",
    "demand_count": "271",
    "avg_salary": "122500"
  },
  {
    "skill_id": 191,
    "skills": "microstrategy",
    "demand_count": "106",
    "avg_salary": "121619"
  }
]
*/

