
# Dependencies
express = require 'express'
hulk = require 'hulk-hogan'

# Server default configuration
#
# This is loaded before either of the
# environment-specific configurations.
module.exports = ->
    baseDir = @set 'baseDir'

    # The port the server should run on
    @set 'port', process.env.PORT || 3000

    # Register hulk-hogan (mustache) views
    @register '.html', hulk

    # Set the view directory and default options
    @set 'views', baseDir + '/server/views'
    @set 'view engine', 'html'
    @set 'view options',
        layout: 'layouts/default/index'
        title: ''

    # Set the server's public directory
    @use express.static baseDir + '/public'
    
    # Allow parsing of request bodies and '_method' parameters
    @use express.bodyParser()
    @use express.methodOverride()

    # Enable cookies
    @use express.cookieParser()
    
    # Configurate mongoose
    mongoose = require 'mongoose'
    mongoose.connect 'mongodb://heroku:veridu@alex.mongohq.com:10064/app7142811/'

    # Mount application routes
    @use @router