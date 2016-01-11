angular.module '%module%.common'
.factory 'utils', ->

  # Generate UUID : ex 'f81d4fae-7dec-11d0-a765-00a0c91e6bf6' (RFC 4122)
  guid = ->
    s4 = ->
      Math.floor((1 + Math.random()) * 0x10000).toString(16).substring 1
    s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4()

  # Check if type is array
  typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

  guid: guid
  typeIsArray: typeIsArray
