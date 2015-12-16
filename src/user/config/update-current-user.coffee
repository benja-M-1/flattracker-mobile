angular.module '%module%.user'
.run ($state, storage) ->

  # @TODO : we could check Facebook token validity?
  if storage.user
    $state.go 'homepage'
  else
    $state.go 'login'
