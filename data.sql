/* Populate database with sample data. */

-- Insert data into animals table in millestone 1 of the the project

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', '2020-02-03', 10.23, '1', 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', '2018-11-15', 8.0, '1', 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Pikachu', '2021-01-07', 15.04, '0', 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Devimon', '2017-05-12', 11.0, '1', 5);

-- Insert data into animals table in millestone 2 of the the project

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', '2020-02-08', -11.0, '0', 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', '2021-11-15', -5.7, '1', 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', '1993-04-02', -12.13, '0', 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', '2005-06-12', -45.0, '1', 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', '2005-06-07', 20.4, '1', 7);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', '1998-10-13', 17.0, '1', 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Ditto', '2022-05-14', 22.0, '1', 4);

-- Insert data into owners table in millestone 3 of the the project

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert data into species table in millestone 3 of the the project

INSERT INTO species  (name) VALUES ('Pokemon');
INSERT INTO species  (name) VALUES ('Digimon');

-- Modify the inserted animals so it includes the species_id value
BEGIN;
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
COMMIT;
SELECT * FROM animals;

-- Modify the inserted animals to include owner information (owner_id)
BEGIN;
UPDATE animals SET owner_id = 1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');
COMMIT;
SELECT * FROM animals;

-- Insert data into vets table in millestone 4 of the the project

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert data into specializations table in millestone 4 of the the project

INSERT INTO specializations (vets_id, species_id) VALUES (1, 1);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 1);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vets_id, species_id) VALUES (4, 2);

-- Insert data into visits table in millestone 4 of the the project

INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-03-08');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10, 4, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10, 1, '2021-01-11');