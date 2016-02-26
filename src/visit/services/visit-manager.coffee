angular.module '%module%.visit'
.factory 'VisitManager', ($q, $log, $httpParamSerializer, storage, Visits) ->

  create = (url) ->
    creatingVisit = $q.defer()

    # Create visit
    visitJSON =
      'visit[url]': url
      'visit[searcher]': storage.user.id

    Visits.save $httpParamSerializer(visitJSON), (visitResponse) ->
      visit = visitResponse

      creatingVisit.resolve visit
    , (error) ->
      $log.error error
      creatingVisit.reject error

    creatingVisit.promise

  get = (id) ->
    gettingVisit = $q.defer()

    Visits.get {id: id}, (visitResponse) ->
      gettingVisit.resolve visitResponse
    , (error) ->
      $log.error error
      gettingVisit.reject error

    gettingVisit.promise

  cgetUserAsSearcherVisits = ->
    collectingVisit = $q.defer()

    Visits.cgetUserVisitsAsSearcherAction {userId: storage.user.id}, (visitsResponse) ->
      collectingVisit.resolve visitsResponse
    , (error) ->
      $log.error error
      collectingVisit.reject error

    collectingVisit.promise

  cget = ->
    collectingVisit = $q.defer()

    Visits.cget {}, (visitsResponse) ->
      collectingVisit.resolve visitsResponse
    , (error) ->
      $log.error error
      collectingVisit.reject error

    collectingVisit.promise

  assignVisitToMe = (visitId) ->
    assigningVisit = $q.defer()

    Visits.assignVisitToTracker {userId: storage.user.id, id: visitId}, (visitResponse) ->
      assigningVisit.resolve visitResponse
    , (error) ->
      $log.error error
      assigningVisit.reject error

    assigningVisit.promise

  postMessage = (visitId, message) ->
    postingMessage = $q.defer()

    # Create visit
    messageJSON =
      'message[author]': storage.user.id
      'message[content]': message

    Visits.addMessage {id: visitId}, $httpParamSerializer(messageJSON), (visitResponse) ->
      visit = visitResponse

      postingMessage.resolve visit
    , (error) ->
      $log.error error
      postingMessage.reject error

    postingMessage.promise

  create: create
  get: get
  cgetUserAsSearcherVisits: cgetUserAsSearcherVisits
  cget: cget
  assignVisitToMe: assignVisitToMe
  postMessage: postMessage
