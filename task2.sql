-- DROP DATABASE IF EXISTS WeaponaryDB;
CREATE DATABASE IF NOT EXISTS WeaponaryDB;
USE WeaponaryDB;

CREATE TABLE IF NOT EXISTS platoon -- взвод
(
    id  INT AUTO_INCREMENT PRIMARY KEY,
    num INT NOT NULL
);
INSERT INTO platoon
    (id, num)
VALUES (1, 222),
       (2, 232),
       (3, 212),
       (4, 200);

CREATE TABLE IF NOT EXISTS officer
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL
);

INSERT INTO officer(id, name, position)
VALUES (1, 'Буров О.С.', 'майор'),
       (2, 'Рыбаков Н.Г.', 'майор'),
       (3, 'Деребанов В.Я.', 'подполковник');

CREATE TABLE IF NOT EXISTS weapon
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    weapon_name VARCHAR(20),
    officer_id  INT NOT NULL,
    FOREIGN KEY (officer_id) REFERENCES officer (id)

);

INSERT INTO weapon
    (id, weapon_name, officer_id)
VALUES (1, 'AK-47', 1),
       (2, 'Глок20', 2),
       (3, 'AK-74', 3);

CREATE TABLE IF NOT EXISTS soldier
(
    soldierId INT AUTO_INCREMENT NOT NULL,
    name      VARCHAR(50)        NOT NULL,
    platoonId INT,
    PRIMARY KEY (soldierId),
    Foreign key (platoonId) references platoon (Id)
);

INSERT INTO soldier
    (name, platoonId)
VALUES ('Петров В.А.', 1),
       ('Лодарев П.С.', 2),
       ('Леонтьев К.В.', 3),
       ('Духов Р.М.', 4);

CREATE TABLE IF NOT EXISTS office
(
    id  INT PRIMARY KEY AUTO_INCREMENT,
    num INT NOT NULL
);

INSERT INTO office
VALUES (1, 205),
       (2, 221),
       (3, 201);

CREATE TABLE IF NOT EXISTS soldier_weapon
(
    soldier_id INT NOT NULL,
    weapon_id  INT NOT NULL,
    FOREIGN KEY (soldier_id) REFERENCES soldier (soldierId),
    FOREIGN KEY (weapon_id) REFERENCES weapon (id)
);

INSERT INTO soldier_weapon(soldier_id, weapon_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (2, 2),
       (3, 1),
       (3, 2),
       (4, 1);

CREATE TABLE IF NOT EXISTS soldier_office
(
    soldier_id INT NOT NULL,
    office_id  INT NOT NULL,
    FOREIGN KEY (soldier_id) REFERENCES soldier (soldierId),
    FOREIGN KEY (office_id) REFERENCES office (id)
);

INSERT INTO soldier_office(soldier_id, office_id)
VALUES (1, 1),
       (2, 2),
       (3, 3);

