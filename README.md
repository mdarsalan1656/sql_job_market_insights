# 📊 Data Analyst Job Market Analysis — SQL Project

## Introduction

This project dives deep into the **data analyst job market** using SQL to answer the most pressing career questions for aspiring and practicing data professionals:

- *What are the highest-paying data analyst roles?*
- *Which skills are employers demanding the most?*
- *What skills command the best salaries?*
- *Which skills offer the best combination of demand AND pay?*

By querying a real-world dataset of job postings, this project surfaces actionable, data-driven insights to help job seekers make smarter decisions about which skills to build and which roles to target.

---

## Background

The data analytics job market is vast — and navigating it without data is ironic. This project was born out of a desire to answer a simple question: **if you want to break into or level up in data analytics, where should you invest your time?**

The dataset used spans thousands of job postings for data analyst roles, capturing:

- Job titles, locations, and companies
- Salary information (annual averages)
- Required skills per posting
- Remote/on-site classification

All five SQL queries in this project were written to target **remote data analyst roles** specifically, reflecting the modern reality that remote work has opened up global competition and opportunity in this field.

The questions explored follow a logical progression — from the broadest (what pays most?) to the most strategic (what skill is both in-demand *and* well-paid?):

1. Top-paying Data Analyst jobs
2. Skills required for those top-paying jobs
3. Most in-demand skills across all postings
4. Top-paying skills by average salary
5. Optimal skills — the sweet spot of high demand + high pay

---

## Tools Used

| Tool | Purpose |
|------|---------|
| **PostgreSQL** | Primary database engine for running all queries |
| **SQL** | Core language for all analysis — JOINs, CTEs, aggregations, filtering |
| **VS Code** | Writing and managing `.sql` files |
| **Git & GitHub** | Version control and project sharing |
| **JSON / CSV** | Output formats for query results, enabling downstream visualization |

---

## The Analysis

Each query was designed to answer a specific question. Here's a breakdown of the approach and findings:

### 1. 🏆 Top-Paying Data Analyst Jobs

**File:** `1_top_paying_jobs.sql`

```sql
SELECT job_title, salary_year_avg, name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
  AND job_location = 'Anywhere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

**Approach:** Filtered for remote (`'Anywhere'`) Data Analyst roles with non-null salaries, then ranked by salary descending.

**Key Findings:**
- The highest-paying role in the dataset — *Associate Director of Data Insights* at **AT&T** — offered an average salary of **$255,829**, showing that senior data roles can reach executive compensation levels.
- Top employers include major corporations across tech, finance, and telecommunications.
- The salary range across the top 10 stretches from ~$184K to $255K, indicating a wide premium for the most senior or specialized roles.

![Top 10 Highest-Paying Remote Data Analyst Jobs](assets\1_top_paying_jobs.png)

---

### 2. 💼 Skills for Top-Paying Jobs

**File:** `2_top_paying_skills.sql`

**Approach:** Built on Query 1 by joining in the skills associated with each top-paying job posting.

**Key Findings:**
- Top-paying roles consistently require a **multi-skill stack** — not just SQL alone.
- Skills like **SQL, Python, Tableau, R, Snowflake, and Pandas** appear repeatedly across the highest-paying postings.
- This confirms that salary premiums reward breadth combined with depth.

---

### 3. 📈 Most In-Demand Skills

**File:** `3_indemand_skills.sql`

```sql
SELECT skills, COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```

**Results:**

| Skill | Demand Count |
|-------|-------------|
| SQL | 7,291 |
| Excel | 4,611 |
| Python | 4,330 |
| Tableau | 3,745 |
| Power BI | 2,609 |

**Key Findings:**
- **SQL is undisputed #1** — appearing in nearly 2x as many postings as the next skill. It is non-negotiable for any data analyst.
- **Excel still holds strong at #2**, edging out Python — a reminder that business-facing analyst roles still rely heavily on spreadsheets.
- **Tableau + Power BI combined** represent 6,354 listings, nearly rivalling SQL alone, confirming that data visualization is a core skill, not a nice-to-have.
- **Practical takeaway:** SQL → Python → one BI tool (Tableau or Power BI) covers the three highest-demand skill categories.

![Top 5 Most In-Demand Skills for Remote Data Analysts](assets\3_indemand_skills.png)

---

### 4. 💰 Top-Paying Skills by Average Salary

**File:** `4_top_paying_indemand_skills.sql`

**Approach:** Calculated average salary for each skill across all Data Analyst postings with specified salaries, then ranked by average salary descending.

**Top 10 Results:**

| Skill | Avg Salary |
|-------|-----------|
| PySpark | $208,172 |
| Bitbucket | $189,155 |
| Couchbase | $160,515 |
| Watson | $160,515 |
| DataRobot | $155,486 |
| GitLab | $154,500 |
| Swift | $153,750 |
| Jupyter | $152,777 |
| Pandas | $151,821 |
| Elasticsearch | $145,000 |

**Key Findings:**
- **Big Data and Machine Learning skills dominate** the salary charts — PySpark, Pandas, NumPy, Databricks, scikit-learn, and Jupyter all feature in the top 25.
- **Four salary tiers** emerge naturally:
  - *Elite ($180K+):* PySpark, Bitbucket — rare, specialized, and very well paid.
  - *Senior ($150–179K):* Watson, DataRobot, GitLab, Jupyter, Pandas — premium tools for specialist roles.
  - *Mid ($130–149K):* Golang, NumPy, Databricks, Linux, Kubernetes.
  - *Base (sub-$130K):* Airflow, scikit-learn, Scala, PostgreSQL, GCP — all still clearing $120K+.
- Even the **lowest-ranked skill** in the top 25 (MicroStrategy) averages above **$121K**, meaning any investment in this list pays off financially.

![Top 25 Highest-Paying Skills for Data Analysts](assets\4_top_paying_skills.png)

---

### 5. 🎯 Optimal Skills — High Demand + High Pay

**File:** `5_optimal_skills.sql`

**Approach:** Combined demand counts and salary averages using a CTE (and later a more concise single query), filtering only skills with more than 10 job postings to remove statistical noise.

**Key Findings:**
- **PySpark ($208K, 111 listings)** and **Bitbucket ($189K, 38 listings)** sit at the top — high reward but narrower paths.
- The true **sweet-spot skills** are those combining strong demand with excellent pay:
  - **Pandas** — 291 listings, $151K avg
  - **Databricks** — 277 listings, $141K avg
  - **GCP** — 271 listings, $122K avg
  - **Airflow** — 228 listings, $126K avg
- **Databricks and GCP** stand out as particularly investable: both have very high demand reflecting strong enterprise adoption of cloud-native data platforms.
- The **Python data stack** (Pandas, NumPy, scikit-learn, Jupyter, PySpark) collectively dominates volume, reinforcing Python's centrality in data careers.

![Optimal Skills: High Demand × High Pay](assets\5_optimal_skills.png)

> *Each bubble represents a skill. The dashed lines mark the median demand and salary — skills in the top-right quadrant offer the best of both worlds.*

---

## Learnings

Working through this project produced several meaningful takeaways — both technical and strategic:

**SQL Skills Strengthened:**
- Writing multi-table **JOINs** across fact and dimension tables
- Using **CTEs (Common Table Expressions)** to modularize complex queries before refactoring them into concise single queries
- Applying **aggregate functions** (`COUNT`, `AVG`, `ROUND`) with `GROUP BY` for meaningful summarization
- Using **`HAVING`** to filter on aggregated values (vs. `WHERE` for row-level filtering)
- Combining **`ORDER BY`** with `LIMIT` to surface ranked results efficiently

**Analytical Thinking:**
- The importance of framing the *right questions* before writing a single line of SQL — each query was designed with a specific career insight goal in mind.
- Learning to cross-reference findings across queries (e.g., overlaying demand data onto salary data) yields far richer insights than any single query alone.
- Statistical caution matters: filtering for `demand_count > 10` in Query 5 prevents rare-skill outliers from distorting averages.

**Career Insights:**
- There is a real and measurable tension between *in-demand* skills (SQL, Excel, Python) and *highest-paying* skills (PySpark, Bitbucket, niche ML tools). Aligning career strategy means consciously choosing a point on that spectrum.
- The data strongly supports investing in the Python data stack + one BI tool + cloud platform as the foundation for a well-rounded, financially rewarding data analyst career.

---

## Conclusion

This SQL project set out to answer one core question: **where should a data analyst invest their time to maximize both employability and earning potential?**

The data delivers a clear answer:

1. **SQL is the foundation** — no other skill comes close in terms of raw demand. Master it first.
2. **Python unlocks the premium tier** — through libraries like Pandas, NumPy, and PySpark, Python knowledge directly correlates with higher salaries.
3. **Cloud and big data platforms are the next frontier** — Databricks, GCP, and Airflow represent the growing enterprise data engineering layer that commands both high demand and strong pay.
4. **Visualization is non-negotiable** — Tableau or Power BI appear in thousands of postings; data storytelling is a core part of the analyst role.
5. **Niche specializations pay a premium** — if maximum salary is the goal, deep expertise in tools like PySpark or Bitbucket yields outsized returns, though with a narrower job market.

The most strategically sound path: build SQL fluency → develop Python data stack proficiency → add one BI tool → layer in cloud platform knowledge (Databricks or GCP). That combination covers the highest combined demand while positioning well into the $120K–$150K+ salary range for remote roles.

---

*Data source: Job postings dataset covering remote Data Analyst roles with salary information.*  
*All salary figures are USD annual averages.*
