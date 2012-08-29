mongoose = require 'mongoose'

mongoose.Query.prototype.paginate = (page = 1, limit = 10, cb)->
  query = this
  model = this.model
  skipFrom = (page * limit) - limit
  query = query.skip(skipFrom).limit(limit)
  if cb
    query.exec (err, docs)->
      if err
        cb err, null, null
      else
        model.count query._conditions, (err, total)->
          cb null, total, docs
  else
    throw new Error("pagination needs a callback as the third argument.")