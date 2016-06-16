angular.module('goalmgr', ['ngRoute', 'frontend-main', 'templates']).config(function($routeProvider) {
  $routeProvider.when('/goals', {
    templateUrl: 'views/goalslist.html',
    controllerAs: 'goalsCtrl'
  }).when('/goals/new', {
    templateUrl: 'views/newgoal.html',
    controllerAs: 'addGoalCtrl'
  }).when('/alternatives/new', {
    templateUrl: 'views/newalternative.html',
    controllerAs: 'addAlterCtrl'
  }).when('/alternatives/:altid', {
    templateUrl: 'views/alternative.html',
    controllerAs: 'alterCtrl'
  }).when('/goals/view', {
    templateUrl: 'views/goal.html',
    controllerAs: 'viewGoalCtrl'
  }).otherwise({
    redirectTo: '/goals'
  });
}).constant('API_SERVER', 'localhost:3000');

'use strict';
angular.module('goalmgr').controller('alterCtrl', [
  'altSvc', 'goalSvc', function(altSvc, goalSvc) {
    var altctrl;
    altctrl = this;
  }
]);

'use strict';
angular.module('goalmgr').controller('addAlterCtrl', [
  'altSvc', 'goalSvc', '$location', function(altSvc, goalSvc, $location) {
    var altctrl;
    altctrl = this;
    this.supergoal = goalSvc.getCurrent();
    this.alter = {
      description: "",
      goalId: null,
      Subgoals: []
    };
    console.log(altctrl.supergoal);
    this.addSubgoal = function() {};
    this.createAlter = function() {
      altSvc.add(alter).then(function() {
        return console.log("success");
      });
    };
    this.back = function() {
      $location.path('goals/view');
    };
  }
]);

'use strict';
angular.module('goalmgr').controller('viewAlterCtrl', [
  'altSvc', '$routeParams', function(altSvc, $routeParams) {
    var altctrl, alter;
    altctrl = this;
    alter = {
      description: "",
      goalId: 0
    };
    this.getAlter = function() {
      altSvc.getById().then(function(data) {
        return alter = data;
      });
    };
    this.addGoal = function() {};
  }
]);

'app controller goes here';


'use strict';
angular.module('goalmgr').controller('goalsCtrl', [
  'goalSvc', '$location', function(goalSvc, $location) {
    var goalctrl;
    goalctrl = this;
    this.topgoals = [];
    this.pendant = [];
    this.lastachiev = [];
    this.gettopgoals = function() {
      goalSvc.getTop().then(function(data) {
        return goalctrl.topgoals = data;
      }, function(data) {
        return console.log("Error al tratar de obtener los objetivos de alto nivel");
      });
    };
    this.getpendant = function() {
      goalSvc.getPendant().then(function(data) {
        return goalctrl.pendant = data;
      }, function(data) {
        return console.log("Error al tratar de obtener los objetivos pendientes");
      });
    };
    this.getlastachieved = function() {
      goalSvc.getLastAchieved().then(function(data) {
        return goalctrl.lastachiev = data;
      }, function(data) {
        return console.log("Error al tratar de obtener los últimos objetivos conseguidos");
      });
    };
    this.newGoal = function() {
      $location.path('goals/new');
    };
    goalctrl.gettopgoals();
    goalctrl.getpendant();
    goalctrl.getlastachieved();
    this.viewDetails = function(goalid) {
      console.log(goalid);
      goalSvc.getById(goalid).then(function(data) {
        goalSvc.setCurrent(data);
        $location.path('goals/view');
      });
    };
  }
]);

'use strict';
angular.module('goalmgr').controller('addGoalCtrl', [
  'goalSvc', '$location', function(goalSvc, $location) {
    var goalctrl;
    goalctrl = this;
    this.newgoal = {
      name: "",
      priority: 0
    };
    this.priorities = [
      {
        id: 1,
        name: 'high'
      }, {
        id: 2,
        name: 'regular'
      }, {
        id: 3,
        name: 'low'
      }
    ];
    this.createGoal = function() {
      goalSvc.add(goalctrl.newgoal).then(function(data) {
        $location.path('editgoal');
      });
    };
  }
]);

'use strict';
angular.module('goalmgr').controller('viewGoalCtrl', [
  'goalSvc', 'altSvc', '$location', function(goalSvc, altSvc, $location) {
    var goalctrl;
    goalctrl = this;
    this.goal = goalSvc.getCurrent();
    this.alternatives = [];
    this.meta = [];
    this.currgoal = this.priorities = [
      {
        id: 1,
        name: 'high'
      }, {
        id: 2,
        name: 'regular'
      }, {
        id: 3,
        name: 'low'
      }
    ];
    this.getalternatives = function() {
      altSvc.getForGoal(goalctrl.goal.id).then(function(data) {
        goalctrl.alternatives = data;
      });
    };
    this.editgoal = function() {
      goalSvc.update(goalctrl.goal).then(function(data) {});
    };
    this.addAlternative = function() {
      goalSvc.setCurrent(goalctrl.goal);
      $location.path('alternatives/new');
    };
    this.getsupergoals = function() {
      goalSvc.getMeta(goalctrl.goal.id).then(function(data) {
        goalctrl.meta = data;
      });
    };
    goalctrl.getalternatives();
    goalctrl.getsupergoals();
    this.back = function() {
      $location.path('goals/');
    };
    this.gotogoal = function(goalid) {
      goalSvc.getById(goalid).then(function(data) {
        $location.path('goals/view');
      });
    };
    this.gotoalt = function(altid) {
      $location.path('alternatives/' + altid);
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
      httpRequest.headers = httpRequest.headers || {
        'Content-Type': 'application/json'
      };
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
    this.currentgoal = null;
    genericReq = function(httpRequest) {
      var deferred;
      deferred = $q.defer();
      httpRequest.headers = httpRequest.headers || {
        'Content-Type': 'application/json'
      };
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
      },
      update: function(goal) {
        var httpReq;
        httpReq = {
          method: 'PUT',
          url: 'http://' + API_SERVER + '/goals/' + goal.id,
          data: goal
        };
        return genericReq(httpReq);
      },
      getMeta: function(id) {
        var httpReq;
        httpReq = {
          method: 'GET',
          url: 'http://' + API_SERVER + '/goals/meta/' + id
        };
        return genericReq(httpReq);
      },
      setCurrent: function(goal) {
        goalSvc.currentgoal = goal;
      },
      getCurrent: function() {
        return goalSvc.currentgoal;
      }
    };
  }
]);
