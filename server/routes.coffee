
# Routes
module.exports = ->

    # Index
    @get '/', require('./controllers/index')
    @get '/page-:page', require('./controllers/index')
    
    @get '/new-topic', require('./controllers/newTopic')
    @post '/new-topic', require('./controllers/newTopic')

    # Topic   
    @get '/topic/:slug', require('./controllers/topic')

    # Add reply   
    @post '/add-reply', require('./controllers/addReply')

    # Rate reply   
    @get '/rate-reply/:topicId/:id/:type', require('./controllers/rateReply')