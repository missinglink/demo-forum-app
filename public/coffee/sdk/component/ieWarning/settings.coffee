app.config.set () ->

    selectors =
        main: '.ie-warning'

    return {
        selectors: selectors
    }

, [ 'component', 'ieWarning' ]
