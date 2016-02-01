angular.module '%module%.visit'
.controller 'VisitListCtrl', ($scope, VisitManager, $cordovaToast, $state) ->

  VisitManager.cget()
  .then (visits) ->
    $scope.visits = visits
  .catch ->
    $cordovaToast.show 'Aucune visite n\'est enregistrée', 'short', 'bottom'
    $state.go 'homepage'

