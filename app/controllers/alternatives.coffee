router = require('express').Router()
models = require('../models/index')

# Returns all alternatives for a given goal
router.get '/bygoal/:goalid', (req,res,next) ->
  models.Goal.find
    where: [
      id: req.params.goalid
    ]
  .then (goal) ->
    goal.getOptions()
  .then (alternatives) ->
    res.json alternatives


# create new alternative for a given goal
# option 1 (setting association by instance)
  # router.post '/:goalid', (req,res,next) ->
  #   models.Goal.find
  #     where: [
  #       id: req.params.goalid
  #     ]
  #   .then (goal) ->
  #     models.Alternative.create
  #       description: req.body.description
  #       Goal: goal
  #       Subgoals: req.body.Subgoals
  #      ,
  #       include: [
  #         model: Goal
  #         as: 'Subgoals'
  #        ,
  #         model: Goal
  #         as: 'Goal'
  #       ]
  #   .then (alt) ->
  #     res.json alt
# option 2 (setting association by id)
  router.post '/:goalid', (req,res,next) ->
    models.Alternative.create
      description: req.body.description
      GoalId: req.params.goalid
      Subgoals: req.body.Subgoals
     ,
      include: [
        model: Goal
        as: 'Subgoals'
      ]
    .then (alt) ->
      res.json alt

# adds an existing goal as subgoal for an existing alternative // Later I need to add checks to see if the (altid,goalid) pair already is an association
router.post '/:altid/:goalid', (req, res, next) ->
  # by directly creating a registry in relational table
  models.GoalToAlternative.create
    GoalId: req.params.goalid
    AlternativeId: req.params.altid
  .then (rel)
    res.send 'success'

# removes goal as subgoal of alternative (does not delete goal)
router.delete '/:altid/:goalid', (req, res, next) ->
  models.GoalToAlternative.destroy
    where: [
      GoalId: req.params.goalid
      AlternativeId: req.params.altid
    ]
  .then () ->
    res.send 'success'


# returns true if the alternative is achieved (all subgoals are achieved)
router.get '/ach/:id', (req,res,next) ->
  achieved = true
  #
  achieved

module.exports = router
