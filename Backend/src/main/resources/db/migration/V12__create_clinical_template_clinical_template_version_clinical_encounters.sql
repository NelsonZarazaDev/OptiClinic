CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE clinical_template(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    status BOOLEAN DEFAULT TRUE,
    company_id UUID,
    branch_id UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,

    CONSTRAINT CHK_CLINICAL_TEMPLATE_OWNER
        CHECK (num_nonnulls(company_id, branch_id) = 1),

    CONSTRAINT FK_CLINICAL_TEMPLATE_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_CLINICAL_TEMPLATE_BRANCHES_ID FOREIGN KEY (branch_id)
        REFERENCES branches(id)
        ON DELETE RESTRICT
);

CREATE TABLE clinical_template_version (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID,
    branch_id UUID,
    version_number INTEGER NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'DRAFT',
    schema_definition JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,

    CONSTRAINT CHK_CLINICAL_TEMPLATE_OWNER
        CHECK (num_nonnulls(company_id, branch_id) = 1),

    CONSTRAINT chk_clinical_template_version_number
        CHECK (version_number > 0),

    CONSTRAINT chk_clinical_template_version_status
        CHECK (status IN ('DRAFT', 'PUBLISHED', 'ARCHIVED')),

    CONSTRAINT uq_clinical_company_template_version
        UNIQUE (company_id, version_number),

    CONSTRAINT uq_clinical_branch_template_version
        UNIQUE (branch_id, version_number),

    CONSTRAINT FK_CLINICAL_TEMPLATE_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_CLINICAL_TEMPLATE_BRANCHES_ID FOREIGN KEY (branch_id)
        REFERENCES branches(id)
        ON DELETE RESTRICT
);

CREATE TABLE clinical_encounters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID,
    branch_id UUID,
    patient_company_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    template_version_id UUID NOT NULL,
    reason_for_consultation TEXT NOT NULL,
    current_illness TEXT,
    response_data JSONB NOT NULL,
    diagnosis_code VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,

    CONSTRAINT CHK_CLINICAL_ENCOUNTERS_OWNER
        CHECK (num_nonnulls(company_id, branch_id) = 1),

    CONSTRAINT FK_CLINICAL_ENCOUNTERS_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_CLINICAL_ENCOUNTERS_BRANCHES_ID FOREIGN KEY (branch_id)
        REFERENCES branches(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_clinical_encounters_patient_company
        FOREIGN KEY (patient_company_id)
            REFERENCES patient_companion(id)
            ON DELETE RESTRICT,

    CONSTRAINT fk_clinical_encounters_professional
        FOREIGN KEY (professional_id)
            REFERENCES users(id)
            ON DELETE RESTRICT,

    CONSTRAINT fk_clinical_encounters_template_version
        FOREIGN KEY (template_version_id)
            REFERENCES clinical_template_version(id)
            ON DELETE RESTRICT
);

CREATE INDEX idx_clinical_template_company_id
    ON clinical_template(company_id)
    WHERE company_id IS NOT NULL;

CREATE INDEX idx_clinical_template_branch_id
    ON clinical_template(branch_id)
    WHERE branch_id IS NOT NULL;

CREATE INDEX idx_clinical_encounters_company_id
    ON clinical_encounters(company_id);

CREATE INDEX idx_clinical_encounters_company_patient_id
    ON clinical_encounters(patient_company_id);

CREATE INDEX idx_clinical_encounters_professional_id
    ON clinical_encounters(professional_id);

CREATE INDEX idx_clinical_encounters_template_version_id
    ON clinical_encounters(template_version_id);