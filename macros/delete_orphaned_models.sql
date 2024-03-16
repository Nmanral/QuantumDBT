{% macro drop_orphaned_models(schema=target.schema, dryrun=True) %}


{# Get the models that currently exists in dbt #}
{% if execute %}
    {% set current_models = [] %}
    {% for node in graph.nodes.values() %}
        {% if node.resource_type == 'model' and node.name.startswith('mart') %}
            {% do current_models.append(node.alias | default(node.name)) %}
        {% endif %}
    {% endfor %}
{% endif %}


{# Get schema details for table names #}
{% set get_schema_details_query %}
    SHOW TABLES IN {{ schema }};
{% endset %}


{# Get all the tables from the schema #}
{% set schema_details = run_query(get_schema_details_query) %}
{% if execute %}
    {% set all_tables = [] %}
    {# Iterate over each row in the schema details set #}
    {% for row in schema_details.rows %}
        {% do all_tables.append(row[1]) %}
    {% endfor %}
{% endif %}


{# Find tables in all_tables not in current_models #}
{% if execute %}
    {%set drop_relations = [] %}
    {% for item in all_tables %}
        {% if item not in current_models %}
            {% do drop_relations.append(item) %}
        {% endif %}
    {% endfor %}
{% endif %}


{# Execute drop command for each relation #}
{% if drop_relations %}
    {% if dryrun | as_bool == False %}
        {% do log('Executing DROP commands...', True) %}
    {% else %}
        {% do log('Printing DROP commands...', True) %}
    {% endif %}
    {% for drop_relation in drop_relations %}
        {% do log(drop_relation, True) %}
        {% if dryrun | as_bool == False %}
            DROP TABLE {{ schema }}.drop_relation;
        {% endif %}
    {% endfor %}
{% else %}
    {% do log('No relation to clean', True) %}
{% endif %}

{% endmacro %}