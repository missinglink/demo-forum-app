var express, path, server;

require("coffee-script");

express = require('express');

path = require('path');

server = module.exports = express.createServer();

server.set('baseDir', path.resolve(__dirname + '/..'));

server.configure(require('./config/default.coffee'));

server.configure('development', require('./config/development.coffee'));

server.configure('production', require('./config/production.coffee'));

require('./routes').call(server);

server.listen(server.set('port'));

console.log('Server running...');

console.log('  > Listening on port %d in %s mode', server.address().port, server.settings.env);