angular.module '%module%.common'
.run ($window, FACEBOOK_APP_ID) ->
  $window.fbAsyncInit = ->
    FB.init
      appId: FACEBOOK_APP_ID
      status: true
      cookie: true
      xfbml: true
      version: 'v2.4'
