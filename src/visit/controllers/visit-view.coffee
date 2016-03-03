angular.module '%module%.visit'
.controller 'VisitViewCtrl', ($stateParams, $cordovaToast, $state, $scope, VisitManager, storage) ->
  visitId = $stateParams.id
  $scope.form = {}
  $scope.addCommentFormDisabled = false

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

  $scope.postMessage = ->
    $scope.addCommentFormDisabled = true
    $scope.loading = true
    VisitManager.postMessage(visitId, $scope.form.comment)
    .then (visit) ->
      $scope.visit = visit
      $cordovaToast.show 'Votre message a bien été posté !', 'short', 'bottom'
      $scope.form = {}
    .catch ->
      $cordovaToast.show 'Erreur lors de l\'envoi du message', 'short', 'bottom'
    .finally ->
      $scope.addCommentFormDisabled = false
      $scope.loading = false

  # Update placeholder
  $scope.$watch 'visit', (visit) ->
    if not visit?.tracker
      return

    if visit?.messages?.length == 0
      if visit.searcher.id == storage.user.id
        $scope.commentPlaceholder = "Dites à " + visit.tracker.name + " ce que vous souhaitez qu'il vérifie pendant la visite ?"
      else
        $scope.commentPlaceholder = "Que voulez-vous que je vérifie pendant la visite ?"
    else
      $scope.commentPlaceholder = 'Ajoutez un commentaire'
  , true
