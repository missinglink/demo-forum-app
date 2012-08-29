app.implement (trigger, target, classNames) ->
    self = {}
    toggle = null

    close = () ->
        if toggle.isOn() then toggle.toggle()

    onBodyClick = (e) ->
        realTarget = if e.toElement? then $ e.toElement else $ e.target
        if realTarget.closest(trigger.add target).length is 0 then close()

    bindBodyClick = () ->
        app.event.bind 'click', null, onBodyClick

    bindModalOpen = () ->
        app.event.on 'modal.open', () -> close()

    init = () ->
        setup()
        bindBodyClick()
        bindModalOpen()

    setup = () ->
        toggle = app.ui.classToggle.create trigger, target,
            trigger: classNames.trigger
            target: classNames.target

    init()

    return self;

, [ 'ui', 'dropdown', 'create' ], false
