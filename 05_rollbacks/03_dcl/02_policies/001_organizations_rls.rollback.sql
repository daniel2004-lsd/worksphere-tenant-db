-- ==============================================================================
-- Script: 001_organizations_rls.rollback.sql
-- Description: Drops RLS policies and disables RLS on tenant tables.
-- Module: Rollbacks DCL Policies
-- ==============================================================================

DROP POLICY IF EXISTS tenant_isolation_policy ON organizations;
ALTER TABLE organizations NO FORCE ROW LEVEL SECURITY;
ALTER TABLE organizations DISABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tenant_isolation_policy ON memberships;
ALTER TABLE memberships NO FORCE ROW LEVEL SECURITY;
ALTER TABLE memberships DISABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tenant_isolation_policy ON outbox_events;
ALTER TABLE outbox_events NO FORCE ROW LEVEL SECURITY;
ALTER TABLE outbox_events DISABLE ROW LEVEL SECURITY;
