_ = require 'underscore'

exports.decorate = (decorator,f) ->
    (args...) -> decorator.apply @, [f, args]




exports.MakeThrottle = (options={}) ->
    options.lasttime = 1
    options.wait = 100
    options.queue = []
        
    (f,args) ->
        console.log 'my f is',f
        # slowly pops the queue
        sink = ->
            args = options.queue.shift()
            f.apply @, args
            if options.queue.length then setTimeout sink, options.wait
            else options.lasttime = new Date().getTime()

        # do we need to wait in a queue? 
        if options.queue.length then return options.queue.push args

        # can we execute right away?
        if (diff = new Date().getTime() - options.lasttime) > options.wait
            f.apply @, args
            options.lasttime = new Date().getTime()
        else
            if not options.queue.length then setTimeout sink, diff
            options.queue.push args

