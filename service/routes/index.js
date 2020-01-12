const express = require('express');
const router = express.Router();
const testController = require('../controllers/test.controller');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/api/v1/test', testController.getTest)

module.exports = router;
