CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Members (
    MemberID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(150),
    DateRegistered DATE DEFAULT GETDATE()
);

CREATE TABLE Authors (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Books (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    PublicationYear INT,
    Quantity INT NOT NULL,
    AvailableCopies INT NOT NULL,
    AuthorID INT,
    CategoryID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Librarians (
    LibrarianID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    FullName VARCHAR(100)
);

CREATE TABLE BorrowRecords (
    BorrowID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATE DEFAULT GETDATE(),
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Members (FirstName, LastName, Email, Phone, Address)
VALUES
('Ama', 'Mensah', 'ama.mensah@example.com', '0241234567', 'Kumasi, Ghana'),
('Kwame', 'Boateng', 'kwame.boateng@example.com', '0559876543', 'Accra, Ghana'),
('Akosua', 'Owusu', 'akosua.owusu@example.com', '0205551234', 'Cape Coast, Ghana'),
('Yaw', 'Kusi', 'yaw.kusi@example.com', '0271112222', 'Takoradi, Ghana'),
('Efua', 'Adjei', 'efua.adjei@example.com', '0263334444', 'Tema, Ghana'),
('Kojo', 'Asante', 'kojo.asante@example.com', '0235556666', 'Sunyani, Ghana'),
('Abena', 'Ofori', 'abena.ofori@example.com', '0257778888', 'Tamale, Ghana'),
('Michael', 'Owusu', 'michael.owusu@example.com', '0249990000', 'Koforidua, Ghana');
select * from members;

INSERT INTO Authors (AuthorName)
VALUES
('Chinua Achebe'),
('Ama Ata Aidoo'),
('Ngugi wa Thiong''o'),
('Wole Soyinka'),
('Ayi Kwei Armah'),
('J.K. Rowling'),
('George Orwell'),
('Harper Lee');
select * from Authors;

INSERT INTO Categories (CategoryName)
VALUES
('Fiction'),
('History'),
('Science'),
('Children'),
('Drama'),
('Biography'),
('Fantasy'),
('Politics');
select * from Categories;

INSERT INTO Books (Title, ISBN, PublicationYear, Quantity, AvailableCopies, AuthorID, CategoryID)
VALUES
('Things Fall Apart', '9780435905255', 1958, 10, 10, 1, 1),
('Changes: A Love Story', '9780435910136', 1991, 5, 5, 2, 1),
('Decolonising the Mind', '9780852555019', 1986, 7, 7, 3, 3),
('The Man Died', '9780435909994', 1972, 4, 4, 4, 5),
('The Beautyful Ones Are Not Yet Born', '9780435905408', 1968, 6, 6, 5, 1),
('Harry Potter and the Philosopher''s Stone', '9780747532743', 1997, 12, 12, 6, 7),
('1984', '9780451524935', 1949, 8, 8, 7, 8),
('To Kill a Mockingbird', '9780061120084', 1960, 9, 9, 8, 1);
select * from Books;

INSERT INTO Librarians (Username, PasswordHash, FullName)
VALUES
('admin1', 'hashedpassword123', 'Kojo Asante'),
('admin2', 'hashedpassword456', 'Efua Adjei'),
('admin3', 'hashedpassword789', 'Yaw Kusi');
select * from Librarians;

INSERT INTO BorrowRecords (MemberID, BookID, DueDate)
VALUES
(1, 1, '2026-07-15'),
(1, 2, '2026-06-15'),
(2, 2, '2026-07-20'),
(3, 3, '2026-07-25'),
(4, 4, '2026-07-18'),
(5, 5, '2026-07-22'),
(6, 6, '2026-07-30'),
(7, 7, '2026-07-28'),
(8, 8, '2026-07-29');
select * from BorrowRecords;

SELECT COUNT(*) AS TotalMembers FROM Members;
SELECT COUNT(*) AS TotalBooks FROM Books;
SELECT COUNT(*) AS TotalBorrowRecords FROM BorrowRecords;

--Authors, Books and Categories
SELECT b.Title, a.AuthorName, c.CategoryName
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
JOIN Categories c ON b.CategoryID = c.CategoryID;

--Borrowed Books By Members
SELECT m.FirstName, m.LastName, b.Title, br.BorrowDate, br.DueDate
FROM BorrowRecords br
JOIN Members m ON br.MemberID = m.MemberID
JOIN Books b ON br.BookID = b.BookID;

--Overdue Books
SELECT m.FirstName, m.LastName, b.Title, br.DueDate
FROM BorrowRecords br
JOIN Members m ON br.MemberID = m.MemberID
JOIN Books b ON br.BookID = b.BookID
WHERE br.ReturnDate IS NULL ORDER BY br.DueDate;

--Amount of Books an Author Has 
SELECT a.AuthorName, COUNT(b.BookID) AS TotalBooks
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.AuthorName;

USE LibraryDB
Go
Select name from sys.tables;
