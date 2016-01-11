angular.module '%module%.visit'
.run (storage) ->
  if not storage.visits
    storage.visits = []
