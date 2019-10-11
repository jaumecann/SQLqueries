
-- primera consulta (registres vols)

SELECT count(*) as 'total'
FROM flights;

-- segona consulta (retard promig segons aeroport)

SELECT Origin, AVG(ArrDelay) as 'prom_arribades', AVG(DepDelay) as 'prom_sortides'
FROM flights
GROUP BY Origin;

-- tercera consulta (retard promig d'arribada, segons mesos, anys i origen)

SELECT Origin, colYear, colMonth, AVG(ArrDelay) as 'prom_arribades' 
FROM flights
GROUP BY Origin, colYear, colMonth
ORDER BY Origin ASC, colYear ASC;

-- quarta consulta (repetir amb nom ciutat)

SELECT City, colYear, colMonth, AVG(ArrDelay) as 'prom_arribades' 
FROM flights LEFT JOIN usairports
ON usairports.IATA=flights.Origin 
GROUP BY City, colYear, colMonth
ORDER BY City ASC, colYear ASC;

-- cinquena consulta (companyies mes vols cancelats per mesos i anys, ordenades per major nombre)

SELECT UniqueCarrier, colYear, colMonth, AVG(ArrDelay), COUNT(Cancelled) as 'total_cancelled'
FROM flights
WHERE Cancelled=1
GROUP BY colMonth, colYear
ORDER BY total_cancelled DESC;

-- sisena consulta (identificador 10 avions amb més distancia recorreguda)

SELECT TailNum, SUM(Distance) as 'totalDistance'
FROM flights
WHERE TailNum NOT LIKE ''
GROUP BY TailNum
ORDER BY totalDistance DESC
LIMIT 10;

-- setena consulta (retard promig companyies, només de les que els seus vols arriben amb retràs promig superior a 10 minuts)

SELECT UniqueCarrier, avgDelay
FROM (SELECT UniqueCarrier, AVG(ArrDelay) as 'avgDelay'
FROM flights
GROUP BY UniqueCarrier) as totalavgs
WHERE avgDelay > 10
ORDER BY avgDelay DESC;
