-- 01 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1 , apellido2 , nombre, tipo FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre ASC ;
-- 02 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT apellido1 , apellido2 , nombre , telefono, tipo FROM personaasignatura
WHERE tipo = 'alumno'
AND telefono IS NULL;
-- 03 Retorna el llistat dels alumnes que van néixer en 1999.
SELECT apellido1 , apellido2 , nombre , fecha_nacimiento FROM persona
WHERE  tipo = 'alumno'
AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';
-- 04 Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
SELECT apellido1 , apellido2 , nombre , telefono, tipo, nif FROM persona
WHERE nif LIKE '%K'
AND tipo = 'profesor'
AND telefono IS NULL;
-- 05 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7
SELECT asi.cuatrimestre, asi.nombre , asi.curso , asi.id_grado FROM asignatura AS asi
WHERE asi.cuatrimestre = 1
AND asi.curso = 3
AND asi.id_grado = 7; 
-- 06 Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT  persona.apellido1 , persona.apellido2 , persona.nombre , departamento.nombre as Departamento FROM persona 
left JOIN profesor
ON persona.id = profesor.id_profesor
inner join departamento
ON profesor.id_departamento = departamento.id
WHERE persona.tipo = 'profesor'
ORDER BY persona.apellido1 , persona.nombre ASC; 
-- 07 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
SELECT persona.nif, persona.nombre, persona.apellido1, asignatura.nombre as 'asignatura', curso_escolar.anyo_inicio , curso_escolar.anyo_fin  FROM asignatura 
left join alumno_se_matricula_asignatura as alum
on asignatura.id = alum.id_asignatura
left join curso_escolar 
on curso_escolar.id = asignatura.curso
LEFT JOIN persona
ON alum.id_alumno = persona.id
where persona.nif = '26902806M'
and curso_escolar.id = 1;
-- 08 Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT departamento.nombre, grado.nombre FROM departamento
LEFT JOIN profesor
ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura
ON profesor.id_profesor = asignatura.id_profesor
LEFT JOIN grado
ON asignatura.id_grado = grado.id
WHERE grado.id = 4;
-- validación
-- SELECT persona.nombre, grado.nombre FROM persona
-- LEFT JOIN profesor
-- ON persona.id = profesor.id_profesor
-- LEFT JOIN asignatura
-- ON profesor.id_profesor = asignatura.id_profesor
-- LEFT JOIN grado
-- ON asignatura.id_grado = grado.id
-- WHERE grado.id = 4;
-- 09 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.nombre , persona.apellido1 , persona.apellido2, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona
LEFT JOIN alumno_se_matricula_asignatura
ON persona.id = alumno_se_matricula_asignatura.id_alumno  
LEFT JOIN curso_escolar
ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE persona.tipo = 'alumno'
AND curso_escolar.id = 5;


-- *******************************break point LEFT JOIN i RIGHT JOIN.**********************
-- 01  Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre AS 'departamento', persona.apellido1, persona.apellido2 , persona.nombre  FROM persona
LEFT JOIN profesor
ON persona.id = profesor.id_profesor
LEFT JOIN departamento
ON profesor.id_departamento = departamento.id
ORDER BY departamento.nombre,  persona.apellido1, persona.apellido2, persona.nombre ASC;
-- 02 Retorna un llistat amb els professors que no estan associats a un departament.
SELECT departamento.nombre AS 'departamento', persona.apellido1, persona.apellido2 , persona.nombre  FROM persona
LEFT JOIN profesor
ON persona.id = profesor.id_profesor
LEFT JOIN departamento
ON profesor.id_departamento = departamento.id
WHERE departamento.nombre IS NULL;
-- 03 Retorna un llistat amb els departaments que no tenen professors associats.
SELECT departamento.nombre AS 'departamento' , persona.apellido1 FROM departamento
LEFT JOIN profesor
ON  departamento.id = profesor.id_departamento
LEFT JOIN persona
ON  profesor.id_profesor = persona.id
WHERE persona.apellido1 IS NULL;
-- 04 Retorna un llistat amb els professors que no imparteixen cap assignatura.
SELECT  asignatura.nombre AS 'asignatura',  persona.apellido1 FROM persona
LEFT JOIN profesor
ON persona.id =profesor.id_profesor  
LEFT JOIN asignatura
ON profesor.id_departamento = asignatura.id_profesor
WHERE persona.tipo = 'profesor'
AND asignatura.nombre IS NULL
ORDER BY persona.apellido1 ASC;
-- 05 Retorna un llistat amb les assignatures que no tenen un professor assignat.
SELECT  asignatura.nombre AS 'asignatura',  persona.apellido1 AS 'apellido_profesor' FROM asignatura
LEFT JOIN profesor
ON asignatura.id_profesor = profesor.id_departamento    
LEFT JOIN persona
ON profesor.id_profesor = persona.id 
-- WHERE persona.tipo = 'profesor'
WHERE persona.apellido1 IS NULL;
-- 06 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT departamento.nombre FROM departamento
LEFT JOIN profesor
ON departamento.id = profesor.id_departamento    
LEFT JOIN asignatura
ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.nombre IS NULL;

