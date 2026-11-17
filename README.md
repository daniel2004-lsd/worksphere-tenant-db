# WorkSphere — Tenant Database Migrations (`worksphere-tenant-db`)

[![Liquibase](https://img.shields.io/badge/Liquibase-5.0.2-blue.svg)](https://www.liquibase.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791.svg)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)]()

> **Autonomous Database Migration Repository** for the **Tenant Service** of the WorkSphere Platform.  
> Adheres strictly to the canonical architectural standard defined in `EcoRuteandoDb`.

---

## 🏛️ Repository Architecture

This repository operates independently from the application service codebase (`worksphere-tenant-service`). It contains all DDL, DML, DCL, and Rollback assets required to provision and maintain the `tenant_db` relational database.

```text
worksphere-tenant-db/
├── changelog/
│   └── db.changelog-master.yaml   # Canonical migration entrypoint
├── 01_ddl/                        # Data Definition Language (Tables, Extensions)
│   ├── 00_extensions/             # PostgreSQL extensions (uuid-ossp)
│   ├── 03_tables/001_tenant_module/ # organizations, memberships, outbox_events
│   └── changelog.yaml             # DDL orchestrator
├── 02_dml/                        # Data Manipulation Language (Initial seeds & patches)
│   └── changelog.yaml
├── 03_dcl/                        # Data Control Language (Row-Level Security & Grants)
│   ├── 02_policies/               # Multi-tenant RLS isolation policies
│   └── changelog.yaml
├── 05_rollbacks/                  # Strictly mapped 1-to-1 reverse migration scripts
│   ├── 01_ddl/
│   └── 03_dcl/
├── scripts/                       # Local execution automation
│   ├── run-local-update.sh
│   └── run-local-rollback.sh
├── liquibase.properties.example   # Configuration template
└── .gitignore
```

---

## 🛡️ Security & Multi-Tenancy Architecture

1. **Row-Level Security (RLS):**
   * Multi-tenant data segregation is strictly enforced inside the PostgreSQL engine kernel via `ENABLE ROW LEVEL SECURITY` and `FORCE ROW LEVEL SECURITY`.
   * Access requires the connection session to set `app.current_tenant_id`. Queries without matching tenant ID return zero rows.
   * Background transactional processors (such as the Outbox publisher) authenticate using `app.current_tenant_id = 'SYSTEM'`.

2. **Transactional Outbox (`outbox_events`):**
   * Guarantees atomic domain event emission to RabbitMQ within the same local database transaction, avoiding dual-write discrepancies.

---

## 🚀 Local Execution

### Prerequisites
* PostgreSQL 16 running locally (default: `localhost:5432/tenant_db`)
* Liquibase CLI 5.x installed

### Apply Migrations
```bash
./scripts/run-local-update.sh
```

### Rollback Last Changeset
```bash
./scripts/run-local-rollback.sh 1
```

---

## 📜 Branching Model

This repository adheres to the four-tier Git flow:
* `develop` (Active development)
* `qa` (Integration testing)
* `staging` (Pre-production smoke testing)
* `main` (Production baseline)
