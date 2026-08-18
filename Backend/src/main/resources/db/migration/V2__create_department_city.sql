CREATE TABLE department(
    id INT PRIMARY KEY,
    name VARCHAR (42) NOT NULL,
    country_id INT NOT NULL,

    CONSTRAINT UQ_DEPARTMENT_NAME UNIQUE (name),

    CONSTRAINT FK_DEPARTMENT_COUNTRY_ID
        FOREIGN KEY (country_id)
            REFERENCES country(id)
            ON DELETE RESTRICT
);


CREATE TABLE city(
    id INT PRIMARY KEY,
    name VARCHAR (170) NOT NULL,
    department_id INT NOT NULL,

    CONSTRAINT UQ_CITY_NAME UNIQUE (name),

    CONSTRAINT FK_CITY_DEPARTMENT_ID
        FOREIGN KEY (department_id)
            REFERENCES department(id)
            ON DELETE RESTRICT
);