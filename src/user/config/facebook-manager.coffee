angular.module '%module%.user'
.factory 'FacebookManager', ($q, $cordovaFacebook, $log, $ionicViewService, storage) ->

  login = ->
    # Disable back button
    $ionicViewService.nextViewOptions
      disableBack: true

    # Login with Facebook and get user info
    loging = $q.defer()
    $cordovaFacebook.login ['public_profile', 'email']
    .then ->
      $cordovaFacebook.api('me', ['public_profile', 'email'])
      .then (me) ->
        storage.user = me
        loging.resolve()
      , (error) ->
        $log.error error
        loging.reject()
    , (error) ->
      $log.error error
      loging.reject()
    loging.promise

  logout = ->
    # Disable back button
   $ionicViewService.nextViewOptions
      disableBack: true

    # Remove user from localStorage and FB logout
    delete storage.user
    logouting = $q.defer()
    $cordovaFacebook.logout()
    .then ->
      logouting.resolve()
    , (error) ->
      $log.error error
      logouting.reject()
    logouting.promise

  logout: logout
  login: login
