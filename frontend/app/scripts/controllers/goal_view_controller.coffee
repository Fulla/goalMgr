'use strict'

angular.module 'goalmgr'

.controller 'viewGoalCtrl', ['goalSvc','altSvc','$location',
  (goalSvc,altSvc,$location) ->
    goalctrl = this
    this.goal = goalSvc.getCurrent()
    this.alternatives = []
    this.meta = []
    this.currgoal =
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

    # this.getgoal = () ->
    #   goalSvc.getById(goalctrl.goal.id)
    #   .then (data) ->
    #     goalctrl.goal = data
    #     goalctrl.getalternatives()
    #     goalctrl.getmetagoals()
    #     return
    #   return

    this.getalternatives = () ->
      altSvc.getForGoal(goalctrl.goal.id)
      .then (data) ->
        goalctrl.alternatives = data
        return
      return

    this.editgoal = () ->
      goalSvc.update(goalctrl.goal)
      .then (data)->
        return
      return

    # redirects to the creation of a new alternative for the solution of goal
    this.addAlternative = () ->
      goalSvc.setCurrent goalctrl.goal # stores the unsaved changes in the currentgoal object in the goalSvc
      $location.path 'alternatives/new'
      return

    # returns a list of pairs (supergoal, alternative), where <goal> is a subgoal of <supergoal> through <alternative>
    this.getsupergoal = () ->
      goalSvc.getMeta(goalctrl.goal.id)
      .then (data) ->
        goalctrl.meta = data
        return
      return

    goalctrl.getalternatives()
    goalctrl.getsupergoals()

    this.back = () ->
      $location.path 'goals/'
      return

    this.gotogoal = (goalid) ->
      goalSvc.getById(goalid)
      .then (data) ->
        $location.path 'goals/view'
        return
      return
      

    this.gotoalt = (altid) ->
      $location.path 'alternatives/'+altid
      return

    return
]
