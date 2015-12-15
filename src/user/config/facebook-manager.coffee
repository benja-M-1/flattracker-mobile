angular.module '%module%.user'
.factory 'FacebookManager', ($q, $cordovaFacebook, $log, storage) ->

  login = ->
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
