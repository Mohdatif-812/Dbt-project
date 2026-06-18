select

    p.product_id,
    p.product_name,

    w.warehouse_name,

    sum(f.quantity) as inventory_quantity

from {{ ref('FACT_INVENTORY') }} f

left join {{ ref('dim_product') }} p
    on f.product_key = p.product_key

left join {{ ref('dim_warehouse') }} w
    on f.warehouse_key = w.warehouse_key

group by

    p.product_id,
    p.product_name,
    w.warehouse_name