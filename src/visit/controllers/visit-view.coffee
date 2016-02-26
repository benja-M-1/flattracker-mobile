angular.module '%module%.visit'
.controller 'VisitViewCtrl', ($stateParams, $cordovaToast, $state, $scope, VisitManager, storage) ->
  visitId = $stateParams.id

  $scope.$on '$ionicView.beforeEnter', ->
    $scope.loading = true
    VisitManager.get(visitId)
    .then (visit) ->
      $scope.visit = visit
    .catch ->
      $cordovaToast.show 'Cette visite n\'est pas disponible', 'short', 'bottom'
      $state.go 'homepage'
    .finally ->
      $scope.loading = false


  # Update placeholder
  $scope.$watch 'visit', (visit) ->
    if not visit?.tracker
      return

    # @TODO: remove it
    visit.messages = []


    if visit?.messages?.length == 0
      if visit.searcher.id == storage.user.id
        $scope.commentPlaceholder = "Dites à " + visit.tracker.name + " ce que vous souhaitez qu'il vérifie pendant la visite ?"
      else
        $scope.commentPlaceholder = "Que voulez-vous que je vérifie pendant la visite ?"
    else
      $scope.commentPlaceholder = 'Ajoutez un commentaire'
  , true
