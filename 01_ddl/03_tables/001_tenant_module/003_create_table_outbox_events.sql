-- ==============================================================================
-- Script: 003_create_table_outbox_events.sql
-- Description: Creates the transactional outbox_events table for asynchronous messaging.
-- Module: DDL Tables - Tenant Module
-- ==============================================================================

CREATE TABLE IF NOT EXISTS outbox_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id VARCHAR(64) NOT NULL,
    aggregate_type VARCHAR(60) NOT NULL,
    aggregate_id VARCHAR(64) NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    payload JSONB NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    retry_count INT NOT NULL DEFAULT 0,
    last_error TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_outbox_events_status_created 
    ON outbox_events (status, created_at) 
    WHERE status = 'PENDING';

CREATE INDEX IF NOT EXISTS idx_outbox_events_tenant_id 
    ON outbox_events (tenant_id);
