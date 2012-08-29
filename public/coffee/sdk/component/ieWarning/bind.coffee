$ () ->
    conf = app.config.get 'component.ieWarning'

    elements = $(conf.selectors.main)

    elements.each () ->
    	element = $ @
    	trigger = $(@).find('[data-role="close"]')
    	app.ui.classToggle.create trigger, element, { trigger: null, target: 'hidden' }