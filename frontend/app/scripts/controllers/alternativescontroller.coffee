angular.module 'goalmgr'

.controller 'alterCtrl', ['altSvc',
  (altSvc) ->

]


.controller 'newAlterCtrl', ['altSvc',
  (altSvc) ->
    newalt = this
    alter =
      description: ""
      goalId: goalId

    this.addGoal = () ->
      # panel para seleccionar objetivo existente, y boton para crear nuevo

    this.createAlter = () ->
      altSvc.add(alter)
      .then () ->
        console.log "success"

]


.controller 'viewAlterCtrl', ['altSvc',
  (altSvc) ->
    alt = this
    alter =
      description: ""
      goalId: 0

    this.getAlter = () ->
      altSvc.getById()
      .then (data) ->
        alter = data

    this.addGoal = () ->
      # panel para seleccionar objetivo existente, y boton para crear nuevo



]
