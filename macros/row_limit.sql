{% macro row_limit(limit) -%}
    {% if limit is not none and (target.name == 'dev' or target.name == 'ci') %}
        limit {{ limit }}
    {% else %}
        {% if target.name == 'dev' or target.name == 'ci' %}
            limit 1000
        {% endif %}
    {% endif %}
{%- endmacro %}