-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT  FirstName, LastName, CustomerId,Country 
FROM Customer 
WHERE country != "USA" 

-- Provide a query only showing the Customers from Brazil.

SELECT  FirstName, LastName, CustomerId 
FROM Customer
WHERE country = "Brazil" 

-- Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT  Customer.FirstName, Customer.LastName, Invoice.InvoiceID, Invoice.InvoiceDate, Invoice.BillingCountry  
FROM Customer  
LEFT JOIN Invoice 
ON Customer.CustomerId = Invoice.CustomerId
WHERE country = "Brazil" 

--  Provide a query showing only the Employees who are Sales Agents.

SELECT  FirstName, LastName
FROM Employee
WHERE title LIKE '%sales support%'

-- Provide a query showing a unique list of billing countries from the Invoice table.

SELECT  DISTINCT BillingCountry
FROM Invoice

-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT Employee.FirstName, Employee.LastName, Invoice.InvoiceId
FROM Employee 
LEFT JOIN Customer
ON Customer.SupportRepId = Employee.EmployeeId
LEFT JOIN Invoice
ON Invoice.CustomerId = Customer.CustomerId
WHERE Employee.title LIKE '%sales support%'

-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT  Invoice.Total, Customer.FirstName, Customer.LastName, Customer.Country, Employee.FirstName, Employee.LastName
FROM Invoice 
LEFT JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
LEFT JOIN Employee
ON Employee.EmployeeId = Customer.SupportRepId

-- How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?

SELECT count(InvoiceId), sum(total)
FROM Invoice
WHERE substr(InvoiceDate,0,5) = '2009' 
OR substr(InvoiceDate,0,5)= '2011'
GROUP BY substr(InvoiceDate,0,5) = '2009', '2011'

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT count(InvoiceId)
FROM InvoiceLine
WHERE InvoiceId = '37'

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT count(InvoiceId)
FROM InvoiceLine
GROUP BY InvoiceId 

-- Provide a query that includes the track name with each invoice line item.

SELECT DISTINCT Name 
FROM  Track 
LEFT JOIN InvoiceLine
ON Track.TrackId = InvoiceLine.TrackId 

-- Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT  DISTINCT Track.Name, Album.Title, InvoiceLine.InvoiceId
FROM  Album
LEFT JOIN Track
ON Album.AlbumId = Track.AlbumId 
LEFT JOIN InvoiceLine
ON InvoiceLine.TrackId = Track.TrackId

-- Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT count(InvoiceId), Customer.Country
FROM Invoice
LEFT JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
GROUP BY Customer.Country

-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resultant table.

SELECT count(Track.TrackId), Playlist.Name
FROM PlaylistTrack
LEFT JOIN Track
ON PlaylistTrack.TrackId = Track.TrackId
LEFT JOIN Playlist
ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
GROUP BY Playlist.PlaylistId

-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.

SELECT DISTINCT Track.Name, Album.Title, MediaType.Name, Genre.Name
FROM Track
LEFT JOIN Album
ON Track.AlbumId = Album.AlbumId
LEFT JOIN MediaType
ON Track.MediaTypeId = MediaType.MediaTypeId
LEFT JOIN Genre
ON Track.Genreid = Genre.GenreId
GROUP BY Track.TrackId

-- Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT DISTINCT Invoice.InvoiceId, count(InvoiceLine.InvoiceId)
FROM Invoice
LEFT JOIN InvoiceLine
WHERE Invoice.InvoiceId = InvoiceLine.InvoiceId
GROUP BY Invoice.InvoiceId

-- Provide a query that shows total sales made by each sales agent.

SELECT Employee.FirstName, Employee.LastName, sum(Invoice.total)
FROM Employee
LEFT JOIN Customer
ON Employee.EmployeeId = Customer.SupportRepId
LEFT JOIN Invoice
ON Customer.CustomerId= Invoice.CustomerId 
WHERE Employee.title LIKE '%sales support%'
GROUP BY Employee.EmployeeId

-- Which sales agent made the most in sales in 2009?

SELECT Employee.FirstName, Employee.LastName, sum(Invoice.Total)
FROM Employee
LEFT JOIN Customer
ON Employee.EmployeeId = Customer.SupportRepId
LEFT JOIN Invoice
ON Customer.CustomerId = Invoice.CustomerId
Where substr(Invoice.InvoiceDate,0,5) = '2009'
AND Employee.title LIKE '%sales support%'
GROUP BY Employee.EmployeeId
ORDER BY Invoice.Total desc
LIMIT 1

-- Which sales agent made the most in sales in 2010?

SELECT Employee.FirstName, Employee.LastName, sum(Invoice.Total)
FROM Employee
LEFT JOIN Customer
ON Employee.EmployeeId = Customer.SupportRepId
LEFT JOIN Invoice
ON Customer.CustomerId = Invoice.CustomerId
Where substr(Invoice.InvoiceDate,0,5) = '2010'
AND Employee.title LIKE '%sales support%'
GROUP BY Employee.EmployeeId
ORDER BY Invoice.Total desc
LIMIT 1

-- Which sales agent made the most in sales over all?

SELECT Employee.FirstName, Employee.LastName, sum(Invoice.Total)
FROM Employee
LEFT JOIN Customer
ON Employee.EmployeeId = Customer.SupportRepId
LEFT JOIN Invoice
ON Customer.CustomerId = Invoice.CustomerId
AND Employee.title LIKE '%sales support%'
GROUP BY Employee.EmployeeId
ORDER BY Invoice.Total desc
LIMIT 1

-- Provide a query that shows the # of customers assigned to each sales agent.

SELECT Employee.FirstName, Employee.LastName, count(Customer.CustomerId)
FROM Employee 
JOIN Customer 
ON Employee.EmployeeId = Customer.SupportRepId
GROUP BY Employee.EmployeeId

-- Provide a query that shows the total sales per country. Which country's customers spent the most?

SELECT DISTINCT sum(Invoice.Total), Customer.Country 
FROM Invoice
LEFT JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
GROUP BY Invoice.InvoiceID
ORDER BY Invoice.Total desc

-- Provide a query that shows the most purchased track of 2013.
SELECT count(InvoiceLine.TrackId), Track.name
FROM InvoiceLine
LEFT JOIN Invoice
ON InvoiceLine.InvoiceId = Invoice.InvoiceId
LEFT JOIN Track
ON InvoiceLine.TrackId = Track.TrackId
WHERE substr(Invoice.InvoiceDate,0,5) = '2013'
GROUP BY Track.TrackId
ORDER BY count(InvoiceLine.Trackid) desc
LIMIT 1

-- Provide a query that shows the top 5 most purchased tracks over all.