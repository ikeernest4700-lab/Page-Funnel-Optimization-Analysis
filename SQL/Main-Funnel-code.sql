with step as (select 
website_session_id,
pageview_url,
created_at,
row_number() over (partition by website_session_id order by created_at) as rn
from website_pageviews),



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
)

select 
w.website_session_id,
w.created_at,
initcap(device_type) as device_type,
case when w.utm_source='bsearch' then 'Bing Search'
when w.utm_source='gsearch' then 'Google Search'
when w.utm_source='socialbook' then 'Facebook/Social'
else 'Other' end as traffic_source,
coalesce(o.items_purchased::numeric*o.price_usd::numeric,0) as sales ,

case when f.landing is not null then 1 else 0 end as landing,
case when f.product is not null then 1 else 0 end as product,
case when f.product_detail is not null then 1 else 0 end as product_detail,
case when f.cart is not null then 1 else 0 end as cart,
case when f.shipping is not null then 1 else 0 end as shipping,
case when f.billing is not null then 1 else 0 end as billing,
case when f.purchase is not null then 1 else 0 end as purchase

from website_sessions as w
join funnel as f
on w.website_session_id=f.website_session_id
left join orders as o
on w.website_session_id=o.website_session_id


