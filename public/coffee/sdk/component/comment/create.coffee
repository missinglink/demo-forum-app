app.implement () ->
    self = {}
    conf = app.config.get 'component.comment'

    onAddComment = (data) ->
        $('[data-role="comments-stack"][data-post-id="' + data['post-id'] + '"]').prepend app.template.render('components.comment', data)

    showForm = (e) ->
        postId = $(@).attr 'data-post-id'
        $(conf.selectors.commentForm).filter("[data-post-id='#{postId}']").show()
        e.preventDefault()

    hideForm = (e) ->
        postId = $(@).attr 'data-post-id'
        $(conf.selectors.commentForm).filter("[data-post-id='#{postId}']").hide()
        e.preventDefault()

    self.onAdd = onAddComment
    self.showForm = showForm
    self.hideForm = hideForm

    return self

, [ 'component', 'comment' ], true