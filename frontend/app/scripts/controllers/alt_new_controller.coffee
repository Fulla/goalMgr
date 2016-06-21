'use strict'

angular.module 'goalmgr'

.controller 'addAlterCtrl', ['altSvc','goalSvc','$location',
  (altSvc,goalSvc,$location) ->
    altctrl = this
    this.supergoal = goalSvc.getCurrent()
    this.selecpanel = false
    this.possiblesubgoals = []
    this.alter =
      description: ""
      goalId: altctrl.supergoal.id
      Subgoals: []

    this.addSubgoal = () ->
      # opens panel to select a subgoal
      altctrl.selecpanel = true
      return

    this.createAlter = () ->
      altSvc.add(alter)
      .then () ->
        console.log "success"
      return

    this.back = () ->
      $location.path 'goals/view'
      return

    # Goal selection panel
    # this.goalfilter = ""
    this.gridgoals =
      data: []
      enableFiltering: true

    this.getpossiblesubgoals = () ->
      altSvc.getPossibleSub(altctrl.supergoal.id)
      .then (data) ->
        console.log data
        altctrl.possiblesubgoals = data
        altctrl.gridgoals.data = data
        return
    # this.filtergoals = () ->
    #
    #   return

    altctrl.getpossiblesubgoals()

    this.closepanel = () ->
      altctrl.selecpanel = false
      return

    this.openpanel = () ->
      altctrl.selecpanel = true
      return

    return
]
