app.config.set () ->

    selectors =
        commentForm: '.comment-form'

    return {
        selectors: selectors
    }

, [ 'component', 'comment' ]
