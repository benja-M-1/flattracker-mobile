angular.module '%module%.user'
.factory 'FacebookManager', ($q, $cordovaFacebook, $log, $ionicViewService, $httpParamSerializer, storage, Users) ->

  login = ->
    # Disable back button
    $ionicViewService.nextViewOptions
      disableBack: true

    # Login with Facebook and get user info
    loging = $q.defer()
    $cordovaFacebook.login ['public_profile', 'email']
    .then ->
      $cordovaFacebook.api('me?fields=id,first_name,last_name,email,picture', ['public_profile', 'email'])
      .then (me) ->
        userJSON =
          'user[email]': me.email
          'user[name]': me.first_name + ' ' + me.last_name
          'user[facebookId]': me.id
          'user[facebookPictureUrl]': me.picture.data.url
        Users.createOrUpdate $httpParamSerializer(userJSON), (user) ->
          storage.user =
            id: user.id
            name: user.name
            facebookId: user.facebook_id
            pictureUrl: user.facebook_picture_url
          loging.resolve()
        , (error) ->
          $log.error error
          loging.reject()
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
