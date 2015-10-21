angular.module '%module%.core'
.config ($stateProvider) ->
  $stateProvider
  .state 'homepage',
    url: '/home'
    templateUrl: 'core/views/homepage.html'
    controller: 'HomepageCtrl'
    cache: false
