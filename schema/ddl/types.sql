-- ============================================================
-- BITS HYDERABAD CAMPUS SECURITY PATROLLING DATABASE
-- types.sql
-- PostgreSQL + PostGIS
-- ============================================================

CREATE EXTENSION IF NOT EXISTS postgis;

-- ============================================================
-- INCIDENT TYPES
-- ============================================================

DO $$
BEGIN
    CREATE TYPE incident_category AS ENUM (
        'Harassment',
        'Wildlife',
        'Theft',
        'Vandalism',
        'Altercation',
        'Fire',
        'Vehicle Accident',
        'Overcrowding',
        'Medical',
        'Event Emergency'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- INCIDENT SEVERITY
-- ============================================================

DO $$
BEGIN
    CREATE TYPE incident_severity AS ENUM (
        'Low',
        'Medium',
        'High',
        'Critical'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- INCIDENT STATUS
-- ============================================================

DO $$
BEGIN
    CREATE TYPE incident_status AS ENUM (
        'Reported',
        'Assigned',
        'Investigating',
        'Resolved',
        'Closed'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- GUARD STATUS
-- ============================================================

DO $$
BEGIN
    CREATE TYPE guard_status AS ENUM (
        'On Duty',
        'Off Duty',
        'On Patrol',
        'Busy',
        'Emergency'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- PATROL STATUS
-- ============================================================

DO $$
BEGIN
    CREATE TYPE patrol_status AS ENUM (
        'Scheduled',
        'Active',
        'Completed',
        'Cancelled'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- REQUEST STATUS
-- ============================================================

DO $$
BEGIN
    CREATE TYPE request_status AS ENUM (
        'Pending',
        'Accepted',
        'Rejected',
        'In Progress',
        'Completed',
        'Cancelled'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- COMPLAINT STATUS
-- ============================================================

DO $$
BEGIN
    CREATE TYPE complaint_status AS ENUM (
        'Pending',
        'Assigned',
        'Investigating',
        'Resolved',
        'Closed'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- CROWD LEVEL
-- ============================================================

DO $$
BEGIN
    CREATE TYPE crowd_level AS ENUM (
        'Low',
        'Medium',
        'High',
        'Critical'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- THREAT LEVEL
-- ============================================================

DO $$
BEGIN
    CREATE TYPE threat_level AS ENUM (
        'Low',
        'Moderate',
        'High'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;


-- ============================================================
-- LOST / FOUND STATUS
-- ============================================================

DO $$
BEGIN
    CREATE TYPE lost_found_status AS ENUM (
        'Reported',
        'Found',
        'Claimed',
        'Returned',
        'Closed'
    );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;