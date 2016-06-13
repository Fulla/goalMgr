router = require('express').Router()

# Returns all alternatives for a given goal
router.get '/bygoal/:goalid', (req,res,next) ->

# create new alternative for a given goal
router.post '/:goalid', (req,res,next) ->
  return

# returns true if the alternative is achieved (all subgoals are achieved)
router.get '/ach/:id', (req,res,next) ->
  achieved = true
  #
  achieved

module.exports = router
