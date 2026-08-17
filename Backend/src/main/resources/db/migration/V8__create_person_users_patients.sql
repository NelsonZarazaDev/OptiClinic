CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE person(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    first_surname VARCHAR(100) NOT NULL,
    identification_type UUID,
    identification_number VARCHAR(50),
    birth_date TIMESTAMPTZ NOT NULL,
    biological_sex VARCHAR(20) NOT NULL,
    gender_identity VARCHAR(50) NOT NULL,
    email VARCHAR(254),
    phone VARCHAR(20),
    occupation VARCHAR(150),
    blood_type VARCHAR(3),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    status_id UUID NOT NULL,
    CONSTRAINT CHK_PERSON_BLOOD_TYPE CHECK (blood_type IN ('O-','O+','A-','A+','B-','B+','AB-','AB+')),

    CONSTRAINT FK_PERSON_STATUS_ID FOREIGN KEY (status_id)
        REFERENCES status_person(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_person_email ON person(email);
CREATE INDEX idx_person_birth_date ON person(birth_date);
CREATE INDEX idx_person_identification_number ON person(identification_number);
CREATE INDEX idx_person_identification_number_identification_type ON person(identification_number,identification_type);


CREATE TABLE users(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID NOT NULL,
    role_id UUID NOT NULL,
    is_active BOOLEAN DEFAULT FALSE,
    delete_at TIMESTAMPTZ,

    CONSTRAINT FK_PERSON_ID FOREIGN KEY (person_id)
        REFERENCES person(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_ROLE_ID FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_users_person_id ON users(person_id);
CREATE INDEX idx_users_person_id_is_active ON users(person_id,is_active);


CREATE TABLE patients(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID NOT NULL
)