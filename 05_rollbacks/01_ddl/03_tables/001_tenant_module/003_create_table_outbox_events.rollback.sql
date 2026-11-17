-- ==============================================================================
-- Script: 003_create_table_outbox_events.rollback.sql
-- Description: Drops the outbox_events table and associated objects.
-- Module: Rollbacks DDL Tables - Tenant Module
-- ==============================================================================

DROP TABLE IF EXISTS outbox_events CASCADE;
