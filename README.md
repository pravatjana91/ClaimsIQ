# ClaimsIQ — Snowflake + MCP + Multi-Agent Project

ClaimsIQ is a hands-on project that builds a fraud/claims intelligence agent over Snowflake, exposes Snowflake capabilities through an MCP-style server, and then connects the same tools to LangGraph, CrewAI, and Swarm.

## Project flow

00. Snowflake setup + synthetic ClaimsIQ data
01. MCP server backed by Snowflake
02. LangGraph agent
03. CrewAI agent
04. Swarm agent
05. Compare the three approaches

## Setup

### 1. Create the environment file

Copy:

    .env.example

to:

    .env

Then fill in your real Snowflake and OpenAI values.

Do NOT commit `.env`.

### 2. Install packages

    pip install -r requirements.txt

### 3. Load `.env`

In a notebook/kernel, run:

```python
from dotenv import load_dotenv
load_dotenv()
```

The supplied notebooks currently expect environment variables to be available to the Python process. If your notebook environment does not automatically load `.env`, run the above before the Snowflake/LLM connection cells.

## Snowflake values

You need:

- Account identifier — from your Snowflake account details; do not include `.snowflakecomputing.com`
- Username — your Snowflake login
- Password — your Snowflake password, unless using key-pair authentication
- Warehouse — e.g. COMPUTE_WH
- Database — CLAIMSIQ
- Schema — PUBLIC
- Role — a role with the required CREATE/USAGE privileges; avoid ACCOUNTADMIN unless genuinely required

## Run order

Run the notebooks in this order:

    notebooks/00_snowflake_setup_and_seed_data.ipynb
    notebooks/01_mcp_server_snowflake.ipynb
    notebooks/02_langgraph_agent.ipynb
    notebooks/03_crewai_agent.ipynb
    notebooks/04_swarm_agent.ipynb
    notebooks/05_compare_all_three.ipynb

Notebook 00 creates the database/schema/tables and loads synthetic data, including the deterministic Ananya Rao scenario.

Notebook 01 creates `mcp_snowflake_server.py`. Later notebooks reuse that generated module.

## Important lab scenario

Customer ID:

    CUST99001

Customer:

    Ananya Rao

Claim:

    CLM99001

Order:

    ORD99001

The scenario includes a ₹45,000 festive-sale order, a pending claim, flagged transactions from unrecognized devices, and high-severity fraud signals.

## Security concept built into the lab

The MCP server includes a guardrail on the analytics tool so a destructive query such as:

    DELETE FROM CUSTOMERS WHERE 1=1

is rejected.

This gives you a natural bridge from agent construction to guardrails, authorization, least privilege, and tool security.

## Project structure

    ClaimsIQ/
    ├── .env.example
    ├── .gitignore
    ├── requirements.txt
    ├── README.md
    ├── notebooks/
    │   ├── 00_snowflake_setup_and_seed_data.ipynb
    │   ├── 01_mcp_server_snowflake.ipynb
    │   ├── 02_langgraph_agent.ipynb
    │   ├── 03_crewai_agent.ipynb
    │   ├── 04_swarm_agent.ipynb
    │   └── 05_compare_all_three.ipynb
    ├── sql/
    │   └── claimsiq_schema.sql
    └── src/

## Trainer recommendation

For a class, give each team its own Snowflake database/schema or a controlled schema and its own credentials/role. Do not distribute a shared ACCOUNTADMIN password. For the agent labs, use least-privilege roles and keep the warehouse small/auto-suspended to control cost.
"# ClaimsIQ" 
