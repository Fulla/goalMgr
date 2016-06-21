'use strict'

module.exports = (sequelize, DataTypes) ->
    Goal = sequelize.define 'Goal', {
      name: DataTypes.STRING,  # the description of the goal
      priority: DataTypes.INTEGER, # priority: {high, regular, low}
      achieved: DataTypes.BOOLEAN, # is it achieved?
      achdate: DataTypes.DATE,  # when it was achieved
      achobserv: DataTypes.STRING  # observations about the achievement conditions
      },
      classMethods:
        associate: (models) ->
          Goal.belongsToMany models.Alternative,  # the alternatives to which this goal serves as subgoal
            as: 'Metagoals'
            through: 'GoalToAlternative'
          Goal.hasMany models.Alternative,  # the alternative options to solve this goal
            as: 'Options'
          return
    Goal
