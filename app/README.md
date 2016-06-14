# GOAL MANAGER

* A "goal" may have "alternative" solutions
* An "alternative" is composed by one or more sub"goals"
* A "goal" may act as subgoal in 0 or more alternatives (hence the goal-alternative relation)

* Achievement conditions:
  - A goal is completed if (at least) an alternative is completed
  - An alternative is completed if all the subgoals are completed

goal = 
	{ 
	  name,
	  description,
	  achieved (boolean),
	  from_alternative (null for top level goals)
	}
	
alternative = 
	{
	  description,
	  goalId (foreignKey),
	  subgoals (num of subgoals),
	  achSubgoals (num of achieved subgoals)
	}

goal-alternative =
	{
	  goalId,
	  alternativeId
	}

## Features

* No cycles allowed: When a goal is selected as a subgoal for an alternative of a goal, there must be checked if the same goal is not a higher level goal in the same chain.
* Dynamic completion check: When all subgoals from an alternative are completed, the alternative also is put as completed, and thus also the upper level goal is. The state is propagate upwards.

## Issues

* There's no consistency checks. If a goal "a" -that is the opposite of another goal "b"- is achieved, the goal "b" should be (but it isn't) deactivated. In the current approach, consistency is user's matter.
