app.implement (value) ->
    self = {}
    mouse = { x: 0, y: 0 }
    conf = app.config.get 'ui.tooltip'
    element = $ ''
    alignment = conf.defaultAlignment
    currentValue = null
    win = $ window

    showTooltip = (value) ->
        if value isnt currentValue
            hideTooltip()
            createTooltip { content: value }
            currentValue = value

    hideTooltip = () ->
        $(conf.selectors.tooltip).remove()
        currentValue = null

    createTooltip = (data) ->
        element = $(app.template.render 'ui.tooltip', data).appendTo 'body'
        updatePosition()

    unsetAlignmentClasses = () ->
        for alignmentClass in conf.classNames.alignment.length
            element.removeClass alignmentClass

    setAlignmentClass = (dir) ->
        unsetAlignmentClasses()
        dir = if dir then 1 else 0
        element.addClass conf.classNames.alignment[dir]

    updatePosX = () ->
        x = mouse.x - element.outerWidth() / 2
        if x < conf.offset
            x = conf.offset
        else if x + element.outerWidth() > win.width() - conf.offset
            x = win.width() - conf.offset - element.outerWidth()

        element.css 'left', x

    updatePosY = (dir) ->
        y = mouse.y
        dir = (dir) ? 1 : 0
        y = if dir is 0 then y -= element.outerHeight() + conf.offset else y += conf.offset
        element.css('top', y);
        if y < 0 or y + element.outerHeight() > win.height() then false

        true

    updatePosition = () ->
        if element.length isnt 0
            updatePosX()

            isAvailable = updatePosY alignment
            if isAvailable
                setAlignmentClass alignment
            else
                updatePosY !alignment
                setAlignmentClass !alignment

    onMouseMove = (evt) ->
        mouse = { x: evt.pageX, y: evt.pageY }
        updatePosition()

    bindMouseMove = () ->
        app.event.bind 'mousemove', '', onMouseMove

    init = () ->
        bindMouseMove();

    init()

    self.show = showTooltip
    self.hide = hideTooltip

    return self

, [ 'ui', 'tooltip' ], true