router = require('express').Router()

# Return the list of top level goals (goals that are not subgoals of any goal)
router.get '/top', (req,res,next) ->
  res.send "these are the top goals"

router.get '/pendant', (req,res,next) ->
  res.send "these are the pendant goals"

router.get '/achieved', (req,res,next) ->
  res.send "these are the last achieved goals"

# Return a goal with id:id
router.get '/:id', (req,res,next) ->
  res.send "this is the goal #{req.params.id}"

# Creates a new goal and [if subgoal] associates it with an alternative for upper level goal
router.post '/', (req,res,next) ->

module.exports = router
