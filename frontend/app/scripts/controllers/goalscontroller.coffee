angular.module 'goalmgr'

.controller 'goalsCtrl', ['goalSvc','$location',
  (goalSvc,$location) ->
    goalctrl = this
    this.topgoals = []
    this.pendant = []
    this.lastachiev = []

    this.gettopgoals = () ->
      goalSvc.getTop()
      .then (
        (data) ->
          goalctrl.topgoals = data
        (data) ->
          console.log "Error al tratar de obtener los objetivos de alto nivel"
      )
      return

    this.getpendant = () ->
      goalSvc.getPendant()
      .then (
        (data) ->
          goalctrl.pendant = data
        (data) ->
          console.log "Error al tratar de obtener los objetivos pendientes"
      )
      return

    this.getlastachieved = () ->
      goalSvc.getLastAchieved()
      .then (
        (data) ->
          goalctrl.lastachiev = data
        (data) ->
          console.log "Error al tratar de obtener los últimos objetivos conseguidos"
      )
      return

    this.newGoal = () ->
      $location.path 'goals/new'
      return

    goalctrl.gettopgoals()
    goalctrl.getpendant()
    goalctrl.getlastachieved()

    this.viewDetails = (goalid) ->
      $location.path 'goals/'+goalid

    return
]

.controller 'addGoalCtrl', ['goalSvc','$location',
  (goalSvc,$location) ->
    goalsctrl = this
    this.newgoal =
      name: ""
      priority: 0
      achieved: false

    this.priorities = ['high', 'regular', 'low']

    this.createGoal = () ->
      goalSvc.add(goalctrl.newgoal)
      .then (data)->
        $location.path 'editgoal'
        return
      return

    return
]

.controller 'viewGoalCtrl', ['goalSvc','altSvc','$location','$routeParams'
  (goalSvc,altSvc,$location,$routeParams) ->
    goalctrl = this
    this.goal = null
    this.alternatives = []
    this.meta = []
    this.currgoal = $routeParams.goalid
    this.priorities = ['high', 'regular', 'low']

    this.getgoal = () ->
      goalScv.getById()
      .then (data) ->
        goal = data
        goalctrl.getalternatives()

    this.getalternatives = () ->
      altSvc.getForGoal(this.currgoal)
      .then (data) ->
        goalctrl.alternatives = data

    this.editgoal = () ->
      goalSvc.update(goalctrl.goal)
      .then (data)->
        return

    this.addAlternative = () ->
      $location.path 'alternatives/new'

    this.getmetagoals = () ->
      # retorna una lista de pares (metagoal, alternative), donde currgoal es subobjetivo de metagoal a traves de alternative
      goalSvc.getMeta()
      .then (data) ->
        goalctrl.meta = data

    return
]
