CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE patient_companion(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID NOT NULL,
    patient_id UUID NOT NULL,
    company_id UUID NOT NULL,

    CONSTRAINT FK_PATIENT_COMPANION_PERSON_ID FOREIGN KEY (person_id)
        REFERENCES person(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_PATIENT_COMPANION_PATIENT_ID FOREIGN KEY (patient_id)
        REFERENCES patients(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_PATIENT_COMPANION_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_patient_companion_person_id ON patient_companion(person_id);
CREATE INDEX idx_patient_companion_patient_id ON patient_companion(patient_id);
CREATE INDEX idx_patient_companion_company_id ON patient_companion(company_id);
CREATE INDEX idx_patient_companion_patient_id_company_id ON patient_companion(patient_id,company_id);
CREATE INDEX idx_patient_companion_person_id_company_id ON patient_companion(person_id,company_id);
