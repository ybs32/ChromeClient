const execSync = require('child_process').execSync;

function exec(cmd, next) {
  try {
    next(execSync(cmd).toString());
  } catch (err) {
    next(null, err);
  }
}

module.exports = {
  exec
};