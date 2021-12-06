

  create  table "demo_dbt"."public"."fct_orders__dbt_tmp"
  as (
    with orders as(
    select * from "demo_dbt"."public"."stg_orders"

),

payments as (
    select * from "demo_dbt"."public"."stg_payments"
),

order_payments as (
    select
    payments.order_id,
    sum(payments.amount) as amount

    from payments
    group by 1
    
),

final as (
    select 
    orders.order_id,
    orders.customer_id,
    order_payments.amount

    from orders
    left join order_payments using (order_id)
)
select * from final
  );