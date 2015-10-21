angular.module '%module%.common'
.run (storage, AccountManager) ->

  if storage.user
    AccountManager.updateCurrentUser (user, error) ->
      
