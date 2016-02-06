angular.module '%module%.visit'
.config ($stateProvider) ->
  $stateProvider
  .state 'visit-view',
    url: '/visits/:id'
    templateUrl: 'visit/views/visit-view.html'
    controller: 'VisitViewCtrl'
  .state 'visit-list',
    url: '/visits'
    templateUrl: 'visit/views/visit-list.html'
    controller: 'VisitListCtrl'
  .state 'visit-request-list',
    url: '/visit-requests/list'
    templateUrl: 'visit/views/visit-request-list.html'
    controller: 'VisitRequestListCtrl'
