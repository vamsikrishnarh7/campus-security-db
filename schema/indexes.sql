-- ============================================================
-- INDEXES FOR BITS HYDERABAD CAMPUS SECURITY DATABASE
-- ============================================================

-- INCIDENTS
CREATE INDEX IF NOT EXISTS idx_incidents_category
ON incidents(category);

CREATE INDEX IF NOT EXISTS idx_incidents_severity
ON incidents(severity);

CREATE INDEX IF NOT EXISTS idx_incidents_status
ON incidents(status);

CREATE INDEX IF NOT EXISTS idx_incidents_reported_at
ON incidents(reported_at);

CREATE INDEX IF NOT EXISTS idx_incidents_assigned_guard
ON incidents(assigned_guard_id);

CREATE INDEX IF NOT EXISTS idx_incidents_reported_by_student
ON incidents(reported_by_student);


-- INCIDENT STATUS HISTORY
CREATE INDEX IF NOT EXISTS idx_incident_history_incident
ON incident_status_history(incident_id);

CREATE INDEX IF NOT EXISTS idx_incident_history_changed_at
ON incident_status_history(changed_at);


-- INCIDENT PERSON
CREATE INDEX IF NOT EXISTS idx_incident_person_incident
ON incident_person(incident_id);

CREATE INDEX IF NOT EXISTS idx_incident_person_student
ON incident_person(student_id);


-- PATROLS
CREATE INDEX IF NOT EXISTS idx_patrols_guard
ON patrols(guard_id);

CREATE INDEX IF NOT EXISTS idx_patrols_zone
ON patrols(zone_id);

CREATE INDEX IF NOT EXISTS idx_patrols_start_time
ON patrols(start_time);

CREATE INDEX IF NOT EXISTS idx_patrols_status
ON patrols(status);


-- PATROL LOCATIONS
CREATE INDEX IF NOT EXISTS idx_patrol_locations_patrol
ON patrol_locations(patrol_id);

CREATE INDEX IF NOT EXISTS idx_patrol_locations_recorded_at
ON patrol_locations(recorded_at);


-- INVESTIGATIONS
CREATE INDEX IF NOT EXISTS idx_investigations_incident
ON investigations(incident_id);

CREATE INDEX IF NOT EXISTS idx_investigations_investigator
ON investigations(investigator_id);


-- ESCORT REQUESTS
CREATE INDEX IF NOT EXISTS idx_escort_student
ON escort_requests(student_id);

CREATE INDEX IF NOT EXISTS idx_escort_guard
ON escort_requests(assigned_guard_id);

CREATE INDEX IF NOT EXISTS idx_escort_status
ON escort_requests(status);

CREATE INDEX IF NOT EXISTS idx_escort_requested_at
ON escort_requests(requested_at);


-- EMERGENCY REQUESTS
CREATE INDEX IF NOT EXISTS idx_emergency_student
ON emergency_requests(student_id);

CREATE INDEX IF NOT EXISTS idx_emergency_guard
ON emergency_requests(assigned_guard_id);

CREATE INDEX IF NOT EXISTS idx_emergency_status
ON emergency_requests(status);

CREATE INDEX IF NOT EXISTS idx_emergency_requested_at
ON emergency_requests(requested_at);


-- COMPLAINTS
CREATE INDEX IF NOT EXISTS idx_complaints_student
ON complaints(student_id);

CREATE INDEX IF NOT EXISTS idx_complaints_guard
ON complaints(assigned_guard_id);

CREATE INDEX IF NOT EXISTS idx_complaints_status
ON complaints(status);

CREATE INDEX IF NOT EXISTS idx_complaints_reported_at
ON complaints(reported_at);


-- LOST AND FOUND
CREATE INDEX IF NOT EXISTS idx_lost_found_student
ON lost_found(student_id);

CREATE INDEX IF NOT EXISTS idx_lost_found_status
ON lost_found(status);

CREATE INDEX IF NOT EXISTS idx_lost_found_reported_at
ON lost_found(reported_at);


-- EVENTS
CREATE INDEX IF NOT EXISTS idx_events_start_time
ON events(start_time);

CREATE INDEX IF NOT EXISTS idx_events_security_required
ON events(security_required);


-- EVENT SECURITY ASSIGNMENTS
CREATE INDEX IF NOT EXISTS idx_event_assignment_event
ON event_security_assignments(event_id);

CREATE INDEX IF NOT EXISTS idx_event_assignment_guard
ON event_security_assignments(guard_id);


-- CROWD MONITORING
CREATE INDEX IF NOT EXISTS idx_crowd_monitoring_zone
ON crowd_monitoring(zone_id);

CREATE INDEX IF NOT EXISTS idx_crowd_monitoring_time
ON crowd_monitoring(monitored_at);

CREATE INDEX IF NOT EXISTS idx_crowd_monitoring_level
ON crowd_monitoring(crowd_level);


-- CROWD ALERTS
CREATE INDEX IF NOT EXISTS idx_crowd_alerts_zone
ON crowd_alerts(zone_id);

CREATE INDEX IF NOT EXISTS idx_crowd_alerts_status
ON crowd_alerts(status);

CREATE INDEX IF NOT EXISTS idx_crowd_alerts_time
ON crowd_alerts(alert_time);


-- PATROL-INCIDENT RELATION
CREATE INDEX IF NOT EXISTS idx_patrol_incidents_incident
ON patrol_incidents(incident_id);


-- ZONE THREAT HISTORY
CREATE INDEX IF NOT EXISTS idx_zone_threat_history_zone
ON zone_threat_history(zone_id);

CREATE INDEX IF NOT EXISTS idx_zone_threat_history_changed_at
ON zone_threat_history(changed_at);


-- GUARD LOCATION HISTORY
CREATE INDEX IF NOT EXISTS idx_guard_location_history_guard
ON guard_location_history(guard_id);

CREATE INDEX IF NOT EXISTS idx_guard_location_history_zone
ON guard_location_history(zone_id);

CREATE INDEX IF NOT EXISTS idx_guard_location_history_recorded_at
ON guard_location_history(recorded_at);


-- EMERGENCY RESPONSE HISTORY
CREATE INDEX IF NOT EXISTS idx_emergency_response_request
ON emergency_response_history(emergency_request_id);

CREATE INDEX IF NOT EXISTS idx_emergency_response_guard
ON emergency_response_history(guard_id);

CREATE INDEX IF NOT EXISTS idx_emergency_response_time
ON emergency_response_history(action_time);