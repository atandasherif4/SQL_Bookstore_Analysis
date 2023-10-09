-- Create the Books table
CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  title VARCHAR(100),
  author VARCHAR(100),
  genre VARCHAR(50),
  price DECIMAL(8, 2)
);

-- Insert data into the Books table
INSERT INTO Books (book_id, title, author, genre, price)
VALUES
  (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 10.99),
  (2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 12.50),
  (3, '1984', 'George Orwell', 'Science Fiction', 8.99),
  (4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 9.99),
  (5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 11.25);
  
--View the table created
SELECT *
FROM books;

-- Create the Customers table
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50)
);

-- Insert data into the Customers table
INSERT INTO Customers (customer_id, name, email, city, country)
VALUES
  (1, 'John Smith', 'john@example.com', 'London', 'UK'),
  (2, 'Jane Doe', 'jane@example.com', 'New York', 'USA'),
  (3, 'Michael Johnson', 'michael@example.com', 'Sydney', 'Australia'),
  (4, 'Sophia Rodriguez', 'sophia@example.com', 'Paris', 'France'),
  (5, 'Luis Hernandez', NULL, 'Mexico City', 'Mexico');
  
--Viewing customer's table
SELECT *
FROM customers;

-- Create the Orders table
CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into the Orders table
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
  (1, 1, '2022-01-15', 50.99),
  (2, 2, '2022-02-20', 75.50),
  (3, 3, '2022-03-10', 30.75),
  (4, 4, '2022-04-05', 22.99),
  (5, 5, '2022-05-12', 15.25);
  
--Viewing orders table
SELECT *
FROM orders;

-- Create the Order_Items table
CREATE TABLE Order_Items (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  book_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert data into the Order_Items table
INSERT INTO Order_Items (order_item_id, order_id, book_id, quantity)
VALUES
  (1, 1, 1, 2),
  (2, 2, 3, 1),
  (3, 3, 2, 3),
  (4, 4, 5, 1),
  (5, 5, 4, 2);
  
--Viewing order_items table
SELECT *
FROM Order_Items;

--QUESTION_ONE: Retrieve all books with a price greater than $10. 
SELECT title AS book_name, 
	   price
FROM books
WHERE price > 10;

--QUESTION_TWO: Find the total amount spent by each customer in descending order.
SELECT customers.name AS customer_name, 
	   orders.total_amount AS total_amount_spent
FROM orders 
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
ORDER BY 2 DESC;

--QUESTION_THREE: Retrieve the top 3 best-selling books based on the total quantity sold.
SELECT books.title AS best_selling_books, 
	   order_items.quantity AS total_quantity_sold
FROM order_items
LEFT JOIN books
ON order_items.book_id = books.book_id
ORDER BY 2 DESC
LIMIT 3;

--QUESTION_FOUR: Find the average price of books in the Fiction genre.
SELECT ROUND(AVG(price),2) AS average_price
FROM books
WHERE genre = 'Fiction';

--QUESTION_FIVE: Retrieve the names of customers who have placed orders.
SELECT customers.name,
	orders.order_id
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE order_id IS NOT NULL;

--QUESTION_SIX: Find the total revenue generated from book sales.
SELECT SUM(total_amount) AS total_revenue_generated
FROM orders;

--QUESTION SEVEN: Retrieve the books with titles containing the word “and” (case-insensitive).
SELECT title AS book_title
FROM books
WHERE title LIKE '%and%';

--QUESTION EIGHT: Find the customers who have placed orders worth more than $50. 
SELECT customers.name AS customer_name,
	   orders.total_amount 
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE  orders.total_amount > 50;

--QUESTION NINE: Retrieve the book titles and their corresponding authors sorted in alphabetical order by author.
SELECT title, 
	   author
FROM books
ORDER BY 2;

--QUESTION TEN: Find the customers who have not placed any orders. 
SELECT customers.name AS customer_name
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.order_id IS NULL;




