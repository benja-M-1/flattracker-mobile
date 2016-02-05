angular.module '%module%.user'
.factory 'Users', ($resource, SERVER_API_URL) ->
  $resource SERVER_API_URL + '/users/:id', {id: '@id'},
    createOrUpdate:
      url: SERVER_API_URL + '/users'
      method: 'POST'
      headers:
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
