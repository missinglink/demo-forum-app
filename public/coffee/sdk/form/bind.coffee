$ () ->
    conf = app.config.get 'form'

    execFormAction = (form) ->
        action = app.form.action.get form
        if typeof action is 'function'
            app.form.action.perform form
            return true
        return false

    bindFormActions = (form) ->
        app.event.bind 'submit', 'form', (evt) ->
            form = $(@)

            if form.is conf.selectors.validationForm
                validates = app.form.validate form

                if validates is false then return false

            return !execFormAction form

    bindFormActions()