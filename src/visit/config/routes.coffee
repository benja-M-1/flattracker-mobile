angular.module '%module%.visit'
.config ($stateProvider) ->
  $stateProvider
  .state 'visit-view',
    url: '/visits/:uuid'
    templateUrl: 'visit/views/visit-view.html'
    controller: 'VisitViewCtrl'