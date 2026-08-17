CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE company(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    identification_type_id UUID NOT NULL,
    identification_number VARCHAR(50) NOT NULL,
    logo VARCHAR(500),
    status_id UUID NOT NULL,
    city_id INT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,

    CONSTRAINT uq_company_email UNIQUE (email),
    CONSTRAINT uq_company_phone UNIQUE (phone),

    CONSTRAINT FK_COMPANY_IDENTIFICATION_TYPE_ID
        FOREIGN KEY (identification_type_id)
            REFERENCES identification_type(id)
            ON DELETE RESTRICT,

    CONSTRAINT FK_COMPANY_CITY_ID
        FOREIGN KEY (city_id)
            REFERENCES city(id)
            ON DELETE RESTRICT,

    CONSTRAINT FK_COMPANY_STATUS_ID
        FOREIGN KEY (status_id)
            REFERENCES status_companys_branches(id)
            ON DELETE RESTRICT
);

CREATE INDEX idx_company_name ON company(name);
CREATE INDEX idx_company_email ON company(email);
CREATE INDEX idx_company_phone ON company(phone);
CREATE INDEX idx_company_identification_number ON company(identification_number);

CREATE TABLE branches(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    logo VARCHAR(500),
    status_id UUID NOT NULL,
    city_id INT NOT NULL,
    company_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,

    CONSTRAINT FK_BRANCHES_CITY_ID
        FOREIGN KEY (city_id)
            REFERENCES city(id)
            ON DELETE RESTRICT,

    CONSTRAINT FK_BRANCHES_COMPANY_ID
        FOREIGN KEY (company_id)
            REFERENCES company(id)
            ON DELETE RESTRICT,

    CONSTRAINT FK_BRANCHES_STATUS_ID
        FOREIGN KEY (status_id)
            REFERENCES status_companys_branches(id)
            ON DELETE RESTRICT
);

CREATE INDEX idx_branches_name ON branches(name);
CREATE INDEX idx_branches_email ON branches(email);
CREATE INDEX idx_branches_phone ON branches(phone);
CREATE INDEX idx_branches_company_id ON branches(company_id);
