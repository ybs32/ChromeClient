const createError = require('http-errors');
const cmd = require('../services/command.service');

function getList(req, res, next) {
  cmd.exec('ls -alF', (list, err) => {
    if (err) {
      return res.status(500).json({
        result: err.toString()
      });
    }

    let item = [];
    item = list.split('\n');
    item = item.slice(1, item.length - 1);
    return res.status(200).json({
      result: item
    });
  });
}

module.exports = {
  getList
};