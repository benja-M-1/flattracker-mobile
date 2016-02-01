angular.module '%module%.visit'
.factory 'VisitManager', ($q, storage, utils) ->

  create = (url) ->
    creatingVisit = $q.defer()

    # Generate uuid (@TODO: move this to backend)
    uuid = utils.guid()

    # Create visit
    visit =
      _id: uuid
      url: url
      owner: storage.user.id

    # Add visit to visit list
    if not utils.typeIsArray storage.visits
      storage.visits = []
    storage.visits.push visit

    creatingVisit.resolve visit
    creatingVisit.promise

  get = (uuid) ->
    gettingVisit = $q.defer()

    if not utils.typeIsArray storage.visits
      return gettingVisit.reject()

    # Search visit (@TODO: move this to backend)
    visit = _.findWhere storage.visits,
      _id: uuid,
      owner: storage.user.id

    if visit
      gettingVisit.resolve visit
    else
      gettingVisit.reject()

    gettingVisit.promise

  cget = ->
    collectingVisit = $q.defer()

    visits = storage.visits

    collectingVisit.resolve visits

    collectingVisit.promise

  create: create
  get: get
  cget: cget
