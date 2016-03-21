angular.module '%module%.visit'
.controller 'VisitListTrackerCtrl', ($scope, VisitManager, $cordovaToast, $state) ->

  $scope.$on '$ionicView.beforeEnter', ->
    $scope.loading = true
    VisitManager.cget()
    .then (visits) ->
      $scope.visits = visits
    .catch ->
      $cordovaToast.show 'Aucune visite n\'est enregistrée', 'short', 'bottom'
      $state.go 'homepage'
    .finally ->
      $scope.loading = false
