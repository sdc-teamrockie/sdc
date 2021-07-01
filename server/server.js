const express = require('express');
const app = express();
const path = require('path');
const PORT = process.env.PORT || 3000;
const db = require('../database/index.js');
const {getReviewByCount, getReviewForProductID, getReviewMetaData, postReview, lastInsertId, postPhotos, addCharacteristicsReviews, reportReview, incrementHelpful} = require('../database/index.js');
app.use(express.json(), express.urlencoded({extended: false}));

// get reviews endpoint
app.get('/reviews', function(req, res) {
  // query parameters can be retrived from the query object on req obj send to route.
  const params = req.query;
  let productID = Number(params.product_id);
  let sort;
  if (params.sort === 'helpful') {
    sort = 'helpfulness';
  } else if (params.sort === 'relevant') {
    sort = 'recommend';
  } else {
    sort = 'review_date';
  }

  let convertToDate = function(dateToConvert) {
    return new Date(dateToConvert).toISOString();
  };

  getReviewByCount(productID, Number(params.count), sort, (err, result) => {
    if (err) {
      res.status(404).send(err);
    } else {
      const data = result;
      const resultsArray = data.map((data) => {
        return {
          review_id: data.reviewID,
          rating: data.rating,
          summary: data.summary,
          recommend: data.recommend,
          response: data.response,
          body: data.body,
          date: convertToDate(data.review_date),
          review_name: data.reviewer_name,
          helpfulness: data.helpfulness,
          photos: [
            {
              id: data.photoID,
              url: data.url
            }
          ]
        };
      });
      const resultData = {
        product: productID,
        page: Number(params.page),
        count: Number(params.count),
        results: resultsArray
      };
      res.status(200).json(resultData);
    }
  });
});

app.get('/reviews/meta', function(req, res) {
  const params = req.query;
  let productID = params.product_id;

  getReviewMetaData(productID, (err, result) => {
    if (err) {
      console.error('err has occurred', err);
    } else {
      var calcAllRating = function() {
        const ratingObj = {};
        for (var i = 1; i <= 5; i++) {
          var ratedNum = result.filter(data => data.rating === i);
          if (ratedNum.length > 0) {
            ratingObj[i] = ratedNum.length;
          }
        }
        return ratingObj;
      };

      var recordRecommend = function() {
        const recommendObj = {};
        for (var i = 0; i <= 1; i++) {
          var recordBool = result.filter(data => data.recommend === i);
          recommendObj[i] = recordBool.length;
        }
        return recommendObj;
      };

      const getCharacteristics = function() {
        const trackName = {};
        const characteristicNames = result.forEach((data) => {
          if (trackName[data.name] === undefined) {
            trackName[data.name] = {id: data.characterID, values: []};
            trackName[data.name].values.push(data.value);
          } else {
            trackName[data.name].values.push(data.value);
          }
          // calculate all average value for that particular characterID
        });
        const average = (array) => array.reduce((a, b) => (a + b)) / array.length;
        for (var keys in trackName) {
          trackName[keys].values = (average(trackName[keys].values).toFixed(4));
        }
        return trackName;
      };

      const resultData = {
        product_id: productID,
        ratings: calcAllRating(),
        recommended: recordRecommend(),
        characteristics: getCharacteristics()
      };

      res.status(200).json(resultData);
    }
  });
});

app.post('/reviews', function(req, res) {
  let body = req.body;
  var bodyArray = [];
  var currentTime = new Date();
  var dates = date => new Date(date).getTime();
  // default Value covers helpfulness, reported, review_date,
  const defaultValues = [0, 0, dates(currentTime)];
  for (var keys in body) {
    if (keys !== 'photos' && keys !== 'characteristics' && keys !== 'recommend') {
      bodyArray.push(body[keys]);
    }
    if (keys === 'recommend') {
      if (body[keys] === false) {
        body[keys] = 0;
        bodyArray.push(body[keys]);
      } else {
        body[keys] = 1;
        bodyArray.push(body[keys]);
      }
    }
  }
  bodyArray = bodyArray.concat(defaultValues);
  postReview(bodyArray, (err, result) => {
    if (err) {
      console.error(err);
    } else {
      return result;
    }
  });
  // functionality that depends on lastInsertedID for reviewID
  var lastinsertID = lastInsertId((err, result) => {
    if (err) {
      console.error(err);
    } else {
      const photos = JSON.parse(body.photos);
      photos.forEach((photo) => {
        postPhotos([result, photo], (err, result) => {
          if (err) {
            console.error(err);
          } else {
            console.log(result);
          }
        });
      });

      // add characteristics
      let characterIds = Object.keys(JSON.parse(body.characteristics));
      let characterValues = Object.values(JSON.parse(body.characteristics));
      for (let i = 0; i < characterIds.length; i++) {
        addCharacteristicsReviews([Number(characterIds[i]), result, characterValues[i]], function(err, result) {
          if (err) {
            console.error(err);
          } else {
            console.log(result);
          }
        });
      }
    }
  });

});


app.put('/reviews/:review_id/report', function(req, res) {
  const id = req.params.review_id;
  reportReview(id, function(err, result) {
    if (err) {
      res.status(404).send(result);
    } else {
      res.status(200).send(result);
    }
  });
});

app.put('/reviews/:review_id/helpful', function(req, res) {
  const id = req.params.review_id;
  incrementHelpful(id, function(err, result) {
    if (err) {
      res.status(404).send(result);
    } else {
      res.status(200).send(result);
    }
  });
});


app.listen(PORT, () => {
  console.log(`Server listening at localhost:${3000}!`);
});
