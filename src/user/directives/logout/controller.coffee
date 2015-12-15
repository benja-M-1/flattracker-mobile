angular.module '%module%.user'
.controller 'LogoutCtrl', ($scope, $state, $cordovaToast, FacebookManager) ->

  $scope.logout = ->
    FacebookManager.logout()
    .then ->
      $cordovaToast.show 'Vous avez bien été déconnecté(e)', 'short', 'bottom'
      $state.go 'login'
    .catch ->
      $cordovaToast.show 'Erreur lors de la déconnexion Facebook', 'short', 'bottom'
