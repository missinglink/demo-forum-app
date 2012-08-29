app.implement (trigger, target, classNames) ->

    toggle = (e) ->
        if classNames.trigger? then trigger.toggleClass classNames.trigger
        if classNames.target? then target.toggleClass classNames.target
        if e? then e.preventDefault()

    bindToggleClick = () ->
        trigger.on 'click', toggle

    isOn = () ->
        trigger.hasClass classNames.trigger

    init = () ->
        bindToggleClick()

    init()

    self.toggle = toggle
    self.isOn = isOn

    return self

, [ 'ui', 'classToggle', 'create' ], false
