'use strict';
module.exports = (sequelize, DataTypes) ->
  Alternative = sequelize.define 'Alternative', {
    description: DataTypes.STRING, # description of the alternative
    achieved:  # is it achieved?
      type: DataTypes.BOOLEAN,
      default: false
    # subgoals: DataTypes.INTEGER
    # achSubgoals: DataTypes.INTEGER
  },
  classMethods:
    associate: (models) ->
        Alternative.belongsToMany models.Goal,  # the subgoals (conditions) to achieve the supergoal through this alternative
          as: 'Subgoals'
          through: 'GoalToAlternative'
        Alternative.belongsTo models.Goal,  # the supergoal to which this is a solution option
          as: 'Goal'
        return
  Alternative
