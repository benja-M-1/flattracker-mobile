angular.module '%module%.core'
.controller 'HomepageCtrl', ($scope, $state, storage, AccountManager) ->

  $scope.user = storage.user

  $scope.logout = ->
    AccountManager.logout()
    $state.go 'login'
