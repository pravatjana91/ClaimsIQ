CREATE DATABASE IF NOT EXISTS CLAIMSIQ;
USE DATABASE CLAIMSIQ;
CREATE SCHEMA IF NOT EXISTS PUBLIC;
USE SCHEMA PUBLIC;

CREATE OR REPLACE TABLE CUSTOMERS (
    customer_id STRING PRIMARY KEY,
    name STRING,
    email STRING,
    signup_date DATE,
    account_risk_tier STRING,
    verified_devices STRING
);

CREATE OR REPLACE TABLE ORDERS (
    order_id STRING PRIMARY KEY,
    customer_id STRING,
    product_id STRING,
    product_name STRING,
    order_value NUMBER(10,2),
    order_ts TIMESTAMP_NTZ,
    device_id STRING,
    shipping_country STRING,
    is_festive_sale BOOLEAN
);

CREATE OR REPLACE TABLE CLAIMS (
    claim_id STRING PRIMARY KEY,
    order_id STRING,
    claim_reason STRING,
    claim_amount NUMBER(10,2),
    filed_ts TIMESTAMP_NTZ,
    status STRING
);

CREATE OR REPLACE TABLE TRANSACTIONS (
    txn_id STRING PRIMARY KEY,
    customer_id STRING,
    amount NUMBER(10,2),
    txn_ts TIMESTAMP_NTZ,
    device_id STRING,
    payment_method STRING,
    txn_status STRING
);

CREATE OR REPLACE TABLE FRAUD_SIGNALS (
    signal_id STRING PRIMARY KEY,
    customer_id STRING,
    signal_type STRING,
    severity STRING,
    detected_ts TIMESTAMP_NTZ
);
