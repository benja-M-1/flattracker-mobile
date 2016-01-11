angular.module '%module%.visit'
.controller 'VisitViewCtrl', ($stateParams, $cordovaToast, $state, $scope, VisitManager) ->
  visitId = $stateParams.uuid

  VisitManager.get(visitId)
  .then (visit) ->
    $scope.visit = visit
  .catch ->
    $cordovaToast.show 'Cette visite n\'est pas disponible', 'short', 'bottom'
    $state.go 'homepage'
