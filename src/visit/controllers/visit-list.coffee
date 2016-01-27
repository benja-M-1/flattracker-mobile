angular.module '%module%.visit'
.controller 'VisitListCtrl', ($scope) ->
    $scope.visits = storage.visits
