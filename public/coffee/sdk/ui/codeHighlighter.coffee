app.implement () ->
	self = {}

	makeLineNumbers = () ->
		target = $ @
		content = target.find('code').html()
		lines = content.split '\n'
		numbers = []
		for i in [1..lines.length]
			numbers.push label: app.utils.math.zeroPad i, 1
		target.after(app.template.render 'ui.code-highlighter', numbers: numbers, content: content).remove()
		
	init = () ->
		hljs.tabReplace = '	'
		hljs.initHighlightingOnLoad()
		$('pre').each makeLineNumbers

	$ init

	return self;

, [ 'ui', 'codeHighlighter', 'initialise' ], true