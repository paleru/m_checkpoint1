

DROP TABLE IF EXISTS contact_categories, contact_types, contacts, items CASCADE;

CREATE TABLE IF NOT EXISTS contact_categories (
	id SERIAL PRIMARY KEY,
	contact_category VARCHAR(20) NOT NULL CHECK (contact_category <> '')
);

CREATE TABLE IF NOT EXISTS contact_types (
	id SERIAL PRIMARY KEY,
	contact_type VARCHAR(20) NOT NULL CHECK (contact_type <> '')
);

CREATE TABLE IF NOT EXISTS contacts (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL CHECK (first_name <> ''),
	--should be able to have contacts with only one name
	last_name VARCHAR(30),
	title VARCHAR(30),
	organization VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS items (
	contact VARCHAR(50) NOT NULL CHECK (contact <> ''),
	contact_id INT NOT NULL references contacts(id),
	contact_type_id INT NOT NULL references contact_types(id),
	contact_category_id INT NOT NULL references contact_categories(id)
);

INSERT INTO contacts (first_name, last_name, title, organization) 
	VALUES 
	('Erik', 'Eriksson', 'Teacher', 'Utbildning AB'),
	('Anna', 'Sundh', NULL, NULL),
	('Goran', 'Bregovic', 'Coach', 'Dalens IK'),
	('Ann-Marie', 'Bergqvist', 'Cousin', NULL),
	('Herman', 'Appelkvist', NULL, NULL),
	('Pål Egil', 'Runde', 'Student', NULL);

INSERT INTO contact_types (contact_type) 
	VALUES 
	('Email'),('Phone'),('Skype'),('Instagram');

INSERT INTO contact_categories (contact_category) 
	VALUES 
	('Home'),('Work'),('Fax');

INSERT INTO items (contact, contact_id, contact_type_id, contact_category_id)
	VALUES 
	('011-12 33 45', 3, 2, 1),
	('goran@infoab.se', 3, 1, 2),
	('010-88 55 44', 4, 2, 2),
	('erik57@hotmail.com', 1, 1, 1),
	('@annapanna99', 2, 4, 1),
	('077-563578', 2, 2, 1),
	('070-156 22 78', 3, 2, 2),
	('palegil.runde@email.com', 6, 1, 2);

-- 1.6 only works when run separately for some reason
SELECT ct.contact_type FROM contact_types ct 
	WHERE ct.id NOT IN (
		SELECT contact_type_id FROM items
	);

-- 1.7
CREATE OR REPLACE VIEW view_contacts AS
SELECT 
	c.first_name, 
	c.last_name,
	i.contact,
	ct.contact_type,
	cc.contact_category
FROM 
	contacts c 
JOIN items i ON i.contact_id = c.id
JOIN contact_types ct ON ct.id = i.contact_type_id
JOIN contact_categories cc ON cc.id = i.contact_category_id;

-- 1.8
SELECT * FROM view_contacts;


-- 1.9
/* Utilizing a composite PK 
CREATE TABLE IF NOT EXISTS items (
	contact VARCHAR(50) NOT NULL CHECK (contact <> ''),
	contact_id INT NOT NULL references contacts(id),
	contact_type_id INT NOT NULL references contact_types(id),
	contact_category_id INT NOT NULL references contact_categories(id),

	PRIMARY KEY (contact, contact_id, contact_type_id, contact_category_id)
);
*/


