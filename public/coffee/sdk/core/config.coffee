app.implement () ->

    self = {};

    setConfig = (func, nsArr) ->
        nsArr.splice 0, 0, 'config'
        app.implement func, nsArr, false

    getConfig = (ns) ->
        curr = app.config
        for ns in ns.split '.'
            curr = curr[ns]
        curr();

    self.set = setConfig
    self.get = getConfig

    self
, [ 'config' ], true
