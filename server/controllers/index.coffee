TopicModel = require '../models/topic'
require '../helpers/paginate'



settings =
	topicsPerPage: 10



render = (response, data) ->
	response.render 'pages/index', data



getPaginationData = (current, total) ->
	pagination =
		'is-first': if current > 1 then false else true
		'is-last': if current < total then false else true
		'previous-page': if current > 1 then current - 1 else 1
		'next-page': if current < total then current + 1 else current
	return pagination



module.exports = (request, response) ->
	viewData =
		title: 'Topics'

	page = if request.params.page? then parseInt request.params.page, 10 else 1
	if page < 1 then page = 1

	TopicModel.find().sort('created', -1).paginate page, settings.topicsPerPage, (err, total, topics) ->
		if topics? then TopicModel.processTopics topics
		viewData['has-topics'] = if topics? and topics.length isnt 0 then true else false
		viewData.topics = topics
		viewData.pagination = getPaginationData page, Math.round(total / settings.topicsPerPage + 0.4)

		render response, viewData


