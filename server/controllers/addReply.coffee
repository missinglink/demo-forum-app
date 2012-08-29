TopicModel = require '../models/topic'
require '../helpers/paginate'



render = (response, data) ->
	response.render 'pages/topic', data



module.exports = (request, response) ->
	viewData =
		'base-dir': '../../'

	data = request.body.reply

	TopicModel.findOne _id: data['topic-id'], (err, topic) ->
		topic.replies.push
			name: data.name
			email: data.email
			text: data.text
		topic.save (err) ->
			if err? then render response, error: err else response.redirect "/topic/#{topic.slug}"