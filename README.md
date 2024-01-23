# 👋 Hi, Welcome to QuantumDBT

> [!IMPORTANT]
> This DBT Project is an example of organizing your DBT project to leverage the best out of DBT.

## Table of Content
- [Overview](#overview)
- [Objectives](#objectives)
- [Features](#features)


## 🔥 Features
### 1. macros

Macros are one of the most powerful features in dbt, that help us achieve DRY methodology in DBT.
To explain in laymen terms macros in dbt is a reusable piece of code that you can invoke in your SQL files.
Macros are written in [Jinja](https://documentation.bloomreach.com/engagement/docs/jinja-syntax), a templating language, and allow for dynamic generation of SQL queries.

#### Example:
```jinja
{% macro generate_date_series(start_date, end_date) %}
select 
    series::date as date
from 
    generate_series({{ start_date }}, {{ end_date }}, interval '1 day') as series
{% endmacro %}
```

This macro generates a series of dates from start_date to end_date. You can use it in your models to create date dimensions or fill in gaps in time series data.

### 2. sqlfluff
When working with a big team it is very difficult to get everyone to follow certain standard in SQL code, sqlfluff comes as a saviour in that case. SQLFluff is an open-source SQL linter and auto-formatter designed to improve the readability and maintainability of SQL code.

Using sqlfluff with dbt is a great way to make standardized SQL code throughout the team. SQLFluff works with databricks which I have used here in this repository. You can find a github action that uses SQLFLuff to monitor the SQL code that getspushed to the repository.

The [github](https://github.com/Nmanral/QuantumDBT/blob/main/.github/worklfows/sql-lint.yml) action gets triggered for any pull request which is opened and synchronized and checks the linting and formatting of any SQL file if any within that pull request and adds a comment in the pull request with the formatted SQL file with the rules defined under [.sqlfluff](https://github.com/Nmanral/QuantumDBT/blob/main/.sqlfluff) file.

### 3. github actions
If you haven't used [github actions](https://github.com/features/actions) yet, you are missing out on a lot of cool stuff that canbe achieved for your CI/CD process.

I have some github actions defined in this repo, that I found helpful in making our CI/CD process very insightful and smooth.

> [!IMPORTANT]
> I have another [repo](https://github.com/Nmanral/gitops) where I put github actions that I create to ease our process for other workflow as well

### More documentation to be added soon.