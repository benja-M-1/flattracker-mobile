angular.module '%module%.user'
.controller 'LoginCtrl', ($scope, $cordovaToast, $state, storage, FacebookManager) ->

  $scope.login = ->
    FacebookManager.login()
    .then ->
      $cordovaToast.show 'Succès de la connexion Facebook', 'short', 'bottom'
      $state.go 'homepage'
    .catch (error) ->
      $cordovaToast.show 'Erreur lors de la connexion Facebook', 'short', 'bottom'
