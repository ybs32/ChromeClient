
module.exports = {
  getTest
};

function getTest(req, res, next) {
    res.render('index', { title: 'Express' });
}