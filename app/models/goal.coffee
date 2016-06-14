'use strict'

module.exports = (sequelize, DataTypes) ->
    Goal = sequelize.define 'Goal', {
      name: DataTypes.STRING,
      priority: DataTypes.INTEGER,
      achieved: DataTypes.BOOLEAN,
      achdate: DataTypes.DATE,
      achobserv: DataTypes.STRING
      },
      classMethods:
        associate: (models) ->
          Goal.belongsToMany models.Alternative,
            as: 'Metagoals',
            through: 'GoalToAlternative'
          Goal.hasMany models.Alternative
          return
    Goal
