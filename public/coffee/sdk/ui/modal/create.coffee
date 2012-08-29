app.implement (content) ->
    self = {}
    conf = app.config.get 'ui.modal'
    isOpen = false
    element = []
    inner = []
    closeButton = []

    updatePosition = () ->
        screenW = $(window).width()
        screenH = $(window).height()
        inner.css
            position: 'absolute'
            left: screenW / 2 - inner.outerWidth() / 2
            top: screenH / 2 - inner.outerHeight() / 2

    openModal = (content, settings) ->
        settings.content = content
        if isOpen is false
            element = $(app.template.render('ui.modal', settings)).appendTo 'body'
            inner = element.find conf.selectors.inner
            closeButton = element.find conf.selectors.closeButton
            updatePosition()
            bindLoad()
            bindClick()
            bindResize()
            $('body').css 'overflow', 'hidden'
            isOpen = true
            app.event.trigger 'modal.open', self
        else
            throw 'ui.modal.open bubbled'

    closeModal = () ->
        if isOpen
            element.remove()
            $('body').css 'overflow', 'auto'
            isOpen = false
            app.event.trigger 'modal.close', self
        else
            throw 'ui.modal.close called with no open modal'

    refreshModal = () ->
        updatePosition()

    onClick = (evt) ->
        if $(evt.target).closest(inner).length is 0 and evt.target isnt inner
            closeModal()

    bindResize = () ->
        $(window).on 'resize', refreshModal

    bindClick = () ->
        element.on 'click', onClick
        closeButton.on 'click', closeModal

    bindLoad = () ->
        $(window).on 'load', refreshModal

    bindKeyPress = () ->
        app.event.bind 'keydown', null, (evt) ->
            if evt.keyCode is 27 && isOpen is true # ESC
                closeModal()

    init = () ->
        bindKeyPress()

    init()

    self.open = openModal
    self.close = closeModal
    self.refresh = refreshModal

    return self

, [ 'ui', 'modal' ], true
