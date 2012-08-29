app.config.set () ->

    settings =
        margin:10
        duration: 4000

    selectors =
        alert: '.component.alert'

    return {
        settings: settings
        selectors: selectors
    }

, [ 'ui', 'alert' ]
