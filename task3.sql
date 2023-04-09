CREATE DATABASE IF NOT EXISTS HumanResourcesDepartment;
USE HumanResourcesDepartment;

CREATE TABLE IF NOT EXISTS positions
(
    id   INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(50)
);

INSERT INTO positions
    (name)
VALUES ('Директор'),
       ('Охранник'),
       ('Шофер'),
       ('Грузчик'),
       ('Продавец'),
       ('Электрик');

CREATE TABLE IF NOT EXISTS education
(
    id             INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_education VARCHAR(50)
);

INSERT INTO education
    (type_education)
VALUES ('середня освіт'),
       ('вища (або «третинна») освіта'),
       ('Бакалавр'),
       ('Магiстр'),
       ('Доктор філософії');

CREATE TABLE IF NOT EXISTS departments
(
    id    INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name  VARCHAR(50)                    NOT NULL,
    phone VARCHAR(15)
);

INSERT INTO departments
    (name, phone)
VALUES ('Продажа', '0962345678'),
       ('Охрана', '0981234567'),
       ('Транспортный', '09683457896'),
       ('Грузчики', null),
       ('Техническое обслуживание', '0964567890');

CREATE TABLE IF NOT EXISTS staff
(
    id                INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    last_name         VARCHAR(20)                    NOT NULL,
    first_name        VARCHAR(20)                    NOT NULL,
    patronymic        VARCHAR(20)                    NOT NULL,
    department_id     INT                            NOT NULL,
    position_id       INT                            NOT NULL,
    education_id      INT                            NOT NULL,
    date_of_hiring    DATE,
    date_of_dismissal DATE,
    FOREIGN KEY (department_id) REFERENCES departments (id),
    FOREIGN KEY (position_id) REFERENCES positions (id),
    FOREIGN KEY (education_id) REFERENCES education (id)
);

INSERT INTO staff
(id, last_name, first_name, patronymic, department_id, position_id, education_id, date_of_hiring,
 date_of_dismissal)
VALUES (1, 'Старков', 'Андрей', 'Владимирович', 1, 2, 4, '2020-02-02', null),
       (2, 'Иванов', 'Петр', 'Михайлович', 3, 2, 2, '2010-10-02', null),
       (3, 'Сидоров', 'Михаил', 'Васильевич', 2, 4, 1, '2020-02-02', null),
       (4, 'Полякова', 'Анна', 'Семеновна', 1, 6, 2, '2000-02-10', null),
       (5, 'Воробьева', 'Ольга', 'Андреевна', 1, 2, 2, '2020-02-02', null),
       (6, 'Петров', 'Антон', 'Сергеевич', 2, 6, 1, '2020-02-02', null),
       (7, 'Абрамов', 'Сергей', 'Абрамович', 4, 3, 3, '200-01-02', null),
       (8, 'Королев', 'Александр', 'Александрович', 5, 4, 2, '2020-02-02', null);

CREATE TABLE IF NOT EXISTS personalInformation
(
    id             INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    birth_date     DATE,
    passport       VARCHAR(50),
    inn            VARCHAR(50),
    address        VARCHAR(100),
    marital_status VARCHAR(10),
    phone          VARCHAR(15),
    email          VARCHAR(50),
    children       INT,
    staff_id       INT,
    FOREIGN KEY (staff_id) REFERENCES staff (id)
);

INSERT INTO personalInformation
(birth_date, passport, inn, address, marital_status, phone, email, children, staff_id)
VALUES ('1987-12-12', 'ИИ 654358', '1235466431256', 'Харьков, ул. Шевченко, 34, кв. 32', 'женат', '+380952020121',
        'mi_lkj@gmail.com', 2, 1),
       ('1990-11-10', 'ММ 654358', '54647547546', 'Киев, ул. Свободы, 265, кв. 87', 'женат', '+380954020121',
        'midcdecej@gmail.com', 1, 2),
       ('1991-12-12', 'КА 5464564', '356756376565', 'Одесса, ул. Метрополита, 55, кв. 32', 'не женат', '+380952020127',
        'wwdzdc@gmail.com', 0, 3),
       ('2000-07-12', 'ИП 332342', '356766735', 'Житомир, ул. Духновича, 4, кв. 32', 'замужем', '+380952020126',
        'efujjj@gmail.com', 0, 4),
       ('1999-08-05', 'КП 3453453', '35675367575', 'Лозовая, ул. Мира, 546, кв. 234', 'не замужем', '+380952020103',
        'mmm@gmail.com', 0, 5),
       ('2000-09-22', 'ИВ 34345346', '35775637656', 'Красноград, ул. Счастья, 4, кв. 32', 'женат', '+380952019121',
        'ssrw@gmail.com', 2, 6),
       ('2001-10-08', 'ИВ 345354', '356767537', 'Киев, ул. Радости, 34, кв. 234', 'не женат', '+380952020621',
        'vjefk@gmail.com', 0, 7),
       ('1997-12-11', 'РВ 5675675', '3567375676', 'Киев, ул. Научная, 2, кв. 342', 'женат', '+380952967121',
        'ppror@gmail.com', 1, 8);

SELECT *
FROM personalInformation;
SELECT *
FROM staff;
SELECT *
FROM education;
SELECT *
FROM positions;
SELECT *
FROM departments;

-- Проверка связей таблицы. Вывести по одному столбцу с каждой таблицы: фамилия, email, должность, отдел, образование, количество детей

SELECT staff.last_name              AS last_name,
       positions.name               AS position,
       departments.name             AS department,
       education.type_education     AS education,
       personalInformation.children AS children

FROM staff
         LEFT JOIN personalInformation
                   ON staff.id = personalInformation.staff_id
         LEFT JOIN positions
                   ON staff.position_id = positions.id
         LEFT JOIN departments
                   ON staff.department_id = departments.id
         LEFT JOIN education
                   ON staff.education_id = education.id
ORDER BY staff.last_name;