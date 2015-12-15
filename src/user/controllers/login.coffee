angular.module '%module%.user'
.controller 'LoginCtrl', ($scope, $state, storage, $cordovaToast, FacebookManager) ->

  $scope.login = ->
    FacebookManager.login()
    .then ->
      $state.go 'homepage'
    .catch (error) ->
      $cordovaToast.show 'Erreur lors de la connexion Facebook', 'short', 'bottom'
