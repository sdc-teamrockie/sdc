const mysql = require('mysql');

const connection = mysql.createConnection({
  host: '18.117.158.150',
  port: 3306,
  user: 'dave',
  password: 'davepassword',
  database: 'reviews',
  connectionLimit: 5
});

// connection.query(queryString, queryParam, err first cb)

connection.connect((err) => {
  if (err) {
    return console.error('error:', err.message);
  }
});

const getReviewByCount = function(id, n, sort, callback) {
  var queryString = `SELECT * FROM reviews WHERE productID=${id} AND reported=0 ORDER BY ${sort} DESC LIMIT ${n}`;
  connection.query(queryString, function(err, result) {
    if (err) {
      callback(err, 'unable to get review');
    } else {
      callback(null, result);
    }
  });
};
const getReviewForProductID = function(productID, callback) {
  var queryString = 'SELECT * FROM reviews LEFT JOIN photos ON reviews.reviewID = photos.reviewID WHERE reviews.productID=?';
  connection.query(queryString, productID, function(err, result) {
    if (err) {
      callback(err, `error occurred for getReviewForProductID ${productID}`);
    } else {
      callback(null, result);
    }
  });
};

const getReviewMetaData = function(productID, callback) {
  var queryString = `SELECT reviews.rating, reviews.recommend, reviews.reviewID, name, value, characteristics.characterID
  FROM reviews
  LEFT JOIN characteristics_reviews ON characteristics_reviews.reviewID = reviews.reviewID
  LEFT JOIN characteristics ON characteristics.characterID = characteristics_reviews.characterID
  WHERE reviews.productID=?`;
  connection.query(queryString, productID, function(err, result) {
    if (err) {
      callback(err, `error occurred for getReviewMetaData for productID:${productID}`);
    } else {
      callback(null, result);
    }
  });
};

const postReview = function(array, callback) {
  var queryString = 'INSERT INTO reviews (productID, rating, summary, body, recommend, reviewer_name, reviewer_email, helpfulness, reported, review_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  connection.query(queryString, array, function(err, result) {
    if (err) {
      callback(err, 'error occurred for inserting into review');
    } else {
      callback(null, 'review has been posted');
    }
  });
};
const lastInsertId = function(callback) {
  var queryString = 'SELECT LAST_INSERT_ID()s';
  connection.query(queryString, function(err, result) {
    if (err) {
      callback(err, 'err occurred lastInsertId');
    } else {
      // console.log('am i getting', result[0].s);
      callback(null, result[0].s);
    }
  });
};

const postPhotos = function(array, callback) {
  var queryString = 'INSERT INTO photos (reviewID, url) VALUES (?, ?)';
  connection.query(queryString, array, function(err, result) {
    if (err) {
      callback(err, 'err occurred for postPhotos');
    } else {
      callback(null, 'photo has been posted');
    }
  });
};

const addCharacteristicsReviews = function(array, callback) {
  var queryString = 'INSERT INTO characteristics_reviews (characterID, reviewID, value) VALUES (?, ?, ?)';
  connection.query(queryString, array, function(err, result) {
    if (err) {
      callback(err, 'err has occurred for adding characteristics review');
    } else {
      callback(null, 'characteristics reviews has been added');
    }
  });
};

const reportReview = function(id, callback) {
  var queryString = 'UPDATE reviews SET reported=1 WHERE reviewID=?';
  connection.query(queryString, id, function(err, result) {
    if (err) {
      callback(err, 'review report unsucessful');
    } else {
      callback(null, 'review has been reported');
    }
  });
};

const incrementHelpful = function(id, callback) {
  var queryString = 'UPDATE reviews SET helpfulness = helpfulness+1 WHERE reviewID=?';
  connection.query(queryString, id, function(err, result) {
    if (err) {
      callback(err, 'helpfulness update failed');
    } else {
      callback(null, 'helpfulness incremented');
    }
  });
};



module.exports = {
  getReviewByCount,
  getReviewForProductID,
  getReviewMetaData,
  postReview,
  lastInsertId,
  postPhotos,
  addCharacteristicsReviews,
  reportReview,
  incrementHelpful
};