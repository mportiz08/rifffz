setTitle = (artist, album) ->
  $('title').text "♪ #{album} | #{artist}"

initControls = (artist, album, songs) ->
  window.controls = new app.Controls(artist, album, songs)

togglePlayShortcut = (e) ->
  e.preventDefault()
  window.controls.togglePlay()

nextTrackShortcut = (e) ->
  e.preventDefault()
  window.controls.nextTrack(e)

prevTrackShortcut = (e) ->
  e.preventDefault()
  window.controls.prevTrack(e)

setupKeyboardShortcuts = ->
  $(document).keypress (e) ->
    togglePlayShortcut(e) if e.which == 32
  $(document).keyup (e) ->
    switch e.which
      when 37, 38 then prevTrackShortcut(e)
      when 39, 40 then nextTrackShortcut(e)

$ ->
  if $('.album-info').length > 0
    artist = $('.album-info .artist-name').text()
    album  = $('.album-info .album-name').text()
    songs = _.map $('.album-song-list a'), (s) -> $(s).text()
    setTitle(artist, album)
    initControls(artist, album, songs)
    setupKeyboardShortcuts()
