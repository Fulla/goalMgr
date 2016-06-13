angular.module 'goalmgr'

.controller 'goalsCtrl', ['goalSvc','$location',
  (goalSvc,$location) ->
    goals = this
    this.topgoals = []
    this.pendant = []
    this.lastachiev = []

    this.gettopgoals = () ->
      goalSvc.getTop()
      .then (
        (data) ->
          goals.topgoals = data
        (data) ->
          console.log "Error al tratar de obtener los objetivos de alto nivel"
      )
      return

    this.getpendant = () ->
      goalSvc.getPendant()
      .then (
        (data) ->
          goals.pendant = data
        (data) ->
          console.log "Error al tratar de obtener los objetivos pendientes"
      )
      return

    this.getlastachieved = () ->
      goalSvc.getLastAchieved()
      .then (
        (data) ->
          goals.lastachiev = data
        (data) ->
          console.log "Error al tratar de obtener los últimos objetivos conseguidos"
      )
      return

    this.newGoal = () ->
      $location.path 'goals/new'
      return

    goals.gettopgoals()
    goals.getpendant()
    goals.getlastachieved()

    return
]

.controller 'addGoalCtrl', ['goalSvc','$location',
  (goalSvc,$location) ->
    addgoal = this
    this.newgoal =
      name: ""
      priority: 0
      achieved: false

    this.priorities = ['alta', 'media', 'baja']

    this.createGoal = () ->
      goalSvc.add(addgoal.newgoal)
      .then (data)->

        $location.path 'editgoal'

]

.controller 'viewGoalCtrl', ['goalSvc','altSvc','$location',
  (goalSvc,altSvc,$location) ->
    goal = this
    this.currgoal = null
    this.alternatives = []
    this.meta = []

    this.getgoal = () ->
      goalScv.getById()
      .then (data) ->
        currgoal = data
        goal.getalternatives()

    this.getalternatives = () ->
      altSvc.getForGoal(this.currgoal.id)
      .then (data) ->
        goal.alternatives = data

    this.editgoal = () ->
      goalSvc.update(goal.currgoal)
      .then (data)->
        return

    this.addAlternative = () ->
      $location.path 'alternatives/new'

    this.getmetagoals = () ->
      # retorna una lista de pares (metagoal, alternative), donde currgoal es subobjetivo de metagoal a traves de alternative
      goalSvc.getMeta()
      .then (data) ->
        goal.meta = data

]
