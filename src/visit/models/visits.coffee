angular.module '%module%.visit'
.factory 'Visits', ($resource, SERVER_API_URL) ->
  $resource SERVER_API_URL + '/visits/:id', {id: '@id'},
    get:
      url: SERVER_API_URL + '/visits/:id'
      method: 'GET'
