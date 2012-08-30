mongoose = require 'mongoose'
moment = require 'moment'
stringHelper = require '../helpers/string'



ReplySchema = new mongoose.Schema
	email:
		type: String
	name:
		type: String
	text:
		type: String
	created:
		type: Date
		default: Date.now
	rank:
		type: Number
		default: 0



TopicSchema = new mongoose.Schema
	title:
		type: String
	slug:
		type: String
	text:
		type: String
	replies:
		type: [ ReplySchema ]
	score:
		type: Number
	email:
		type: String
	name:
		type: String
	created:
		type: Date
		default: Date.now



TopicSchema.statics.process = processTopic = (topic) ->
	topic['replies-count'] = topic.replies.length
	topic['created-date'] = moment(new Date(topic.created)).fromNow()
	topic['topic-id'] = topic._id
	if topic.email is '' then topic['has-email'] = false else topic['has-email'] = true



TopicSchema.pre 'save', (next) ->
	@slug = stringHelper.slugify @title
	next()



TopicSchema.statics.processTopics = (topics) ->
	topics.forEach processTopic



mongoose.model 'Reply', ReplySchema
module.exports = mongoose.model 'Topic', TopicSchema