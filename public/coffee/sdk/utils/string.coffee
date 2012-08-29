app.implement (string) ->
    return string.charAt(0).toUpperCase() + string.slice 1

, [ 'utils', 'string', 'capitalise' ], false



app.implement (string) ->
    return string.replace(/^\s\s*/, '').replace /\s\s*$/, ''
    
, [ 'utils', 'string', 'trimSpaces' ], false



app.implement (string, limit, decorator) ->
    if string.length > limit then return string.substr(0, string.length - decorator.length) + decorator
    return string
    
, [ 'utils', 'string', 'truncate' ], false