router = require('express').Router()
models = require('../models/index')

# Return the list of top level goals (goals that are not subgoals of any goal)
router.get '/top', (req,res,next) ->
  models.Goal.findAll
    attributes: ['id', 'name', 'priority', 'createdAt', 'achieved']
    include: [
      model: models.Alternative
      as: 'Metagoals'
    ]
    where: [
      '"Metagoals.GoalToAlternative"."GoalId" is NULL'
    ]
  .then (top) ->
    res.json top

# returns all un-achieved goals
router.get '/pendant', (req,res,next) ->
    models.Goal.findAll
      attributes: ['id', 'name', 'priority', 'createdAt']
      where: [
        achieved: false
      ]
    .then (pendant) ->
      res.json pendant

# returns the last 10 achieved goals // maybe later I can change "limit" to be a parameter
router.get '/achieved', (req,res,next) ->
    models.Goal.findAll
      attributes: ['id', 'name', 'priority', 'createdAt']
      where: [
        achieved: true
      ]
      order: 'achdate DESC'
      limit: 10
    .then (achieved) ->
      res.json achieved

# returns a list of alternatives to which goal (id) serve as subgoal, along with their corresponding supergoals
router.get '/meta/:id', (req,res,next) ->
    models.Goal.find
      where: [
        id: req.params.id
      ]
    .then (goal) ->
      goal.getMetagoals
        include: [
          model: models.Goal
          as: 'Goal'
        ]
    .then (supergoals) ->
      res.json supergoals


# Return a goal with id:id
router.get '/:id', (req,res,next) ->
  models.Goal.find
    where: [
      id: req.params.id
    ]
  .then (goal) ->
    res.json goal

# Creates a new goal and [if subgoal] associates it with an alternative for upper level goal
router.post '/', (req,res,next) ->
  models.Goal.create
    name: req.body.name
    priority: req.body.priority
    achieved: false
    achdate: null
  .then (goal) ->
    res.json goal

# Updates a goal
router.put '/:id', (req,res,next) ->
  models.Goal.find
    where: [
      id: req.params.id
    ]
  .then (goal) ->
    if goal
      if req.body.achieved == true
        adate = new Date
      else
        adate = null
      goal.updateAttributes
        name: req.body.name
        priority: req.body.priority
        achieved: req.body.achieved
        achdate: adate
  .then (goal) ->
    res.json goal

# get subgoals (requirements) for a given alternative
router.get '/subgoals/:altid', (req, res, next) ->
  models.Goal.findAll
    attributes: ['id','name', 'priority', 'achieved']
    include:
      model: models.Alternative
      as: 'Metagoals'
      where:
        id: req.params.altid


module.exports = router
