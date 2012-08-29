app.implement (form) ->
    self = {}
    conf = app.config.get 'form'

    getInputLabel = (input) ->
        return input.closest('form').find('label[for="' + input.attr('name') + '"]')

    resetError = (input) ->
        label = getInputLabel input
        label.find(conf.selectors.errorMessage).remove()

    displayError = (msg, input) ->
        label = getInputLabel input
        if label.find(conf.selectors.errorMessage).length isnt 0
            resetError input

        label.append app.template.render 'ui.validation.error', { message: msg }

    validateEmail = (string) ->
        lastAtPos = string.lastIndexOf('@')
        lastDotPos = string.lastIndexOf('.')

        return (lastAtPos < lastDotPos && lastAtPos > 0 && string.indexOf('@@') is -1 && lastDotPos > 2 && (string.length - lastDotPos) > 2)

    testRule = (input, rule, ruleVal) ->
        validates = true

        switch rule
            when 'minLength'
                if input.val().length < parseInt ruleVal, 10
                    validates = false
                    displayError "Must be at least #{ ruleVal } characters long", input
            when 'type'
                if ruleVal is 'email'
                    validates = validateEmail input.val()
                    displayError 'Needs to be a valid email address', input
            when 'matchField'
                if form.find "[name='#{ ruleVal }']".length
                    targetField = form.find "[name='#{ ruleVal }']"
                    if input.val() isnt targetField.val()
                        validates = false
                        displayError app.utils.string.capitalise(ruleVal) + ' confirmation doesn\'t match', input
            when 'required'
                if ruleVal is true or ruleVal is 'true' and input.val().length is 0
                    validates = false
                    displayError 'This field cannot be empty', input
                    
        return validates

    parseRules = (rulesString) ->
        rules = {}
        rulesArr = rulesString.split ','
        for curr in rulesArr
            curr = curr.split ':'
            rules[ app.utils.string.trimSpaces curr[0] ] = app.utils.string.trimSpaces curr[1]
        rules

    validateField = (input, rules) ->
        for rule, ruleVal of rules
            if testRule(input, rule, ruleVal) is false then return false

        resetError input
        return true

    validateForm = (form) ->
        validates = true
        form.find('input').each () ->
            if typeof $(@).attr('data-validate') isnt 'undefined'
                rules = parseRules($(@).attr 'data-validate')
                validates = validateField $(@), rules
        validates

    return validateForm form

, [ 'form', 'validate' ], false
