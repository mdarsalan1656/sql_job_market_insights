/*

Question: What are the most in-demand skills for data analysts?
- join job posting to inner join table similar to quarry 2
- identify the top 5 in-demand skills for a data analyst
- focus on all job postings
- why? retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers
*/

SELECT
      skills,
      COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY 
    demand_count DESC
LIMIT 5

/*
Here are the key insights from this dataset:
SQL is undisputed king. With 7,291 listings, it accounts for 32% of all top-5 demand — nearly 2.8× more than Power BI (#5) and 58% more than Excel (#2). For any data role, SQL is non-negotiable.
The big cliff after SQL. There's a sharp drop of 2,680 listings between SQL and Excel — by far the largest gap in the ranking. After that, Excel, Python, and Tableau cluster much more closely together (within ~870 listings of each other), suggesting roughly equal demand among the three.
Excel still holds strong at #2. Despite being decades old, Excel (4,611) edges out Python (4,330) — a reminder that many business and analyst roles still rely heavily on spreadsheets, especially in non-tech industries.
Python vs. Tableau is a near tie. Only 585 listings separate them (4,330 vs 3,745). Python skews toward data science/engineering roles, while Tableau is BI/reporting-focused — so the choice between them depends on which career track you're targeting.
The visualisation tools together are formidable. Tableau + Power BI combined = 6,354 listings, which nearly rivals SQL on its own. Data visualisation is clearly a core required skill, not a nice-to-have.
Practical takeaway: If you're building a data career from scratch, prioritize SQL → Python → one BI tool (Tableau or Power BI). That combination covers the three skill categories with the highest combined demand.
*/

/*
[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/