CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE company_user(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    company_id UUID NOT NULL ,
    is_active BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_COMPANY_USER_USER_ID FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT FK_COMPANY_USER_COMPANY_ID FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_company_user_user_id ON company_user(user_id);
CREATE INDEX idx_company_user_company_id ON company_user(company_id);
CREATE INDEX idx_company_user_is_active ON company_user(is_active);
CREATE INDEX idx_company_user_user_id_company_id ON company_user(user_id, company_id);
CREATE INDEX idx_company_user_user_id_company_id_is_active ON company_user(user_id, company_id, is_active);
