--create tables

CREATE EXTENSION "uuid-ossp";

CREATE TABLE doctors(
    uuid uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name CHARACTER VARYING (256), 
	category VARCHAR (256),
	position VARCHAR (256)
);

CREATE TABLE patients(
    uuid uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name CHARACTER VARYING (256), 
	sex VARCHAR (1),
	birth_date DATE,
	weight INTEGER CHECK (weight > 10 AND weight < 300),
	height INTEGER CHECK (height > 50 AND height < 220)
);

CREATE TABLE anamnesis(
    patient_uuid uuid REFERENCES patients(uuid), 
	doctor_uuid uuid REFERENCES doctors(uuid), 
	diagnosis VARCHAR (256), 
	treatment VARCHAR (256)
);


--data from tables

INSERT INTO doctors(name, category, position) VALUES 
	('Williams', 'First', 'Therapist'),
    ('Peters', 'First', 'Pediatrist'),
    ('Gibson', 'Highest', 'Ophthalmologist');
	
INSERT INTO patients(name, sex, birth_date, weight, height) VALUES 
	('Smith', 'M', '1990-04-20', '80', '180'),
	('Jones', 'M', '1970-05-12', '90', '190'),
	('Harris', 'F', '1995-01-23', '50', '160'),
	('Davies', 'F', '2000-07-10', '60', '165');
	
INSERT INTO anamnesis(patient_uuid, doctor_uuid, diagnosis, treatment) VALUES 
(
    (SELECT uuid FROM patients WHERE name='Smith'),
    (SELECT uuid FROM doctors WHERE name='Williams'),
    'temprature',
    'measure the temperature, give tablet'
),
(
    (SELECT uuid FROM patients WHERE name='Jones'),
    (SELECT uuid FROM doctors WHERE name='Williams'),
    'headache',
    'give tablet'
),
(
    (SELECT uuid FROM patients WHERE name='Harris'),
    (SELECT uuid FROM doctors WHERE name='Williams'),
    'medical checkup',
    'referral for a blood test'
),
(
    (SELECT uuid FROM patients WHERE name='Davies'),
    (SELECT uuid FROM doctors WHERE name='Williams'),
    'headache',
    'give tablet'
),
(
    (SELECT uuid FROM patients WHERE name='Smith'),
    (SELECT uuid FROM doctors WHERE name='Gibson'),
    'decreased vision',
    'referral for surgery'
),
(
    (SELECT uuid FROM patients WHERE name='Jones'),
    (SELECT uuid FROM doctors WHERE name='Peters'),
    'childs infectious disease',
    'give an injection'
),
(
    (SELECT uuid FROM patients WHERE name='Harris'),
    (SELECT uuid FROM doctors WHERE name='Peters'),
    'childs infectious disease',
    'give an injection'
),
(
    (SELECT uuid FROM patients WHERE name='Davies'),
    (SELECT uuid FROM doctors WHERE name='Gibson'),
    'aching eyes',
    'drops prescription'
),
(
    (SELECT uuid FROM patients WHERE name='Jones'),
    (SELECT uuid FROM doctors WHERE name='Gibson'),
    'aching eyes',
    'drops prescription'
),
(
    (SELECT uuid FROM patients WHERE name='Harris'),
    (SELECT uuid FROM doctors WHERE name='Gibson'),
    'decreased vision',
    'referral for surgery'
)



--1
SELECT name, category FROM doctors


--2
SELECT * FROM patients

--3
SELECT * FROM patients WHERE sex = 'F'

--4
SELECT * FROM patients ORDER BY birth_date

--5
SELECT patients.name, doctors.name 
FROM patients JOIN anamnesis ON patients.uuid=patient_uuid
JOIN doctors ON doctors.uuid=doctor_uuid  




