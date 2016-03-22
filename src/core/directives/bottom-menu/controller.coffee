angular.module '%module%.core'
.controller 'BottomMenuCtrl', ($scope, storage) ->
  $scope.mode = storage.mode

  if storage.mode=='searcher'
    $scope.isSearcher = true
  else
    $scope.isSearcher = false

