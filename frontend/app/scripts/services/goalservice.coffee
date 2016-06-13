'use strict'

angular.module 'goalmgr'
.service 'goalSvc', ['$q', '$http', 'API_SERVER',
  ($q, $http, API_SERVER) ->
      goalSvc = this
      genericReq = (httpRequest) ->
        deferred = $q.defer()
        $http(httpRequest)
        .success (data,status,headers,config) ->
          deferred.resolve data
        .error (data,status,headers,config) ->
          deferred.reject status
        deferred.promise
      getAll: () ->
        httpReq =
          method: 'GET'
          url: 'http://'+API_SERVER+'/goals'
        genericReq(httpReq)
      getTop: () ->
        httpReq =
          method: 'GET'
          url: 'http://'+API_SERVER+'/goals/top'
        genericReq(httpReq)
      getPendant: () ->
        httpReq =
          method: 'GET'
          url: 'http://'+API_SERVER+'/goals/pendant'
        genericReq(httpReq)
      getLastAchieved: () ->
        httpReq =
          method: 'GET'
          url: 'http://'+API_SERVER+'/goals/achieved'
        genericReq(httpReq)
      getById: (id) ->
        httpReq =
          method: 'GET'
          url: 'http://'+API_SERVER+'/goals/'+ id
        genericReq(httpReq)
      add: (goal) ->
        httpReq =
          method: 'POST'
          url: 'http://'+API_SERVER+'/goals'
          data: goal
        genericReq(httpReq)
      remove: (id) ->
        httpReq =
          method: 'DELETE'
          url: 'http://'+API_SERVER+'/goals/'+id
        genericReq(httpReq)
]
