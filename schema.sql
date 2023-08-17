/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL (4,2)
)
ALTER TABLE animals ADD COLUMN species;
ADD COLUMN species varchar(255);

CREATE TABLE owners (
	 id SERIAL PRIMARY KEY,
	full_name VARCHAR(255) ,
	age INT
)

CREATE TABLE species (
	 id SERIAL PRIMARY KEY,
	 name VARCHAR(255)
)

ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals
ADD COLUMN id SERIAL PRIMARY KEY

ALTER TABLE animals
DROP COLUMN species

ALTER TABLE animals
ADD COLUMN species_id INT

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) REFERENCES species(id)

ALTER TABLE animals
ADD COLUMN owner_id INT

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id) REFERENCES owners(id)

CREATE TABLE vets (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	date_of_graduation DATE
)


CREATE TABLE specializations(
    species_id INTEGER REFERENCES species(id),
    vets_id INTEGER REFERENCES vets(id),
    CONSTRAINT specializations_pk PRIMARY KEY(species_id,vets_id)
)

CREATE TABLE visits(
	animal_id INTEGER REFERENCES animals(id),
	vets_id INTEGER REFERENCES vets(id),
	date_of_visit date,
	CONSTRAINT visit_pk PRIMARY KEY (animal_id,vets_id,date_of_visit)
)