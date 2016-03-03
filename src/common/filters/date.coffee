angular.module '%module%.common'
.filter 'date', ->
  (date, format) ->
    moment(date).format format
.config ->
  moment.locale 'fr'
