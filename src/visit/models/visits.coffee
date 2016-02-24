angular.module '%module%.visit'
.factory 'Visits', ($resource, SERVER_API_URL) ->
  $resource SERVER_API_URL + '/visits/:id', {id: '@id', userId: '@userId'},
    get:
      url: SERVER_API_URL + '/visits/:id'
      method: 'GET'
    cget:
      url: SERVER_API_URL + '/visits'
      method: 'GET'
      isArray: true
    cgetUserVisitsAsSearcherAction:
      url: SERVER_API_URL + '/users/:userId/visits-as-searcher'
      method: 'GET'
      isArray: true
    save:
      url: SERVER_API_URL + '/visits'
      method: 'POST'
      headers:
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    assignVisitToTracker:
      url: SERVER_API_URL + '/visits/:id/affect/:userId'
      method: 'PUT'
