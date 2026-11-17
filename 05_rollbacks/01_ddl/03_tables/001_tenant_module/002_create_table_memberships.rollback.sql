-- ==============================================================================
-- Script: 002_create_table_memberships.rollback.sql
-- Description: Drops the memberships table and associated objects.
-- Module: Rollbacks DDL Tables - Tenant Module
-- ==============================================================================

DROP TABLE IF EXISTS memberships CASCADE;
