app.implement () ->
    self = {}

    getFormAction = (form) ->
        actionNs = form.attr 'action'
        return if app.action.get actionNs then app.action.get actionNs else null

    getFormData = (form) ->
        dataArr = form.serializeArray()
        dataObj = {}

        for dataEntry in dataArr
            dataObj[dataEntry.name] = dataEntry.value

        dataObj

    doFormAction = (form) ->
        action = getFormAction form

        if typeof action is 'function'
            action getFormData(form), form
            return true

        return false

    self.getData = getFormData
    self.action =
        get: getFormAction,
        perform: doFormAction

    return self;

, [ 'form' ], true
