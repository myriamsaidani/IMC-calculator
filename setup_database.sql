-- Création de la base de données
CREATE DATABASE IF NOT EXISTS imc;

-- Utilisation de la base de données
USE imc;

-- Création de la table calcul_imc
CREATE TABLE IF NOT EXISTS calcul_imc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    poids DOUBLE NOT NULL,
    taille DOUBLE NOT NULL,
    imc DOUBLE NOT NULL,
    categorie VARCHAR(50) NOT NULL,
    date_calcul TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Vérification des privilèges (exécutez cette commande dans phpMyAdmin avec un compte admin)
-- GRANT ALL PRIVILEGES ON imc.* TO 'root'@'localhost' IDENTIFIED BY '';
