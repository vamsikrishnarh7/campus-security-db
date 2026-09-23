-- ============================================================
-- BITS HYDERABAD CAMPUS SECURITY PATROLLING DATABASE
-- COMPLETE DATA.SQL
-- ============================================================

BEGIN;

-- ============================================================
-- 1. STUDENTS
-- ============================================================

INSERT INTO students
(student_id, name, gender, phone, email, hostel, room_number, program, year_of_study)
VALUES
(1001,'Aarav Sharma','Male','9000000001','aarav.sharma@hyderabad.bits-pilani.ac.in','SR Bhawan','A101','B.E. Computer Science',2),
(1002,'Ananya Reddy','Female','9000000002','ananya.reddy@hyderabad.bits-pilani.ac.in','Gandhi Bhawan','B204','B.E. Computer Science',3),
(1003,'Rohit Kumar','Male','9000000003','rohit.kumar@hyderabad.bits-pilani.ac.in','Krishna Bhawan','C112','B.E. Electronics',1),
(1004,'Sneha Rao','Female','9000000004','sneha.rao@hyderabad.bits-pilani.ac.in','Godavari Bhawan','D305','B.E. Electrical',4),
(1005,'Aditya Verma','Male','9000000005','aditya.verma@hyderabad.bits-pilani.ac.in','SR Bhawan','A210','B.E. Mechanical',2),
(1006,'Priya Nair','Female','9000000006','priya.nair@hyderabad.bits-pilani.ac.in','Gandhi Bhawan','B118','B.E. Chemical',3),
(1007,'Karthik Reddy','Male','9000000007','karthik.reddy@hyderabad.bits-pilani.ac.in','Krishna Bhawan','C220','B.E. Computer Science',4),
(1008,'Meghana Singh','Female','9000000008','meghana.singh@hyderabad.bits-pilani.ac.in','Godavari Bhawan','D109','B.E. Computer Science',1),
(1009,'Arjun Patel','Male','9000000009','arjun.patel@hyderabad.bits-pilani.ac.in','SR Bhawan','A315','B.E. Electronics',3),
(1010,'Ishita Menon','Female','9000000010','ishita.menon@hyderabad.bits-pilani.ac.in','Gandhi Bhawan','B402','B.E. Mathematics',2),
(1011,'Vivek Joshi','Male','9000000011','vivek.joshi@hyderabad.bits-pilani.ac.in','Krishna Bhawan','C105','B.E. Computer Science',4),
(1012,'Nandini Rao','Female','9000000012','nandini.rao@hyderabad.bits-pilani.ac.in','Godavari Bhawan','D214','B.E. Biotechnology',3),
(1013,'Rahul Das','Male','9000000013','rahul.das@hyderabad.bits-pilani.ac.in','SR Bhawan','A406','B.E. Civil',2),
(1014,'Kavya Reddy','Female','9000000014','kavya.reddy@hyderabad.bits-pilani.ac.in','Gandhi Bhawan','B309','B.E. Computer Science',1),
(1015,'Siddharth Rao','Male','9000000015','siddharth.rao@hyderabad.bits-pilani.ac.in','Krishna Bhawan','C316','B.E. Electrical',4),
(1016,'Pooja Sharma','Female','9000000016','pooja.sharma@hyderabad.bits-pilani.ac.in','Godavari Bhawan','D121','B.E. Chemical',2),
(1017,'Manish Gupta','Male','9000000017','manish.gupta@hyderabad.bits-pilani.ac.in','SR Bhawan','A223','B.E. Mechanical',3),
(1018,'Divya Iyer','Female','9000000018','divya.iyer@hyderabad.bits-pilani.ac.in','Gandhi Bhawan','B411','B.E. Computer Science',4),
(1019,'Varun Reddy','Male','9000000019','varun.reddy@hyderabad.bits-pilani.ac.in','Krishna Bhawan','C208','B.E. Electronics',2),
(1020,'Sanjana Rao','Female','9000000020','sanjana.rao@hyderabad.bits-pilani.ac.in','Godavari Bhawan','D318','B.E. Computer Science',1);


-- ============================================================
-- 2. GUARDS
-- ============================================================
-- current_zone_id kept NULL initially because zones reference guards
-- and guards reference zones.

INSERT INTO guards
(guard_id, name, phone, gender, shift, status, duty_location,
 current_zone_id, joined_date)
VALUES
(1,'Ramesh Kumar','9100000001','Male','Day','On Duty',
 ST_SetSRID(ST_MakePoint(78.3030,17.5440),4326)::geography,
 NULL,'2019-01-15'),

(2,'Suresh Reddy','9100000002','Male','Day','On Patrol',
 ST_SetSRID(ST_MakePoint(78.3040,17.5450),4326)::geography,
 NULL,'2020-03-12'),

(3,'Mahesh Rao','9100000003','Male','Evening','On Duty',
 ST_SetSRID(ST_MakePoint(78.3050,17.5460),4326)::geography,
 NULL,'2018-11-20'),

(4,'Anil Kumar','9100000004','Male','Evening','On Patrol',
 ST_SetSRID(ST_MakePoint(78.3060,17.5470),4326)::geography,
 NULL,'2021-05-18'),

(5,'Prakash Singh','9100000005','Male','Day','Busy',
 ST_SetSRID(ST_MakePoint(78.3070,17.5480),4326)::geography,
 NULL,'2017-08-10'),

(6,'Vijay Rao','9100000006','Male','Night','On Duty',
 ST_SetSRID(ST_MakePoint(78.3080,17.5490),4326)::geography,
 NULL,'2020-12-01'),

(7,'Naveen Kumar','9100000007','Male','Night','Emergency',
 ST_SetSRID(ST_MakePoint(78.3030,17.5455),4326)::geography,
 NULL,'2019-07-22'),

(8,'Ravi Teja','9100000008','Male','Day','On Patrol',
 ST_SetSRID(ST_MakePoint(78.3045,17.5465),4326)::geography,
 NULL,'2022-02-14'),

(9,'Ajay Sharma','9100000009','Male','Evening','Off Duty',
 ST_SetSRID(ST_MakePoint(78.3055,17.5475),4326)::geography,
 NULL,'2018-06-30'),

(10,'Kiran Rao','9100000010','Male','Night','On Duty',
 ST_SetSRID(ST_MakePoint(78.3065,17.5485),4326)::geography,
 NULL,'2021-09-05');


-- ============================================================
-- 3. SECURITY ZONES
-- ============================================================

INSERT INTO security_zones
(zone_id, zone_name, threat_level, incharge_guard_id, boundary, description)
VALUES

(201,'Academic','Moderate',1,
 ST_GeomFromText(
 'POLYGON((78.298 17.541,78.302 17.541,78.302 17.545,78.298 17.545,78.298 17.541))',
 4326),
 'Academic blocks, classrooms and lecture areas'),

(202,'Hostel','Low',2,
 ST_GeomFromText(
 'POLYGON((78.302 17.541,78.306 17.541,78.306 17.545,78.302 17.545,78.302 17.541))',
 4326),
 'Student residential and hostel area'),

(203,'Mess/Food','Moderate',3,
 ST_GeomFromText(
 'POLYGON((78.306 17.541,78.310 17.541,78.310 17.545,78.306 17.545,78.306 17.541))',
 4326),
 'Mess, cafeteria and food court'),

(204,'Sports','Low',4,
 ST_GeomFromText(
 'POLYGON((78.298 17.545,78.302 17.545,78.302 17.549,78.298 17.549,78.298 17.545))',
 4326),
 'Sports grounds and recreation facilities'),

(205,'Main Gate','High',5,
 ST_GeomFromText(
 'POLYGON((78.302 17.545,78.306 17.545,78.306 17.549,78.302 17.549,78.302 17.545))',
 4326),
 'Main campus entry and exit gate'),

(206,'Library','Moderate',6,
 ST_GeomFromText(
 'POLYGON((78.306 17.545,78.310 17.545,78.310 17.549,78.306 17.549,78.306 17.545))',
 4326),
 'Central library and surrounding study areas'),

(207,'Parking','High',7,
 ST_GeomFromText(
 'POLYGON((78.298 17.549,78.302 17.549,78.302 17.553,78.298 17.553,78.298 17.549))',
 4326),
 'Vehicle parking and movement area'),

(208,'Research/Lab','Moderate',8,
 ST_GeomFromText(
 'POLYGON((78.302 17.549,78.306 17.549,78.306 17.553,78.302 17.553,78.302 17.549))',
 4326),
 'Research laboratories and technical facilities');


-- Now assign guards to their zones.

UPDATE guards SET current_zone_id = 201 WHERE guard_id = 1;
UPDATE guards SET current_zone_id = 202 WHERE guard_id = 2;
UPDATE guards SET current_zone_id = 203 WHERE guard_id = 3;
UPDATE guards SET current_zone_id = 204 WHERE guard_id = 4;
UPDATE guards SET current_zone_id = 205 WHERE guard_id = 5;
UPDATE guards SET current_zone_id = 206 WHERE guard_id = 6;
UPDATE guards SET current_zone_id = 207 WHERE guard_id = 7;
UPDATE guards SET current_zone_id = 208 WHERE guard_id = 8;
UPDATE guards SET current_zone_id = 205 WHERE guard_id = 9;
UPDATE guards SET current_zone_id = 207 WHERE guard_id = 10;


-- ============================================================
-- 4. EVENTS
-- ============================================================

INSERT INTO events
(event_id,event_name,event_type,start_time,end_time,location,
 expected_crowd,organizer,security_required)
VALUES
(1,'Freshers Orientation','Academic',
 '2026-08-05 09:00','2026-08-05 16:00',
 ST_SetSRID(ST_MakePoint(78.3000,17.5430),4326)::geography,
 800,'BITS Hyderabad',TRUE),

(2,'Independence Day Celebration','Cultural',
 '2026-08-15 08:00','2026-08-15 13:00',
 ST_SetSRID(ST_MakePoint(78.3010,17.5470),4326)::geography,
 1200,'Student Affairs Division',TRUE),

(3,'Inter Hostel Cricket','Sports',
 '2026-08-18 16:00','2026-08-18 20:00',
 ST_SetSRID(ST_MakePoint(78.3000,17.5470),4326)::geography,
 500,'Sports Council',TRUE),

(4,'Technical Symposium','Technical',
 '2026-08-22 09:00','2026-08-22 18:00',
 ST_SetSRID(ST_MakePoint(78.3040,17.5510),4326)::geography,
 600,'Technical Club',TRUE),

(5,'Cultural Night','Cultural',
 '2026-08-25 18:00','2026-08-25 22:00',
 ST_SetSRID(ST_MakePoint(78.3010,17.5460),4326)::geography,
 1000,'Cultural Association',TRUE),

(6,'Alumni Meet','Official',
 '2026-08-28 10:00','2026-08-28 15:00',
 ST_SetSRID(ST_MakePoint(78.3040,17.5430),4326)::geography,
 350,'Alumni Association',TRUE),

(7,'Hackathon 2026','Technical',
 '2026-09-01 09:00','2026-09-02 21:00',
 ST_SetSRID(ST_MakePoint(78.3050,17.5510),4326)::geography,
 400,'Computer Science Department',TRUE),

(8,'Blood Donation Camp','Medical',
 '2026-09-05 09:00','2026-09-05 16:00',
 ST_SetSRID(ST_MakePoint(78.3070,17.5470),4326)::geography,
 250,'Medical Centre',TRUE),

(9,'Sports Festival','Sports',
 '2026-09-10 08:00','2026-09-10 20:00',
 ST_SetSRID(ST_MakePoint(78.2990,17.5480),4326)::geography,
 900,'Sports Council',TRUE),

(10,'Student Club Fair','Cultural',
 '2026-09-15 10:00','2026-09-15 17:00',
 ST_SetSRID(ST_MakePoint(78.3030,17.5440),4326)::geography,
 700,'Student Union',TRUE);


-- ============================================================
-- 5. INCIDENTS
-- ============================================================

INSERT INTO incidents
(incident_id,category,severity,description,location,reported_at,
 reported_by_student,assigned_guard_id,status,resolved_at,resolution_summary)
VALUES

(3001,'Harassment','High',
 'Student reported verbal harassment near hostel entrance.',
 ST_SetSRID(ST_MakePoint(78.3030,17.5430),4326)::geography,
 '2026-08-01 09:10',1001,2,'Resolved',
 '2026-08-01 10:20','Guard intervened and separated the individuals.'),

(3002,'Wildlife','Medium',
 'Snake sighted near hostel pathway.',
 ST_SetSRID(ST_MakePoint(78.3040,17.5440),4326)::geography,
 '2026-08-02 21:15',1002,6,'Resolved',
 '2026-08-02 22:10','Area isolated and wildlife team contacted.'),

(3003,'Theft','High',
 'Laptop reported missing from library study area.',
 ST_SetSRID(ST_MakePoint(78.3080,17.5470),4326)::geography,
 '2026-08-03 14:20',1003,6,'Investigating',
 NULL,NULL),

(3004,'Vandalism','Medium',
 'Damage observed on hostel common room property.',
 ST_SetSRID(ST_MakePoint(78.3050,17.5430),4326)::geography,
 '2026-08-04 11:30',1004,2,'Resolved',
 '2026-08-04 13:00','Damage documented and responsible students identified.'),

(3005,'Altercation','High',
 'Physical altercation reported near mess.',
 ST_SetSRID(ST_MakePoint(78.3080,17.5430),4326)::geography,
 '2026-08-05 20:30',1005,3,'Resolved',
 '2026-08-05 21:20','Parties separated and statements recorded.'),

(3006,'Fire','Critical',
 'Smoke detected from electrical equipment in laboratory.',
 ST_SetSRID(ST_MakePoint(78.3040,17.5510),4326)::geography,
 '2026-08-06 10:05',1006,8,'Closed',
 '2026-08-06 12:00','Fire contained and electrical equipment isolated.'),

(3007,'Vehicle Accident','High',
 'Two-wheeler collided with campus vehicle near gate.',
 ST_SetSRID(ST_MakePoint(78.3040,17.5470),4326)::geography,
 '2026-08-07 08:40',1007,5,'Resolved',
 '2026-08-07 10:00','First aid provided and traffic cleared.'),

(3008,'Overcrowding','Medium',
 'High crowd density observed near cafeteria.',
 ST_SetSRID(ST_MakePoint(78.3080,17.5430),4326)::geography,
 '2026-08-08 13:10',1008,3,'Closed',
 '2026-08-08 14:00','Crowd dispersed after additional security deployment.'),

(3009,'Medical','High',
 'Student fainted near academic block.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5430),4326)::geography,
 '2026-08-09 15:45',1009,1,'Resolved',
 '2026-08-09 16:30','Student transferred to medical centre.'),

(3010,'Event Emergency','High',
 'Emergency evacuation required during student event.',
 ST_SetSRID(ST_MakePoint(78.3010,17.5460),4326)::geography,
 '2026-08-10 19:20',1010,4,'Resolved',
 '2026-08-10 20:00','Event temporarily stopped and crowd safely evacuated.'),

(3011,'Theft','Medium',
 'Wallet reported missing near sports complex.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5470),4326)::geography,
 '2026-08-11 17:30',1011,4,'Closed',
 '2026-08-12 10:00','Wallet recovered and returned.'),

(3012,'Wildlife','Low',
 'Peacock entered academic walkway.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5440),4326)::geography,
 '2026-08-12 08:20',1012,1,'Resolved',
 '2026-08-12 09:00','Bird safely moved away from pedestrian area.'),

(3013,'Harassment','Medium',
 'Student reported inappropriate comments near parking area.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography,
 '2026-08-13 22:10',1013,7,'Investigating',
 NULL,NULL),

(3014,'Vandalism','Low',
 'Broken light fixture found in corridor.',
 ST_SetSRID(ST_MakePoint(78.3030,17.5440),4326)::geography,
 '2026-08-14 09:40',1014,1,'Resolved',
 '2026-08-14 11:00','Maintenance team notified.'),

(3015,'Altercation','High',
 'Argument escalated into physical confrontation.',
 ST_SetSRID(ST_MakePoint(78.3050,17.5440),4326)::geography,
 '2026-08-15 21:30',1015,3,'Closed',
 '2026-08-15 23:00','Individuals counselled and statements recorded.'),

(3016,'Fire','Critical',
 'Small electrical fire detected in laboratory equipment.',
 ST_SetSRID(ST_MakePoint(78.3040,17.5500),4326)::geography,
 '2026-08-16 11:10',1016,8,'Closed',
 '2026-08-16 12:30','Fire extinguisher used and electrical supply isolated.'),

(3017,'Vehicle Accident','Medium',
 'Minor vehicle collision in parking area.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography,
 '2026-08-17 18:20',1017,7,'Resolved',
 '2026-08-17 19:15','No serious injuries; vehicles moved.'),

(3018,'Medical','Medium',
 'Student suffered ankle injury during sports activity.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5480),4326)::geography,
 '2026-08-18 17:40',1018,4,'Resolved',
 '2026-08-18 18:30','Student treated at medical centre.'),

(3019,'Overcrowding','High',
 'Large crowd gathered outside event venue.',
 ST_SetSRID(ST_MakePoint(78.3010,17.5460),4326)::geography,
 '2026-08-19 19:00',1019,4,'Closed',
 '2026-08-19 20:00','Additional guards deployed.'),

(3020,'Theft','High',
 'Mobile phone reported stolen near mess.',
 ST_SetSRID(ST_MakePoint(78.3070,17.5430),4326)::geography,
 '2026-08-20 13:50',1020,3,'Investigating',
 NULL,NULL),

(3021,'Wildlife','Medium',
 'Wild boar sighted near peripheral campus road.',
 ST_SetSRID(ST_MakePoint(78.2990,17.5500),4326)::geography,
 '2026-08-21 06:45',1001,7,'Resolved',
 '2026-08-21 08:00','Area secured and animal moved away.'),

(3022,'Fire','High',
 'Smoke detected from kitchen equipment.',
 ST_SetSRID(ST_MakePoint(78.3080,17.5420),4326)::geography,
 '2026-08-22 12:30',1002,3,'Closed',
 '2026-08-22 13:20','Kitchen equipment switched off and inspected.'),

(3023,'Harassment','High',
 'Complaint received regarding repeated harassment.',
 ST_SetSRID(ST_MakePoint(78.3010,17.5420),4326)::geography,
 '2026-08-23 16:15',1003,2,'Investigating',
 NULL,NULL),

(3024,'Medical','Low',
 'Student reported minor dehydration.',
 ST_SetSRID(ST_MakePoint(78.3030,17.5440),4326)::geography,
 '2026-08-24 14:00',1004,1,'Resolved',
 '2026-08-24 14:45','Water and medical assistance provided.'),

(3025,'Vehicle Accident','High',
 'Car collided with barrier near parking entrance.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5500),4326)::geography,
 '2026-08-25 09:25',1005,7,'Resolved',
 '2026-08-25 10:30','Traffic controlled and vehicle removed.'),

(3026,'Overcrowding','Critical',
 'Crowd exceeded safe capacity during cultural event.',
 ST_SetSRID(ST_MakePoint(78.3010,17.5460),4326)::geography,
 '2026-08-26 20:15',1006,5,'Closed',
 '2026-08-26 21:00','Entry temporarily stopped and crowd redistributed.'),

(3027,'Vandalism','Medium',
 'Damage reported to outdoor campus equipment.',
 ST_SetSRID(ST_MakePoint(78.2990,17.5480),4326)::geography,
 '2026-08-27 11:20',1007,4,'Resolved',
 '2026-08-27 13:10','Equipment secured and repair request raised.'),

(3028,'Altercation','Medium',
 'Dispute between students reported near library.',
 ST_SetSRID(ST_MakePoint(78.3080,17.5460),4326)::geography,
 '2026-08-28 18:45',1008,6,'Resolved',
 '2026-08-28 19:40','Students separated and matter resolved.'),

(3029,'Theft','Medium',
 'Bicycle reported missing from parking area.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography,
 '2026-08-29 07:30',1009,7,'Investigating',
 NULL,NULL),

(3030,'Event Emergency','High',
 'Emergency medical situation during technical event.',
 ST_SetSRID(ST_MakePoint(78.3040,17.5510),4326)::geography,
 '2026-08-30 15:10',1010,8,'Resolved',
 '2026-08-30 16:00','Medical team responded and student transferred for treatment.');


-- ============================================================
-- 6. INCIDENT PERSON
-- ============================================================

INSERT INTO incident_person
(incident_id,student_id,person_name,role)
VALUES
(3001,1001,'Aarav Sharma','Complainant'),
(3001,NULL,'Unknown Student','Reported Person'),
(3003,1003,'Rohit Kumar','Victim'),
(3005,1005,'Aditya Verma','Participant'),
(3005,1006,'Priya Nair','Participant'),
(3013,1013,'Rahul Das','Complainant'),
(3015,1015,'Siddharth Rao','Participant'),
(3015,1016,'Pooja Sharma','Participant'),
(3020,1020,'Sanjana Rao','Victim'),
(3023,1003,'Rohit Kumar','Complainant'),
(3028,1008,'Meghana Singh','Participant'),
(3028,1011,'Vivek Joshi','Participant');


-- ============================================================
-- 7. INCIDENT STATUS HISTORY
-- IMPORTANT:
-- changed_by_guard, NOT changed_by_guard_id
-- history_id explicitly supplied
-- ============================================================

INSERT INTO incident_status_history
(history_id,incident_id,old_status,new_status,changed_by_guard,changed_at,remarks)
VALUES
(1,3001,NULL,'Reported',2,'2026-08-01 09:10','Incident reported'),
(2,3001,'Reported','Assigned',2,'2026-08-01 09:15','Guard assigned'),
(3,3001,'Assigned','Investigating',2,'2026-08-01 09:25','Investigation started'),
(4,3001,'Investigating','Resolved',2,'2026-08-01 10:20','Incident resolved'),

(5,3002,NULL,'Reported',6,'2026-08-02 21:15','Wildlife sighting reported'),
(6,3002,'Reported','Assigned',6,'2026-08-02 21:20','Night guard assigned'),
(7,3002,'Assigned','Resolved',6,'2026-08-02 22:10','Wildlife cleared'),

(8,3003,NULL,'Reported',6,'2026-08-03 14:20','Theft reported'),
(9,3003,'Reported','Assigned',6,'2026-08-03 14:30','Guard assigned'),
(10,3003,'Assigned','Investigating',6,'2026-08-03 15:00','Investigation ongoing'),

(11,3004,NULL,'Reported',2,'2026-08-04 11:30','Vandalism reported'),
(12,3004,'Reported','Assigned',2,'2026-08-04 11:40','Guard assigned'),
(13,3004,'Assigned','Resolved',2,'2026-08-04 13:00','Issue resolved'),

(14,3005,NULL,'Reported',3,'2026-08-05 20:30','Altercation reported'),
(15,3005,'Reported','Assigned',3,'2026-08-05 20:35','Guard assigned'),
(16,3005,'Assigned','Investigating',3,'2026-08-05 20:50','Statements collected'),
(17,3005,'Investigating','Resolved',3,'2026-08-05 21:20','Matter resolved'),

(18,3006,NULL,'Reported',8,'2026-08-06 10:05','Fire reported'),
(19,3006,'Reported','Assigned',8,'2026-08-06 10:06','Emergency guard assigned'),
(20,3006,'Assigned','Investigating',8,'2026-08-06 10:15','Fire investigation started'),
(21,3006,'Investigating','Resolved',8,'2026-08-06 12:00','Fire contained'),

(22,3007,NULL,'Reported',5,'2026-08-07 08:40','Accident reported'),
(23,3007,'Reported','Assigned',5,'2026-08-07 08:45','Gate guard assigned'),
(24,3007,'Assigned','Resolved',5,'2026-08-07 10:00','Accident handled'),

(25,3009,NULL,'Reported',1,'2026-08-09 15:45','Medical emergency reported'),
(26,3009,'Reported','Assigned',1,'2026-08-09 15:48','Guard dispatched'),
(27,3009,'Assigned','Resolved',1,'2026-08-09 16:30','Student transferred'),

(28,3013,NULL,'Reported',7,'2026-08-13 22:10','Complaint reported'),
(29,3013,'Reported','Assigned',7,'2026-08-13 22:15','Guard assigned'),
(30,3013,'Assigned','Investigating',7,'2026-08-13 22:30','Investigation ongoing');


-- ============================================================
-- 8. PATROLS
-- ============================================================

INSERT INTO patrols
(patrol_id,guard_id,zone_id,start_time,end_time,status,
 start_location,end_location,observations)
VALUES
(1,1,201,'2026-08-01 08:00','2026-08-01 10:00','Completed',
 ST_SetSRID(ST_MakePoint(78.3000,17.5430),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3010,17.5440),4326)::geography,
 'Academic block routine patrol completed.'),

(2,2,202,'2026-08-01 10:00','2026-08-01 12:00','Completed',
 ST_SetSRID(ST_MakePoint(78.3030,17.5420),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3050,17.5440),4326)::geography,
 'Hostel entrances inspected.'),

(3,3,203,'2026-08-02 12:00','2026-08-02 14:00','Completed',
 ST_SetSRID(ST_MakePoint(78.3070,17.5420),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3090,17.5440),4326)::geography,
 'Mess and cafeteria checked.'),

(4,4,204,'2026-08-03 16:00','2026-08-03 18:00','Completed',
 ST_SetSRID(ST_MakePoint(78.3000,17.5460),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3010,17.5480),4326)::geography,
 'Sports grounds checked.'),

(5,5,205,'2026-08-04 08:00','2026-08-04 10:00','Completed',
 ST_SetSRID(ST_MakePoint(78.3040,17.5460),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3050,17.5480),4326)::geography,
 'Main gate traffic monitored.'),

(6,6,206,'2026-08-05 18:00','2026-08-05 20:00','Completed',
 ST_SetSRID(ST_MakePoint(78.3070,17.5460),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3090,17.5480),4326)::geography,
 'Library area inspected.'),

(7,7,207,'2026-08-06 20:00','2026-08-06 22:00','Active',
 ST_SetSRID(ST_MakePoint(78.3000,17.5500),4326)::geography,
 NULL,
 'Parking area currently under patrol.'),

(8,8,208,'2026-08-07 09:00','2026-08-07 11:00','Completed',
 ST_SetSRID(ST_MakePoint(78.3040,17.5500),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3050,17.5520),4326)::geography,
 'Research laboratories inspected.'),

(9,1,201,'2026-08-08 14:00','2026-08-08 16:00','Completed',
 ST_SetSRID(ST_MakePoint(78.2990,17.5420),4326)::geography,
 ST_SetSRID(ST_MakePoint(78.3020,17.5450),4326)::geography,
 'Academic area checked.'),

(10,5,205,'2026-08-09 17:00','2026-08-09 19:00','Scheduled',
 ST_SetSRID(ST_MakePoint(78.3030,17.5460),4326)::geography,
 NULL,
 'Scheduled gate patrol.');


-- ============================================================
-- 9. PATROL LOCATIONS
-- ============================================================

INSERT INTO patrol_locations
(location_id,patrol_id,recorded_at,location)
VALUES
(1,1,'2026-08-01 08:20',ST_SetSRID(ST_MakePoint(78.2990,17.5420),4326)::geography),
(2,1,'2026-08-01 08:50',ST_SetSRID(ST_MakePoint(78.3000,17.5430),4326)::geography),
(3,1,'2026-08-01 09:30',ST_SetSRID(ST_MakePoint(78.3010,17.5440),4326)::geography),

(4,2,'2026-08-01 10:20',ST_SetSRID(ST_MakePoint(78.3030,17.5420),4326)::geography),
(5,2,'2026-08-01 11:00',ST_SetSRID(ST_MakePoint(78.3040,17.5430),4326)::geography),

(6,3,'2026-08-02 12:20',ST_SetSRID(ST_MakePoint(78.3070,17.5420),4326)::geography),
(7,3,'2026-08-02 13:10',ST_SetSRID(ST_MakePoint(78.3080,17.5430),4326)::geography),

(8,4,'2026-08-03 16:20',ST_SetSRID(ST_MakePoint(78.2990,17.5460),4326)::geography),
(9,4,'2026-08-03 17:10',ST_SetSRID(ST_MakePoint(78.3000,17.5470),4326)::geography),

(10,5,'2026-08-04 08:20',ST_SetSRID(ST_MakePoint(78.3030,17.5460),4326)::geography),
(11,5,'2026-08-04 09:10',ST_SetSRID(ST_MakePoint(78.3050,17.5480),4326)::geography),

(12,6,'2026-08-05 18:20',ST_SetSRID(ST_MakePoint(78.3070,17.5460),4326)::geography),
(13,6,'2026-08-05 19:10',ST_SetSRID(ST_MakePoint(78.3080,17.5480),4326)::geography),

(14,7,'2026-08-06 20:20',ST_SetSRID(ST_MakePoint(78.2990,17.5500),4326)::geography),
(15,7,'2026-08-06 21:10',ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography),

(16,8,'2026-08-07 09:20',ST_SetSRID(ST_MakePoint(78.3040,17.5500),4326)::geography),
(17,8,'2026-08-07 10:10',ST_SetSRID(ST_MakePoint(78.3050,17.5520),4326)::geography),

(18,9,'2026-08-08 14:30',ST_SetSRID(ST_MakePoint(78.3000,17.5430),4326)::geography);


-- ============================================================
-- 10. INVESTIGATIONS
-- ============================================================

INSERT INTO investigations
(investigation_id,incident_id,investigator_id,started_at,completed_at,
 findings,evidence_summary,conclusion)
VALUES
(1,3001,2,'2026-08-01 09:25','2026-08-01 10:15',
 'Statements obtained from involved students.',
 'Witness statements and guard observations.',
 'Harassment complaint substantiated.'),

(2,3002,6,'2026-08-02 21:25','2026-08-02 22:00',
 'Snake movement traced near hostel boundary.',
 'Guard observations and photographs.',
 'Wildlife safely relocated.'),

(3,3003,6,'2026-08-03 15:00',NULL,
 'CCTV footage under review.',
 'Library CCTV recordings.',
 NULL),

(4,3005,3,'2026-08-05 20:50','2026-08-05 21:15',
 'Statements collected from both parties.',
 'Student statements.',
 'Altercation resolved without further incident.'),

(5,3006,8,'2026-08-06 10:15','2026-08-06 11:45',
 'Electrical equipment identified as source.',
 'Photographs and equipment inspection.',
 'Electrical fault caused the fire.'),

(6,3007,5,'2026-08-07 08:50','2026-08-07 09:45',
 'Vehicle movement and statements reviewed.',
 'Vehicle photographs and witness statements.',
 'Minor collision due to restricted visibility.'),

(7,3013,7,'2026-08-13 22:30',NULL,
 'Interviews with complainant initiated.',
 'Initial student statement.',
 NULL),

(8,3020,3,'2026-08-20 14:10',NULL,
 'CCTV review initiated around mess entrance.',
 'CCTV footage pending.',
 NULL);


-- ============================================================
-- 11. INVESTIGATION EVIDENCE
-- ============================================================

INSERT INTO investigation_evidence
(evidence_id,investigation_id,evidence_type,description,collected_at)
VALUES
(1,1,'Witness Statement','Statement from complainant.','2026-08-01 09:40'),
(2,1,'Guard Report','Guard intervention report.','2026-08-01 09:50'),
(3,2,'Photograph','Photograph of wildlife sighting.','2026-08-02 21:40'),
(4,3,'CCTV','Library CCTV recording.','2026-08-03 15:30'),
(5,4,'Witness Statement','Statements from involved students.','2026-08-05 21:00'),
(6,5,'Photograph','Photographs of damaged equipment.','2026-08-06 10:40'),
(7,6,'Vehicle Report','Vehicle damage report.','2026-08-07 09:00'),
(8,7,'Student Statement','Initial harassment complaint statement.','2026-08-13 22:45'),
(9,8,'CCTV','Mess entrance CCTV footage.','2026-08-20 14:30'),
(10,8,'Student Statement','Statement from victim.','2026-08-20 14:45');


-- ============================================================
-- 12. ESCORT REQUESTS
-- ============================================================

INSERT INTO escort_requests
(escort_request_id,student_id,pickup_location,destination,requested_at,
 assigned_guard_id,status,accepted_at,completed_at)
VALUES
(1,1001,ST_SetSRID(ST_MakePoint(78.3030,17.5430),4326)::geography,
 'Library','2026-08-02 20:00',2,'Completed',
 '2026-08-02 20:02','2026-08-02 20:15'),

(2,1004,ST_SetSRID(ST_MakePoint(78.3050,17.5430),4326)::geography,
 'Medical Centre','2026-08-03 22:10',6,'Completed',
 '2026-08-03 22:12','2026-08-03 22:25'),

(3,1007,ST_SetSRID(ST_MakePoint(78.3000,17.5500),4326)::geography,
 'Hostel','2026-08-05 21:00',7,'Completed',
 '2026-08-05 21:02','2026-08-05 21:20'),

(4,1011,ST_SetSRID(ST_MakePoint(78.3080,17.5460),4326)::geography,
 'Hostel','2026-08-10 22:30',6,'Completed',
 '2026-08-10 22:32','2026-08-10 22:50'),

(5,1015,ST_SetSRID(ST_MakePoint(78.3000,17.5470),4326)::geography,
 'Academic Block','2026-08-15 20:00',4,'Accepted',
 '2026-08-15 20:05',NULL),

(6,1018,ST_SetSRID(ST_MakePoint(78.3040,17.5510),4326)::geography,
 'Hostel','2026-08-20 23:00',8,'Pending',
 NULL,NULL);


-- ============================================================
-- 13. EMERGENCY REQUESTS
-- ============================================================

INSERT INTO emergency_requests
(emergency_request_id,student_id,emergency_type,description,location,
 requested_at,assigned_guard_id,status,response_time,resolved_at)
VALUES
(1,1003,'Medical','Student experiencing severe dizziness.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5430),4326)::geography,
 '2026-08-04 15:30',1,'Completed','2026-08-04 15:34','2026-08-04 16:10'),

(2,1006,'Safety','Student reported suspicious person near hostel.',
 ST_SetSRID(ST_MakePoint(78.3040,17.5430),4326)::geography,
 '2026-08-06 22:00',6,'Completed','2026-08-06 22:05','2026-08-06 22:30'),

(3,1010,'Medical','Student injured during sports activity.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5480),4326)::geography,
 '2026-08-12 18:00',4,'Completed','2026-08-12 18:04','2026-08-12 18:40'),

(4,1014,'Security','Suspicious unattended bag reported.',
 ST_SetSRID(ST_MakePoint(78.3060,17.5470),4326)::geography,
 '2026-08-18 12:30',5,'Completed','2026-08-18 12:34','2026-08-18 13:00'),

(5,1019,'Medical','Student requested immediate medical assistance.',
 ST_SetSRID(ST_MakePoint(78.3080,17.5460),4326)::geography,
 '2026-08-25 16:45',6,'In Progress','2026-08-25 16:48',NULL);


-- ============================================================
-- 14. COMPLAINTS
-- ============================================================

INSERT INTO complaints
(complaint_id,student_id,category,description,location,reported_at,
 status,assigned_guard_id,resolution_summary,resolved_at)
VALUES
(1,1001,'Noise','Excessive noise reported near hostel rooms.',
 ST_SetSRID(ST_MakePoint(78.3040,17.5430),4326)::geography,
 '2026-08-01 23:00','Resolved',2,
 'Students advised to reduce noise.','2026-08-02 00:00'),

(2,1005,'Parking','Vehicle parked in restricted area.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography,
 '2026-08-05 09:00','Resolved',7,
 'Vehicle owner contacted.','2026-08-05 09:30'),

(3,1009,'Security','Broken security light reported.',
 ST_SetSRID(ST_MakePoint(78.3070,17.5460),4326)::geography,
 '2026-08-09 19:00','Assigned',6,
 NULL,NULL),

(4,1012,'Noise','Loud music reported near common area.',
 ST_SetSRID(ST_MakePoint(78.3050,17.5430),4326)::geography,
 '2026-08-12 22:00','Closed',2,
 'Issue resolved after warning.','2026-08-13 00:00'),

(5,1016,'Safety','Poor lighting reported near walkway.',
 ST_SetSRID(ST_MakePoint(78.3020,17.5450),4326)::geography,
 '2026-08-17 20:30','Investigating',1,
 NULL,NULL),

(6,1020,'Cleanliness','Waste accumulation near parking area.',
 ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography,
 '2026-08-22 08:00','Pending',7,
 NULL,NULL);


-- ============================================================
-- 15. LOST AND FOUND
-- ============================================================

INSERT INTO lost_found
(item_id,student_id,item_type,description,report_type,location,
 reported_at,status,found_by_guard_id,claimed_by_student_id,resolved_at)
VALUES
(1,1002,'Wallet','Black leather wallet','Lost',
 ST_SetSRID(ST_MakePoint(78.3080,17.5460),4326)::geography,
 '2026-08-03 14:00','Returned',6,1002,'2026-08-04 10:00'),

(2,1007,'Mobile Phone','Blue smartphone','Lost',
 ST_SetSRID(ST_MakePoint(78.3070,17.5430),4326)::geography,
 '2026-08-07 16:00','Found',3,NULL,NULL),

(3,NULL,'ID Card','Student ID card found near gate','Found',
 ST_SetSRID(ST_MakePoint(78.3040,17.5470),4326)::geography,
 '2026-08-09 08:30','Found',5,NULL,NULL),

(4,1011,'Bicycle','Black mountain bicycle','Lost',
 ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography,
 '2026-08-11 07:00','Claimed',7,1011,'2026-08-12 09:00'),

(5,1014,'Keys','Hostel room keys with keychain','Lost',
 ST_SetSRID(ST_MakePoint(78.3030,17.5440),4326)::geography,
 '2026-08-15 18:00','Found',1,NULL,NULL),

(6,NULL,'Laptop Bag','Black laptop backpack','Found',
 ST_SetSRID(ST_MakePoint(78.3080,17.5470),4326)::geography,
 '2026-08-20 13:00','Reported',6,NULL,NULL);


-- ============================================================
-- 16. EVENT SECURITY ASSIGNMENTS
-- ============================================================

INSERT INTO event_security_assignments
(assignment_id,event_id,guard_id,assigned_at,role)
VALUES
(1,1,1,'2026-08-04 18:00','Entrance Security'),
(2,1,2,'2026-08-04 18:00','Crowd Control'),

(3,2,5,'2026-08-14 18:00','Main Gate Security'),
(4,2,4,'2026-08-14 18:00','Crowd Control'),

(5,3,4,'2026-08-17 18:00','Sports Ground'),
(6,3,7,'2026-08-17 18:00','Parking Security'),

(7,4,8,'2026-08-21 18:00','Venue Security'),
(8,4,5,'2026-08-21 18:00','Entrance Security'),

(9,5,3,'2026-08-24 18:00','Venue Security'),
(10,5,4,'2026-08-24 18:00','Crowd Control'),

(11,6,1,'2026-08-27 18:00','Entrance Security'),
(12,6,6,'2026-08-27 18:00','Venue Security'),

(13,7,8,'2026-08-31 18:00','Venue Security'),
(14,7,5,'2026-08-31 18:00','Entrance Security'),

(15,8,6,'2026-09-04 18:00','Medical Camp Security'),
(16,9,4,'2026-09-09 18:00','Sports Ground'),
(17,9,7,'2026-09-09 18:00','Parking Security'),
(18,10,1,'2026-09-14 18:00','Entrance Security');


-- ============================================================
-- 17. CROWD MONITORING
-- ============================================================

INSERT INTO crowd_monitoring
(monitoring_id,zone_id,monitored_at,people_count,crowd_level,recorded_by_guard_id)
VALUES
(1,201,'2026-08-01 09:00',120,'Medium',1),
(2,202,'2026-08-02 20:00',85,'Low',2),
(3,203,'2026-08-03 13:00',310,'High',3),
(4,204,'2026-08-04 17:00',150,'Medium',4),
(5,205,'2026-08-05 09:00',420,'High',5),
(6,206,'2026-08-06 18:00',110,'Medium',6),
(7,207,'2026-08-07 20:00',280,'High',7),
(8,208,'2026-08-08 10:00',95,'Low',8),
(9,203,'2026-08-09 13:00',390,'High',3),
(10,205,'2026-08-10 09:00',500,'Critical',5),
(11,201,'2026-08-11 11:00',140,'Medium',1),
(12,202,'2026-08-12 21:00',70,'Low',2),
(13,204,'2026-08-13 17:30',210,'High',4),
(14,207,'2026-08-14 19:00',330,'High',7),
(15,208,'2026-08-15 11:00',160,'Medium',8);


-- ============================================================
-- 18. CROWD ALERTS
-- ============================================================

INSERT INTO crowd_alerts
(alert_id,zone_id,alert_time,people_count,crowd_level,
 threshold_value,message,status,resolved_by_guard_id,resolved_at)
VALUES
(1,203,'2026-08-03 13:15',310,'High',250,
 'Cafeteria crowd exceeded normal threshold.',
 'Completed',3,'2026-08-03 13:45'),

(2,205,'2026-08-05 09:20',420,'High',350,
 'High crowd detected near main gate.',
 'Completed',5,'2026-08-05 09:50'),

(3,207,'2026-08-07 20:15',280,'High',220,
 'Parking area crowd exceeded threshold.',
 'Completed',7,'2026-08-07 21:00'),

(4,205,'2026-08-10 09:10',500,'Critical',400,
 'Critical crowd level detected at main gate.',
 'Completed',5,'2026-08-10 09:40'),

(5,207,'2026-08-14 19:15',330,'High',250,
 'High crowd detected near parking zone.',
 'In Progress',7,NULL);


-- ============================================================
-- 19. WILDLIFE INCIDENT DETAILS
-- ============================================================

INSERT INTO wildlife_incident_details
(wildlife_detail_id,incident_id,animal_type,animal_count,danger_level,action_taken)
VALUES
(1,3002,'Snake',1,'High','Area isolated and wildlife team contacted.'),
(2,3012,'Peacock',1,'Low','Bird safely moved away from walkway.'),
(3,3021,'Wild Boar',2,'High','Area secured and animals moved away.');


-- ============================================================
-- 20. FIRE INCIDENT DETAILS
-- ============================================================

INSERT INTO fire_incident_details
(fire_detail_id,incident_id,fire_source,containment_status,
 fire_service_called,evacuation_required,damage_description)
VALUES
(1,3006,'Electrical equipment','Contained',
 FALSE,TRUE,'Electrical equipment damaged.'),

(2,3016,'Laboratory equipment','Contained',
 FALSE,FALSE,'Minor equipment damage.'),

(3,3022,'Kitchen equipment','Contained',
 FALSE,FALSE,'Kitchen equipment inspected after smoke incident.');


-- ============================================================
-- 21. MEDICAL INCIDENT DETAILS
-- ============================================================

INSERT INTO medical_incident_details
(medical_detail_id,incident_id,injury_type,severity,
 ambulance_called,hospital_name,treatment_summary)
VALUES
(1,3009,'Fainting','High',
 TRUE,'BITS Medical Centre','Student stabilized and monitored.'),

(2,3018,'Ankle injury','Medium',
 FALSE,'BITS Medical Centre','Basic treatment provided.'),

(3,3024,'Dehydration','Low',
 FALSE,'BITS Medical Centre','Hydration and observation provided.'),

(4,3030,'Medical emergency','High',
 TRUE,'BITS Medical Centre','Emergency treatment initiated.');


-- ============================================================
-- 22. VEHICLE ACCIDENT DETAILS
-- ============================================================

INSERT INTO vehicle_accident_details
(accident_detail_id,incident_id,vehicle_type,vehicle_number,
 driver_name,injuries_reported,damage_description)
VALUES
(1,3007,'Two Wheeler','TS09AB1234','Karthik Reddy',
 TRUE,'Minor front-side damage.'),

(2,3017,'Two Wheeler','TS08CD5678','Manish Gupta',
 FALSE,'Minor scratches.'),

(3,3025,'Car','TS10EF9012','Rahul Das',
 FALSE,'Front bumper damaged.');


-- ============================================================
-- 23. PATROL INCIDENTS
-- ============================================================

INSERT INTO patrol_incidents
(patrol_id,incident_id,detected_at)
VALUES
(1,3001,'2026-08-01 09:10'),
(2,3004,'2026-08-04 11:30'),
(3,3008,'2026-08-08 13:10'),
(4,3010,'2026-08-10 19:20'),
(5,3007,'2026-08-07 08:40'),
(6,3028,'2026-08-28 18:45'),
(7,3029,'2026-08-29 07:30'),
(8,3030,'2026-08-30 15:10');


-- ============================================================
-- 24. ZONE THREAT HISTORY
-- ============================================================

INSERT INTO zone_threat_history
(history_id,zone_id,old_level,new_level,changed_at,changed_by_guard_id,reason)
VALUES
(1,201,'Low','Moderate','2026-08-01 07:30',1,
 'Increased activity in academic area'),

(2,202,'Moderate','Low','2026-08-02 07:00',2,
 'Reduced incident frequency'),

(3,203,'Low','Moderate','2026-08-03 12:30',3,
 'Increased cafeteria crowd'),

(4,205,'Moderate','High','2026-08-05 08:30',5,
 'High visitor and vehicle movement'),

(5,207,'Moderate','High','2026-08-07 19:30',7,
 'Increased parking activity'),

(6,206,'Low','Moderate','2026-08-10 17:00',6,
 'Increased evening activity'),

(7,208,'Low','Moderate','2026-08-15 10:00',8,
 'Technical event activity');


-- ============================================================
-- 25. GUARD LOCATION HISTORY
-- ============================================================

INSERT INTO guard_location_history
(location_history_id,guard_id,zone_id,location,recorded_at)
VALUES
(1,1,201,ST_SetSRID(ST_MakePoint(78.2990,17.5420),4326)::geography,'2026-08-01 08:20'),
(2,1,201,ST_SetSRID(ST_MakePoint(78.3000,17.5430),4326)::geography,'2026-08-01 09:00'),

(3,2,202,ST_SetSRID(ST_MakePoint(78.3030,17.5420),4326)::geography,'2026-08-01 10:20'),
(4,2,202,ST_SetSRID(ST_MakePoint(78.3040,17.5430),4326)::geography,'2026-08-01 11:00'),

(5,3,203,ST_SetSRID(ST_MakePoint(78.3070,17.5420),4326)::geography,'2026-08-02 12:20'),
(6,3,203,ST_SetSRID(ST_MakePoint(78.3080,17.5430),4326)::geography,'2026-08-02 13:10'),

(7,4,204,ST_SetSRID(ST_MakePoint(78.2990,17.5460),4326)::geography,'2026-08-03 16:20'),
(8,4,204,ST_SetSRID(ST_MakePoint(78.3000,17.5470),4326)::geography,'2026-08-03 17:10'),

(9,5,205,ST_SetSRID(ST_MakePoint(78.3030,17.5460),4326)::geography,'2026-08-04 08:20'),
(10,5,205,ST_SetSRID(ST_MakePoint(78.3050,17.5480),4326)::geography,'2026-08-04 09:10'),

(11,6,206,ST_SetSRID(ST_MakePoint(78.3070,17.5460),4326)::geography,'2026-08-05 18:20'),
(12,6,206,ST_SetSRID(ST_MakePoint(78.3080,17.5480),4326)::geography,'2026-08-05 19:10'),

(13,7,207,ST_SetSRID(ST_MakePoint(78.2990,17.5500),4326)::geography,'2026-08-06 20:20'),
(14,7,207,ST_SetSRID(ST_MakePoint(78.3000,17.5510),4326)::geography,'2026-08-06 21:10'),

(15,8,208,ST_SetSRID(ST_MakePoint(78.3040,17.5500),4326)::geography,'2026-08-07 09:20'),
(16,8,208,ST_SetSRID(ST_MakePoint(78.3050,17.5520),4326)::geography,'2026-08-07 10:10'),

(17,5,205,ST_SetSRID(ST_MakePoint(78.3040,17.5470),4326)::geography,'2026-08-09 08:30'),
(18,7,207,ST_SetSRID(ST_MakePoint(78.3000,17.5500),4326)::geography,'2026-08-09 18:30');


-- ============================================================
-- 26. EMERGENCY RESPONSE HISTORY
-- ============================================================

INSERT INTO emergency_response_history
(response_history_id,emergency_request_id,guard_id,action,action_time,remarks)
VALUES
(1,1,1,'Reached student location','2026-08-04 15:34','Student found conscious.'),
(2,1,1,'Provided first aid','2026-08-04 15:40','Basic first aid provided.'),

(3,2,6,'Reached hostel area','2026-08-06 22:05','Suspicious person located.'),
(4,2,6,'Area secured','2026-08-06 22:15','Person escorted away.'),

(5,3,4,'Reached sports ground','2026-08-12 18:04','Student located.'),
(6,3,4,'Provided assistance','2026-08-12 18:15','Student escorted to medical centre.'),

(7,4,5,'Reached gate area','2026-08-18 12:34','Unattended bag located.'),
(8,4,5,'Area inspected','2026-08-18 12:45','Bag determined to be harmless.'),

(9,5,6,'Reached student location','2026-08-25 16:48','Student located.'),
(10,5,6,'Medical assistance requested','2026-08-25 16:55','Medical centre contacted.');


-- ============================================================
-- COMMIT
-- ============================================================

COMMIT;


-- ============================================================
-- VALIDATION
-- ============================================================

-- 1. Row count of all 26 tables

SELECT 'students' AS table_name, COUNT(*) AS row_count FROM students
UNION ALL
SELECT 'guards', COUNT(*) FROM guards
UNION ALL
SELECT 'security_zones', COUNT(*) FROM security_zones
UNION ALL
SELECT 'incidents', COUNT(*) FROM incidents
UNION ALL
SELECT 'incident_person', COUNT(*) FROM incident_person
UNION ALL
SELECT 'incident_status_history', COUNT(*) FROM incident_status_history
UNION ALL
SELECT 'patrols', COUNT(*) FROM patrols
UNION ALL
SELECT 'patrol_locations', COUNT(*) FROM patrol_locations
UNION ALL
SELECT 'investigations', COUNT(*) FROM investigations
UNION ALL
SELECT 'investigation_evidence', COUNT(*) FROM investigation_evidence
UNION ALL
SELECT 'escort_requests', COUNT(*) FROM escort_requests
UNION ALL
SELECT 'emergency_requests', COUNT(*) FROM emergency_requests
UNION ALL
SELECT 'complaints', COUNT(*) FROM complaints
UNION ALL
SELECT 'lost_found', COUNT(*) FROM lost_found
UNION ALL
SELECT 'events', COUNT(*) FROM events
UNION ALL
SELECT 'event_security_assignments', COUNT(*) FROM event_security_assignments
UNION ALL
SELECT 'crowd_monitoring', COUNT(*) FROM crowd_monitoring
UNION ALL
SELECT 'crowd_alerts', COUNT(*) FROM crowd_alerts
UNION ALL
SELECT 'wildlife_incident_details', COUNT(*) FROM wildlife_incident_details
UNION ALL
SELECT 'fire_incident_details', COUNT(*) FROM fire_incident_details
UNION ALL
SELECT 'medical_incident_details', COUNT(*) FROM medical_incident_details
UNION ALL
SELECT 'vehicle_accident_details', COUNT(*) FROM vehicle_accident_details
UNION ALL
SELECT 'patrol_incidents', COUNT(*) FROM patrol_incidents
UNION ALL
SELECT 'zone_threat_history', COUNT(*) FROM zone_threat_history
UNION ALL
SELECT 'guard_location_history', COUNT(*) FROM guard_location_history
UNION ALL
SELECT 'emergency_response_history', COUNT(*) FROM emergency_response_history
ORDER BY table_name;


-- 2. Guards and their zones

SELECT
    g.guard_id,
    g.name AS guard_name,
    g.status,
    z.zone_id,
    z.zone_name,
    z.threat_level
FROM guards g
LEFT JOIN security_zones z
ON g.current_zone_id = z.zone_id
ORDER BY g.guard_id;


-- 3. Incidents with assigned guards

SELECT
    i.incident_id,
    i.category,
    i.severity,
    i.status,
    g.name AS assigned_guard
FROM incidents i
LEFT JOIN guards g
ON i.assigned_guard_id = g.guard_id
ORDER BY i.incident_id;


-- 4. Patrol information

SELECT
    p.patrol_id,
    g.name AS guard_name,
    z.zone_name,
    p.start_time,
    p.end_time,
    p.status
FROM patrols p
JOIN guards g
ON p.guard_id = g.guard_id
JOIN security_zones z
ON p.zone_id = z.zone_id
ORDER BY p.patrol_id;


-- 5. Check invalid student references

SELECT i.incident_id, i.reported_by_student
FROM incidents i
LEFT JOIN students s
ON i.reported_by_student = s.student_id
WHERE i.reported_by_student IS NOT NULL
AND s.student_id IS NULL;


-- 6. Check invalid guard references

SELECT i.incident_id, i.assigned_guard_id
FROM incidents i
LEFT JOIN guards g
ON i.assigned_guard_id = g.guard_id
WHERE i.assigned_guard_id IS NOT NULL
AND g.guard_id IS NULL;


-- 7. Check incident history

SELECT
    history_id,
    incident_id,
    old_status,
    new_status,
    changed_by_guard,
    changed_at,
    remarks
FROM incident_status_history
ORDER BY history_id;


-- 8. PostGIS zone/guard data

SELECT
    zone_id,
    zone_name,
    threat_level,
    ST_AsText(boundary) AS boundary
FROM security_zones
ORDER BY zone_id;