-- ==============================================================================
-- Script: 001_enable_uuid_extension.sql
-- Description: Enables the uuid-ossp extension for UUID generation functions.
-- Module: DDL Extensions
-- ==============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
