{{ config(
        schema='gmx_v2',
        alias = 'position_increase',
        post_hook='{{ expose_spells(\'["arbitrum", "avalanche_c"]\',
                                    "project",
                                    "gmx",
                                    \'["ai_data_master","gmx-io"]\') }}'
        )
}}

{%- set chains = [
    'arbitrum',
    'avalanche_c',
] -%}

{%- for chain in chains -%}
SELECT
    blockchain,
    block_time,
    block_date,
    block_number,
    tx_hash,
    index,
    contract_address,
    tx_from,
    tx_to,   
    event_name,
    msg_sender,
    account,
    market,
    collateral_token,
    size_in_usd,
    size_in_tokens,
    collateral_amount,
    borrowing_factor,
    funding_fee_amount_per_size,
    long_token_claimable_funding_amount_per_size,
    short_token_claimable_funding_amount_per_size,
    execution_price,
    index_token_price_max,
    index_token_price_min,
    collateral_token_price_max,
    collateral_token_price_min,
    size_delta_usd,
    size_delta_in_tokens,
    order_type,
    increased_at_time,
    collateral_delta_amount,
    price_impact_usd,
    price_impact_amount,
    is_long,
    order_key,
    position_key
FROM {{ ref('gmx_v2_' ~ chain ~ '_position_increase') }}
{% if not loop.last %}
UNION ALL
{% endif %}
{%- endfor -%}