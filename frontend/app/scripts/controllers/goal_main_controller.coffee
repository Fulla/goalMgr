'use strict'

angular.module 'goalmgr'

.controller 'goalsCtrl', ['goalSvc','$location',
  (goalSvc,$location) ->
    goalctrl = this
    this.topgoals = []
    this.pendant = []
    this.lastachiev = []

    this.gettopgoals = () ->
      goalSvc.getTop()
      .then (data) ->
          		goalctrl.topgoals = data
           ,
            (data) ->
              console.log "Error al tratar de obtener los objetivos de alto nivel"
      return

    this.getpendant = () ->
      goalSvc.getPendant()
      .then (data) ->
              goalctrl.pendant = data
           ,
            (data) ->
              console.log "Error al tratar de obtener los objetivos pendientes"
      return

    this.getlastachieved = () ->
      goalSvc.getLastAchieved()
      .then (data) ->
              goalctrl.lastachiev = data
           ,
            (data) ->
              console.log "Error al tratar de obtener los últimos objetivos conseguidos"
      return

    this.newGoal = () ->
      $location.path 'goals/new'
      return

    goalctrl.gettopgoals()
    goalctrl.getpendant()
    goalctrl.getlastachieved()

    this.viewDetails = (goalid) ->
      console.log goalid
      goalSvc.getById(goalid)
      .then (data) ->

        goalSvc.setCurrent data
        $location.path 'goals/view'
        return
      return

    return
]
