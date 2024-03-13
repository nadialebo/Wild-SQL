SELECT w.lastname, w.firstname 
FROM wizard as w
WHERE w.id in (
      SELECT p.wizard_id
      FROM player as p
      WHERE enrollment_date BETWEEN '1995-01-01' AND '1998-12-31'
)

--Affiche les prénoms et noms des sorciers (wizards) qui se sont inscrits comme joueurs entre les années 1995 et 1998 (enrollment_date) et qui ont pour rôle 'keeper'
SELECT w.lastname, w.firstname 
FROM wizard as w
WHERE w.id in (
      SELECT p.wizard_id
      FROM player as p
      WHERE enrollment_date BETWEEN '1995-01-01' AND '1998-12-31'
      AND role = 'keeper'
)

--Affiche les prénoms, noms et rôles des sorciers (wizards) qui se sont inscrits comme joueurs entre les années 1995 et 1998 (enrollment_date) et qui ont pour rôle ‘chaser’
SELECT w.lastname, w.firstname,p.role 
FROM wizard as w
JOIN player as p ON w.id = p.wizard_id
WHERE w.id IN (     
      SELECT wizard_id
      FROM player as p
      WHERE enrollment_date BETWEEN '1995-01-01' AND '1998-12-31'
      AND role = 'chaser'
);

--Affiche le nombre de joueurs par rôle et par équipe
CREATE VIEW count_players_by_role AS (
                                  SELECT t.name, p.role, count(wizard_id) as nb_players
                                  FROM player as p, team as t
                                  WHERE t.id = p.team_id
                                  GROUP BY t.name, p.role
                              );
SELECT * from count_players_by_role;

--Affiche, pour l’équipe 'Gryffindor', les nom, prénom et le rôle des joueurs dont le rôle est 'chaser'
CREATE VIEW gryffindor_chaser AS (
                              SELECT w.lastname, w.firstname,p.role
                              FROM player as p
                              JOIN team as t ON p.team_id = t.id
                              JOIN wizard as w ON p.wizard_id = w.id
                              WHERE t.name = 'Gryffindor'
                              AND role = 'chaser'
                              );

SELECT * from gryffindor_chaser;
