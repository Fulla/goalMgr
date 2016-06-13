module.exports = (app) ->
    goals = require '../controllers/goals.coffee'
    alternatives = require '../controllers/alternatives.coffee'

    app.use (req,res,next) ->
      res.header 'Access-Control-Allow-Origin', '*'
      next()

    app.get '/', (req,res,next) ->
      res.end 'Index'

    app.use '/goals', goals

    app.use '/alt', alternatives

    return
