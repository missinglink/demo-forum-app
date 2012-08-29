app.config.set () ->

    keycodes =
        enter: 13
        backspace: 8
        tab: 9
        shift: 16
        control: 17
        alt: 18
        arrow:
            left: 37
            up: 38
            right: 39
            down: 40
        del: 46
        escape: 27
        space: 32
        letters:
            v: [ 86, 118 ]

    return keycodes

, [ 'constants', 'keycodes' ]



app.config.set () ->

    return {
        keycodes: app.config.get 'constants.keycodes'
    }

, [ 'constants', 'all' ]