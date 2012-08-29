app.config.set () ->
	
    selectors = 
        validationForm: '[data-validates]'
        errorMessage: '.validation-error'

    return { selectors: selectors }

, [ 'form' ]
