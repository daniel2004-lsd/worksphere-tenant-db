#!/usr/bin/env bash
# ==============================================================================
# Script: run-local-update.sh
# Description: Executes Liquibase update against local PostgreSQL tenant_db
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

CLASSPATH="${REPO_ROOT}/lib/postgresql-42.7.4.jar"

echo "🚀 Running Liquibase update for worksphere-tenant-db..."
liquibase \
  --changelog-file=changelog/db.changelog-master.yaml \
  --search-path=. \
  --classpath="${CLASSPATH}" \
  --url=jdbc:postgresql://localhost:5432/tenant_db \
  --username=worksphere_admin \
  --password=worksphere_secret_password \
  update

echo "✅ Liquibase update completed successfully!"
