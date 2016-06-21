router = require('express').Router()
models = require('../models/index')
Promise = require('bluebird')

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
        model: models.Goal
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
  .then (rel) ->
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

router.get '/possiblesub/:goalid', (req, res, next) ->
  possiblesub = []
  supertree = []
  getSuperTree(parseInt req.params.goalid)
  .then (supert) ->
    supertree = supert

    models.Goal.findAll
      attributes: ['id','name']
      raw: true
    .then (allgoals) ->
      Promise.map allgoals, (goal) ->
        getSubTree(goal.id)
        .then (subtree) ->
          if joinableTrees supertree, subtree
            console.log goal
            possiblesub.push goal
      .then () ->
        console.log 'los subobjetivos disponibles son: '
        console.log possiblesub
        res.send possiblesub


module.exports = router

########################
## auxiliar functions ##
########################

# for a given goalid, returns the list of goals that (recursively) are up in the dependency chain.
getSuperTree = (goalid) ->
    treeList = []
    # bucle = (meta) ->
    #   new Promise () ->
    #     for m in meta
    #       getSuperTree(m.GoalId)
    #       treeList.push m.GoalId
    bucle = (gid) ->
      models.Alternative.findAll
        attributes: ['id', 'GoalId']
        include: [
          model: models.Goal
          as: 'Subgoals'
          where: [
            id: goalid
          ]
        ]
      .then (meta) ->
        for m in meta
          if m != undefined
            bucle(m.GoalId)
        treeList.push gid
        return
    bucle(goalid)
    .then () ->
      console.log treeList
      treeList

# for a given goalid, returns the list of goals that (recursively) are down in the dependency chain
getSubTree = (goalid) ->
    treeList = []
    # bucle = (meta) ->
    #   new Promise () ->
    #     for m in meta
    #       getSuperTree(m.GoalId)
    #       treeList.push m.GoalId
    bucle = (gid) ->
      models.Alternative.findAll
        # attributes: ['id', 'GoalId']
        include: [
          required: true
          model: models.Goal
          as: 'Subgoals'
        ]
        where: [
          GoalId: gid
        ]
      .then (sub) ->
        for sAlt in sub
          if sAlt != undefined
              for sGoal in sAlt.Subgoals
                if sGoal != undefined
                  bucle(sGoal.id)
        treeList.push gid
        return
    bucle(goalid)
    .then () ->
      console.log treeList
      treeList


joinableTrees = (suplist, sublist) ->
  for sup in suplist
    for sub in sublist
      if sup == sub
        return false
  return true
