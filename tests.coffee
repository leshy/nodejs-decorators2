helpers = require 'helpers'
d = require './index'

exports.nohammer = (test) ->
    cnt = 0

    hammerme = (arg) ->
        cnt += arg

    hammermed = d.decorate d.makeNoHammer({waittime: 50}), hammerme

    hammermed(1)
    hammermed(1)
    hammermed(1)
    hammermed(3)

    helpers.wait 75, ->
        hammermed(1)
        test.equals cnt, 5
        test.done()