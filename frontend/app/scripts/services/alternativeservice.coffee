'use strict'

angular.module 'goalmgr'
.service 'altSvc', ['$q', '$http', 'API_SERVER',
  ($q, $http, API_SERVER) ->
      goalSvc = this
      genericReq = (httpRequest) ->
        deferred = $q.defer()
        httpRequest.headers = httpRequest.headers || 'Content-Type':'application/json'
        $http(httpRequest)
        .success (data,status,headers,config) ->
          deferred.resolve data
        .error (data,status,headers,config) ->
          deferred.reject status
        deferred.promise
      getForGoal: (goalid) ->
        httpReq =
          method: 'GET'
          url: 'http://'+API_SERVER+'/alt/bygoal/'+goalid
        genericReq(httpReq)
      getById: (id) ->
        httpReq =
          method: 'GET'
          url: 'http://'+API_SERVER+'/alt/'+ id
        genericReq(httpReq)
      add: (alt,goalid) ->
        httpReq =
          method: 'POST'
          url: 'http://'+API_SERVER+'/alt/'+goalid
          data: alt
        genericReq(httpReq)
      remove: (id) ->
        httpReq =
          method: 'DELETE'
          url: 'http://'+API_SERVER+'/alt/'+id
        genericReq(httpReq)
]
