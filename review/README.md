# ReviewAPI 

## ReviewAPI is a RESTful API that provides Reviews and Rating data to the Atelier e-Commerce platform.
<!-- <div style="text-align: center">
  <img src="https://img.shields.io/badge/docker-Docker-blue" alt="docker badge">
  <img src="https://img.shields.io/badge/NGINX-NGINX-green" alt="docker badge">
</div> -->
<img src="https://img.shields.io/badge/Runtime-Node.js-%23429643?logo=node.js"/> <img src="https://img.shields.io/badge/Database-mySQL-yellow"/> 

<img src="https://img.shields.io/badge/Deployment-AWS%20EC2-%23EC912D?logo=amazon"/> <img src="https://img.shields.io/badge/Development-Docker-9cf?logo=docker"/> <img src="https://img.shields.io/badge/Load--Balance-NGINX-green" alt="docker badge">

<img src=https://img.shields.io/badge/Testing-artillery.io-lightgrey/> <img src="https://img.shields.io/badge/Testing-Loader.io-%231A82E3?"/>
                                                                                                                                                   
                                                                                                                                                   

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


### Final System Architecture



## Load Testing

### Load Test - One API Instance
Using a single instance of the API server I managed to handle 1,000 clients/sec over a appropriate response time, however it is the case where my API has to handle 1,000 client/second it reaches bottleneck (slower response time)


<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/9e9b2abe-34e3-46f3-9a4c-97f5af789207/Screen_Shot_2021-07-01_at_12.41.43_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T181241Z&X-Amz-Expires=86400&X-Amz-Signature=dd5f6f82bda83217dc4f6cde239b0e29e6b76d1379b0039ec73c58151fb95063&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_12.41.43_PM.png%22" alt="100 client per second test">

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/e34d7324-1741-4481-8860-61d8625f7a11/Screen_Shot_2021-07-01_at_12.43.07_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T181222Z&X-Amz-Expires=86400&X-Amz-Signature=fa5d03c7d26922a587df7865eeda930bbcb6ee08e781283f2d9db0bc6aeaa60b&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_12.43.07_PM.png%22" alt="250 client per second test">

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/12265e4a-c327-4485-a6c9-a22e921592f1/Screen_Shot_2021-07-01_at_1.01.17_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T181157Z&X-Amz-Expires=86400&X-Amz-Signature=b1460932179a8287dcb0d2046d6cab0d059692d80c612d7c1a570400a0e31f05&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_1.01.17_PM.png%22" alt="500 clients per second test">

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/52a49b59-fdfc-402c-a3bb-39f165750110/Screen_Shot_2021-07-01_at_1.04.36_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T180646Z&X-Amz-Expires=86400&X-Amz-Signature=43fb961f1069f459fb44cf92f12d6c4ffe0f8b1b09edbd6af8ca1831e130fc20&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_1.04.36_PM.png%22" alt="750 client per seconds test">


<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/08029d21-ff15-48da-8859-f29251479d7a/Screen_Shot_2021-07-01_at_1.09.19_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210705T181321Z&X-Amz-Expires=86400&X-Amz-Signature=757f32665a019c90c3833f6033d8d8c11609131b3d14d50c0a80aa619a910b49&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen_Shot_2021-07-01_at_1.09.19_PM.png%22" alt="1000 client per second test">

> response time raises for 1000 client per second

I realized that once the API tries to handle 1000 client/sec my response time suffers heavily, Therefore I dockerized my API and using NGINX for load balancing to try to optimize allowing more clients and better response time


## API Routes

- [List Reviews](#list-reviews)

- [List Metadata](#list-Metadata)

- [Add A Review](#add-a-review)

- [Mark Review As Helpful](#mark-review-as-helpful)

- [Report Review](#report-review)

### List Reviews
`GET /reviews/` Returns a list of reviews for a particular product. This list does not include any reported reviews.

Parameters 

| Parameters | Type    | In    | Description                                               |
| ---------- | ------- | ----- | --------------------------------------------------------- |
| page | integer | query | Selects the page of results to return. Default 1.     |
| count       | integer | query | Specifies how many results per page to return. Default 5.         |
| sort | text | query | Changes the sort order of reviews to be based on "newest", "helpful", or "relevant"     |
| product_id | integer | query | Specifies the product for which to retrieve reviews.     |

Response

`Status: 200 OK`

```JSON
{
  "product": "2",
  "page": 0,
  "count": 5,
  "results": [
    {
      "review_id": 5,
      "rating": 3,
      "summary": "I'm enjoying wearing these shades",
      "recommend": false,
      "response": null,
      "body": "Comfortable and practical.",
      "date": "2019-04-14T00:00:00.000Z",
      "reviewer_name": "shortandsweeet",
      "helpfulness": 5,
      "photos": [{
          "id": 1,
          "url": "urlplaceholder/review_5_photo_number_1.jpg"
        },
        {
          "id": 2,
          "url": "urlplaceholder/review_5_photo_number_2.jpg"
        },
        // ...
      ]
    },
    {
      "review_id": 3,
      "rating": 4,
      "summary": "I am liking these glasses",
      "recommend": false,
      "response": "Glad you're enjoying the product!",
      "body": "They are very dark. But that's good because I'm in very sunny spots",
      "date": "2019-06-23T00:00:00.000Z",
      "reviewer_name": "bigbrotherbenjamin",
      "helpfulness": 5,
      "photos": [],
    },
    // ...
  ]
}
```

### List Metadata
`GET /reviews/meta` Returns review metadata for a given product.

Query Parameters 

| Parameters | Type    | Description                                               |
| ---------- | ------- | --------------------------------------------------------- |
| product_id| integer |  Required ID of the product for which data should be returned    |

Response

`Status: 200 OK`

``` JSON
{
  "product_id": "2",
  "ratings": {
    2: 1,
    3: 1,
    4: 2,
    // ...
  },
  "recommended": {
    0: 5
    // ...
  },
  "characteristics": {
    "Size": {
      "id": 14,
      "value": "4.0000"
    },
    "Width": {
      "id": 15,
      "value": "3.5000"
    },
    "Comfort": {
      "id": 16,
      "value": "4.0000"
    },
    // ...
}
```

### Add a Review

`POST /reviews` Adds a review for the given product.

Body Parameters

| Parameters | Type    | Description                                               |
| ---------- | ------- | --------------------------------------------------------- |
| product_id| integer |  Required ID of the product for which data should be returned    |
| rating| int |  Integer (1-5) indicating the review rating    |
| summary| text |  Summary text of the review    |
| body| text |  Continued or full text of the review |
| recommend| bool |  Value indicating if the reviewer recommends the product |
| name| text |  Username for question asker   |
| email| text |  Email address for question asker   |
| photos| [text] |  Array of text urls that link to images to be shown    |
| characteristics| object |  Object of keys representing characteristic_id and values representing the review value for that characteristic. { "14": 5, "15": 5 //...}    |

`Response Status: 201 CREATED`

### Mark Review As Helpful

`PUT /reviews/:review_id/helpful` Updates a review to show it was found helpful.

Parameters 

| Parameters | Type    | Description                                               |
| ---------- | ------- | --------------------------------------------------------- |
| review_id| integer |  Required ID of the review to update    |

Response

`Status: 204 NO CONTENT`

### Report Review

`PUT /reviews/:review_id/report` Updates a review to show it was reported. Note, this action does not delete the review, but the review will not be returned in the above GET request.

Parameters 

| Parameters | Type    | Description                                               |
| ---------- | ------- | --------------------------------------------------------- |
| review_id| integer |  Required ID of the review to update    |

Response

`Status: 204 NO CONTENT`
