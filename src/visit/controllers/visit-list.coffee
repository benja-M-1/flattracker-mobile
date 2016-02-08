angular.module '%module%.visit'
.controller 'VisitListCtrl', ($scope, VisitManager, $cordovaToast, $state) ->

  $scope.$on '$ionicView.beforeEnter', ->
    $scope.loading = true
    VisitManager.cgetUserAsSearcherVisits()
    .then (visits) ->
      $scope.visits = visits
    .catch ->
      $cordovaToast.show 'Aucune visite n\'est enregistrée', 'short', 'bottom'
      $state.go 'homepage'
    .finally ->
      $scope.loading = false
