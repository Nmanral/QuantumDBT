{% macro delete_prefix_model(prefix, materialization) %}

    {% set dev_schema = var('dev_database') %}
    {% set schema_name = dev_schema if dev_schema is not none else target.schema %}
    
    {% call statement('get_models', fetch_result=True) %}
        show {{materialization}}s in {{schema_name}} LIKE '{{prefix}}_*'
    {% endcall %}
        {% if load_result('get_models')['data']|length > 0 %}
            {%- for to_delete on load_result('get_models')['data'] %}
                {% call_statement() -%}
                    {% do log(to_delete, info=True) %}
                    drop {{materialization}} if exists {{to_delete[0]}}.{{to_delete[1]}} ;
                {% endcall_statement %}
            {%- endfor %}
        {% else %}
            {% do log('No models to delete with prefix' ~ prefix, info=True) %}
        {% endif %}
{% endmacro %}
