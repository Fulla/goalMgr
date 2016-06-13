angular.module('goalmgr', ['ngRoute', 'frontend-main', 'templates']).config(function($routeProvider) {
  $routeProvider.when('/goals', {
    templateUrl: 'views/goalslist.html',
    controllerAs: 'goalsCtrl'
  }).when('/alternatives', {
    templateUrl: 'views/viewalternative.html',
    controllerAs: 'alterCtrl'
  }).when('/goals/new', {
    templateUrl: 'views/newgoal.html',
    controllerAs: 'addGoalCtrl'
  }).when('/alternatives/new', {
    templateUrl: 'views/newAlternative.html',
    controllerAs: 'addAlterCtrl'
  }).otherwise({
    redirectTo: '/goals'
  });
}).constant('API_SERVER', 'localhost:3000');

angular.module('goalmgr').controller('alterCtrl', ['altSvc', function(altSvc) {}]).controller('newAlterCtrl', [
  'altSvc', function(altSvc) {
    var alter, newalt;
    newalt = this;
    alter = {
      description: "",
      goalId: goalId
    };
    this.addGoal = function() {};
    return this.createAlter = function() {
      return altSvc.add(alter).then(function() {
        return console.log("success");
      });
    };
  }
]).controller('viewAlterCtrl', [
  'altSvc', function(altSvc) {
    var alt, alter;
    alt = this;
    alter = {
      description: "",
      goalId: 0
    };
    this.getAlter = function() {
      return altSvc.getById().then(function(data) {
        return alter = data;
      });
    };
    return this.addGoal = function() {};
  }
]);

'app controller goes here';


angular.module('goalmgr').controller('goalsCtrl', [
  'goalSvc', '$location', function(goalSvc, $location) {
    var goals;
    goals = this;
    this.topgoals = [];
    this.pendant = [];
    this.lastachiev = [];
    this.gettopgoals = function() {
      goalSvc.getTop().then((function(data) {
        return goals.topgoals = data;
      }, function(data) {
        return console.log("Error al tratar de obtener los objetivos de alto nivel");
      }));
    };
    this.getpendant = function() {
      goalSvc.getPendant().then((function(data) {
        return goals.pendant = data;
      }, function(data) {
        return console.log("Error al tratar de obtener los objetivos pendientes");
      }));
    };
    this.getlastachieved = function() {
      goalSvc.getLastAchieved().then((function(data) {
        return goals.lastachiev = data;
      }, function(data) {
        return console.log("Error al tratar de obtener los últimos objetivos conseguidos");
      }));
    };
    this.newGoal = function() {
      $location.path('goals/new');
    };
    goals.gettopgoals();
    goals.getpendant();
    goals.getlastachieved();
  }
]).controller('addGoalCtrl', [
  'goalSvc', '$location', function(goalSvc, $location) {
    var addgoal;
    addgoal = this;
    this.newgoal = {
      name: "",
      priority: 0,
      achieved: false
    };
    this.priorities = ['alta', 'media', 'baja'];
    return this.createGoal = function() {
      return goalSvc.add(addgoal.newgoal).then(function(data) {
        return $location.path('editgoal');
      });
    };
  }
]).controller('viewGoalCtrl', [
  'goalSvc', 'altSvc', '$location', function(goalSvc, altSvc, $location) {
    var goal;
    goal = this;
    this.currgoal = null;
    this.alternatives = [];
    this.meta = [];
    this.getgoal = function() {
      return goalScv.getById().then(function(data) {
        var currgoal;
        currgoal = data;
        return goal.getalternatives();
      });
    };
    this.getalternatives = function() {
      return altSvc.getForGoal(this.currgoal.id).then(function(data) {
        return goal.alternatives = data;
      });
    };
    this.editgoal = function() {
      return goalSvc.update(goal.currgoal).then(function(data) {});
    };
    this.addAlternative = function() {
      return $location.path('alternatives/new');
    };
    return this.getmetagoals = function() {
      return goalSvc.getMeta().then(function(data) {
        return goal.meta = data;
      });
    };
  }
]);

angular.module('frontend-main', ['ngRoute']).config(function($routeProvider) {
  return $routeProvider.when('/main', {
    templateUrl: 'views/main.html',
    controller: 'MainCtrl'
  });
}).controller('MainCtrl', function($scope) {
  return $scope.awesomeThings = ['HTML5 Boilerplate', 'AngularJS', 'Karma', 'Coffeescript', 'Less', 'Jade'];
});

'use strict';
angular.module('goalmgr').service('altSvc', [
  '$q', '$http', 'API_SERVER', function($q, $http, API_SERVER) {
    var genericReq, goalSvc;
    goalSvc = this;
    genericReq = function(httpRequest) {
      var deferred;
      deferred = $q.defer();
      $http(httpRequest).success(function(data, status, headers, config) {
        return deferred.resolve(data);
      }).error(function(data, status, headers, config) {
        return deferred.reject(status);
      });
      return deferred.promise;
    };
    return {
      getForGoal: function(goalid) {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/alt/bygoal/' + goalid
        };
        return genericReq(httpReq);
      },
      getById: function(id) {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/alt/' + id
        };
        return genericReq(httpReq);
      },
      add: function(alt, goalid) {
        var httpReq;
        httpReq = {
          method: 'POST',
          url: 'http://' + API_SERVER + '/alt/' + goalid,
          data: alt
        };
        return genericReq(httpReq);
      },
      remove: function(id) {
        var httpReq;
        httpReq = {
          method: 'DELETE',
          url: 'http://' + API_SERVER + '/alt/' + id
        };
        return genericReq(httpReq);
      }
    };
  }
]);

'use strict';
angular.module('goalmgr').service('goalSvc', [
  '$q', '$http', 'API_SERVER', function($q, $http, API_SERVER) {
    var genericReq, goalSvc;
    goalSvc = this;
    genericReq = function(httpRequest) {
      var deferred;
      deferred = $q.defer();
      $http(httpRequest).success(function(data, status, headers, config) {
        return deferred.resolve(data);
      }).error(function(data, status, headers, config) {
        return deferred.reject(status);
      });
      return deferred.promise;
    };
    return {
      getAll: function() {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/goals'
        };
        return genericReq(httpReq);
      },
      getTop: function() {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/goals/top'
        };
        return genericReq(httpReq);
      },
      getPendant: function() {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/goals/pendant'
        };
        return genericReq(httpReq);
      },
      getLastAchieved: function() {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/goals/achieved'
        };
        return genericReq(httpReq);
      },
      getById: function(id) {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/goals/' + id
        };
        return genericReq(httpReq);
      },
      add: function(goal) {
        var httpReq;
        httpReq = {
          method: 'POST',
          url: 'http://' + API_SERVER + '/goals',
          data: goal
        };
        return genericReq(httpReq);
      },
      remove: function(id) {
        var httpReq;
        httpReq = {
          method: 'DELETE',
          url: 'http://' + API_SERVER + '/goals/' + id
        };
        return genericReq(httpReq);
      }
    };
  }
]);
