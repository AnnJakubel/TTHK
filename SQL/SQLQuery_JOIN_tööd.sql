--- JOIN p�ringud andmebaasi AdventureWorksDW2019 tabelite vahel
-- JOIN definitsioon - Andmete kombineerimine kahelt tabelilt veerude p�hjal
-- millel on kattuvad v��rtused.


-- LEFT JOIN
-- Selle k�su kasutamisel kuvatakse k�ik esimese
-- tabeli andmed ning teisest tabelist vaid neid kirjeid,
-- millel on vaste esimese tabeli andmekirjele. 
-- Seda m��ratakse l�bi v�tmete mida pannakse
-- �ksteisega seosesse (nt �hes tabelis v��rv�ti,
-- teises primaarv�ti mille v��rtused kattuvad).
-- Kui esimeses tabelis on andmekirje, milles pole
-- teises vastet, siis teise tabeli veergudel on
-- v��rtuseks NULL.


-- Antud n�ide liidab tabelid DimEmployee ja DimSalesTerritory v�tme 
-- SalesTerritoryKey p�hjal, kuna antud v�ti eksisteerib DimEmployee 
-- tabelis v��rv�tmena ning DimSalesTerritory tabelis primaarv�tmena.

SELECT * FROM dbo.DimEmployee
LEFT JOIN dbo.DimSalesTerritory
ON DimEmployee.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey;

-- Antud n�ide liidab tabelid DimCustomer ja DimGeography v�tme
-- GeographyKey p�hjal. Siin juhul valisin SELECT k�suga v�lja
-- m�lemast tabelist veerud, City veerg kuulub 2.tabelile.

SELECT FirstName, LastName, Gender, City
FROM dbo.DimCustomer
LEFT JOIN dbo.DimGeography
ON DimCustomer.GeographyKey = DimGeography.GeographyKey;


-- RIGHT JOIN
-- Sama p�him�ttega nagu left join, kuid vahe on selles, 
-- et prioriteet, mille j�rgi andmed kuvatakse on 
-- parempoolses (ehk teises) tabelis. 
-- Kui teises tabelis on andmed, millele pole l�bi
-- v�tmete vastet esimeses tabelis, siis esimese
-- tabeli veergudes kuvatakse v��rtusteks NULL.


-- Antud n�ide liidab tabelid DimEmployee ja FactSalesQuota tabelid
-- EmployeeKey v�tme p�hjal, mis eksisteerib FactSalesQuota tabelis
-- v��rv�tmena. Kuvatakse vaid neid DimEmployee kirjeid mille v�tmel
-- on vaste FactSalesQuota tabelis.

SELECT * FROM dbo.DimEmployee
RIGHT JOIN dbo.FactSalesQuota
ON DimEmployee.EmployeeKey = FactSalesQuota.EmployeeKey;


-- Antud n�ites kuvatakse DimProduct kirjeid, millel on ProductSubcategory olemas,
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
-- Antud k�su puhul on samuti tabelite liitmine,
-- kuid erisus eelnevatega on see, et kuvatakse ainult andmed,
-- millel on m�lemas tabelis v�tme vaste olemas. J�rgmised
-- n�ited n�itlikustavad seda, teises n�ites samuti valin
-- erinevaid veerge m�lemast tabelist. V�tmete loogika on sama
-- kasutades �he tabeli v��rv�tit mis vastab teise tabeli 
-- primaarv�tmele. 

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
-- kus on vaste olemas v�tmetele kui ka need kus
-- esimeses v�i teises tabelis andmekirjed puuduvad
-- (v��rtuseks sel juhul annab NULL)

-- J�rgnevas n�ites annab DimGeography tabel n�iteks NULL vasted
-- k�ige viimases andmekirjes.

SELECT * FROM dbo.DimGeography
FULL OUTER JOIN dbo.DimSalesTerritory
ON DimGeography.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey

-- J�rgnevas n�ites annab FactInternetSalesReason tabelis
-- viimasele kolmele vreale NULL v��rtused, samas teise 
-- tabeli osas on v��rtused olemas.
SELECT 
SalesOrderNumber, 
FactInternetSalesReason.SalesReasonKey, 
SalesReasonName, 
SalesReasonReasonType
FROM dbo.FactInternetSalesReason
FULL OUTER JOIN dbo.DimSalesReason
on FactInternetSalesReason.SalesReasonKey = DimSalesReason.SalesReasonKey;


-- FULL JOIN
-- T�pselt sama toimemehhanism nagu FULL OUTER JOIN k�sk.

-- J�rgnevas n�ites on paremini n�ha NULL v��rtusi tabeli �hel v�i teisel poolel.

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
-- tabeli reast j�rjest iga teise tabeli reaga. 
-- N�iteks t�histame esimese tabeli ridu 1, 2, 3,
-- teise tabeli ridu t�histame A, B, C.
-- CROSS JOIN genereerib kombinatsioone 1A, 1B, 1C,
-- 2A, 2B, 2C, 3A, 3B, 3C �hte tabelisse. 

SELECT * FROM dbo.DimOrganization
CROSS JOIN dbo.DimCurrency

SELECT FactCurrencyRate.DateKey, 
AverageRate, 
DayNumberOfMonth, 
EnglishMonthName, 
CalendarYear
FROM dbo.FactCurrencyRate
CROSS JOIN dbo.DimDate


