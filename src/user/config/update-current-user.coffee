angular.module '%module%.user'
.run ($state, $ionicPlatform, storage, PushManager) ->

  # @TODO : we could check Facebook token validity?
  if storage.user
    $state.go 'homepage'
  else
    $state.go 'login'

  if storage.user
    PushManager.fullInit()
