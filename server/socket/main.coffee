cookie = require 'cookie'
connect = require 'connect'
Session = connect.middleware.session.Session
mongoose = require 'mongoose'
TopicModel = require '../models/topic'



initialiseSocket = (app, sessionStore) ->
    sio = require('socket.io').listen app

    sio.set 'authorization', (data, accept) ->
        if data.headers.cookie
            data.cookie = cookie.parse data.headers.cookie
            data.sessionID = data.cookie['connect.sid']
            sessionStore.get data.sessionID, (err, session) ->
                if err or not session
                    accept 'Error', false
                else
                    data.session = new Session data, session
                    data.sessionStore = sessionStore
                    accept null, true
        else
            return accept 'No cookie transmitted.', false
        accept null, true

    sio.sockets.on 'connection', (socket) -> onConnect(socket, app)



onConnect = (socket, app) ->
    socket.on 'comment.add', (data, cb) ->
        addComment data, cb, socket



addReply= (data, cb, socket) ->
    TopicModel.findOne data['topic-id'], (err, topic) ->
        if err?
            cb err
        else
            topic.comments.push
                name: data.name
                email: data.email
                text: data.text
            topic.save (err) ->
                 if err? then cb err else socket.emit 'comment.add', data



exports.initialise = initialiseSocket