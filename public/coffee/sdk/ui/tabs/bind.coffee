$ () ->
    conf = app.config.get 'ui.tabs.sections'

    $(conf.selectors.wrapper).each () ->
        onChange = if $(@).hasClass('content-tabs') then app.ui.tile.refresh else () ->
        app.ui.tabs.create $(@), conf, onChange