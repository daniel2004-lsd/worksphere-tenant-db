#!/usr/bin/env bash
# ==============================================================================
# Script: run-local-rollback.sh
# Description: Rolls back Liquibase changesets by count or tag
# Usage: ./scripts/run-local-rollback.sh [count] (default: 1)
# ==============================================================================
set -euo pipefail

COUNT="${1:-1}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

CLASSPATH="${REPO_ROOT}/lib/postgresql-42.7.4.jar"

echo "⚠️ Rolling back ${COUNT} Liquibase changeset(s) on tenant_db..."
liquibase \
  --changelog-file=changelog/db.changelog-master.yaml \
  --search-path=. \
  --classpath="${CLASSPATH}" \
  --url=jdbc:postgresql://localhost:5432/tenant_db \
  --username=worksphere_admin \
  --password=worksphere_secret_password \
  rollback-count --count="${COUNT}"

echo "✅ Liquibase rollback completed successfully!"
