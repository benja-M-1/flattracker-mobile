angular.module '%module%.core'
.controller 'HomepageCtrl', ($scope, $state, $cordovaToast, storage, VisitManager) ->
  $scope.user = storage.user

  $scope.createVisit = (url) ->
    VisitManager.create(url)
    .then (visit) ->
      $cordovaToast.show 'Votre visite a bien été créée', 'short', 'bottom'
      $state.go 'visit-view', {id: visit.id}
    .catch ->
      $cordovaToast.show 'Erreur lors de la création de la visite', 'short', 'bottom'