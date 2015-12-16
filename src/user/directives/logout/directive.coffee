angular.module '%module%.user'
.directive 'logout', ->
  templateUrl: 'user/directives/logout/template.html'
  restrict:    'E'
  replace:     true
  controller:  'LogoutCtrl'
  scope:       {}
