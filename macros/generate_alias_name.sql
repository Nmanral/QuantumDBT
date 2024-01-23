{% macro generate_alias_name(custom_alias_name=none, node=none) %}
    {% if target.name == 'ci' %}
        {{ 'pr_' ~ env_var("DBT_PR_ID") ~ '_' ~ node.name }}
    {% elif target.name == 'dev' %}
        {{ env_var("DBT_USERNAME") ~ '_' ~ node.name }}
    {% else %}
        {% if custom_alias_name is none %}
            {{ node.name }}
        {% else %}
            {{ custom_alias_name | trim }}
        {% endif %}
    {% endif %}
{% endmacro %}