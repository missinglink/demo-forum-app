$ () ->
	for id, template of templates
		template = new Hogan.Template template
		app.template.set id, template