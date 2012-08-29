$ () ->
    conf = app.config.get 'ui.tooltip'

    onMouseEnter = (element) ->
        app.ui.tooltip.show element.attr(conf.attribute)

    onMouseLeave = () ->
        app.ui.tooltip.hide()

    init = () ->
        selector = '[' + conf.attribute + ']'
        app.event.bind 'mouseenter', selector, () -> onMouseEnter $(@)
        app.event.bind 'mouseleave', selector, onMouseLeave

    init()