/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3 ;
ALTER TABLE animals
BEGIN
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK --species column is back to null
SELECT * FROM animals;
BEGIN
UPDATE animals
SET species = 'digimon' WHERE NAME LIKE '%mon'
UPDATE animals
SET species = 'pokemon' WHERE species IS NULL
COMMIT
SELECT * FROM animals -- changes persisted
BEGIN
DELETE FROM animals -- all the records are deleted
ROLLBACK
SELECT * FROM animals -- record is back
BEGIN
DELETE FROM animals
WHERE date_of_birth > '2022-01-01'
BEGIN
SAVEPOINT savepoint1
UPDATE animals
SET weight_kg = weight_KG * -1;
ROLLBACK TO SAVEPOINT savepoint1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT

--How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals

--How many animals have never tried to escape?
SELECT COUNT(*) AS total_animals_that_never_tried_escape FROM animals WHERE escape_attempts <= 0

--What is the average weight of animals?
SELECT AVG(weight_kg) AS avg_weights_of_animal FROM animals

--Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered

--What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- was the last animal seen by William Tatcher?
SELECT vs.name as name, v.date_of_visit FROM visits v INNER JOIN
 vets vs  ON vs.id = v.vets_id WHERE vs.name ='William Tatcher' ORDER BY v.date_of_visit DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT count( DISTINCT a.name) FROM visits v INNER JOIN
 vets vs  ON vs.id = v.vets_id  INNER JOIN animals a ON a.id= v.animal_id  WHERE vs.name ='Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vs.name as name, sp.name as species_name FROM specializations s RIGHT OUTER JOIN
 vets vs  ON vs.id = s.vets_id  LEFT OUTER JOIN species sp ON sp.id = s.species_id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vs.name as name, v.date_of_visit,a.name as animals_name FROM visits v INNER JOIN
 vets vs  ON vs.id = v.vets_id  INNER JOIN animals a ON a.id= v.animal_id  WHERE vs.name ='Stephanie Mendez'
  AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT a.name as animals_name, count(a.name) FROM visits v INNER JOIN
 vets vs  ON vs.id = v.vets_id  INNER JOIN animals a ON a.id= v.animal_id
 GROUP BY a.name ORDER BY count( a.name) DESC LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT vs.name as name, v.date_of_visit,a.name as animals_name FROM visits v INNER JOIN
 vets vs  ON vs.id = v.vets_id  INNER JOIN animals a ON a.id= v.animal_id
 WHERE vs.name ='Stephanie Mendez'  ORDER BY date_of_visit LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT vs.name as name, v.date_of_visit,a.name as animals_name FROM visits v INNER JOIN
 vets vs  ON vs.id = v.vets_id  INNER JOIN animals a ON a.id= v.animal_id
 ORDER BY date_of_visit DESC LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
  SELECT COUNT(*) FROM visits v JOIN animals a ON a.id = v.animal_id
  JOIN vets vs ON vs.id = v.vets_id LEFT JOIN specializations spec ON
  spec.vets_id = vs.id AND spec.species_id = a.species_id WHERE spec.vets_id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
  SELECT COUNT(visits.animal_id) FROM visits where vets_id =
 (select id from vets WHERE name = 'Maisy Smith') AND
 animal_id IN (SELECT id from animals WHERE species_id =
  (SELECT id FROM species WHERE name = 'Digimon'));