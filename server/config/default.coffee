
# Dependencies
browserify = require 'browserify'
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

    # Set up client-side CoffeeScript compilation with browserify
    browserScriptBundle = browserify
        require: baseDir + '/client/bootstrap.coffee'
        mount: '/script/main.js'
    @use browserScriptBundle
    
    # Allow parsing of request bodies and '_method' parameters
    @use express.bodyParser uploadDir: baseDir + '/public/uploads/'
    @use express.methodOverride()

    # Enable cookies
    @use express.cookieParser()
    
    # Configurate mongoose
    mongoose = require 'mongoose'
    mongoose.connect 'mongodb://localhost/forum'

    # Configurate mongoose session store
    SessionMongoose = require 'session-mongoose'
    sessionStore = new SessionMongoose { url: 'mongodb://localhost/sessions' }
    @use express.session
        store: sessionStore
        secret: 'A dead session in a good session'

    # Mount application routes
    @use @router

    # Compile shared Hogan templates
    hoganshare = require 'hoganshare'

    @get "/templates.js", (req, res) ->
        res.contentType ".js"
        res.send hoganshare.getTemplates baseDir + "/server/views/partials"

    # Initialise Socket.io
    socketHandler = require baseDir + '/server/socket/main'
    socketHandler.initialise @, sessionStore