{% macro standard_text(column_name) %}
    upper(trim({{ column_name }}))
{% endmacro %}

{% macro clean_email(column_name) %}
    case
        when lower(trim({{ column_name }})) like '%@gmail.com'
          or lower(trim({{ column_name }})) like '%@example.com'
        then lower(trim({{ column_name }}))
        else null
    end
{% endmacro %}

{% macro clean_phone(column_name) %}
    case
        when length(regexp_replace({{ column_name }}, '[^0-9]', '')) >= 10
        then right(regexp_replace({{ column_name }}, '[^0-9]', ''), 10)
        else null
    end
{% endmacro %}

{% macro clean_address(column_name) %}
    trim(
        regexp_replace(
            upper({{ column_name }}),
            '[0-9]',
            ''
        )
    )
{% endmacro %}

{% macro negative_to_zero(column_name) %}
    case
        when {{ column_name }} < 0 then 0
        else {{ column_name }}
    end
{% endmacro %}

{% macro clean_amount(column_name) %}
    round({{ column_name }}, 0)
{% endmacro %}

{% macro latest_record(pk_col, ts_col) %}
    qualify row_number() over (
        partition by {{ pk_col }}
        order by {{ ts_col }} desc
    ) = 1
{% endmacro %}