
SELECT *
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths`
ORDER BY 3,4;

SELECT *
FROM `infra-inkwell-452402-j4.Portfolio.CovidVaccunations`
ORDER BY 3,4;

SELECT location, date,total_cases,new_cases,total_deaths,population
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths`
order by 1,2;

--Looking at Total Cases vs Total Deaths

SELECT location, date,total_cases,new_cases,total_deaths,(total_cases/population)
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths`
WHERE location like '%United States%'
order by 1,2;


--Looking at Countries with Highest Infection rate compared to population
SELECT 
  location, 
  MAX(total_cases) AS HighestInfectionCount, 
  MAX(total_cases / population) AS PercentPopulationInfected
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY PercentPopulationInfected DESC;

--Showing Countries with Highest Death Count per population
SELECT 
  continent,
  MAX(total_deaths) AS TotalDeathCount
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

--GLOBAL NUMBERS
SELECT
  SUM(new_cases) AS total_cases,
  SUM(SAFE_CAST(new_deaths AS INT64)) AS total_deaths,
  (SUM(SAFE_CAST(new_deaths AS INT64)) / SUM(new_cases)) * 100 AS DeathPercentage
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths`
WHERE continent IS NOT NULL;
--Looking at total population vs Vaccinations
SELECT
  dea.continent,
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(COALESCE(CAST(vac.new_vaccinations AS INT64), 0))
    OVER (PARTITION BY dea.location ORDER BY dea.date) as RollingPeopleVaccinated,
    --,(RollingPeopleVaccinated/population)*100
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths` dea
JOIN `infra-inkwell-452402-j4.Portfolio.CovidVaccunations` vac
  ON dea.location = vac.location
 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

--USE CTE
WITH PopvsVac AS (
  SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(COALESCE(CAST(vac.new_vaccinations AS INT64), 0))
      OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
  FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths` AS dea
  JOIN `infra-inkwell-452402-j4.Portfolio.CovidVaccunations` AS vac
    ON dea.location = vac.location
   AND dea.date = vac.date
  WHERE dea.continent IS NOT NULL
)
SELECT
  *,
  (RollingPeopleVaccinated / population) * 100 AS PercentVaccinated
FROM PopvsVac
ORDER BY 2,3;

--Temp Table
DROP TABLE IF EXISTS `infra-inkwell-452402-j4.Portfolio.PercentPopulationVaccunated`;

CREATE OR REPLACE TABLE `infra-inkwell-452402-j4.Portfolio.PercentPopulationVaccunated` (
  Continent STRING,
  Location STRING,
  Date DATE,
  Population NUMERIC,
  New_vaccinations INT64,
  RollingPeopleVaccinated INT64
);
--Creating a map
CREATE TEMP TABLE PercentPopulationVaccinated AS
SELECT
  dea.continent        AS Continent,
  dea.location         AS Location,
  dea.date             AS Date,
  CAST(dea.population AS NUMERIC)     AS Population,
  CAST(vac.new_vaccinations AS INT64) AS New_vaccinations,
  SUM(COALESCE(CAST(vac.new_vaccinations AS INT64), 0))
    OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths` AS dea
JOIN `infra-inkwell-452402-j4.Portfolio.CovidVaccunations` AS vac
  ON dea.location = vac.location
 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;


SELECT *
FROM PercentPopulationVaccinated
ORDER BY Location, Date;


SELECT
  *,
  (RollingPeopleVaccinated / Population) * 100 AS PercentVaccinated
FROM PercentPopulationVaccinated
ORDER BY Location, Date;

--order by 2,3
SELECT *,
       (RollingPeopleVaccinated / population) * 100 AS PercentVaccinated
FROM `infra-inkwell-452402-j4.Portfolio.PercentPopulationVaccinated`
ORDER BY location, date;

--Creating View to store data for later vizualizations
CREATE OR REPLACE VIEW `infra-inkwell-452402-j4.Portfolio.PercentPopulationVaccunated_vw` AS
SELECT
  dea.continent,
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(COALESCE(CAST(vac.new_vaccinations AS INT64), 0))
    OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM `infra-inkwell-452402-j4.Portfolio.CovidDeaths` AS dea
JOIN `infra-inkwell-452402-j4.Portfolio.CovidVaccunations` AS vac
  ON dea.location = vac.location
 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;