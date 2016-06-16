'use strict'

angular.module 'goalmgr'

.controller 'addGoalCtrl', ['goalSvc','$location',
  (goalSvc,$location) ->
    goalctrl = this
    this.newgoal =
      name: ""
      priority: 0

    this.priorities = [
    	id:1
    	name:'high'
    ,
    	id:2
    	name:'regular'
    ,
    	id:3
    	name:'low'
   	]

    this.createGoal = () ->
      goalSvc.add(goalctrl.newgoal)
      .then (data)->
        $location.path 'editgoal'
        return
      return

    return
]
