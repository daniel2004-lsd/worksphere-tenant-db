-- ==============================================================================
-- Script: 001_create_table_organizations.rollback.sql
-- Description: Drops the organizations table and associated objects.
-- Module: Rollbacks DDL Tables - Tenant Module
-- ==============================================================================

DROP TABLE IF EXISTS organizations CASCADE;
