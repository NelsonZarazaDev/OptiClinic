CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE status_person(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    is_global BOOLEAN DEFAULT FALSE,
    company_id UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,

    CONSTRAINT UQ_STATUS_PERSON_NAME UNIQUE (name),

    CONSTRAINT FK_STATUS_PERSON_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_status_person_is_global ON status_person(is_global);
CREATE INDEX idx_status_person_is_global_company_id ON status_person(is_global,company_id);