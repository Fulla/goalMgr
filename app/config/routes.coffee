module.exports = (app) ->
    goals = require '../controllers/goals.coffee'
    alternatives = require '../controllers/alternatives.coffee'

    app.use (req,res,next) ->
      res.header 'Access-Control-Allow-Origin', '*'
      res.header 'Access-Control-Allow-Methods', 'GET, HEAD, POST, PUT, OPTIONS'
      res.header 'Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With'
      next()

    app.get '/', (req,res,next) ->
      res.end 'Index'

    app.use '/goals', goals

    app.use '/alt', alternatives

    return
