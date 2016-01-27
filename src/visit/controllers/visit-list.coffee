angular.module '%module%.visit'
  .controller 'VisitListCtrl', ($scope, storage) ->
    $scope.visit=storage.visits