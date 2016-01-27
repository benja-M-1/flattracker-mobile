angular.module '%module%.visit'
.controller 'VisitListCtrl', ($scope, storage) ->
    $scope.visits = storage.visits
