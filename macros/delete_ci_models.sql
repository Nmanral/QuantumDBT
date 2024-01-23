{% macro delete_ci_models(pr_id, materialization) -%}

    {%- set dev_schema = var('dev_database') -%}
    {%- set schema_name = dev_schema if dev_schema is not none else target.schema -%}
    
    {% call statement('get_pr_tables', fetch_result=True) %}
        show {{materialization}} in {{schema_name}} LIKE 'pr_{{pr_id}}*'
    {% endcall %}
        
        {%- for to_delete on load_result('get_pr_tables')['data'] %}
        {% call_statement() -%}
            {% do log(to_delete, info=True) %}
            drop {{materialization}} if exists {{to_delete[0]}}.{{to_delete[1]}} ;
        {% endcall_statement %}
    {%- endfor %}

{% endmacro %}
