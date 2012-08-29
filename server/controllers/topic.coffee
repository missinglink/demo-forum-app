TopicModel = require '../models/topic'
require '../helpers/paginate'



render = (response, data) ->
	response.render 'pages/topic', data



module.exports = (request, response) ->
	viewData =
		'base-dir': '../../'

	slug = if request.params.slug? then request.params.slug

	TopicModel.findOne { slug: slug}, (err, topic) ->
		if topic?
			TopicModel.process topic
			viewData['topic'] = topic
		viewData['title'] = if topic? then topic.title else 'Topic not found'
		render response, viewData

