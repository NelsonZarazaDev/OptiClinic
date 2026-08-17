CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE reservation(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    starts_at TIMESTAMPTZ,
    ends_at TIMESTAMPTZ,
    appointment_status VARCHAR(12),
    person_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    company_id UUID,
    branch_id UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,

    CONSTRAINT CHK_RESERVATION_APPOINTMENT_STATUS
        CHECK (appointment_status IN ('RESERVED','ASSIGNED','NOT_ASSIGNED')),

    CONSTRAINT chk_reservation_owner
        CHECK (num_nonnulls(company_id, branch_id) = 1),

    CONSTRAINT chk_reservation_dates
        CHECK (ends_at > starts_at),

    CONSTRAINT FK_RESERVATION_PERSON_ID FOREIGN KEY (person_id)
        REFERENCES person(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_RESERVATION_PROFESSIONAL_ID FOREIGN KEY (professional_id)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_RESERVATION_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_RESERVATION_BRANCHES_ID FOREIGN KEY (branch_id)
        REFERENCES branches(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_reservation_starts_at ON reservation(starts_at);
CREATE INDEX idx_reservation_ends_at ON reservation(ends_at);
CREATE INDEX idx_reservation_professional_id ON reservation(professional_id);
CREATE INDEX idx_reservation_company_id ON reservation(company_id);
CREATE INDEX idx_reservation_branch_id ON reservation(branch_id);
CREATE INDEX idx_reservation_starts_at_ends_at ON reservation(starts_at, ends_at);