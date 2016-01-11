angular.module '%module%.visit'
.factory 'Visits', ($resource, SERVER_API_URL, storage) ->
  $resource SERVER_API_URL + 'visits/:id', {id: '@id', access_token: '@access_token'},
    get:
      url: SERVER_API_URL + 'visits/:id'
      method: 'GET'
      params:
        Authorization: 'Bearer ' + storage.accessToken
