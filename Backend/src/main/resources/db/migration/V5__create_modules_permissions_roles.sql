CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE modules(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    is_active BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_modules_name ON modules(name);

CREATE TABLE roles(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    is_active BOOLEAN DEFAULT FALSE,
    company_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMPTZ,
    delete_at TIMESTAMPTZ,

    CONSTRAINT FK_ROLES_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_roles_name ON roles(name);
CREATE INDEX idx_roles_company_id ON roles(company_id);
CREATE INDEX idx_roles_name_is_active ON roles(is_active);
CREATE INDEX idx_roles_id_is_active ON roles(id, is_active);
CREATE INDEX idx_roles_id_company_id ON roles(id, company_id);
CREATE INDEX idx_roles_name_company_id ON roles(name, company_id);
CREATE INDEX idx_roles_id_is_active_company_id ON roles(id, is_active, company_id);

CREATE TABLE permissions(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id UUID NOT NULL,
    module_id UUID NOT NULL,

    CONSTRAINT FK_PERMISSIONS_ROLE_ID FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_PERMISSIONS_MODULE_ID FOREIGN KEY (module_id)
        REFERENCES modules(id)
        ON DELETE RESTRICT
);

