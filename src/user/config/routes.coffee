angular.module '%module%.user'
.config ($stateProvider) ->

  $stateProvider
  .state 'login',
    url: '/login'
    templateUrl: 'user/views/login.html'
    controller: 'LoginCtrl'
  .state 'profile',
    url: '/profile'
    templateUrl: 'user/views/profile.html'
    controller: 'ProfileCtrl'
  .state 'profile-tracker',
    url: 'profile-tracker'
    templateUrl: 'user/views/profile-tracker.html'
    controller: 'ProfileTrackerCtrl'


