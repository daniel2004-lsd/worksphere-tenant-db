-- ==============================================================================
-- Script: 001_create_table_organizations.sql
-- Description: Creates the organizations table representing tenant entities.
-- Module: DDL Tables - Tenant Module
-- ==============================================================================

CREATE TABLE IF NOT EXISTS organizations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id VARCHAR(64) NOT NULL UNIQUE,
    name VARCHAR(120) NOT NULL,
    slug VARCHAR(64) NOT NULL UNIQUE,
    admin_email VARCHAR(120) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_organizations_tenant_id ON organizations(tenant_id);
CREATE INDEX IF NOT EXISTS idx_organizations_slug ON organizations(slug);
