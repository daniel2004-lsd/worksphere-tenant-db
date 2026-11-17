-- ==============================================================================
-- Script: 001_enable_uuid_extension.rollback.sql
-- Description: Drops the uuid-ossp extension.
-- Module: Rollbacks DDL Extensions
-- ==============================================================================

DROP EXTENSION IF EXISTS "uuid-ossp";
