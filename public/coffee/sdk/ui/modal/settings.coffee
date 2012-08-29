app.config.set () ->

    selectors =
        modal: '.modal'
        inner: '.inner'
        closeButton: 'a.close'

    return { selectors: selectors }

, [ 'ui', 'modal' ]