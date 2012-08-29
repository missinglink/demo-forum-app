$ () ->
    conf = app.config.get 'component.comment'

    app.action.set (data, form) ->
    	form.trigger 'reset'
    	app.socket.emit 'comment.add', data, (err) -> if err? then app.ui.alert err, type: 'error'
    , 'component.comment.add', null

    app.action.set app.component.comment.showForm, 'component.comment.showForm', 'click'
    app.action.set app.component.comment.hideForm, 'component.comment.hideForm', 'click'

    app.socket.on 'comment.add', (data) -> app.component.comment.onAdd data