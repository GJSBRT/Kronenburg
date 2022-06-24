const path = require('path');

module.exports = {
  entry: './redis.js',
  target: 'node',
  mode: 'production',
  output: {
    filename: 'wtf_redis.js',
    path: path.resolve(__dirname, '..'),
  },
  optimization: {
    minimize: false,
  },
};
