angular.module '%module%.visit'
.controller 'VisitViewCtrl', ($stateParams, $cordovaToast, $state, $scope, VisitManager) ->
  visitId = $stateParams.id

  $scope.$on '$ionicView.beforeEnter', ->
    $scope.loading = true
    VisitManager.get(visitId)
    .then (visit) ->
      $scope.visit = visit
    .catch ->
      $cordovaToast.show 'Cette visite n\'est pas disponible', 'short', 'bottom'
      $state.go 'homepage'
    .finally ->
      $scope.loading = false
