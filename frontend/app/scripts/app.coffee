angular.module 'goalmgr', [ 'ngRoute','frontend-main','templates' ]

  .config ($routeProvider) ->
    $routeProvider
      .when '/goals',
        templateUrl: 'views/goalslist.html'
        controllerAs: 'goalsCtrl'
      .when '/goals/new',
        templateUrl: 'views/newgoal.html'
        controllerAs: 'addGoalCtrl'
      .when '/alternatives/new',
        templateUrl: 'views/newalternative.html'
        controllerAs: 'addAlterCtrl'
      .when '/alternatives/:altid',
        templateUrl: 'views/alternative.html'
        controllerAs: 'alterCtrl'
      .when '/goals/view',
        templateUrl: 'views/goal.html'
        controllerAs: 'viewGoalCtrl'
      .otherwise
        redirectTo: '/goals'
    return

  .constant('API_SERVER','localhost:3000')
