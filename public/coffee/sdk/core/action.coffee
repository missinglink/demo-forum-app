app.implement () ->
    self = {}
    actions = {}

    getAction = (nsString) ->
        return app.utils.namespace.fetch(actions, nsString.split('.'));

    callAction = (nsString) ->
        func = getAction nsString
        func()

    setAction = (func, ns, evtType) ->
        app.declare func, actions, ns.split('.'), false
        if evtType?
            app.event.bind evtType, '[data-action=' + ns + ']', func

    self.set = setAction
    self.get = getAction
    self.call = callAction

    return self

, [ 'action' ], true
