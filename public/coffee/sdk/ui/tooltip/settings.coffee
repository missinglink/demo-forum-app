app.config.set () ->
    
    classNames =
        alignment: [ 'align-top', 'align-bottom' ]

    selectors = 
        tooltip: '.tooltip'

    return {
        classNames: classNames
        selectors: selectors
        defaultAlignment: 1
        offset: 20
        attribute: 'data-tooltip'
    }

, [ 'ui', 'tooltip' ]
