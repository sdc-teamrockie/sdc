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
  url varchar(150),
  FOREIGN KEY (reviewID) REFERENCES reviews(reviewID)
)

CREATE TABLE characteristics (
  characterID int NOT NULL auto_increment PRIMARY KEY,
  productID int,
  FOREIGN KEY (productID) REFERENCES products(productID),
  name varchar(20) NOT NULL
)

-- many to many relationship with characteristics
-- many review to many characteristic review
CREATE TABLE characteristics_reviews (
  crID int NOT NULL auto_increment PRIMARY KEY,
  characterID int,
  FOREIGN KEY (characterID) REFERENCES characteristics(characterID),
  reviewID int,
  FOREIGN KEY (reviewID) REFERENCES reviews(reviewID),
  value int NOT NULL
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



-- LOAD DATA FOR photo
LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/csv/reviews_photos.csv' INTO TABLE photos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(photoID, reviewID, url);

-- LOAD DATA FOR characteristics
LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/csv/characteristics.csv' INTO TABLE characteristics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(characterID, productID, name);


-- LOAD DATA FOR characteristics_reviews  about 4min to load in

LOAD DATA LOCAL INFILE '/Users/fanana/Desktop/hackreactor/sdc/csv/characteristic_reviews.csv' INTO TABLE characteristics_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(crID, characterID, reviewID, value);

-- checks how many rows there is from each table
SELECT count(*) FROM reviews;
SELECT count(*) FROM products;


-- CREATE TABLE products AS SELECT productID FROM reviews


-- breaks  -- i want name from characteristics table -- edit works now
  -- (name) is coming from characteristics table
  -- (value) from characteristics_reviews table
  -- (crID) is for ex: length's ID and fit's ID
SELECT reviews.rating, reviews.recommend, reviews.reviewID, name, value, crID
FROM reviews
LEFT JOIN characteristics_reviews ON characteristics_reviews.reviewID = reviews.reviewID
LEFT JOIN characteristics ON characteristics.characterID = characteristics_reviews.characterID
WHERE reviews.productID = 1000;

-- it's not crID that we want, for a productID --> there is a characterID directly correlated to a value
SELECT reviews.rating, reviews.recommend, reviews.reviewID, name, value, characteristics.characterID
FROM reviews
LEFT JOIN characteristics_reviews ON characteristics_reviews.reviewID = reviews.reviewID
LEFT JOIN characteristics ON characteristics.characterID = characteristics_reviews.characterID
WHERE reviews.productID = 1000;


-- works
SELECT reviews.rating, reviews.recommend, reviews.reviewID
FROM reviews
LEFT JOIN characteristics_reviews ON characteristics_reviews.reviewID = reviews.reviewID
WHERE reviews.productID = 1000;

SELECT reviews.rating, reviews.recommend, reviews.reviewID
FROM reviews
WHERE reviews.productID = 1000;
