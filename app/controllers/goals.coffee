router = require('express').Router()
models = require('../models/index')

# Return the list of top level goals (goals that are not subgoals of any goal)
router.get '/top', (req,res,next) ->
  models.Goal.findAll
    atributes: ['id', 'name', 'createdAt']
    include: [
      model: models.Alternative
      as: 'Metagoals'
    ]
    where: [
      '"Metagoals.GoalToAlternative"."GoalId" is NULL'
    ]
  .then (top) ->
    res.json top

router.get '/pendant', (req,res,next) ->
    models.Goal.findAll
      atributes: ['id', 'name', 'createdAt']
      where: [
        achieved: false
      ]
    .then (pendant) ->
      res.json pendant

router.get '/achieved', (req,res,next) ->
    models.Goal.findAll
      atributes: ['id', 'name', 'createdAt']
      where: [
        achieved: true
      ]
      order: 'achdate DESC'
      limit: 10
    .then (achieved) ->
      res.json achieved

router.get '/meta', (req,res,next) ->
    res.send()


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
      console.log goal
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



module.exports = router
