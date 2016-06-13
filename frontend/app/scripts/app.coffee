angular.module 'goalmgr', [ 'ngRoute','frontend-main','templates' ]

  .config ($routeProvider) ->
    $routeProvider
      .when '/goals',
        templateUrl: 'views/goalslist.html'
        controllerAs: 'goalsCtrl'
      .when '/alternatives',
        templateUrl: 'views/viewalternative.html'
        controllerAs: 'alterCtrl'
      .when '/goals/new',
        templateUrl: 'views/newgoal.html'
        controllerAs: 'addGoalCtrl'
      .when '/alternatives/new',
        templateUrl: 'views/newAlternative.html'
        controllerAs: 'addAlterCtrl'
      .otherwise
        redirectTo: '/goals'
    return

  .constant('API_SERVER','localhost:3000')
