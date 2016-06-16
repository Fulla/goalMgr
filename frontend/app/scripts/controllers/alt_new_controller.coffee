'use strict'

angular.module 'goalmgr'

.controller 'addAlterCtrl', ['altSvc','goalSvc','$location',
  (altSvc,goalSvc,$location) ->
    altctrl = this
    this.supergoal = goalSvc.getCurrent()
    this.alter =
      description: ""
      goalId: null
      Subgoals: []

    console.log altctrl.supergoal

    this.addSubgoal = () ->
      # opens panel to select a subgoal
      return

    this.createAlter = () ->
      altSvc.add(alter)
      .then () ->
        console.log "success"
      return

    this.back = () ->
      $location.path 'goals/view'
      return

    return
]
