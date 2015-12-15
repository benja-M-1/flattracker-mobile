angular.module '%module%.core'
.controller 'HomepageCtrl', ($scope, $state, $cordovaToast, storage, FacebookManager) ->

  $scope.user = storage.user

  $scope.logout = ->
    FacebookManager.logout()
    .then ->
      $cordovaToast.show 'Vous avez bien été déconnecté(e)', 'short', 'bottom'
      $state.go 'login'
    .catch ->
      $cordovaToast.show 'Erreur lors de la déconnexion Facebook', 'short', 'bottom'
