app.declare = (target, root, nsArr, exec) ->
    curr = root
    checked = [root]

    for ns, i in nsArr
        if i + 1 is nsArr.length
            if typeof curr[ns] is 'undefined'
                curr[ns] = if exec then target() else target
                return;
            else
                throw 'Namespace duplicated: ' + nsArr.join('.')

        if typeof curr[ns] is 'undefined' then curr[ns] = {}
        curr = curr[ns]



app.declare (func, nsArr, exec) ->
    app.declare func, app, nsArr, exec
, app, [ 'implement' ], false



app.declare (root, nsArr) ->
    curr = root
    checked = [root]

    for ns, i in nsArr

        if i + 1 is nsArr.length
            if curr[ns]?
                return curr[ns];
            else
                throw 'Namespace fetch failed: ' + nsArr.join('.')

        if typeof curr[ns] is 'undefined'
            throw 'Namespace fetch failed: ' + nsArr.join('.')

        curr = curr[ns]

, app, [ 'utils', 'namespace', 'fetch' ], false
