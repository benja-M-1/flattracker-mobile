angular.module '%module%.user'
.config ($stateProvider) ->
  $stateProvider
  .state 'login',
    url: '/'
    templateUrl: 'user/views/login.html'
    controller: 'LoginCtrl'
    cache: false
