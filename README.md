# Customer-retention-revenue-analysis
Customer journey analysis focused on funnel optimization and cohort retention to uncover conversion losses, churn behavior, and revenue improvement opportunities.
## Project 2: Funnel Optimization & Cohort Retention Analysis

**Live Assets**: [Project 2 Folder (Dashboards, PDFs, SQL)](https://drive.google.com/drive/folders/1dTU5CpzmJBNrTkHeOSnLvu6AkfCnlwlp?usp=drive_link)

---

## Business Problem
In the 2012–2015 e-commerce dataset for **Mr Fuzzy Teddy Bear Store**, significant drop-offs in the purchase funnel (especially Product Detail to Cart) and high customer churn were causing major revenue leakage.

The goal was to:
- Identify where users drop off in the funnel
- Segment performance by product, device, and campaign source
- Quantify the financial impact of conversion loss and churn

---

## Tools Used
- **SQL** : Data extraction, cleaning, joins, segmentation
- **Excel** :Basic data validation and inspection
- **Power BI** :KPI creation (DAX measures), funnel visualization, cohort analysis, interactive dashboards
- **Methods** : Funnel Analysis, Cohort Analysis, Segmentation, ROI Estimation

---

## Solution & Approach
- Built a **Funnel Optimization Dashboard** in Power BI covering:
  Landing → Product Detail → Cart → Shipping → Billing → Purchase
- Performed segmentation analysis by:
  - Product
  - Device type
  - Campaign source
- Extended analysis into **Cohort Retention Analysis** to evaluate churn and repeat purchase behavior

---

## SQL Data Preparation (Sample)

SQL was used to clean, transform, and structure data before loading into Power BI for analysis.

```sql

funnel as (
select 
distinct website_session_id,
max(case when pageview_url in ( '/home', '/lander-1','/lander-2','/lander-2','/lander-3','/lander-4','/lander-5')
then rn end) as landing,
max(case when pageview_url= '/products' then rn end) as product,
  max( case when  pageview_url IN (
            '/the-birthday-sugar-panda',
            '/the-forever-love-bear',
            '/the-hudson-river-mini-bear',
            '/the-original-mr-fuzzy') then rn end ) as product_detail,
max(case when pageview_url='/cart' then rn  end) as cart,
max(case when pageview_url ='/shipping' then rn end) as shipping,
max(case when pageview_url in ('/billing', '/billing-2') then rn end) as billing,
max(case when pageview_url ='/thank-you-for-your-order' then rn end) as purchase

from step 
group by 1
```
[View live funnel SQL codes for Power Bi Reporting](SQL/Main-Funnel-Code.sql)

[View live chort retention SQL codes for Power Bi Reporting](SQL/cohort-retention.sql)

---

## Insights Dashboard View

![Funnel Insights](images/funnel.png)



## Key Metrics & Findings

### Funnel Performance
- Product Detail Reach: **210.21K**
- Cart Reach: **94.95K**
- Users Lost: **115.3K**
- Drop-off Rate: **54.83%**
- Estimated Revenue Loss: **$3.19M**

---

### Product-Level Drop-off
- Mr Fuzzy: **56.96%**
- Sugar Panda: **53.74%**
- Hudson River: **34.87%**

---

### Campaign Source Impact
- Google Search: **54.93% drop-off**

---

### Device Performance
- Desktop: **53.95%**
- Mobile: **57.88%**

---

## Cohort Retention Analysis
- Overall Churn Rate: **88.87%**
- Estimated Revenue Loss from Churn: **$2.29M**
- Repeat Purchase Rate: **1.86%**
- Median Time to Repeat Purchase: **31 days**

## Insights Dashboard View

![Cohort Insights](images/cohort.png)

[live link to full report]()
---

## Business Impact & Recommendations

A **10% improvement in Product → Cart conversion** could generate:
- **$581K additional revenue**
- **7,154 additional orders**

---

## Key Insights
- Major funnel leakage occurs at Product Detail → Cart stage
- Mr Fuzzy products and Google Search traffic are the highest-value drop-off points
- High churn indicates weak retention and engagement issues

---

## Recommendations
- Improve Product Detail UX (images, reviews, pricing clarity)
- Optimize Google Search landing experience through A/B testing
- Implement cart abandonment recovery strategies (email/SMS incentives)
- Develop retention strategies for high-churn cohorts

---

## Overall Business Impact
- **Project 1**: Landing page optimization → **$1.18M potential recovery**
- **Project 2**: Funnel + churn optimization → **$5.48M+ combined opportunity**

---

## Conclusion
This project demonstrates the ability to transform raw data using SQL, build KPI-driven dashboards in Power BI, and generate revenue-focused insights through funnel and cohort analysis.

---

## Contact
- LinkedIn: https://www.linkedin.com/in/emeka-ike-108748198/
- Email: ikeernest4700@gmail.com
- Open to entry-level Data Analyst roles, collaborations, or feedback
