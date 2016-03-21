angular.module '%module%.user'
.controller 'ProfileTrackerCtrl', ($scope, storage) ->
  $scope.user = storage.user
