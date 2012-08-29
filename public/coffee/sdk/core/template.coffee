app.implement () ->
    self = {}
    templates = {}

    setTemplate = (ns, template) ->
        app.declare template, templates, ns.replace(/\//g, '.').split('.'), false

    setTemplates = (templates) ->
        for template in templates
            setTemplate template.ns, template.markup

    getTemplate = (nsString) ->
        return app.utils.namespace.fetch templates, nsString.split('.')

    renderTemplate = (templateNs, data) ->
        template = getTemplate(templateNs)
        if template instanceof Hogan.Template is false then template = Hogan.compile template
        return template.render(data)

    renderString = (str, data) ->
        return Hogan.compile(str).render data

    getTemplates = () -> templates

    self.set = setTemplate
    self.get = getTemplate
    self.render = renderTemplate
    self.renderString = renderString
    self.getAll = getTemplates

    return self
, [ 'template' ], true