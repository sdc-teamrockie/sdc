CREATE DATABASE reviews

CREATE TABLE products (
  productID int NOT NULL auto_increment,
  PRIMARY KEY (productID)
)

-- I want to add productID values into product's productID for values of product that is less than 999999 let's say
-- INSERT INTO products (productID)
-- SELECT productID
-- FROM reviews
-- WHERE productID <= 999999

-- SELECT productID INTO products FROM reviews;

-- ALTER TABLE products ADD FOREIGN KEY (productID) REFERENCES reviews(productID);

CREATE TABLE reviews (
  reviewID int NOT NULL auto_increment PRIMARY KEY,
  productID int,
  rating int NOT NULL,
  review_date bigint NOT NULL,
  summary varchar(150) NOT NULL,
  body varchar(1000) NOT NULL,
  recommend BOOLEAN,
  reported BOOLEAN,
  reviewer_name varchar(50) NOT NULL,
  reviewer_email varchar(50) NOT NULL,
   response varchar(250),
  helpfulness int NOT NULL,
  FOREIGN KEY (productID) REFERENCES products(productID)
)

CREATE TABLE photos (
  photoID int NOT NULL auto_increment PRIMARY KEY,
  reviewID int,
  FOREIGN KEY (reviewID) REFERENCES reviews(reviewID)
)

CREATE TABLE characteristic (
  characteristicID int NOT NULL auto_increment PRIMARY KEY,
  reviewID int,
  FOREIGN KEY (reviewID) REFERENCES reviews(reviewID)
)

-- each photoID has a reference to the productID


LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews1.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(reviewID, productID, rating, review_date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness);



LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews2.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(reviewID, productID, rating, review_date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness);


LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews3.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(reviewID, productID, rating, review_date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews4.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(reviewID, productID, rating, review_date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews5.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(reviewID, productID, rating, review_date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews6.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(reviewID, productID, rating, review_date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness);


-- to load in productID into products table from review.csv
LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews1.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, productID, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews2.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(@dummy, productID, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews2.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(@dummy, productID, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews3.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(@dummy, productID, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews4.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(@dummy, productID, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews5.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(@dummy, productID, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/reviews6.csv' INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(@dummy, productID, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);


-- checks how many rows there is from each table
SELECT count(*) FROM reviews;
SELECT count(*) FROM products;


-- CREATE TABLE products AS SELECT productID FROM reviews