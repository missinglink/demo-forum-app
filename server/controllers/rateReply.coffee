mongoose = require 'mongoose'
TopicModel = require '../models/topic'
ReplyModel = mongoose.model 'Reply'
require '../helpers/paginate'



module.exports = (request, response) ->
	replyId = request.params.id
	type = if request.params.type? then request.params.type else 'like'
	topicId = request.params.topicId

	TopicModel.findOne _id: topicId, (err, topic) ->
		for reply in topic.replies
			if String(reply._id) is replyId
				if type is 'like' then reply.rank += 1 else reply.rank -=1
				topic.save (err) ->
					if not err? then response.redirect "/topic/#{topic.slug}"
