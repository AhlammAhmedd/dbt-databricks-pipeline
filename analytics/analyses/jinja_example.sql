{% set roles = dbt_utils.get_column_values(table=ref('stg_job_postings'), column='search_term') %}
{% for role in roles -%}
    
    select 
        search_term,
        count(*) as postings
    from {{ ref('stg_job_postings') }}
    where search_term = '{{ role }}'
    group by search_term
    {{ 'union all' if not loop.last}}
{% endfor %}