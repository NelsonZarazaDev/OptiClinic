CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE identification_type (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL,
    is_visible_company BOOLEAN NOT NULL DEFAULT FALSE,
    is_visible_user BOOLEAN NOT NULL DEFAULT FALSE,
    country_code CHAR(2) NOT NULL DEFAULT 'CO',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    min_length SMALLINT NOT NULL DEFAULT 1,
    max_length SMALLINT NOT NULL DEFAULT 50,

    format_type VARCHAR(20) NOT NULL DEFAULT 'ALPHANUMERIC',
    regex_pattern VARCHAR(255),

    CONSTRAINT UQ_IDENTIFICATION_TYPE_COUNTRY_CODE
        UNIQUE (country_code, code),

    CONSTRAINT UQ_IDENTIFICATION_TYPE_NAME UNIQUE (name),

    CONSTRAINT chk_format_type
        CHECK (
            format_type IN ('NUMERIC', 'ALPHABETIC', 'ALPHANUMERIC')
            )
);

CREATE TABLE status_companys_branches(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT UQ_STATUS_COMPANYS_BRANCHES_NAME UNIQUE (name)

);

CREATE INDEX idx_identification_type_name ON identification_type(name);