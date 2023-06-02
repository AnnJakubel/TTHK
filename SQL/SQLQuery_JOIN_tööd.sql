--- JOIN päringud andmebaasi AdventureWorksDW2019 tabelite vahel
-- JOIN definitsioon - Andmete kombineerimine kahelt tabelilt veerude põhjal
-- millel on kattuvad väärtused.


-- LEFT JOIN
-- Selle käsu kasutamisel kuvatakse kõik esimese
-- tabeli andmed ning teisest tabelist vaid neid kirjeid,
-- millel on vaste esimese tabeli andmekirjele. 
-- Seda määratakse läbi võtmete mida pannakse
-- üksteisega seosesse (nt ühes tabelis võõrvõti,
-- teises primaarvõti mille väärtused kattuvad).
-- Kui esimeses tabelis on andmekirje, milles pole
-- teises vastet, siis teise tabeli veergudel on
-- väärtuseks NULL.


-- Antud näide liidab tabelid DimEmployee ja DimSalesTerritory võtme 
-- SalesTerritoryKey põhjal, kuna antud võti eksisteerib DimEmployee 
-- tabelis võõrvõtmena ning DimSalesTerritory tabelis primaarvõtmena.

SELECT * FROM dbo.DimEmployee
LEFT JOIN dbo.DimSalesTerritory
ON DimEmployee.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey;

-- Antud näide liidab tabelid DimCustomer ja DimGeography võtme
-- GeographyKey põhjal. Siin juhul valisin SELECT käsuga välja
-- mõlemast tabelist veerud, City veerg kuulub 2.tabelile.

SELECT FirstName, LastName, Gender, City
FROM dbo.DimCustomer
LEFT JOIN dbo.DimGeography
ON DimCustomer.GeographyKey = DimGeography.GeographyKey;


-- RIGHT JOIN
-- Sama põhimõttega nagu left join, kuid vahe on selles, 
-- et prioriteet, mille järgi andmed kuvatakse on 
-- parempoolses (ehk teises) tabelis. 
-- Kui teises tabelis on andmed, millele pole läbi
-- võtmete vastet esimeses tabelis, siis esimese
-- tabeli veergudes kuvatakse väärtusteks NULL.


-- Antud näide liidab tabelid DimEmployee ja FactSalesQuota tabelid
-- EmployeeKey võtme põhjal, mis eksisteerib FactSalesQuota tabelis
-- võõrvõtmena. Kuvatakse vaid neid DimEmployee kirjeid mille võtmel
-- on vaste FactSalesQuota tabelis.

SELECT * FROM dbo.DimEmployee
RIGHT JOIN dbo.FactSalesQuota
ON DimEmployee.EmployeeKey = FactSalesQuota.EmployeeKey;


-- Antud näites kuvatakse DimProduct kirjeid, millel on ProductSubcategory olemas,
-- ehk alamkategooria. Valitud on 3 veergu DimProduct tabelist ja 
-- 2 veergu DimProductSubcategory tabelist.

SELECT 
EnglishProductName, 
StandardCost, 
ListPrice, 
DimProductSubcategory.ProductSubcategoryKey, 
EnglishProductSubcategoryName
FROM dbo.DimProduct
RIGHT JOIN dbo.DimProductSubcategory
ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey;


-- INNER JOIN
-- Antud käsu puhul on samuti tabelite liitmine,
-- kuid erisus eelnevatega on see, et kuvatakse ainult andmed,
-- millel on mõlemas tabelis võtme vaste olemas. Järgmised
-- näited näitlikustavad seda, teises näites samuti valin
-- erinevaid veerge mõlemast tabelist. Võtmete loogika on sama
-- kasutades ühe tabeli võõrvõtit mis vastab teise tabeli 
-- primaarvõtmele. 

SELECT * FROM dbo.DimAccount
INNER JOIN dbo.FactFinance
ON DimAccount.AccountKey = FactFinance.AccountKey;

SELECT 
Amount, 
Date, 
FactFinance.Datekey, 
EnglishDayNameOfWeek,
EnglishMonthName, 
CalendarYear
FROM dbo.FactFinance
INNER JOIN dbo.DimDate
ON FactFinance.DateKey = DimDate.DateKey;


-- FULL OUTER JOIN 
-- Kahe tabeli liitmine, kuid kuvab nii andmeid
-- kus on vaste olemas võtmetele kui ka need kus
-- esimeses või teises tabelis andmekirjed puuduvad
-- (väärtuseks sel juhul annab NULL)

-- Järgnevas näites annab DimGeography tabel näiteks NULL vasted
-- kõige viimases andmekirjes.

SELECT * FROM dbo.DimGeography
FULL OUTER JOIN dbo.DimSalesTerritory
ON DimGeography.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey

-- Järgnevas näites annab FactInternetSalesReason tabelis
-- viimasele kolmele vreale NULL väärtused, samas teise 
-- tabeli osas on väärtused olemas.
SELECT 
SalesOrderNumber, 
FactInternetSalesReason.SalesReasonKey, 
SalesReasonName, 
SalesReasonReasonType
FROM dbo.FactInternetSalesReason
FULL OUTER JOIN dbo.DimSalesReason
on FactInternetSalesReason.SalesReasonKey = DimSalesReason.SalesReasonKey;


-- FULL JOIN
-- Täpselt sama toimemehhanism nagu FULL OUTER JOIN käsk.

-- Järgnevas näites on paremini näha NULL väärtusi tabeli ühel või teisel poolel.

SELECT * FROM dbo.FactSurveyResponse
FULL JOIN dbo.DimCustomer
ON FactSurveyResponse.CustomerKey = DimCustomer.CustomerKey;

SELECT 
FactSurveyResponse.DateKey, 
Date, 
EnglishProductCategoryName, 
FullDateAlternateKey
FROM dbo.FactSurveyResponse
FULL JOIN dbo.DimDate
ON FactSurveyResponse.Datekey = DimDate.DateKey

-- CROSS JOIN
-- Tabelite liitmisel genereeritakse paarid igast esimese
-- tabeli reast järjest iga teise tabeli reaga. 
-- Näiteks tähistame esimese tabeli ridu 1, 2, 3,
-- teise tabeli ridu tähistame A, B, C.
-- CROSS JOIN genereerib kombinatsioone 1A, 1B, 1C,
-- 2A, 2B, 2C, 3A, 3B, 3C ühte tabelisse. 

SELECT * FROM dbo.DimOrganization
CROSS JOIN dbo.DimCurrency

SELECT FactCurrencyRate.DateKey, 
AverageRate, 
DayNumberOfMonth, 
EnglishMonthName, 
CalendarYear
FROM dbo.FactCurrencyRate
CROSS JOIN dbo.DimDate


