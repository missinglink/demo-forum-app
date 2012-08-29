app.config.set () ->

    selectors =
        wrapper: '.tabs-section',
        labels: '.labels>li',
        tabs: '.content>li',
        active: '.active'

    classNames =
        active: 'active'

    return { selectors: selectors, classNames: classNames }

, [ 'ui', 'tabs', 'sections' ]
