app.implement () ->
    self = {}
    alerts = []
    conf = app.config.get 'ui.alert'

    updatePositions = () ->
        y = conf.settings.margin
        alerts.each () ->
            alert = $(@)
            alert.stop().animate { top: y }, 500
            y += alert.outerHeight() + conf.settings.margin

    updateElements = () ->
        alerts = $ conf.selectors.alert

    removeFirst = () ->
        alerts.first().fadeOut 200, () ->
            $(@).remove()
            updatePositions()
        alerts = alerts.not alerts.first()

    getInitialY = () ->
        y = conf.settings.margin
        if alerts.length isnt 0
            alerts.each () -> y += $(@).outerHeight() + conf.settings.margin
        return y

    showAlert = (content, options) ->
        options = $.extend
            type: ''
            url: ''
            action: ''
            content: content
        , options
        initialY = getInitialY()
        $(app.template.render('ui.alert', options)).appendTo('body').css top: initialY
        updateElements()
        setTimeout removeFirst, conf.settings.duration
        updatePositions()

    init = () -> updateElements()

    init()

    self.show = showAlert

    return self

, [ 'ui', 'alert' ], true