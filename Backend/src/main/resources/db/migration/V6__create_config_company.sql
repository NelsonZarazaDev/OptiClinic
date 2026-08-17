CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE config_company(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    timezone VARCHAR(50) NOT NULL DEFAULT 'America/Bogota',
    date_format VARCHAR(20) NOT NULL DEFAULT 'dd/MM/yyyy',
    default_appointment_duration_minutes VARCHAR(2) NOT NULL DEFAULT '30',
    cancellation_limit_hours VARCHAR(1) NOT NULL DEFAULT '1',
    primary_color VARCHAR(7) NOT NULL DEFAULT '#0F6B78',
    secondary_color VARCHAR(7) NOT NULL DEFAULT '#F3F7F8',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ,
    company_id UUID NOT NULL UNIQUE,

    CONSTRAINT FK_CONFIG_COMPANY_ID
        FOREIGN KEY (company_id)
            REFERENCES company(id)
            ON DELETE CASCADE
);

CREATE INDEX idx_config_company_company_id ON config_company(company_id);