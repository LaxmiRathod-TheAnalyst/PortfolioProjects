Select * 
From PortfolioProject..Covid_Deaths
Where continent is not null
Order by 3,4

Select * 
From PortfolioProject..Covid_Vaccination
Order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..Covid_Deaths
Order by 1,2


--Total cases vs Total deaths

Select location, date, total_cases, total_deaths, (cast(total_deaths as int))/(cast(total_cases as int))*100 as DeathPercentage
From PortfolioProject..Covid_Deaths
Where location like '%Ind%'
Order by 1,2


--Total cases vs Population

Select location, date, population, total_cases, (total_cases/population) *100 as PercentPopulationInfected
From PortfolioProject..Covid_Deaths
Order by 1,2


--Looking at countries wih highest infection rate compared to popualation 

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population) *100 as PercentPopulationInfected
From PortfolioProject..Covid_Deaths
Group by location, population
Order by PercentPopulationInfected desc


--Showing countries with highest death count per population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..Covid_Deaths
Where continent is not null
Group by location
Order by TotalDeathCount desc


--Showing continents with highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..Covid_Deaths
Where continent is not null
Group by continent
Order by TotalDeathCount desc


--Global Numbers

Select Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths, Sum(cast
(new_deaths as int))/ Sum(new_cases)*100 as DeathPercentage
From PortfolioProject..Covid_Deaths
--Where location like '%Ind%'
Where continent is not null
--Group by date
Order by 1,2


--Looking at total population vs vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as float)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleaVaccinated/Popultion) * 100
From PortfolioProject..Covid_Deaths dea
Join PortfolioProject..Covid_Vaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3


--Use CTE

with PopvsVac (continent, location, date, population, new_vaccinatios, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as float)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleaVaccinated/Popultion) * 100
From PortfolioProject..Covid_Deaths dea
Join PortfolioProject..Covid_Vaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select *,(RollingPeopleVaccinated/population)*100
From PopvsVac


--TEMP Table

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as float)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleaVaccinated/Popultion) * 100
From PortfolioProject..Covid_Deaths dea
Join PortfolioProject..Covid_Vaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100 as VaccinationPercent
From #PercentPopulationVaccinated


--Creating view to store data for later visualizations

CreateViewPercentPopulationVaccinated as  
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(cast(vac.new_vaccinations as float)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--,(RollingPeopleaVaccinated/Popultion) * 100
From PortfolioProject..Covid_Deaths dea
Join PortfolioProject..Covid_Vaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

Select * 
From PercentPopulationVaccinated

Create View GlobalNumbers as
Select Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths, Sum(cast
(new_deaths as int))/ Sum(new_cases)*100 as DeathPercentage
From PortfolioProject..Covid_Deaths
--Where location like '%Ind%'
Where continent is not null
--Group by date
--Order by 1,2


Select * 
From GlobalNumbers




