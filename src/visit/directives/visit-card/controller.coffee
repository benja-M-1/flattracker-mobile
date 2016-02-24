angular.module '%module%.visit'
.controller 'VisitCardCtrl', ($scope, storage, $cordovaToast, $state, VisitManager) ->
  $scope.assignVisitToMe = (visitId) ->
    $scope.buttonDisabled = true
    VisitManager.assignVisitToMe(visitId)
    .then (visit) ->
      $scope.visit = visit
    .catch ->
      $cordovaToast.show 'Erreur lors de l\'attribution de la visite. Veuillez réessayer.', 'short', 'bottom'
    .finally ->
      $scope.buttonDisabled = false
