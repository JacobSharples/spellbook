{{ config(
        schema='evms',
        alias = 'logs_decoded',
        unique_key=['blockchain', 'tx_hash'],
        post_hook='{{ expose_spells(\'["ethereum", "polygon", "bnb", "avalanche_c", "gnosis", "fantom", "optimism", "arbitrum", "celo", "base", "zksync", "zora", "scroll", "linea", "zkevm", "blast", "mantle", "ronin", "ink"]\',
                                    "sector",
                                    "evms",
                                    \'["hildobby"]\') }}'
        )
}}

{% set decodedlogs_models = [
     ('ethereum', source('ethereum', 'logs_decoded'))
     , ('polygon', source('polygon', 'logs_decoded'))
     , ('bnb', source('bnb', 'logs_decoded'))
     , ('avalanche_c', source('avalanche_c', 'logs_decoded'))
     , ('gnosis', source('gnosis', 'logs_decoded'))
     , ('fantom', source('fantom', 'logs_decoded'))
     , ('optimism', source('optimism', 'logs_decoded'))
     , ('arbitrum', source('arbitrum', 'logs_decoded'))
     , ('celo', source('celo', 'logs_decoded'))
     , ('base', source('base', 'logs_decoded'))
     , ('zksync', source('zksync', 'logs_decoded'))
     , ('zora', source('zora', 'logs_decoded'))
     , ('scroll', source('scroll', 'logs_decoded'))
     , ('linea', source('linea', 'logs_decoded'))
     , ('zkevm', source('zkevm', 'logs_decoded'))
     , ('blast', source('blast', 'logs_decoded'))
     , ('mantle', source('mantle', 'logs_decoded'))
     , ('sei', source('sei', 'logs_decoded'))
     , ('ronin', source('ronin', 'logs_decoded'))
     , ('ink', source('ink', 'logs_decoded'))
] %}

SELECT *
FROM (
        {% for decodedlogs_model in decodedlogs_models %}
        SELECT
        '{{ decodedlogs_model[0] }}' AS blockchain
        , block_time
        , block_number
        , index
        , contract_address
        , event_name
        , namespace
        , signature
        , tx_hash
        FROM {{ decodedlogs_model[1] }}
        {% if not loop.last %}
        UNION ALL
        {% endif %}
        {% endfor %}
        );