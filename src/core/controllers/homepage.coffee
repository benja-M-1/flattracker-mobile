angular.module '%module%.core'
.controller 'HomepageCtrl', ($scope, $state, $cordovaToast, storage, VisitManager) ->
  $scope.user = storage.user

  $scope.$on '$ionicView.beforeEnter', ->
    $scope.nbVisits = storage.visits.length

  $scope.createVisit = (url) ->
    VisitManager.create(url)
    .then (visit) ->
      $cordovaToast.show 'Votre visite a bien été créée', 'short', 'bottom'
      $state.go 'visit-view', {uuid: visit._id}
    .catch ->
      $cordovaToast.show 'Erreur lors de la création de la visite', 'short', 'bottom'
