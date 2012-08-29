app.implement (max) ->

    return Math.round Math.random() * max

, [ 'utils', 'math', 'random' ], false



app.implement (num, count) ->
    numZeropad = num + ''

    while numZeropad.length < count
        numZeropad = "0" + numZeropad

    return numZeropad
, [ 'utils', 'math', 'zeroPad' ], false