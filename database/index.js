const mysql = require('mysql');
// const csvtojson = require('csvtojson');
// const csvFilePath = '../csv/reviews.csv';
var fs = require('fs');
var parse = require('csv-parse');


const connection = mysql.createConnection({
  user: 'root',
  password: 'password',
  database: 'review'
});

// connection.query(queryString, queryParam, err first cb)

// connection.connect((err) => {
//   if (err) {
//     return console.error('error:', err.message);
//   }
//   var queryString = `INSERT `;

//   connection.query();
// });
const header = ['id', 'product_id', 'rating', 'date' , 'summary', 'body', 'recommend' , 'reported' , 'reviewer_name', 'reviewer_email' , 'response' , 'helpfulness']
csvtojson({noheader: false, headers: header})
  .fromFile(csvFilePath)
  .then((jsonObj) => {
    console.log('give me jsonObj length', jsonObj.length);
    console.log('can i get object pls:', jsonObj);
  })
  .catch((err) => {
    console.log('not able to load json for reason:', err);
  });


