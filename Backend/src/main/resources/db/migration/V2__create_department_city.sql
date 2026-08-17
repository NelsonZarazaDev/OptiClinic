CREATE TABLE department(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR (42) NOT NULL,
    country_id INT NOT NULL,

    CONSTRAINT FK_DEPARTMENT_COUNTRY_ID
        FOREIGN KEY (country_id)
            REFERENCES country(id)
            ON DELETE RESTRICT
);


CREATE TABLE city(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR (170) NOT NULL,
    department_id INT NOT NULL,

    CONSTRAINT FK_CITY_DEPARTMENT_ID
        FOREIGN KEY (department_id)
            REFERENCES department(id)
            ON DELETE RESTRICT
);