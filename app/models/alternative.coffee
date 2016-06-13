'use strict';
module.exports = (sequelize, DataTypes) ->
  Alternative = sequelize.define 'Alternative', {
    description: DataTypes.STRING,
    achieved:
      type: DataTypes.BOOLEAN,
      default: false
    subgoals: DataTypes.INTEGER
    achSubgoals: DataTypes.INTEGER
  },
  classMethods:
    associate: (models) ->
        Alternative.belongsToMany models.Goal,
          as: 'Subgoals'
          through: 'GoalToAlternative',
        Alternative.belongsTo models.Goal
        return
  Alternative
