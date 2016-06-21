express = require 'express'
app = express()
bodyparser = require 'body-parser'
http = require 'http'
models = require './models'

app.use bodyparser.json()

routes = require('./config/routes')(app)

app.set('port',3000)

# models.sequelize.sync() crea las tablas que no existen en la db
models.sequelize.sync()
  # logging: console.log
  # force: true
 # )
 .then () ->
  server = app.listen(app.get('port'), ->
    console.log 'Express server listening on port ' + server.address().port
    return
)

# http.createServer server  # no se si va esta linea
