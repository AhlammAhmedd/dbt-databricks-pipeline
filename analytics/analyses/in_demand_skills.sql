with job_postings as(
    select job_id
    from {{ ref('fct_job_postings') }}
    {% if  var('job_title', none) %}
    where search_term = '{{ var("job_title") }}'
    {% endif %}
),

bridge as(
    select *
    from {{ ref('bridge_job_skills') }}
),

skills as(
    select *
    from {{ ref('dim_skill') }}
)

select 
    display_name,
    category,
    count(distinct job_id) as demand_count,
    round(
        count(distinct job_id) / 
        (select count(distinct job_id) from job_postings) * 100,
        1) as demand_percentage
from bridge
inner join skills using (skill_id)
inner join job_postings using (job_id)
group by display_name, category
order by demand_count desc