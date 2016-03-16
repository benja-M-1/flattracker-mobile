angular.module '%module%.visit'
.factory 'VideoService', ($q, $log, $httpParamSerializer, storage, Visits) ->

  deferred = $q.defer()
  promise = deferred.promise

  promise.success = (fn) ->
    promise.then(fn)
  return promise

  promise.error = (fn) ->
    promise.then(null, fn)
  return promise

  # Resolve the URL to the local file
  # Start the copy process
  createFileEntry = (fileURI) ->
    window.resolveLocalFileSystemURL(fileURI, (entry) ->
      return copyFile(entry)
    , fail)

  # Create a unique name for the videofile
  # Copy the recorded video to the app directory
  copyFile = (fileEntry) ->
    name = fileEntry.fullPath.substr(fileEntry.fullPath.lastIndexOf('/') + 1)
    newName = makeid() + name

    window.resolveLocalFileSystemURL(cordova.file.dataDirectory, (fileSystem2) ->
      fileEntry.copyTo(fileSystem2, newName, (succ) ->
        return onCopySuccess(succ)
      , fail)
    , fail)

  # Called on successful copy process
  # Creates a thumbnail from the movie
  # The name is the moviename but with .png instead of .mov
  onCopySuccess = (entry) ->
    name = entry.nativeURL.slice(0, -4)
    window.PKVideoThumbnail.createThumbnail(entry.nativeURL, name + '.png', (prevSucc) ->
      return prevImageSuccess(prevSucc)
    , fail)

  # Called on thumbnail creation success
  # Generates the currect URL to the local moviefile
  # Finally resolves the promies and returns the name
  prevImageSuccess = (succ) ->
    correctUrl = succ.slice(0, -4)
    correctUrl += '.MOV'
    deferred.resolve(correctUrl)

  # Called when anything fails
  # Rejects the promise with an Error
  fail = (error) ->
    console.log('FAIL: ' + error.code)
    deferred.reject('ERROR')

  # Function to make a unique filename
  makeid = ->
    text = '';
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    for i in [0...5]
      text += possible.charAt(Math.floor(Math.random() * possible.length))
    return text

  # The object and functions returned from the Service
  return saveVideo: (data) ->
    createFileEntry(data[0].localURL)
    return promise




