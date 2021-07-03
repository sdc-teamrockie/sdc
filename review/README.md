# ReviewAPI 

## ReviewAPI is a RESTful API that provides Reviews and Rating data to the Atelier e-Commerce platform.

ReviewAPI completes Extract, Transform, and Load process for the required CSV data using LOAD DATA INFILE, which populates mySQL database.
For this project I was given a set of CSV files containing millions of record. The goal was to produce a scalable API that had to serve pre-existing legacy front end code with multiple endpoints. The minimum requirements were to serve 200 clients per seconds with <50ms average response time, after initial deployment on AWS EC2 t2.micros and load testing I was able to achieve 1000 clients per seconds with appropriate response time. 

Due to data type and how data interacted with one another I decided to use mySQL. Allowing me to fully take advantage of how the relationship goes and get a faster query time using that relationship. 
I Implemented the server using node.js and express. Using docker for deployment. Lastly when it comes to scaling horizontally I implemented a load balancer using NGINX

## Table of Contents

[Requirements](#requirements)

[Technologies Used](#technologies-used)

[Installation](#installation)

[ETL Process](#etl-process)

[System Architecture](#system-architecture)

[Load Testing](#load-testing)

[API Routes](#api-routes)


## Requirements

Ensure the following modules are installed before running `npm install`

- Node v14.15.0 or higher
- mySQL v8.0 or higher
> Alternatively project can be run using Docker

## Technologies Used

### Backend

- Node.js
- Express
- mySQL
- Docker
- NGINX

### Testing

- Artillery.io
- Loader.io

### Running Locally
1. Start an instance of mySQL
  - If you have mySQL installed locally 
  - Using Docker
     ```
     docker built -t anyName/serverApp:1.0 .
     ```
     > This builds the docker image into a container
     ```
     docker run --init --rm -p 3000:3000 [docker imageID]
     ```
     > This runs the image and creates a container and runs it on localhost:3000
2. From the root directory start the server by running:

   ```
   npm start
   ```
3. The api will now be accessible on http://localhost:3000

## ETL Process
The first step of the project was to design a schema and pick a database based on the data we recieved in CSV file. For the Review section I was given multiple CSV files:
```
reviews.csv
├── id 
├── product_id
├── rating
├── date
├── summary
├── body
├── recommend
├── reported
├── reviewer_name
├── reviewer_email
├── response
├──helpfulness

reviews_photo.csv
├── id
├── review_id
└── helpful

characteristic_reviews.csv
├── id 
├── characteristic_id
├── review_id
└── value

characteristics.csv
├── id 
├── product_id
└── name
```





