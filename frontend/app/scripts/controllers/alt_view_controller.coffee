'use strict'

angular.module 'goalmgr'

.controller 'viewAlterCtrl', ['altSvc','$routeParams',
  (altSvc,$routeParams) ->
    altctrl = this
    alter =
      description: ""
      goalId: 0

    this.getAlter = () ->
      altSvc.getById()
      .then (data) ->
        alter = data
      return

    this.addGoal = () ->
      # panel para seleccionar objetivo existente, y boton para crear nuevo
      return

    return
]
