{% set roles = ['data analyst', 'data engineer', 'data scientist'] -%}
{% for role in roles -%}
    
    select 
        search_term,
        count(*) as postings
    from {{ ref('stg_job_postings') }}
    where search_term = '{{ role | title}}'
    group by search_term
    {{ 'union all' if not loop.last}}
{%- endfor %}