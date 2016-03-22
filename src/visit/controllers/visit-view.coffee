angular.module '%module%.visit'
.controller 'VisitViewCtrl', ($stateParams, $cordovaToast, $state, $scope, VisitManager, storage, $cordovaCapture, VideoService) ->
  visitId = $stateParams.id
  $scope.form = {}
  $scope.addCommentFormDisabled = false
  $scope.user = storage.user

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
    if visit?.messages?.length == 0
      if visit.searcher.id == storage.user.id
        $scope.commentPlaceholder = "Qu'attendez-vous de cette visite ?"
      else
        $scope.commentPlaceholder = "Que voulez-vous que je vérifie pendant la visite ?"
    else
      $scope.commentPlaceholder = 'Ajoutez un commentaire'
  , true

  # Capture Video
  $scope.clip = ''

  $scope.captureVideo = ->
    $cordovaCapture.captureVideo()
    .then((videoData) ->
      VideoService.saveVideo(videoData).success((data) ->
        #googleLogin()
        $scope.clip = data
        $scope.$apply()
      ).error((data) ->
        console.log('ERROR: ' + data)
      )
    )

  $scope.urlForClipThumb = (clipUrl) ->
    name = clipUrl.substr(clipUrl.lastIndexOf('/') + 1)
    trueOrigin = cordova.file.dataDirectory + name
    sliced = trueOrigin.slice(0, -4)
    return sliced + '.png'

  $scope.showClip = (clip) ->
    console.log('show clip: ' + clip)
