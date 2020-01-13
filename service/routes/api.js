const express = require('express');
const router = express.Router();
const cmdController = require('../controllers/command.controller');

router.get('/v1/cmd/list', cmdController.getList);

module.exports = router;