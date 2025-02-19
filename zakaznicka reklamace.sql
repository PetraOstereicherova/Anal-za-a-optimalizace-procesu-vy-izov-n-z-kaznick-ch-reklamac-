-- pocet reklamací podle důvodu reklamace a typu produktu

select COUNT(Duvod_reklamace) as pocet_reklamací, Duvod_reklamace, Typ_produktu
from Reklamace
group by Duvod_reklamace, Typ_produktu
order by pocet_reklamací desc;

-- update
UPDATE Reklamace SET Typ_produktu = 'Chytré hodinky'
WHERE ID_reklamace = 27;
UPDATE Reklamace SET Datum_vyrizeni = '2024-03-12'
WHERE ID_reklamace = 79;
UPDATE Reklamace SET Datum_vyrizeni = '2025-01-13'
WHERE ID_reklamace = 63;
UPDATE Reklamace SET Datum_vyrizeni = '2025-01-01'
WHERE ID_reklamace = 38;

-- nejvíce reklamovaný výrobek

SELECT COUNT(ID_reklamace) as pocet_reklamace, Typ_produktu
FROM Reklamace
GROUP BY Typ_produktu
order by pocet_reklamace DESC;

-- nejcastejsi dovod reklamace

SELECT COUNT(ID_reklamace) as pocet_reklamace, Duvod_reklamace
FROM Reklamace
GROUP BY Duvod_reklamace
order by pocet_reklamace DESC;

-- Hlavni duvody reklamaci
SELECT COUNT(ID_reklamace) as pocet_reklamace, Duvod_reklamace, Typ_produktu
FROM Reklamace
GROUP BY Duvod_reklamace, Typ_produktu
order by pocet_reklamace DESC


-- prumerna doba zpracovani

WITH pocet_dni AS(
SELECT ID_reklamace, DATEDIFF("DAY", Datum_podáni, Datum_vyrizeni) AS rozdil
FROM Reklamace
WHERE Datum_vyrizeni IS NOT NULL)

-- kde dochazi k nejvetsimu zpozdeni s with
SELECT rozdil celkem, Region_zakaznika
FROM pocet_dni p
JOIN Reklamace r
ON p.ID_reklamace = r.ID_reklamace
WHERE rozdil > 28
ORDER BY celkem DESC;

-- prumer doba zpracovani s with
SELECT ROUND(AVG(rozdil), 2) as prumer
FROM pocet_dni
;

-- průměrnou dobu zpoždění podle regionu s with:

SELECT Region_zakaznika, ROUND(AVG(rozdil), 2) as prumerna_doba
FROM pocet_dni p
JOIN Reklamace r ON p.ID_reklamace = r.ID_reklamace
GROUP BY Region_zakaznika
ORDER BY prumerna_doba DESC;

-- pocet nevyrizenych reklamaci
SELECT COUNT(*) AS celkem_reklamace, 
       SUM(CASE WHEN Stav_reklamace LIKE 'Ne%' THEN 1 ELSE 0 END) AS nevyřízené
FROM Reklamace;

-- pocet eskalovanych pripadu:
SELECT COUNT(Pocet_eskalaci)
FROM Reklamace
WHERE Pocet_eskalaci > 0;


-- počet eskalací na reklamaci:

SELECT COUNT(*) AS pocet_eskalovanych, AVG(Pocet_eskalaci) AS prumer_eskalaci
FROM Reklamace
WHERE Pocet_eskalaci > 0;

-- eskalace podle regionu:

SELECT Region_zakaznika, COUNT(*) AS pocet_eskalovanych
FROM Reklamace
WHERE Pocet_eskalaci > 0
GROUP BY Region_zakaznika
ORDER BY pocet_eskalovanych DESC;

-- Reklamace podle sezónnosti (měsíce v roce)
SELECT MONTH(Datum_podáni) AS mesic, COUNT(*) AS pocet
FROM Reklamace
GROUP BY mesic
ORDER BY mesic;









