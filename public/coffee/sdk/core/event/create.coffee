app.implement () ->
    self = {}
    actions = {}
    conf = app.config.get 'event'
    body = null

    getBody = () ->
        body = $ 'body'

    catchEvent = (eventName, func) ->
        body.on conf.prefix + eventName, func

    triggerEvent = (eventName, data) ->
        body.trigger conf.prefix + eventName, data

    bindEvent = (evtType, selector, func) ->
        $ () ->
            body.on evtType, selector, func

    init = () ->
        getBody()

    $ () ->
        init()

    self.trigger = triggerEvent
    self.on = catchEvent
    self.bind = bindEvent

    return self;

, [ 'event' ], true
