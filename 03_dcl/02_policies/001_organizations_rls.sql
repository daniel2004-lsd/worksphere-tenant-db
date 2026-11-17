-- ==============================================================================
-- Script: 001_organizations_rls.sql
-- Description: Enables PostgreSQL Row-Level Security (RLS) on tenant tables.
-- Module: DCL Policies - Multi-Tenant Isolation
-- ==============================================================================

-- 1. Enable RLS on organizations
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE organizations FORCE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tenant_isolation_policy ON organizations;
CREATE POLICY tenant_isolation_policy ON organizations
    FOR ALL
    USING (
        tenant_id = current_setting('app.current_tenant_id', true)
        OR current_setting('app.current_tenant_id', true) = 'SYSTEM'
    )
    WITH CHECK (
        tenant_id = current_setting('app.current_tenant_id', true)
        OR current_setting('app.current_tenant_id', true) = 'SYSTEM'
    );

-- 2. Enable RLS on memberships
ALTER TABLE memberships ENABLE ROW LEVEL SECURITY;
ALTER TABLE memberships FORCE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tenant_isolation_policy ON memberships;
CREATE POLICY tenant_isolation_policy ON memberships
    FOR ALL
    USING (
        tenant_id = current_setting('app.current_tenant_id', true)
        OR current_setting('app.current_tenant_id', true) = 'SYSTEM'
    )
    WITH CHECK (
        tenant_id = current_setting('app.current_tenant_id', true)
        OR current_setting('app.current_tenant_id', true) = 'SYSTEM'
    );

-- 3. Enable RLS on outbox_events
ALTER TABLE outbox_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE outbox_events FORCE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tenant_isolation_policy ON outbox_events;
CREATE POLICY tenant_isolation_policy ON outbox_events
    FOR ALL
    USING (
        tenant_id = current_setting('app.current_tenant_id', true)
        OR current_setting('app.current_tenant_id', true) = 'SYSTEM'
    )
    WITH CHECK (
        tenant_id = current_setting('app.current_tenant_id', true)
        OR current_setting('app.current_tenant_id', true) = 'SYSTEM'
    );
