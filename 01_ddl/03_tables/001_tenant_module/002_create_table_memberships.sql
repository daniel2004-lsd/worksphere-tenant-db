-- ==============================================================================
-- Script: 002_create_table_memberships.sql
-- Description: Creates the memberships table associating users with organizations.
-- Module: DDL Tables - Tenant Module
-- ==============================================================================

CREATE TABLE IF NOT EXISTS memberships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id VARCHAR(64) NOT NULL,
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    user_id VARCHAR(64) NOT NULL,
    email VARCHAR(120) NOT NULL,
    role VARCHAR(40) NOT NULL,
    department VARCHAR(60),
    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_memberships_org_user UNIQUE (organization_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_memberships_tenant_id ON memberships(tenant_id);
CREATE INDEX IF NOT EXISTS idx_memberships_user_id ON memberships(user_id);
CREATE INDEX IF NOT EXISTS idx_memberships_email ON memberships(email);
