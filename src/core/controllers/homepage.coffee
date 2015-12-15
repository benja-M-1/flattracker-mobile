angular.module '%module%.core'
.controller 'HomepageCtrl', ($scope, storage) ->
  $scope.user = storage.user
