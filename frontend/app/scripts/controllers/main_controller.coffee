angular.module 'frontend-main',['ngRoute']

  .config ($routeProvider) ->
    $routeProvider
      .when '/main',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'

  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma',
      'Coffeescript',
      'Less',
      'Jade'
    ]
