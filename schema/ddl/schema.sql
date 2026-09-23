-- ============================================================
-- BITS HYDERABAD CAMPUS SECURITY PATROLLING DATABASE
-- schema.sql
-- ============================================================

-- Run types.sql BEFORE this file.
-- PostGIS must already be installed.

-- ============================================================
-- 1. STUDENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS students (
    student_id      INTEGER PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    gender          VARCHAR(20),
    phone           VARCHAR(15),
    email           VARCHAR(150) UNIQUE,
    hostel          VARCHAR(100),
    room_number     VARCHAR(20),
    program         VARCHAR(100),
    year_of_study   INTEGER,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 2. GUARDS
-- ============================================================

CREATE TABLE IF NOT EXISTS guards (
    guard_id            INTEGER PRIMARY KEY,
    name                VARCHAR(100) NOT NULL,
    phone               VARCHAR(15),
    gender              VARCHAR(20),
    shift               VARCHAR(30),
    status              guard_status DEFAULT 'Off Duty',

    -- Current location of guard
    duty_location       GEOGRAPHY(Point,4326),

    -- Current assigned security zone
    current_zone_id     INTEGER,

    joined_date         DATE
);


-- ============================================================
-- 3. SECURITY ZONES
-- ============================================================

CREATE TABLE IF NOT EXISTS security_zones (
    zone_id             INTEGER PRIMARY KEY,
    zone_name           VARCHAR(100) NOT NULL,
    threat_level        threat_level NOT NULL,
    incharge_guard_id   INTEGER,

    -- Polygon representing the zone
    boundary            GEOMETRY(Polygon,4326) NOT NULL,

    description         TEXT
);


-- Add FK between guards and zones
ALTER TABLE guards
DROP CONSTRAINT IF EXISTS fk_guard_zone;

ALTER TABLE guards
ADD CONSTRAINT fk_guard_zone
FOREIGN KEY (current_zone_id)
REFERENCES security_zones(zone_id);


ALTER TABLE security_zones
DROP CONSTRAINT IF EXISTS fk_zone_guard;

ALTER TABLE security_zones
ADD CONSTRAINT fk_zone_guard
FOREIGN KEY (incharge_guard_id)
REFERENCES guards(guard_id);


-- ============================================================
-- 4. INCIDENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS incidents (
    incident_id         INTEGER PRIMARY KEY,
    category             incident_category NOT NULL,
    severity             incident_severity NOT NULL,
    description          TEXT NOT NULL,

    location             GEOGRAPHY(Point,4326),

    reported_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    reported_by_student  INTEGER,
    assigned_guard_id    INTEGER,

    status               incident_status DEFAULT 'Reported',

    resolved_at          TIMESTAMP,
    resolution_summary   TEXT
);


-- ============================================================
-- 5. INCIDENT PERSONS
-- ============================================================

CREATE TABLE IF NOT EXISTS incident_person (
    incident_person_id   SERIAL PRIMARY KEY,
    incident_id          INTEGER NOT NULL,
    student_id           INTEGER,
    person_name          VARCHAR(100),
    role                 VARCHAR(50),

    CONSTRAINT fk_incident_person_incident
        FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_incident_person_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
);


-- ============================================================
-- 6. INCIDENT STATUS HISTORY
-- ============================================================

CREATE TABLE IF NOT EXISTS incident_status_history (
    history_id       SERIAL PRIMARY KEY,
    incident_id      INTEGER NOT NULL,
    old_status       incident_status,
    new_status       incident_status NOT NULL,
    changed_by_guard INTEGER,
    changed_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    remarks          TEXT,

    FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id)
        ON DELETE CASCADE,

    FOREIGN KEY (changed_by_guard)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 7. PATROLS
-- ============================================================

CREATE TABLE IF NOT EXISTS patrols (
    patrol_id       SERIAL PRIMARY KEY,
    guard_id        INTEGER NOT NULL,
    zone_id         INTEGER NOT NULL,

    start_time      TIMESTAMP NOT NULL,
    end_time        TIMESTAMP,

    status          patrol_status DEFAULT 'Scheduled',

    start_location  GEOGRAPHY(Point,4326),
    end_location    GEOGRAPHY(Point,4326),

    observations    TEXT,

    FOREIGN KEY (guard_id)
        REFERENCES guards(guard_id),

    FOREIGN KEY (zone_id)
        REFERENCES security_zones(zone_id)
);


-- ============================================================
-- 8. PATROL LOCATIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS patrol_locations (
    location_id     SERIAL PRIMARY KEY,
    patrol_id       INTEGER NOT NULL,
    recorded_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    location        GEOGRAPHY(Point,4326),

    FOREIGN KEY (patrol_id)
        REFERENCES patrols(patrol_id)
        ON DELETE CASCADE
);


-- ============================================================
-- 9. INVESTIGATIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS investigations (
    investigation_id    SERIAL PRIMARY KEY,
    incident_id         INTEGER NOT NULL,
    investigator_id     INTEGER NOT NULL,

    started_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at        TIMESTAMP,

    findings            TEXT,
    evidence_summary    TEXT,
    conclusion          TEXT,

    FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id),

    FOREIGN KEY (investigator_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 10. INVESTIGATION EVIDENCE
-- ============================================================

CREATE TABLE IF NOT EXISTS investigation_evidence (
    evidence_id         SERIAL PRIMARY KEY,
    investigation_id    INTEGER NOT NULL,

    evidence_type       VARCHAR(50),
    description         TEXT,
    collected_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (investigation_id)
        REFERENCES investigations(investigation_id)
        ON DELETE CASCADE
);


-- ============================================================
-- 11. ESCORT REQUESTS
-- ============================================================

CREATE TABLE IF NOT EXISTS escort_requests (
    escort_request_id   INTEGER PRIMARY KEY,
    student_id          INTEGER NOT NULL,

    pickup_location     GEOGRAPHY(Point,4326),
    destination         VARCHAR(200),

    requested_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    assigned_guard_id   INTEGER,

    status              request_status DEFAULT 'Pending',

    accepted_at         TIMESTAMP,
    completed_at        TIMESTAMP,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (assigned_guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 12. EMERGENCY REQUESTS
-- ============================================================

CREATE TABLE IF NOT EXISTS emergency_requests (
    emergency_request_id INTEGER PRIMARY KEY,
    student_id           INTEGER NOT NULL,

    emergency_type       VARCHAR(100) NOT NULL,
    description          TEXT,

    location             GEOGRAPHY(Point,4326),

    requested_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    assigned_guard_id    INTEGER,

    status               request_status DEFAULT 'Pending',

    response_time        TIMESTAMP,
    resolved_at          TIMESTAMP,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (assigned_guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 13. COMPLAINTS
-- ============================================================

CREATE TABLE IF NOT EXISTS complaints (
    complaint_id        INTEGER PRIMARY KEY,
    student_id          INTEGER NOT NULL,

    category             VARCHAR(100) NOT NULL,
    description          TEXT NOT NULL,

    location             GEOGRAPHY(Point,4326),

    reported_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    status               complaint_status DEFAULT 'Pending',

    assigned_guard_id    INTEGER,

    resolution_summary   TEXT,
    resolved_at          TIMESTAMP,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (assigned_guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 14. LOST AND FOUND
-- ============================================================

CREATE TABLE IF NOT EXISTS lost_found (
    item_id             INTEGER PRIMARY KEY,

    student_id          INTEGER,

    item_type           VARCHAR(100) NOT NULL,
    description         TEXT NOT NULL,

    report_type         VARCHAR(20)
        CHECK (report_type IN ('Lost', 'Found')),

    location            GEOGRAPHY(Point,4326),

    reported_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    status              lost_found_status DEFAULT 'Reported',

    found_by_guard_id   INTEGER,

    claimed_by_student_id INTEGER,

    resolved_at         TIMESTAMP,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (found_by_guard_id)
        REFERENCES guards(guard_id),

    FOREIGN KEY (claimed_by_student_id)
        REFERENCES students(student_id)
);


-- ============================================================
-- 15. EVENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS events (
    event_id            INTEGER PRIMARY KEY,

    event_name          VARCHAR(200) NOT NULL,
    event_type          VARCHAR(100),

    start_time          TIMESTAMP NOT NULL,
    end_time            TIMESTAMP,

    location            GEOGRAPHY(Point,4326),

    expected_crowd      INTEGER,

    organizer           VARCHAR(150),

    security_required   BOOLEAN DEFAULT FALSE
);


-- ============================================================
-- 16. EVENT SECURITY ASSIGNMENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS event_security_assignments (
    assignment_id       SERIAL PRIMARY KEY,

    event_id            INTEGER NOT NULL,
    guard_id            INTEGER NOT NULL,

    assigned_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    role                VARCHAR(100),

    FOREIGN KEY (event_id)
        REFERENCES events(event_id)
        ON DELETE CASCADE,

    FOREIGN KEY (guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 17. CROWD MONITORING
-- ============================================================

CREATE TABLE IF NOT EXISTS crowd_monitoring (
    monitoring_id       INTEGER PRIMARY KEY,

    zone_id             INTEGER NOT NULL,

    monitored_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    people_count        INTEGER NOT NULL,

    crowd_level         crowd_level NOT NULL,

    recorded_by_guard_id INTEGER,

    FOREIGN KEY (zone_id)
        REFERENCES security_zones(zone_id),

    FOREIGN KEY (recorded_by_guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 18. CROWD ALERTS
-- ============================================================

CREATE TABLE IF NOT EXISTS crowd_alerts (
    alert_id            INTEGER PRIMARY KEY,

    zone_id             INTEGER NOT NULL,

    alert_time          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    people_count        INTEGER,

    crowd_level         crowd_level,

    threshold_value     INTEGER,

    message             TEXT,

    status              request_status DEFAULT 'Pending',

    resolved_by_guard_id INTEGER,
    resolved_at         TIMESTAMP,

    FOREIGN KEY (zone_id)
        REFERENCES security_zones(zone_id),

    FOREIGN KEY (resolved_by_guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 19. WILDLIFE INCIDENT DETAILS
-- ============================================================

CREATE TABLE IF NOT EXISTS wildlife_incident_details (
    wildlife_detail_id  SERIAL PRIMARY KEY,

    incident_id         INTEGER NOT NULL,

    animal_type         VARCHAR(100),
    animal_count        INTEGER DEFAULT 1,

    danger_level        VARCHAR(50),

    action_taken        TEXT,

    FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id)
        ON DELETE CASCADE
);


-- ============================================================
-- 20. FIRE INCIDENT DETAILS
-- ============================================================

CREATE TABLE IF NOT EXISTS fire_incident_details (
    fire_detail_id      SERIAL PRIMARY KEY,

    incident_id         INTEGER NOT NULL,

    fire_source         VARCHAR(200),
    containment_status  VARCHAR(100),

    fire_service_called BOOLEAN DEFAULT FALSE,

    evacuation_required BOOLEAN DEFAULT FALSE,

    damage_description  TEXT,

    FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id)
        ON DELETE CASCADE
);


-- ============================================================
-- 21. MEDICAL INCIDENT DETAILS
-- ============================================================

CREATE TABLE IF NOT EXISTS medical_incident_details (
    medical_detail_id   SERIAL PRIMARY KEY,

    incident_id         INTEGER NOT NULL,

    injury_type         VARCHAR(150),
    severity            VARCHAR(50),

    ambulance_called    BOOLEAN DEFAULT FALSE,

    hospital_name      VARCHAR(200),

    treatment_summary   TEXT,

    FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id)
        ON DELETE CASCADE
);


-- ============================================================
-- 22. VEHICLE ACCIDENT DETAILS
-- ============================================================

CREATE TABLE IF NOT EXISTS vehicle_accident_details (
    accident_detail_id  SERIAL PRIMARY KEY,

    incident_id         INTEGER NOT NULL,

    vehicle_type        VARCHAR(100),
    vehicle_number      VARCHAR(50),

    driver_name         VARCHAR(150),

    injuries_reported   BOOLEAN DEFAULT FALSE,

    damage_description  TEXT,

    FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id)
        ON DELETE CASCADE
);


-- ============================================================
-- 23. PATROL INCIDENT LINK
-- ============================================================

CREATE TABLE IF NOT EXISTS patrol_incidents (
    patrol_id       INTEGER NOT NULL,
    incident_id     INTEGER NOT NULL,

    detected_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (patrol_id, incident_id),

    FOREIGN KEY (patrol_id)
        REFERENCES patrols(patrol_id)
        ON DELETE CASCADE,

    FOREIGN KEY (incident_id)
        REFERENCES incidents(incident_id)
        ON DELETE CASCADE
);


-- ============================================================
-- 24. ZONE THREAT HISTORY
-- ============================================================

CREATE TABLE IF NOT EXISTS zone_threat_history (
    history_id      SERIAL PRIMARY KEY,

    zone_id         INTEGER NOT NULL,

    old_level       threat_level,
    new_level       threat_level NOT NULL,

    changed_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    changed_by_guard_id INTEGER,

    reason          TEXT,

    FOREIGN KEY (zone_id)
        REFERENCES security_zones(zone_id),

    FOREIGN KEY (changed_by_guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- 25. GUARD LOCATION HISTORY
-- ============================================================

CREATE TABLE IF NOT EXISTS guard_location_history (
    location_history_id SERIAL PRIMARY KEY,

    guard_id            INTEGER NOT NULL,

    zone_id             INTEGER,

    location            GEOGRAPHY(Point,4326),

    recorded_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (guard_id)
        REFERENCES guards(guard_id),

    FOREIGN KEY (zone_id)
        REFERENCES security_zones(zone_id)
);


-- ============================================================
-- 26. EMERGENCY RESPONSE HISTORY
-- ============================================================

CREATE TABLE IF NOT EXISTS emergency_response_history (
    response_history_id   SERIAL PRIMARY KEY,

    emergency_request_id  INTEGER NOT NULL,

    guard_id              INTEGER NOT NULL,

    action                VARCHAR(200),

    action_time           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    remarks               TEXT,

    FOREIGN KEY (emergency_request_id)
        REFERENCES emergency_requests(emergency_request_id)
        ON DELETE CASCADE,

    FOREIGN KEY (guard_id)
        REFERENCES guards(guard_id)
);


-- ============================================================
-- POSTGIS INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_security_zones_boundary
ON security_zones
USING GIST (boundary);


CREATE INDEX IF NOT EXISTS idx_guard_location
ON guards
USING GIST (duty_location);


CREATE INDEX IF NOT EXISTS idx_incident_location
ON incidents
USING GIST (location);


CREATE INDEX IF NOT EXISTS idx_patrol_start_location
ON patrols
USING GIST (start_location);


CREATE INDEX IF NOT EXISTS idx_patrol_end_location
ON patrols
USING GIST (end_location);


CREATE INDEX IF NOT EXISTS idx_patrol_locations
ON patrol_locations
USING GIST (location);


CREATE INDEX IF NOT EXISTS idx_emergency_location
ON emergency_requests
USING GIST (location);


CREATE INDEX IF NOT EXISTS idx_complaint_location
ON complaints
USING GIST (location);


CREATE INDEX IF NOT EXISTS idx_escort_location
ON escort_requests
USING GIST (pickup_location);


CREATE INDEX IF NOT EXISTS idx_lost_found_location
ON lost_found
USING GIST (location);


CREATE INDEX IF NOT EXISTS idx_event_location
ON events
USING GIST (location);


CREATE INDEX IF NOT EXISTS idx_guard_location_history
ON guard_location_history
USING GIST (location);


-- ============================================================
-- END OF SCHEMA
-- ============================================================