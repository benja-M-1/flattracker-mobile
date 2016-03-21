angular.module '%module%.user'
.factory 'ParsePush', ($q, parsePushConfig, $rootScope, $ionicPlatform) ->
  init = ->
    initializing = $q.defer()
    parsePlugin.initialize parsePushConfig.appId,
      parsePushConfig.clientKey,
      initializing.resolve,
      initializing.reject
    initializing.promise

  subscribe = (channel) ->
    subscribing = $q.defer()
    parsePlugin.subscribe channel,
      subscribing.resolve,
      subscribing.reject
    subscribing.promise

  unsubscribe = (channel) ->
    unsubscribing = $q.defer()
    parsePlugin.unsubscribe channel,
      unsubscribing.resolve,
      unsubscribing.reject
    unsubscribing.promise

  getInstallationId = ->
    gettingInstallationId = $q.defer()
    parsePlugin.getInstallationId gettingInstallationId.resolve,
      gettingInstallationId.reject
    gettingInstallationId.promise

  registerPushInterceptor = ->
    registering = $q.defer()
    parsePlugin.registerCallback 'onNotification', ->
      window.onNotification = (data) ->
        do (data) ->
          $rootScope.$emit 'pushReceived', data
      registering.resolve()
    , registering.reject
    registering.promise

  fullInit = ->
    $ionicPlatform.ready () ->
      init()
      .then -> subscribe 'GlobalChannel'
      .then -> registerPushInterceptor()

  fullInit: fullInit
  getInstallationId: getInstallationId
  subscribe: subscribe
  unsubscribe: unsubscribe
