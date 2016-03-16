angular.module '%module%.user'
.controller 'ProfileCtrl', ($scope, storage) ->
  $scope.user = storage.user
