angular.module '%module%.visit'
.directive 'visitCard', ->
  templateUrl: 'visit/directives/visit-card/template.html'
  restrict:    'E'
  controller:  'VisitCardCtrl'
  scope:
    displayAssignButton: '@'
    visit: '='
