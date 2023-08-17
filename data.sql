/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', '2020-03-02',0,true,10.23)
INSERT INTO animals VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8 )
INSERT INTO animals VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04)
INSERT INTO animals VALUES (4, ' Devimon', '2017-05-17', 5, true, 11)
INSERT INTO animals VALUES (5, ' Charmander', '2020-02-08', 0, false, -11)
INSERT INTO animals VALUES(6, 'Plantmon', '2021-11-15', 2, true, -5.7),
(7, 'Squirtle', '1993-04-02', 3, false,  -12.13),
(8, 'Angemon', '2005-06-12', 1, true, -45),
(9, ' Boarmon', '2005-06-07', 7, true, 20.4),
(10, 'Blossom', '1998-10-13', 3, true, 17),
(11, 'Ditto', '2022-05-14', 4, true, 22)

INSERT INTO owners (full_name, age)
VALUES  ('Sam Smith', 34),
		('Jennifer Orwell', 19),
		('Bob', 45),
		('Melody Pond', 77),
		('Dean Winchester', 14),
		('Jodie Whittaker', 38)

INSERT INTO species (name)
VALUES  ('Pokemon'),
		('Digimon')

UPDATE animals SET species_id = 1 WHERE name LIKE '%mon'
UPDATE animals SET species_id = 2 WHERE name NOT LIKE '%mon'

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon'
UPDATE animals SET owner_id = 2 WHERE name + 'Gabumon' OR name = 'Pikachu'
UPDATE animals SET owner_id = 3 WHERE name = 'Plantmon' OR name = 'Devimon'
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom'
UPDATE animals SET owner_id = 5 WHERE name = ' Angemon' OR name = 'Boarmon'

SELECT full_name, name from owners INNER JOIN animals on owners.id = animals.id WHERE full_name = 'Melody Pond'

SELECT a.name, s.name from species s INNER JOIN animals a ON s.id = a.species_id  WHERE s.name='Pokemon'

SELECT full_name as owners_name, name as animal_name from owners LEFT OUTER JOIN animals ON owners.id = animals.owner_id

SELECT s.name, count(*) as total from species s INNER JOIN animals a ON s.id = a.species_id GROUP BY s.name

SELECT o.full_name as owners_name, a.name as animal_name,  s.name as species_name from owners o INNER JOIN animals a ON o.id = a.owner_id
 INNER JOIN species s ON s.id = a.species_id   WHERE o.full_name='Jennifer Orwell' And s.name='Digimon'

SELECT o.full_name as owners_name, a.name as animal_name, a.escape_attempts from owners o INNER JOIN animals a ON o.id = a.owner_id
 WHERE full_name='Dean Winchester' AND escape_attempts = 0

SELECT o.full_name as owner_name, COUNT(a.id) as number_of_animals FROM animals a JOIN owners o ON a.owner_id = o.id GROUP BY
o.full_name ORDER BY number_of_animals DESC LIMIT 1


INSERT INTO vets (name,age,date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
	('Maisy Smith', 26, '2019-01-17'),
	('Stephanie Mendez', 64, '1981-05-04'),
	('Jack Harkness', 38, '2008-7-08' )

INSERT INTO specializations(species_id,vets_id)
VALUES (1,1),
	(1,3),
	(2,3),
	(2,4)

-- Gabumon visit
INSERT INTO visits
VALUES(7,4,'2021-02-02')

--all Agumon visits
INSERT INTO visits
VALUES(5,1,'2020-05-24'),
	(5,3,'2020-07-22'),


--all Pikachu visit
INSERT INTO visits
VALUES(9,2,'2020-01-05'),
	(9,2,'2020-03-08'),
	(9,2,'2020-05-14')

-- Devimon visit
INSERT INTO visits
VALUES(6,3,'2021-05-04')

-- Charmander
INSERT INTO visits
VALUES(3,4,'2021-02-24')

-- all Plantmon visits
INSERT INTO visits
VALUES(1,2,'2019-12-21'),
	(1,1,'2020-08-10'),
	(1,2,'2021-04-07')

-- Squirtle visit
INSERT INTO visits
VALUES(4,3,'2019-09-29')

-- all Angemon visits
INSERT INTO visits
VALUES(2,4,'2020-10-03'),
	(2,4,'2021-11-04')

-- all Boarmon visits
INSERT INTO visits
VALUES(8,2,'2019-01-24'),
	(8,2,'2019-05-15'),
	(8,2,'2021-02-27'),
	(8,2,'2020-08-03')

-- all Blossom visits
INSERT INTO visits
VALUES(10,3,'2020-05-24'),
	(10,1,'2020-01-11')