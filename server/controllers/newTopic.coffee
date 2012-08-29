TopicModel = require '../models/topic'



render = (response, data) ->
	response.render 'pages/new-topic', data


addTopic = (topicData, request, response, callback) ->
	topic = new TopicModel topicData
	topic.save (err) ->
		callback err


module.exports = (request, response) ->
	viewData =
		title: 'New topic'

	if request.body.topic?
		addTopic request.body.topic, request, response, (err) ->
			if err? then render response, error: err else response.redirect '/'
	else
		render response, viewData


