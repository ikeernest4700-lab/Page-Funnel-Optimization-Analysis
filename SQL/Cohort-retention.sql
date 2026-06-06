
 WITH first_session AS (
         SELECT o.website_session_id,
            ((o.items_purchased)::double precision * o.price_usd) AS revenue,
            ((o.price_usd - o.cogs_usd) * (o.items_purchased)::double precision) AS profit,
            p.product_name
           FROM (orders o
             LEFT JOIN products p ON ((o.primary_product_id = p.product_id)))
          ORDER BY ((o.price_usd - o.cogs_usd) * (o.items_purchased)::double precision) DESC
        ), sessions AS (
         SELECT row_number() OVER (PARTITION BY w.user_id ORDER BY w.created_at) AS rn,
            w.website_session_id,
            w.user_id,
            w.created_at,
            f.product_name,
            f.revenue,
            f.profit,
            min(w.created_at) OVER (PARTITION BY w.user_id ORDER BY w.created_at) AS first_date,
            initcap((w.device_type)::text) AS device,
                CASE
                    WHEN ((w.utm_source)::text = 'bsearch'::text) THEN 'Bing Search'::text
                    WHEN ((w.utm_source)::text = 'gsearch'::text) THEN 'Google Search'::text
                    WHEN ((w.utm_source)::text = 'socialbook'::text) THEN 'Fcaebook/Social'::text
                    ELSE 'Other'::text
                END AS traffic_source
           FROM (website_sessions w
             LEFT JOIN first_session f ON ((w.website_session_id = f.website_session_id)))
        )
 SELECT rn,
    website_session_id,
    user_id,
    created_at,
	date_trunc('month', created_at) as created_tru
    product_name,
    revenue,
    profit,
    first_date,
    device,
    traffic_source,
        CASE
            WHEN (date_part('month'::text, age(created_at, first_date)) = (0)::double precision) THEN 'Month 0'::text
            WHEN (date_part('month'::text, age(created_at, first_date)) = (1)::double precision) THEN 'Month 1'::text
            WHEN (date_part('month'::text, age(created_at, first_date)) = (2)::double precision) THEN 'Month 2'::text
            WHEN (date_part('month'::text, age(created_at, first_date)) = (3)::double precision) THEN 'Month 3'::text
            WHEN (date_part('month'::text, age(created_at, first_date)) = (4)::double precision) THEN 'Month 4'::text
            WHEN (date_part('month'::text, age(created_at, first_date)) = (5)::double precision) THEN 'Month 5'::text
            ELSE 'Other Month'::text
        END AS cohort_month,
        CASE
            WHEN (revenue > (0)::double precision) THEN 'purchase'::text
            ELSE 'no purchase'::text
        END AS purchase_behaviour
   FROM sessions;
