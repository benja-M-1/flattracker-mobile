angular.module '%module%.visit'
.controller 'VisitListTrackerCtrl', ($scope, $cordovaToast, $state, storage, VisitManager) ->
  $scope.user = storage.user

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
