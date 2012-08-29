app.implement (wrapper, conf, onChange) ->
    self = {}
    labels = wrapper.find(conf.selectors.labels)
    tabs = wrapper.find(conf.selectors.tabs)

    openTab = (tabId) ->
        labels.add(tabs).removeClass conf.classNames.active
        labels.eq(tabId).add(tabs.eq(tabId)).addClass conf.classNames.active
        onChange()

    getCurrent = () ->
        if labels.filter(conf.selectors.active).length isnt 0
            openTab labels.filter(conf.selectors.active).index()
        else
            openTab 0

    onLabelClick = (evt) ->
        openTab $(@).index()
        evt.preventDefault()

    bindLabelClick = () ->
        labels.on 'click', onLabelClick

    init = () ->
        getCurrent()
        bindLabelClick()

    init()

    return self;

, [ 'ui', 'tabs', 'create' ], false
