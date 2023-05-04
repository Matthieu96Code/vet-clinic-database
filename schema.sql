/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BIT,
  weight_kg FLOAT,
  PRIMARY KEY(id)
);

-- Add a column species of type string to animals table
ALTER TABLE animals ADD species VARCHAR(250);

-- Create a table named owners with the given columns
CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(250),
  age INT,
  PRIMARY KEY(id)
);

-- Create a table named spicies with the given columns
CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  PRIMARY KEY(id)
);

-- Modify animals table
-- Remove column species
ALTER TABLE animals DROP species;
-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD species_id INT REFERENCES species(id);
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);

-- Millestone 4 join table
-- Create a table named vets with the given columns
CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

-- Create a join table specializations relationship between the tables species and vets
CREATE TABLE specializations(
  species_id INT REFERENCES species(id),
  vets_id INT REFERENCES vets(id),
  PRIMARY KEY(species_id, vets_id)
);

-- Create a join table visits relationship between the tables animals and vets
CREATE TABLE visits(
  animals_id INT REFERENCES animals(id),
  vets_id INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(animals_id, vets_id, date_of_visit)
);
