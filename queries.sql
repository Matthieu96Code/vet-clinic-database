/*Queries that provide answers to the questions from all projects.*/

-- Queries manipulation in millestone 1 of the the project

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals WHERE neutered = '1' AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered = '1';

-- Find all animals not named Gabumon.
SELECT * from animals WHERE name NOT IN ('Gabumon');

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Queries manipulation in millestone 2 of the the project

-- setting the species column to unspecified and rollback.
BEGIN;
ALTER TABLE animals RENAME COLUMN species TO unspecified;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- setting the species column to digimon and pokemon and commit.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Delete all records in the table and rollback 
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete animals born after 2022-01-01 and update weight_kg
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- How many animals are there?
SELECT COUNT(*) as total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) as never_escape FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) as average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) as total_escape_attempts FROM animals GROUP BY neutered;

-- hat is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) as minimum_weight, MAX(weight_kg) as maximum FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as average_escap_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- Write queries using JOIN.
-- What animals belong to Melody Pond?
SELECT name, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name  FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name, full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, full_name, escape_attempts FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name, COUNT(*) as most_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY full_name ORDER BY COUNT(*) DESC LIMIT 1;


-- Write queries on the join tables.
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, date_of_visit FROM vets JOIN visits ON vets.id = visits.vets_id JOIN animals ON animals.id = visits.animals_id WHERE vets.name IN ('William Tatcher') ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(specializations.species_id) FROM vets JOIN specializations ON vets.id = specializations.vets_id WHERE vets.name IN ('Stephanie Mendez') GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, vets.name, date_of_visit FROM visits JOIN vets ON vets.id = visits.vets_id JOIN animals ON animals.id = visits.animals_id WHERE vets.name IN ('Stephanie Mendez') AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(date_of_visit) as visit_count FROM visits JOIN animals ON visits.animals_id = animals.id GROUP BY animals.name ORDER BY COUNT(date_of_visit) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, date_of_visit FROM visits JOIN animals ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id WHERE vets.name IN ('Maisy Smith') ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, animals.date_of_birth, animals.weight_kg, vets.name, vets.age, vets.date_of_graduation , date_of_visit FROM visits JOIN animals ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(date_of_visit) as visit_count FROM visits LEFT JOIN vets ON vets.id = visits.vets_id LEFT JOIN specializations ON vets.id = specializations.vets_id WHERE specializations.species_id IS NULL GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(*) FROM visits JOIN vets ON vets.id = visits.vets_id JOIN animals ON visits.animals_id = animals.id JOIN species ON species.id = animals.species_id WHERE vets.name IN ('Maisy Smith') GROUP BY species.name ORDER BY COUNT(*) DESC LIMIT 1;
