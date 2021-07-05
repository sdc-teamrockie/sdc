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

[API Performance](#API-Performance)

[System Architecture](#system-architecture)

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

## Installation

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
└──helpfulness

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
 Since I used mySQL database I had the option to go with LOAD DATA INFILE method, directly loading in the csv column into my table. The reviews.csv was relatively huge (10-million rows) compared to other csv file. Therefore I split the file using script command and loading each one individually. 
 
 This process took about 10 minutes, which in general is much faster than using streams. Although, more manual work but however you skip over the complexity and the wait time over using streams.
 


## System Architecture
### Initial System Architecture


###Final System Architecture



## Load Testing

### Load Test - One API Instance
Using a single instance of the API server I managed to handle 1,000 clients/sec over a appropriate response time, however it is the case where my API has to handle 1,000 client/second it reaches bottleneck (slower response time)


<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/9e9b2abe-34e3-46f3-9a4c-97f5af789207/Screen_Shot_2021-07-01_at_12.41.43_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T181241Z&X-Amz-Expires=86400&X-Amz-Signature=dd5f6f82bda83217dc4f6cde239b0e29e6b76d1379b0039ec73c58151fb95063&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_12.41.43_PM.png%22" alt="100 client per second test">

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/e34d7324-1741-4481-8860-61d8625f7a11/Screen_Shot_2021-07-01_at_12.43.07_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T181222Z&X-Amz-Expires=86400&X-Amz-Signature=fa5d03c7d26922a587df7865eeda930bbcb6ee08e781283f2d9db0bc6aeaa60b&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_12.43.07_PM.png%22" alt="250 client per second test">

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/12265e4a-c327-4485-a6c9-a22e921592f1/Screen_Shot_2021-07-01_at_1.01.17_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T181157Z&X-Amz-Expires=86400&X-Amz-Signature=b1460932179a8287dcb0d2046d6cab0d059692d80c612d7c1a570400a0e31f05&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_1.01.17_PM.png%22" alt="500 clients per second test">

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/52a49b59-fdfc-402c-a3bb-39f165750110/Screen_Shot_2021-07-01_at_1.04.36_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T180646Z&X-Amz-Expires=86400&X-Amz-Signature=43fb961f1069f459fb44cf92f12d6c4ffe0f8b1b09edbd6af8ca1831e130fc20&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_1.04.36_PM.png%22" alt="750 client per seconds test">





